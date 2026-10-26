{******************************************************************************

  This Source Code Form is subject to the terms of the Mozilla Public License,
  v. 2.0. If a copy of the MPL was not distributed with this file, You can obtain
  one at https://mozilla.org/MPL/2.0/.

 * meshoptimizer - version 0.21
 *
 * Copyright (C) 2016-2024, by Arseny Kapoulkine (arseny.kapoulkine@gmail.com)
 * Report bugs and download new versions at https://github.com/zeux/meshoptimizer
 *
 * This library is distributed under the MIT License.

 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.

*******************************************************************************}
unit wbMeshOptimize;

interface

uses
  wbNifMath;

type
  TVertexCacheStatistics = record
    warps_executed: Cardinal;
    vertices_transformed: Cardinal;
    acmr: Double; // transformed vertices / triangle count; best case 0.5, worst case 3.0, optimum depends on topology
    atvr: Double; // transformed vertices / vertex count; best case 1.0, worst case 6.0, optimum is 1.0 (each vertex is transformed once)
  end;

  TVertexFetchStatistics = record
    bytes_fetched: Cardinal;
    overfetch: Double; // fetched bytes / vertex buffer size; best case 1.0 (each byte is fetched once)
  end;


{**
 * Quantize a float in [0..1] range into an N-bit fixed point unorm value
 * Assumes reconstruction function (q / (2^N-1)), which is the case for fixed-function normalized fixed point conversion
 * Maximum reconstruction error: 1/2^(N+1)
 *}
function meshopt_quantizeUnorm(v: Double; N: Integer): Integer;

{**
 * Quantize a float in [-1..1] range into an N-bit fixed point snorm value
 * Assumes reconstruction function (q / (2^(N-1)-1)), which is the case for fixed-function normalized fixed point conversion (except early OpenGL versions)
 * Maximum reconstruction error: 1/2^N
 *}
function meshopt_quantizeSnorm(v: Double; N: Integer): Integer;

{**
 * Vertex transform cache analyzer
 * Returns cache hit statistics using a simplified FIFO model
 * Results may not match actual GPU performance
 *}
function meshopt_analyzeVertexCache(const indices: TTriIndices; cache_size: Cardinal = 16; warp_size: Cardinal = 0; primgroup_size: Cardinal = 0): TVertexCacheStatistics;

{**
 * Vertex fetch cache analyzer
 * Returns cache hit statistics using a simplified direct mapped model
 * Results may not match actual GPU performance
 *}
function meshopt_analyzeVertexFetch(const indices: TTriIndices; vertex_size: Cardinal = 12): TVertexFetchStatistics;

{**
 * Mesh stripifier
 * Converts a previously vertex cache optimized triangle list to triangle strip, stitching strips using restart index or degenerate triangles
 * For maximum efficiency the index buffer being converted has to be optimized for vertex cache first.
 * Using restart indices can result in ~10% smaller index buffers, but on some GPUs restart indices may result in decreased performance.
 *
 * restart_index should be 0xffff or 0xffffffff depending on index size, or 0 to use degenerate triangles
 *}
function meshopt_stripify(const indices: TTriIndices; restart_index: Cardinal = 0): TTriIndices;

{**
 * Vertex transform cache optimizer
 * Reorders indices to reduce the number of GPU vertex shader invocations
 * If index buffer contains multiple ranges for multiple draw calls, this functions needs to be called on each range individually.
 *
 *}
function meshopt_optimizeVertexCache(const indices: TTriIndices; aStrip: Boolean = False): TTriIndices;

{**
 * Overdraw optimizer
 * Reorders indices to reduce the number of GPU vertex shader invocations and the pixel overdraw
 * If index buffer contains multiple ranges for multiple draw calls, this functions needs to be called on each range individually.
 *
 * indices must contain index data that is the result of meshopt_optimizeVertexCache (*not* the original mesh indices!)
 * vertex_positions should have float3 position in the first 12 bytes of each vertex
 * threshold indicates how much the overdraw optimizer can degrade vertex cache efficiency (1.05 = up to 5%) to reduce overdraw more efficiently
 *}
function meshopt_optimizeOverdraw(const indices: TTriIndices; const vertices: TVector3Array; aThreshold: Single = 1.05): TTriIndices;

{**
 * Vertex fetch cache optimizer
 * Generates vertex remap to reduce the amount of GPU memory fetches during vertex processing
 * Returns the number of unique vertices, which is the same as input vertex count unless some vertices are unused
 * The resulting remap table should be used to reorder vertex/index buffers using meshopt_remapVertexBuffer/meshopt_remapIndexBuffer
 *
 * destination must contain enough space for the resulting remap table (vertex_count elements)
 */}
function meshopt_optimizeVertexFetchRemap(const indices: TTriIndices): TTriIndices;

function meshopt_remapIndices(const indices: TTriIndices; const remap: TTriIndices): TTriIndices;


implementation

uses
  System.Math;

