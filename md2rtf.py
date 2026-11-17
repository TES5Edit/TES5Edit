#!/usr/bin/env python3
r"""
md2rtf.py - convert whatsnew.md into whatsnew.rtf for the editor's What's New tab.

Usage:
    python md2rtf.py whatsnew.md whatsnew.rtf [--stop-before "# What's new in xEdit 4.0.5?"]

The RTF carries the Markdown's structure the way GitHub shows it:
    # .. ####     -> bold headings of decreasing size (18 / 16 / 14 / 13 pt); # and ## ruled beneath (an empty table row's border)
    body text     -> 12pt
    `code`        -> Consolas on a shaded box (a code span inside a heading stays heading text)
    ``` fences    -> Consolas lines on a shaded box
    *x* / _x_     -> italic        ~~x~~ -> strike-through        **x** / __x__ -> bold
    URLs          -> link colour, underlined
    * / - items   -> bullet lists, up to three levels by nesting (a deeper indentation than the item above is its child);
                     1. items -> numbered; a following line without a marker continues the item
    lines         -> joined into one paragraph until a blank line
    \x escapes    -> the literal character

Colours are named by slot in the colour table, so the editor can fill them from the active style when it loads the text:
    1 text, 2 code box, 3 link, 4 rule, 5 code text
The values written here are the light defaults; {\*\xeditcolors} after the table tells the editor the slots are these.
"""
import re
import sys

FONT = r'\f0'
CODE_FONT = r'\f1'
HEADING_FS = {1: 36, 2: 32, 3: 28, 4: 26, 5: 26, 6: 26}
HEADING_SB = {1: 360, 2: 300, 3: 240, 4: 200, 5: 200, 6: 200}
BODY_FS = 24
CODE_FS = 21
RULED = {1, 2}

COLORS = ((31, 35, 40), (239, 241, 243), (9, 105, 218), (208, 215, 222), (31, 35, 40))
COLORTBL = '{\\colortbl;' + ''.join('\\red%d\\green%d\\blue%d;' % c for c in COLORS) + '}'

TEXT, CODEBOX, LINK, RULE, CODETEXT = 1, 2, 3, 4, 5

# an ignorable destination telling the editor the colour table holds these slots, so it may refill them from the active style
PALETTE_MARKER = r'{\*\xeditcolors}'

BULLETS = ('\\u8226?', '\\u9702?', '\\u9642?')

BOM = chr(0xFEFF)

# the rule beneath a # / ## heading: RichEdit draws no paragraph border, but it draws a table cell's; an empty one-cell row of exact
# height, wider than any window (clipped at the window's edge), then a small gap
RULE_ROW = ('\\trowd\\trgaph0\\trleft0\\trrh-60\\clbrdrb\\brdrs\\brdrw10\\brdrcf%d\\cellx40000'
            '\\pard\\intbl\\sa0\\sb0{%s\\fs4\\cf%d \\~}\\cell\\row\r\n'
            '\\pard\\sa0\\sb0{%s\\fs8\\cf%d \\~}\\par' % (RULE, FONT, TEXT, FONT, TEXT))

INLINE = re.compile(
    r'(?P<code>`+)(?P<codetext>.+?)(?P=code)'
    r'|\*\*(?P<bold>.+?)\*\*'
    r'|__(?P<bold2>.+?)__'
    r'|~~(?P<strike>.+?)~~'
    r'|(?<![\w*])\*(?P<italic>[^*\s](?:[^*]*[^*\s])?)\*(?![\w*])'
    r'|(?<![\w_])_(?P<italic2>[^_\s](?:[^_]*[^_\s])?)_(?![\w_])'
    r'|(?P<url>https?://[^\s<>()\]]*[^\s<>()\].,;:!?\'"])'
    r'|\\(?P<escaped>[!-/:-@\[-`{-~])'
)


def esc(s):
    """Escape text for RTF; non-ASCII -> \\uN?; drop a BOM and control characters other than tab."""
    out = []
    for ch in s:
        if ch == BOM or (ch < ' ' and ch != '\t'):
            continue
        if ch == '\\':
            out.append('\\\\')
        elif ch == '{':
            out.append('\\{')
        elif ch == '}':
            out.append('\\}')
        elif ch == '\t':
            out.append('\\tab ')
        else:
            c = ord(ch)
            if c < 128:
                out.append(ch)
            elif c > 0xFFFF:
                c -= 0x10000
                for unit in (0xD800 + (c >> 10), 0xDC00 + (c & 0x3FF)):
                    out.append('\\u%d?' % (unit - 65536))
            else:
                n = c if c <= 32767 else c - 65536
                out.append('\\u%d?' % n)
    return ''.join(out)


def code_run(text):
    return r'{%s\fs%d\cf%d\highlight%d %s}' % (CODE_FONT, CODE_FS, CODETEXT, CODEBOX, esc(text))


