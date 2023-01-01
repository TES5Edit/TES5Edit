program Sniff;

uses
  Vcl.Forms,
  frmMain in 'frmMain.pas' {FormMain},
  SniffProcessor in 'SniffProcessor.pas',
  ProcTangents in 'Proc\ProcTangents.pas' {FrameTangents: TFrame},
  ProcTriangulate in 'Proc\ProcTriangulate.pas' {FrameTriangulate: TFrame},
  frMessages in 'frMessages.pas' {FrameMessages: TFrame},
  ProcReplaceAssets in 'Proc\ProcReplaceAssets.pas' {FrameReplaceAssets: TFrame},
  ProcJamAnim in 'Proc\ProcJamAnim.pas' {FrameJamAnim: TFrame},
  ProcWeiExplosion in 'Proc\ProcWeiExplosion.pas' {FrameWeiExplosion: TFrame},
  ProcAttachParent in 'Proc\ProcAttachParent.pas' {FrameAttachParent: TFrame},
  ProcCopyControlledBlocks in 'Proc\ProcCopyControlledBlocks.pas' {FrameCopyControlledBlocks: TFrame},
  ProcParallaxUpdate in 'Proc\ProcParallaxUpdate.pas' {FrameParallaxUpdate: TFrame},
  ProcMoppUpdate in 'Proc\ProcMoppUpdate.pas' {FrameMoppUpdate: TFrame},
  ProcUnweldedVertices in 'Proc\ProcUnweldedVertices.pas' {FrameUnweldedVertices: TFrame},
  ProcFindSeveralStrips in 'Proc\ProcFindSeveralStrips.pas' {FrameFindSeveralStrips: TFrame},
  ProcHavokSettingsUpdate in 'Proc\ProcHavokSettingsUpdate.pas' {FrameHavokSettings: TFrame},
  ProcRenameControlledBlocks in 'Proc\ProcRenameControlledBlocks.pas' {FrameRenameControlledBlocks: TFrame},
  ProcCopyGeometryBlocks in 'Proc\ProcCopyGeometryBlocks.pas' {FrameCopyGeometryBlocks: TFrame},
  ProcCollapseLinksArrays in 'Proc\ProcCollapseLinksArrays.pas' {FrameCollapseLinksArrays: TFrame},
  ProcVertexPaint in 'Proc\ProcVertexPaint.pas' {FrameVertexPaint: TFrame},
  frmVertexPaintHelper in 'Proc\frmVertexPaintHelper.pas' {FormVertexPaintHelper},
  ProcGroupShapes in 'Proc\ProcGroupShapes.pas' {FrameGroupShapes: TFrame},
  ProcRemoveControlledBlocks in 'Proc\ProcRemoveControlledBlocks.pas' {FrameRemoveControlledBlocks: TFrame},
  ProcFixExportedKFAnim in 'Proc\ProcFixExportedKFAnim.pas' {FrameFixExportedKFAnim: TFrame},
  ProcRemoveUnusedNodes in 'Proc\ProcRemoveUnusedNodes.pas' {FrameRemoveUnusedNodes: TFrame},
  ProcConvertRootNode in 'Proc\ProcConvertRootNode.pas' {FrameConvertRootNode: TFrame},
  ProcMergeShapes in 'Proc\ProcMergeShapes.pas' {FrameMergeShapes: TFrame},
  ProcShaderFlagsUpdate in 'Proc\ProcShaderFlagsUpdate.pas' {FrameShaderFlagsUpdate: TFrame},
  ProcPriorityControlledBlocks in 'Proc\ProcPriorityControlledBlocks.pas' {FramePriorityControlledBlocks: TFrame},
  ProcConvertFO3Collision in 'Proc\ProcConvertFO3Collision.pas' {FrameConvertFO3Collision: TFrame},
  ProcOptimizeKF in 'Proc\ProcOptimizeKF.pas' {FrameOptimizeKF: TFrame},
  ProcUniversalTweaker in 'Proc\ProcUniversalTweaker.pas' {FrameUniversalTweaker: TFrame},
  ProcJsonConverter in 'Proc\ProcJsonConverter.pas' {FrameJsonConverter: TFrame},
  ProcAddHeadtrackingAnim in 'Proc\ProcAddHeadtrackingAnim.pas' {FrameAddHeadtrackingAnim: TFrame},
  ProcCheckForErrors in 'Proc\ProcCheckForErrors.pas' {FrameCheckForErrors: TFrame},
  ProcAnimQuadraticToLinear in 'Proc\ProcAnimQuadraticToLinear.pas' {FrameAnimQuadraticToLinear: TFrame},
  ProcInertiaUpdate in 'Proc\ProcInertiaUpdate.pas' {Frame1: TFrame},
  ProcRagdollConstraintUpdate in 'Proc\ProcRagdollConstraintUpdate.pas' {FrameRagdollConstraintUpdate: TFrame},
  ProcRenameStrings in 'Proc\ProcRenameStrings.pas' {FrameRenameStrings: TFrame},
  ProcAnimSkeletonDeath in 'Proc\ProcAnimSkeletonDeath.pas' {FrameAnimSkeletonDeath: TFrame},
  ProcAdjustTransform in 'Proc\ProcAdjustTransform.pas' {FrameAdjustTransform: TFrame},
  ProcChangePartitionSlot in 'Proc\ProcChangePartitionSlot.pas' {FrameChangePartitionSlot: TFrame},
  ProcUpdateBounds in 'Proc\ProcUpdateBounds.pas' {FrameUpdateBounds: TFrame},
  wbDataFormat in '..\..\Core\wbDataFormat.pas',
  wbDataFormatMaterial in '..\..\Core\wbDataFormatMaterial.pas',
  wbDataFormatNif in '..\..\Core\wbDataFormatNif.pas',
  wbDataFormatNifTypes in '..\..\Core\wbDataFormatNifTypes.pas',
  wbDataFormatMisc in '..\..\Core\wbDataFormatMisc.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