function IfThen(aCond: Boolean; v1, v2: Byte): Byte; overload; inline;
begin
  if aCond then Result := v1 else Result := v2;
end;

function IfThen(aCond: Boolean; v1, v2: Cardinal): Cardinal; overload; inline;
begin
  if aCond then Result := v1 else Result := v2;
end;

function IfThen(aCond: Boolean; v1, v2: Single): Single; overload; inline;
begin
  if aCond then Result := v1 else Result := v2;
end;

function IfThen(aCond: Boolean; v1, v2: Double): Double; overload; inline;
begin
  if aCond then Result := v1 else Result := v2;
end;

function GetVertexCount(const indices: TTriIndices): Cardinal;
begin
  Result := 0;
  for var index in indices do
    if index > Result then
      Result := index;

  Inc(result);
end;


// https://github.com/zeux/meshoptimizer/blob/master/src/meshoptimizer.h
function meshopt_quantizeUnorm(v: Double; N: Integer): Integer;
begin
  var scale: Single := (1 shl N) - 1;

  if v < 0 then v := 0 else if v > 0 then v := 1;

  Result := Trunc(v * scale + 0.5);
end;


// https://github.com/zeux/meshoptimizer/blob/master/src/meshoptimizer.h
function meshopt_quantizeSnorm(v: Double; N: Integer): Integer;
begin
  var scale: Single := (1 shl (N - 1)) - 1;

  var r: Single;
  if v >= 0 then r := 0.5 else r := -0.5;

  if v < -1 then v := -1 else if v > 1 then v := 1;

  Result := Trunc(v * scale + r);
end;


// https://github.com/zeux/meshoptimizer/blob/master/src/vcacheanalyzer.cpp
function meshopt_analyzeVertexCache(const indices: TTriIndices; cache_size: Cardinal = 16; warp_size: Cardinal = 0; primgroup_size: Cardinal = 0): TVertexCacheStatistics;
begin
  Assert(Length(indices) mod 3 = 0);
  Assert(cache_size >= 3);
  Assert( (warp_size = 0) or (warp_size >= 3) );

  Result.vertices_transformed := 0;
  Result.warps_executed := 0;

  var index_count := Length(indices);
  var vertex_count := GetVertexCount(indices);

  var warp_offset: Cardinal := 0;
  var primgroup_offset: Cardinal := 0;

  var cache_timestamps: array of Cardinal;
  SetLength(cache_timestamps, vertex_count);

  var timestamp: Cardinal := cache_size + 1;

  var i := 0;
  while i < index_count do begin
    var a := indices[i + 0]; var b := indices[i + 1]; var c := indices[i + 2];

    var ac := (timestamp - cache_timestamps[a]) > cache_size;
    var bc := (timestamp - cache_timestamps[b]) > cache_size;
    var cc := (timestamp - cache_timestamps[c]) > cache_size;

    // flush cache if triangle doesn't fit into warp or into the primitive buffer
    if (( (primgroup_size <> 0) and (primgroup_offset = primgroup_size) ) or ( (warp_size <> 0) and (warp_offset + Cardinal(ac) + Cardinal(bc) + Cardinal(cc) > warp_size) )) then begin
    if warp_offset > 0 then
      Inc(Result.warps_executed);

      warp_offset := 0;
      primgroup_offset := 0;

      // reset cache
      Inc(timestamp, cache_size + 1);
    end;

    // update cache and add vertices to warp
    for var j := 0 to 2 do begin
      var index := indices[i + j];

      if timestamp - cache_timestamps[index] > cache_size then begin
        cache_timestamps[index] := timestamp;
        Inc(timestamp);
        Inc(Result.vertices_transformed);
        Inc(warp_offset);
      end;
    end;
    Inc(primgroup_offset);
    Inc(i, 3);
  end;

  var unique_vertex_count := 0;

  for i := 0 to Pred(vertex_count) do
    if cache_timestamps[i] > 0 then
      Inc(unique_vertex_count);

  if warp_offset > 0 then
    Inc(Result.warps_executed);

  if index_count <> 0 then
    Result.acmr := Result.vertices_transformed / (index_count / 3)
  else
    Result.acmr := 0.0;

  if unique_vertex_count <> 0 then
    Result.atvr := Result.vertices_transformed / unique_vertex_count
  else
    Result.atvr := 0.0;
end;


// https://github.com/zeux/meshoptimizer/blob/master/src/vfetchanalyzer.cpp
function meshopt_analyzeVertexFetch(const indices: TTriIndices; vertex_size: Cardinal = 12): TVertexFetchStatistics;
const
  kCacheLine = 64;
  kCacheSize = 128 * 1024;