def inline(s, plain_code=False):
    """Process inline Markdown. Square brackets are literal: this document uses them for game tags ([TES4], [FE 001]), not links."""
    out = []
    pos = 0
    for m in INLINE.finditer(s):
        out.append(esc(s[pos:m.start()]))
        pos = m.end()
        if m.group('code'):
            text = m.group('codetext')
            if len(m.group('code')) > 1 and text.startswith(' ') and text.endswith(' ') and text.strip():
                text = text[1:-1]
            out.append(esc(text) if plain_code else code_run(text))
        elif m.group('bold') is not None or m.group('bold2') is not None:
            out.append(r'{\b ' + inline(m.group('bold') or m.group('bold2'), plain_code) + '}')
        elif m.group('strike') is not None:
            out.append(r'{\strike ' + inline(m.group('strike'), plain_code) + '}')
        elif m.group('italic') is not None or m.group('italic2') is not None:
            out.append(r'{\i ' + inline(m.group('italic') or m.group('italic2'), plain_code) + '}')
        elif m.group('url'):
            out.append(r'{\ul\cf%d %s}' % (LINK, esc(m.group('url'))))
        else:
            out.append(esc(m.group('escaped')))
    out.append(esc(s[pos:]))
    return ''.join(out)


def convert(md_text, stop_before=None):
    md_text = md_text.replace(BOM, '')
    lines = md_text.replace('\r\n', '\n').replace('\r', '\n').split('\n')
    body = []
    in_fence = False
    indents = []    # the marker columns of the open list levels
    pending = []    # a paragraph or list item still collecting its lines: [head, text, tail]
    fence = []      # the lines of the open fenced block, written padded to one width when it closes

    def flush():
        if pending:
            head, text, tail = pending
            body.append(head + inline(text) + tail)
            pending.clear()

    def write_fence():
        width = max((len(f) for f in fence), default=0)
        for f in fence:
            body.append(r'\pard\li360\sa0\sb0{%s\fs%d\cf%d\highlight%d \~%s%s}\par'
                        % (CODE_FONT, CODE_FS, CODETEXT, CODEBOX, esc(f), r'\~' * (width - len(f) + 1)))
        fence.clear()

    def list_level(indent):
        while indents and indent < indents[-1]:
            indents.pop()
        if not indents or indent > indents[-1]:
            indents.append(indent)
        return min(len(indents) - 1, 2)

    for raw in lines:
        line = raw.rstrip()
        stripped = line.strip()

        if stop_before is not None and stripped == stop_before:
            break

        if stripped.startswith('```'):
            flush()
            if in_fence:
                write_fence()
            in_fence = not in_fence
            body.append(r'\pard\sa0\sb0{%s\fs8\cf%d \~}\par' % (FONT, TEXT))
            continue
        if in_fence:
            fence.append(line.expandtabs(2))
            continue
        if not stripped:
            flush()
            continue

        m = re.match(r'^(#{1,6})\s+(.*?)(?:\s+#+)?$', stripped)
        if m:
            flush()
            indents.clear()
            level = len(m.group(1))
            text = inline(m.group(2), plain_code=True)
            if level in RULED:
                body.append(r'\pard\keepn\sb%d\sa60{\b%s\fs%d\cf%d %s}\par' % (HEADING_SB[level], FONT, HEADING_FS[level], TEXT, text))
                body.append(RULE_ROW)
            else:
                body.append(r'\pard\keepn\sb%d\sa180{\b%s\fs%d\cf%d %s}\par' % (HEADING_SB[level], FONT, HEADING_FS[level], TEXT, text))
            continue

        om = re.match(r'^(\s*)([0-9]+)[.)]\s+(.*)$', line)
        bm = None if om else re.match(r'^(\s*)[*\-+]\s+(.*)$', line)
        if om or bm:
            flush()
            item = om or bm
            li = 360 * (list_level(len(item.group(1))) + 1)
            marker = (item.group(2) + '.') if om else BULLETS[min(len(indents) - 1, 2)]
            pending.extend([r'\pard\fi-360\li%d\tx%d\sa40{%s\fs%d\cf%d %s\tab ' % (li, li, FONT, BODY_FS, TEXT, marker),
                            item.group(item.lastindex), r'}\par'])
            continue

        if pending:
            pending[1] += ' ' + stripped
        else:
            pending.extend([r'\pard\sa120{%s\fs%d\cf%d ' % (FONT, BODY_FS, TEXT), stripped, r'}\par'])

    flush()
    write_fence()
    preamble = (r'{\rtf1\ansi\ansicpg1252\deff0'
                r'{\fonttbl{\f0\fswiss\fcharset0 Segoe UI;}{\f1\fmodern\fcharset0 Consolas;}}'
                + COLORTBL + PALETTE_MARKER + '\r\n')
    return preamble + '\r\n'.join(body) + '\r\n}\r\n'


def main():
    args = sys.argv[1:]
    stop_before = None
    if '--stop-before' in args:
        i = args.index('--stop-before')
        if i + 1 >= len(args):
            sys.exit('usage: python md2rtf.py input.md output.rtf [--stop-before "<line>"]')
        stop_before = args[i + 1]
        del args[i:i + 2]
    if len(args) != 2:
        sys.exit('usage: python md2rtf.py input.md output.rtf [--stop-before "<line>"]')
    md = open(args[0], encoding='utf-8').read()
    rtf = convert(md, stop_before=stop_before)
    open(args[1], 'wb').write(rtf.encode('ascii'))
    print('wrote %s (%d bytes)' % (args[1], len(rtf)))


if __name__ == '__main__':
    main()