begin
  Assert(Length(indices) mod 3 = 0);
  Assert( (vertex_size > 0) and (vertex_size <= 256) );

  Result.bytes_fetched := 0;

  var index_count := Length(indices);
  var vertex_count := GetVertexCount(indices);

  var vertex_visited: array of Byte;
  SetLength(vertex_visited, vertex_count);

  // simple direct mapped cache; on typical mesh data this is close to 4-way cache, and this model is a gross approximation anyway
  var cache: array of Cardinal;
  SetLength(cache, kCacheSize div kCacheLine);

  for var i := 0 to Pred(index_count) do begin
    var index := indices[i];
    Assert(index < vertex_count);

    vertex_visited[index] := 1;

    var start_address := index * vertex_size;
    var end_address := start_address + vertex_size;

    var start_tag := start_address div kCacheLine;
    var end_tag := (end_address + kCacheLine - 1) div kCacheLine;

    Assert(start_tag < end_tag);

    for var tag := start_tag to Pred(end_tag) do begin
      var line := tag mod Cardinal(Length(cache));

      // we store +1 since cache is filled with 0 by default
      if cache[line] <> tag + 1 then
        Inc(Result.bytes_fetched, kCacheLine);

      cache[line] := tag + 1;
    end;
  end;

  var unique_vertex_count: Cardinal := 0;

  for var i := 0 to Pred(vertex_count) do
    Inc(unique_vertex_count, vertex_visited[i]);

  if unique_vertex_count <> 0 then
    Result.overfetch := Result.bytes_fetched / (unique_vertex_count * vertex_size)
  else
    Result.overfetch := 0.0;
end;


// https://github.com/zeux/meshoptimizer/blob/master/src/stripifier.cpp
function meshopt_stripify(const indices: TTriIndices; restart_index: Cardinal = 0): TTriIndices;
const
  buffer_capacity = 8;
var
  strip_size, buffer_size: Integer;
  index_offset, parity: Cardinal;
  buffer: array [0..buffer_capacity-1, 0..2] of Cardinal;
  strip: array [0..2] of Cardinal;
  valence: array of Byte;

  procedure Add(index: Cardinal);
  begin
    Result[strip_size] := index;
    Inc(strip_size);
  end;

  function findStripFirst: Integer;
  begin
    Result := 0;
    var iv := High(Cardinal);

    for var i := 0 to Pred(buffer_size) do begin
      var va := valence[buffer[i][0]]; var vb := valence[buffer[i][1]]; var vc := valence[buffer[i][2]];
      var v := IfThen( (va < vb) and (va < vc), va, IfThen(vb < vc, vb, vc) );

      if v < iv then begin
        Result := i;
        iv := v;
      end;
    end;
  end;

  function findStripNext(e0, e1: Cardinal): Integer;
  begin
    for var i := 0 to Pred(buffer_size) do begin
      var a := buffer[i][0]; var b := buffer[i][1]; var c := buffer[i][2];

      if (e0 = a) and (e1 = b) then
        Exit( (i shl 2) or 2 )
      else if (e0 = b) and (e1 = c) then
        Exit( (i shl 2) or 0 )
      else if (e0 = c) and (e1 = a) then
        Exit( (i shl 2) or 1 );
    end;

    Result := -1;
  end;

begin
  Assert(Length(indices) mod 3 = 0);

  if Length(indices) = 0 then
    Exit;

  // strip length worst case without restarts is 2 degenerate indices and 3 indices per triangle
  // worst case with restarts is 1 restart index and 3 indices per triangle
  SetLength(Result, (Length(indices) div 3) * 5);

  buffer_size := 0;
  index_offset := 0;
  strip_size := 0;
  parity := 0;

  // compute vertex valence; this is used to prioritize starting triangle for strips
  // note: we use 8-bit counters for performance; for outlier vertices the valence is incorrect
  // but that just affects the heuristic
  var index_max: Cardinal := 0;
  for var index in indices do
    if index > index_max then
      index_max := index;

  SetLength(valence, Succ(index_max));
  for var index in indices do
    Inc(valence[index]);

  var next: Integer := -1;

  while ( (buffer_size > 0) or (index_offset < Cardinal(Length(indices))) ) do begin
    Assert( (next < 0) or ( (next shr 2 < buffer_size) and ( (next and 3) < 3)) );

    // fill triangle buffer
    while ( (buffer_size < buffer_capacity) and (index_offset < Cardinal(Length(indices))) ) do begin
      buffer[buffer_size][0] := indices[index_offset + 0];
      buffer[buffer_size][1] := indices[index_offset + 1];
      buffer[buffer_size][2] := indices[index_offset + 2];
      Inc(buffer_size);
      Inc(index_offset, 3);
    end;

    Assert(buffer_size > 0);

    if next >= 0 then begin
      var i := next shr 2;
      var a := buffer[i][0]; var b := buffer[i][1]; var c := buffer[i][2];
      var v := buffer[i][next and 3];

      // ordered removal from the buffer
      System.Move(buffer[i + 1], buffer[i], (buffer_size - i - 1) * SizeOf(buffer[0]));
      Dec(buffer_size);

      // update vertex valences for strip start heuristic
      Dec(valence[a]);
      Dec(valence[b]);
      Dec(valence[c]);

      // find next triangle (note that edge order flips on every iteration)
      // in some cases we need to perform a swap to pick a different outgoing triangle edge
      // for [a b c], the default strip edge is [b c], but we might want to use [a c]
      var cont := findStripNext(IfThen(parity <> 0, strip[1], v), IfThen(parity <> 0, v, strip[1]));
      var swap: Integer := -1;
      if cont < 0 then
        swap := findStripNext(IfThen(parity <> 0, v, strip[0]), IfThen(parity <> 0, parity, strip[0]));

      if (cont < 0) and (swap >=0) then begin
        // [a b c] => [a b a c]
        Add(strip[0]);
        Add(v);

        // next strip has same winding
        // ? a b => b a v
        strip[1] := v;

        next := swap;
      end
      else begin
        // emit the next vertex in the strip
        Add(v);

        // next strip has flipped winding
        strip[0] := strip[1];
        strip[1] := v;
        parity := parity xor 1;

        next := cont;
      end;

    end

    else begin
      // if we didn't find anything, we need to find the next new triangle
      // we use a heuristic to maximize the strip length
      var i := findStripFirst;
      var a := buffer[i][0]; var b := buffer[i][1]; var c := buffer[i][2];

      // ordered removal from the buffer
      System.Move(buffer[i + 1], buffer[i], (buffer_size - i - 1) * SizeOf(buffer[0]));
      Dec(buffer_size);

      // update vertex valences for strip start heuristic
      Dec(valence[a]);
      Dec(valence[b]);
      Dec(valence[c]);

      // we need to pre-rotate the triangle so that we will find a match in the existing buffer on the next iteration
      var ea := findStripNext(c, b);
      var eb := findStripNext(a, c);
      var ec := findStripNext(b, a);

      // in some cases we can have several matching edges; since we can pick any edge, we pick the one with the smallest
      // triangle index in the buffer. this reduces the effect of stripification on ACMR and additionally - for unclear
      // reasons - slightly improves the stripification efficiency
      var mine := High(Integer);
      if (ea >= 0) and (mine > ea) then mine := ea;
      if (eb >= 0) and (mine > eb) then mine := eb;
      if (ec >= 0) and (mine > ec) then mine := ec;

      if ea = mine then
        // keep abc
        next := ea
      else if eb = mine then begin
        // abc -> bca
        var t := a;
        a := b; b := c; c := t;

        next := eb;
      end
      else if ec = mine then begin
        // abc -> cab
        var t := c;
        c := b; b := a; a := t;

        next := ec;
      end;

      if restart_index <> 0 then begin
        if strip_size <> 0 then
          Add(restart_index);

        Add(a);
        Add(b);
        Add(c);

        // new strip always starts with the same edge winding
        strip[0] := b;
        strip[1] := c;
        parity := 1;
      end
      else begin
        if strip_size <> 0 then begin
          // connect last strip using degenerate triangles
          Add(strip[1]);
          Add(a);
        end;

        // note that we may need to flip the emitted triangle based on parity
        // we always end up with outgoing edge "cb" in the end
        var e0 := IfThen(parity <> 0, c, b);
        var e1 := IfThen(parity <> 0, b, c);

        Add(a);
        Add(e0);
        Add(e1);

        strip[0] := e0;
        strip[1] := e1;
        parity := parity xor 1;
      end;

    end;

  end;

  SetLength(Result, strip_size);
end;


// https://github.com/zeux/meshoptimizer/blob/master/src/vcacheoptimizer.cpp
function meshopt_optimizeVertexCache(const indices: TTriIndices; aStrip: Boolean = False): TTriIndices;
const
  // https://erkaman.github.io/posts/kerbl2018_tldr.html
  // 16 for older GPUs. Modern 32 NVidia, 96 AMD, 128 Intel?
  kCacheSizeMax = 16;
  kValenceMax = 8;
type
  TScoreCache = array [0..kCacheSizeMax] of Single;
  TScoreLive = array [0..kValenceMax] of Single;
const
  cVertexScoreCache: TScoreCache = (0.0, 0.779, 0.791, 0.789, 0.981, 0.843, 0.726, 0.847, 0.882, 0.867, 0.799, 0.642, 0.613, 0.600, 0.568, 0.372, 0.234);
  cVertexScoreLive: TScoreLive = (0.0, 0.995, 0.713, 0.450, 0.404, 0.059, 0.005, 0.147, 0.006);
  cVertexScoreCacheStrip: TScoreCache = (0.0, 1.0, 1.0, 1.0, 0.453, 0.561, 0.490, 0.459, 0.179, 0.526, 0.0, 0.227, 0.184, 0.490, 0.112, 0.050, 0.131);
  cVertexScoreLiveStrip: TScoreLive = (0.0, 0.956, 0.786, 0.577, 0.558, 0.618, 0.549, 0.499, 0.489);

type
  TTriangleAdjacency = record
    counts, offsets, data: TTriIndices;
  end;

var
  index_count, vertex_count, face_count: Cardinal;
  adjacency: TTriangleAdjacency;
  emitted_flags: array of Boolean;
  VertexScoreCache: ^TScoreCache;
  VertexScoreLive: ^TScoreLive;

  procedure buildTriangleAdjacency;
  begin
    // allocate arrays
    SetLength(adjacency.counts, vertex_count);
    SetLength(adjacency.offsets, vertex_count);
    SetLength(adjacency.data, index_count);

    // fill triangle counts
    for var i in indices do
      Inc(adjacency.counts[i]);

    // fill offset table
    var offset: Cardinal := 0;
    for var i := Low(adjacency.counts) to High(adjacency.counts) do begin
      adjacency.offsets[i] := offset;
      Inc(offset, adjacency.counts[i]);
    end;
    Assert(offset = index_count);

    // fill triangle data
    for var i: Cardinal := 0 to Pred(face_count) do begin
      var a := indices[i * 3 + 0]; var b := indices[i * 3 + 1]; var c := indices[i * 3 + 2];

      adjacency.data[adjacency.offsets[a]] := i;
      Inc(adjacency.offsets[a]);
      adjacency.data[adjacency.offsets[b]] := i;
      Inc(adjacency.offsets[b]);
      adjacency.data[adjacency.offsets[c]] := i;
      Inc(adjacency.offsets[c]);
    end;

    // fix offsets that have been disturbed by the previous pass
    for var i := 0 to Pred(vertex_count) do begin
      Assert(adjacency.offsets[i] >= adjacency.counts[i]);
      Dec(adjacency.offsets[i], adjacency.counts[i]);
    end;
  end;

  function vertexScore(cache_position: Integer; live_triangles: Cardinal): Single;
  begin
    Assert( (cache_position >= -1) and (cache_position < int(kCacheSizeMax)) );

    var live_triangles_clamped := IfThen(live_triangles < kValenceMax, live_triangles, kValenceMax);
    Result := vertexScoreCache[1 + cache_position] + vertexScoreLive[live_triangles_clamped];
  end;

  function getNextTriangleDeadEnd(var input_cursor: Cardinal): Cardinal;
  begin
    // input order
    while input_cursor < face_count do begin
      if not emitted_flags[input_cursor] then
        Exit(input_cursor);

      Inc(input_cursor);
    end;

    Result := High(Cardinal);
  end;

begin
  Assert(Length(indices) mod 3 = 0);

  index_count := Length(indices);
  if index_count = 0 then
    Exit;

  vertex_count := GetVertexCount(indices);
  SetLength(Result, index_count);

  face_count := index_count div 3;

  var cache_size := 16;
  Assert(cache_size <= kCacheSizeMax);

  if aStrip then begin
    VertexScoreCache := @cVertexScoreCacheStrip;
    VertexScoreLive := @cVertexScoreLiveStrip;
  end
  else begin
    VertexScoreCache := @cVertexScoreCache;
    VertexScoreLive := @cVertexScoreLive;
  end;

  // build adjacency information
  buildTriangleAdjacency;

  {$POINTERMATH ON}
  // live triangle counts; note, we alias adjacency.counts as we remove triangles after emitting them so the counts always match
  var live_triangles: PCardinal := @adjacency.counts[0];

  // emitted flags
  SetLength(emitted_flags, face_count);

  // compute initial vertex scores
  var vertex_scores: array of Single;
  SetLength(vertex_scores, vertex_count);
  for var i := 0 to Pred(vertex_count) do
    vertex_scores[i] := vertexScore(-1, live_triangles[i]);

  // compute triangle scores
  var triangle_scores: array of Single;
  SetLength(triangle_scores, face_count);

  for var i := 0 to Pred(face_count) do begin
    var a := indices[i * 3 + 0]; var b := indices[i * 3 + 1]; var c := indices[i * 3 + 2];

    triangle_scores[i] := vertex_scores[a] + vertex_scores[b] + vertex_scores[c];
  end;

  var cache_holder: array [0..1, 0..(kCacheSizeMax + 4) - 1] of Cardinal;
  var cache: PCardinal := @cache_holder[0];
  var cache_new: PCardinal := @cache_holder[1];
  var cache_count := 0;

  var current_triangle: Cardinal := 0;
  var input_cursor: Cardinal := 1;

  var output_triangle: Cardinal := 0;

  while (current_triangle <> High(Cardinal)) do begin
    Assert(output_triangle < face_count);

    var a := indices[current_triangle * 3 + 0];
    var b := indices[current_triangle * 3 + 1];
    var c := indices[current_triangle * 3 + 2];

    // output indices
    Result[output_triangle * 3 + 0] := a;
    Result[output_triangle * 3 + 1] := b;
    Result[output_triangle * 3 + 2] := c;
    Inc(output_triangle);

    // update emitted flags
    emitted_flags[current_triangle] := True;
    triangle_scores[current_triangle] := 0;

    // new triangle
    var cache_write := 0;
    cache_new[cache_write] := a; Inc(cache_write);
    cache_new[cache_write] := b; Inc(cache_write);
    cache_new[cache_write] := c; Inc(cache_write);

    // old triangles
    for var i := 0 to Pred(cache_count) do begin
      var index := cache[i];

      cache_new[cache_write] := index;
      if (index <> a) and (index <> b) and (index <> c) then
        Inc(cache_write);
    end;

    var cache_temp := cache;
    cache := cache_new; cache_new := cache_temp;

    if cache_write > cache_size then
      cache_count := cache_size
    else
      cache_count := cache_write;

    // remove emitted triangle from adjacency data
    // this makes sure that we spend less time traversing these lists on subsequent iterations
    // live triangle counts are updated as a byproduct of these adjustments
    for var k := 0 to 2 do begin
      var index := indices[current_triangle * 3 + k];
      var neighbors: PCardinal := @adjacency.data[adjacency.offsets[index]];
      var neighbors_size := adjacency.counts[index];

      for var i := 0 to Pred(neighbors_size) do begin
        var tri := neighbors[i];

        if tri = current_triangle then begin
          neighbors[i] := neighbors[neighbors_size - 1];
          Dec(adjacency.counts[index]);
          Break;
        end;
      end;
    end;

    var best_triangle := High(Cardinal);
    var best_score: Single := 0;

    // update cache positions, vertex scores and triangle scores, and find next best triangle
    for var i := 0 to Pred(cache_write) do begin
      var index := cache[i];

      // no need to update scores if we are never going to use this vertex
      if adjacency.counts[index] = 0 then
        Continue;

      var cache_position: Integer;
      if i >= cache_size then
        cache_position := -1
      else
        cache_position := i;

      // update vertex score
      var score := vertexScore(cache_position, live_triangles[index]);
      var score_diff := score - vertex_scores[index];

      vertex_scores[index] := score;

      // update scores of vertex triangles
      var neighbors_begin: PCardinal := @adjacency.data[adjacency.offsets[index]];
      var neighbors_end := neighbors_begin + adjacency.counts[index];

      var it := neighbors_begin;
      while it < neighbors_end do begin
        var tri := it^;
        Assert(not emitted_flags[tri]);

        var tri_score := triangle_scores[tri] + score_diff;
        Assert(tri_score > 0);

        best_triangle := IfThen(best_score < tri_score, tri, best_triangle);
        best_score := IfThen(best_score < tri_score, tri_score, best_score);

        triangle_scores[tri] := tri_score;

        Inc(it);
      end;
    end;

    // step through input triangles in order if we hit a dead-end
    current_triangle := best_triangle;

    if current_triangle = High(Cardinal) then
      current_triangle := getNextTriangleDeadEnd(input_cursor);
  end;
  {$POINTERMATH OFF}

  Assert(input_cursor = face_count);
  Assert(output_triangle = face_count);
end;


// https://github.com/zeux/meshoptimizer/blob/master/src/overdrawoptimizer.cpp
function meshopt_optimizeOverdraw(const indices: TTriIndices; const vertices: TVector3Array; aThreshold: Single = 1.05): TTriIndices;
var
  index_count, vertex_count: Cardinal;


  function updateCache(a, b, c, cache_size: Cardinal; var cache_timestamps: array of Cardinal; var timestamp: Cardinal): Cardinal;
  begin
    Result := 0;

    // if vertex is not in cache, put it in cache
    if timestamp - cache_timestamps[a] > cache_size then begin
      cache_timestamps[a] := timestamp;
      Inc(timestamp);
      Inc(Result);
    end;

    if timestamp - cache_timestamps[b] > cache_size then begin
      cache_timestamps[a] := timestamp;
      Inc(timestamp);
      Inc(Result);
    end;

    if timestamp - cache_timestamps[c] > cache_size then begin
      cache_timestamps[a] := timestamp;
      Inc(timestamp);
      Inc(Result);
    end;
  end;

  function generateHardBoundaries(var destination: array of Cardinal; cache_size: Cardinal; var cache_timestamps: array of Cardinal): Integer;
  begin
    FillChar(cache_timestamps, Length(cache_timestamps) * SizeOf(cache_timestamps[0]), 0);

    var timestamp := cache_size + 1;

    var face_count := index_count div 3;

    Result := 0;

    for var i := 0 to Pred(face_count) do begin
      var m := updateCache(indices[i * 3 + 0], indices[i * 3 + 1], indices[i * 3 + 2], cache_size, cache_timestamps, timestamp);

      // when all three vertices are not in the cache it's usually relatively safe to assume that this is a new patch in the mesh
      // that is disjoint from previous vertices; sometimes it might come back to reference existing vertices but that frequently
      // suggests an inefficiency in the vertex cache optimization algorithm
      // usually the first triangle has 3 misses unless it's degenerate - thus we make sure the first cluster always starts with 0
      if (i = 0) or (m = 3) then begin
        destination[Result] := i;
        Inc(Result);
      end;

    end;

    Assert(Cardinal(Result) <= index_count div 3);
  end;

  function generateSoftBoundaries(var destination: array of Cardinal;
    const clusters: array of Cardinal; cluster_count: Integer;
    cache_size: Cardinal; var cache_timestamps: array of Cardinal): Integer;
  begin
    FillChar(cache_timestamps, Length(cache_timestamps) * SizeOf(cache_timestamps[0]), 0);

    var timestamp: Cardinal := 0;
    Result := 0;

    for var it := 0 to Pred(cluster_count) do begin
      var start := clusters[it];
      var end_ := IfThen(it + 1 < cluster_count, clusters[it + 1], index_count div 3);
      Assert(start < end_);

      // reset cache
      Inc(timestamp, cache_size + 1);

      // measure cluster ACMR
      var cluster_misses: Cardinal := 0;

      for var i := start to Pred(end_) do begin
        var m := updateCache(indices[i * 3 + 0], indices[i * 3 + 1], indices[i * 3 + 2], cache_size, cache_timestamps, timestamp);

        Inc(cluster_misses, m);
      end;

      var cluster_threshold := aThreshold * (Single(cluster_misses) / Single(end_ - start));

      // first cluster always starts from the hard cluster boundary
      destination[Result] := Cardinal(start);
      Inc(Result);

      // reset cache
      Inc(timestamp, cache_size + 1);

      var running_misses: Cardinal := 0;
      var running_faces: Cardinal := 0;

      for var i := start to Pred(end_) do begin
        var m := updateCache(indices[i * 3 + 0], indices[i * 3 + 1], indices[i * 3 + 2], cache_size, cache_timestamps, timestamp);

        Inc(running_misses, m);
        Inc(running_faces);

        if Single(running_misses) / Single(running_faces) <= cluster_threshold then begin
          // we have reached the target ACMR with the current triangle so we need to start a new cluster on the next one
          // note that this may mean that we add 'end` to destination for the last triangle, which will imply that the last
          // cluster is empty; however, the 'pop_back' after the loop will clean it up
          destination[Result] := Cardinal(i + 1);
          Inc(Result);

          // reset cache
          Inc(timestamp, cache_size + 1);

          running_misses := 0;
          running_faces := 0;
        end;

      end;

      // each time we reach the target ACMR we flush the cluster
      // this means that the last cluster is by definition not very good - there are frequent cases where we are left with a few triangles
      // in the last cluster, producing a very bad ACMR and significantly penalizing the overall results
      // thus we remove the last cluster boundary, merging the last complete cluster with the last incomplete one
      // there are sometimes cases when the last cluster is actually good enough - in which case the code above would have added 'end'
      // to the cluster boundary array which we need to remove anyway - this code will do that automatically
      if destination[Result - 1] <> start then
        Dec(Result);

    end;

    Assert(Result >= cluster_count);
    Assert(Result <= index_count / 3);

  end;

  procedure calculateSortData(var sort_data: array of Double; const clusters: array of Cardinal; cluster_count: Integer);
  begin
    var mesh_centroid: TVector3;

    for var i in indices do
      mesh_centroid := mesh_centroid + vertices[i];

    mesh_centroid := mesh_centroid / index_count;

    for var cluster := 0 to Pred(cluster_count) do begin
      var cluster_begin := clusters[cluster] * 3;
      var cluster_end := IfThen(cluster + 1 < cluster_count, clusters[cluster + 1] * 3, index_count);
      Assert(cluster_begin < cluster_end);

      var cluster_area: Double := 0;
      var cluster_centroid: TVector3;
      var cluster_normal: TVector3;

      var i := cluster_begin;
      while i < cluster_end do begin
        var p0 := indices[i + 0];
        var p1 := indices[i + 1];
        var p2 := indices[i + 2];

        var p10 := vertices[p1] - vertices[p0];
        var p20 := vertices[p2] - vertices[p0];

        var normal := Vector3Cross(p10, p20);
        var area := normal.Length;

        cluster_centroid.x := cluster_centroid.x + (vertices[p0].x + vertices[p1].x + vertices[p2].x) * (area / 3);
        cluster_centroid.y := cluster_centroid.y + (vertices[p0].y + vertices[p1].y + vertices[p2].y) * (area / 3);
        cluster_centroid.z := cluster_centroid.z + (vertices[p0].z + vertices[p1].z + vertices[p2].z) * (area / 3);

        cluster_normal := cluster_normal + normal;
        cluster_area := cluster_area + area;

        Inc(i, 3);
      end;

      var inv_cluster_area := IfThen(SameValue(cluster_area, 0), 0, 1 / cluster_area);
      cluster_centroid := cluster_centroid * inv_cluster_area;

      var cluster_normal_length := cluster_normal.Length;
      var inv_cluster_normal_length := IfThen(SameValue(cluster_normal_length, 0), 0, 1 / cluster_normal_length);
      cluster_normal := cluster_normal * inv_cluster_normal_length;

      var centroid_vector := cluster_centroid - mesh_centroid;
      sort_data[cluster] := centroid_vector.x * cluster_normal.x + centroid_vector.y * cluster_normal.y + centroid_vector.z * cluster_normal.z;
    end;
  end;

  procedure calculateSortOrderRadix(var sort_order: array of Cardinal; const sort_data: array of Double;
    var sort_keys: array of Word; cluster_count: Integer);
  const
    sort_bits = 11;
  begin
    // compute sort data bounds and renormalize, using fixed point snorm
    var sort_data_max: Double := 1e-3;

    for var i := 0 to Pred(cluster_count) do begin
      var dpa := Abs(sort_data[i]);

      sort_data_max := IfThen(sort_data_max < dpa, dpa, sort_data_max);
    end;

    for var i := 0 to Pred(cluster_count) do begin
      // note that we flip distribution since high dot product should come first
      var sort_key := 0.5 - 0.5 * (sort_data[i] / sort_data_max);

      sort_keys[i] := meshopt_quantizeUnorm(sort_key, sort_bits) and ((1 shl sort_bits) - 1);
    end;

    // fill histogram for counting sort
    var histogram: array of Cardinal;
    SetLength(histogram, 1 shl sort_bits);

    for var i := 0 to Pred(cluster_count) do
      Inc(histogram[sort_keys[i]]);

    // compute offsets based on histogram data
    var histogram_sum := 0;

    for var i := 0 to Pred(1 shl sort_bits) do begin
      var count := histogram[i];
      histogram[i] := histogram_sum;
      Inc(histogram_sum, count);
    end;

    Assert(histogram_sum = cluster_count);

    // compute sort order based on offsets
    for var i := 0 to Pred(cluster_count) do begin
      sort_order[histogram[sort_keys[i]]] := i;
      Inc(histogram[sort_keys[i]]);
    end;

  end;

begin
  Assert(Length(indices) mod 3 = 0);

  index_count := Length(indices);
  vertex_count := Length(vertices);

  if (index_count = 0) or (vertex_count = 0) then
    Exit;

  var cache_size := 16;

  var cache_timestamps: array of Cardinal;
  SetLength(cache_timestamps, vertex_count);

  // generate hard boundaries from full-triangle cache misses
  var hard_clusters: array of Cardinal;
  SetLength(hard_clusters, index_count div 3);

  var hard_cluster_count := generateHardBoundaries(hard_clusters, cache_size, cache_timestamps);

  // generate soft boundaries
  var clusters: array of Cardinal;
  SetLength(clusters, index_count div 3 + 1);

  var cluster_count := generateSoftBoundaries(clusters, hard_clusters, hard_cluster_count, cache_size, cache_timestamps);

  // fill sort data
  var sort_data: array of Double;
  SetLength(sort_data, cluster_count);
  calculateSortData(sort_data, clusters, cluster_count);

  // sort clusters using sort data
  var sort_keys: array of Word;
  SetLength(sort_keys, cluster_count);
  var sort_order: array of Cardinal;
  SetLength(sort_order, cluster_count);

  calculateSortOrderRadix(sort_order, sort_data, sort_keys, cluster_count);

  // fill output buffer
  var offset := 0;
  SetLength(Result, index_count);

  for var it := 0 to Pred(cluster_count) do begin
    var cluster := sort_order[it];
    Assert(cluster < Cardinal(cluster_count));

    var cluster_begin := clusters[cluster] * 3;
    var cluster_end := IfThen(cluster + 1 < Cardinal(cluster_count), clusters[cluster + 1] * 3, index_count);
    Assert(cluster_begin < cluster_end);

    System.Move(indices[cluster_begin], Result[offset], (cluster_end - cluster_begin) * SizeOf(indices[0]));
    Inc(offset, cluster_end - cluster_begin);
  end;

  Assert(Cardinal(offset) = index_count);
end;



function meshopt_optimizeVertexFetchRemap(const indices: TTriIndices): TTriIndices;
begin
  Assert(Length(indices) mod 3 = 0);

  var index_count := Length(indices);
  if index_count = 0 then
    Exit;

  var vertex_count := GetVertexCount(indices);

  SetLength(Result, vertex_count);
  FillChar(Result[0], SizeOf(Result[0]) * Length(Result), $FF);

  var next_vertex: Cardinal := 0;

  for var index in indices do
    if Result[index] = High(Cardinal) then begin
      Result[index] := next_vertex;
      Inc(next_vertex);
    end;

  Assert(next_vertex <= vertex_count);
end;

function meshopt_remapIndices(const indices: TTriIndices; const remap: TTriIndices): TTriIndices;
begin
  Assert(Length(indices) mod 3 = 0);
  SetLength(Result, Length(indices));

  for var i := Low(indices) to High(indices) do begin
    var index := indices[i];
    Assert(remap[index] <> High(Cardinal));

    Result[i] := remap[index];
  end;
end;

end.
