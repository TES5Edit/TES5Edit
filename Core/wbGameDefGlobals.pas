unit wbGameDefGlobals;

interface

uses
  System.Classes,
  System.SysUtils,
  wbInterface;

function wbHEDRVersion: Double; inline;
function wbHEDRNextObjectID: Integer; inline;
function wbHeaderSignature: TwbSignature; inline;
function wbNexusModsUrl: string; inline;
function wbIgnoreRecords: TStringList; inline;
function wbGroupOrder: TStringList; inline;
function wbFileMagic: TwbFileMagic; inline;
function wbFilePlugins: string; inline;
function wbActorValueEnum: IwbEnumDef; inline;
function wbFileHeader: IwbStructDef; inline;
function wbFileChapters: IwbStructDef; inline;
function wbExtractInfo: PByteSet; inline;
function wbOfficialDLC: TArray<string>; inline;
function wbRecordFlags: IwbIntegerDef; inline;
function wbMainRecordHeader: IwbValueDef; inline;
function wbSizeOfMainRecordStruct: Integer; inline;
function wbRecordDefs: TwbRecordDefEntries; inline;
function wbArchiveExtension: string; inline;
function Files: TwbFiles; inline;
function wbIgnoreLight: Boolean; inline;
function wbPseudoLight: Boolean; inline;
function wbIgnoreMedium: Boolean; inline;
function wbPseudoMedium: Boolean; inline;
function wbIgnoreUpdate: Boolean; inline;
function wbPseudoUpdate: Boolean; inline;
function wbRequireLoadOrder: Boolean; inline;
function wbPluginsFileName: string; inline;
function wbModGroupFileName: string; inline;
function wbEnforceAllMasters: Boolean; inline;
function wbAllowESPMasters: Boolean; inline;
function wbAllowESPMastersOnSave: Boolean; inline;
function wbAlwaysLoadGameMaster: Boolean; inline;
function wbUseFalsePlugins: Boolean; inline;
function wbCreateContainedIn: Boolean; inline;
function wbDelayLoadRecords: Boolean; inline;
function wbCreationClubContentFileName: string; inline;
function wbCreationClubContent: TArray<string>; inline;
function wbDataPath: string; inline;
function wbOutputPath: string; inline;
function wbScriptsPath: string; inline;
function wbBackupPath: string; inline;
function wbCachePath: string; inline;
function wbTempPath: string; inline;
function wbSavePath: string; inline;
function wbMyGamesTheGamePath: string; inline;
function wbTheGameIniFileName: string; inline;
function wbCustomIniFileName: string; inline;
function wbShouldLoadMOHookFile: Boolean; inline;
function wbMOProfile: string; inline;
function wbMOHookFile: string; inline;
function wbLanguage: string; inline;
function wbEncoding: TEncoding; inline;
function wbEncodingTrans: TEncoding; inline;
function wbLoadBSAs: Boolean; inline;
function wbLoadAllBSAs: Boolean; inline;
function wbBuildRefs: Boolean; inline;
function RecordToSkip: TStringList; inline;
function SubRecordToSkip: TStringList; inline;
function GroupToSkip: TStringList; inline;
function ChaptersToSkip: TStringList; inline;

implementation

function wbHEDRVersion: Double;
begin
  Result := _CurrentGameDef.HEDRVersion;
end;

function wbHEDRNextObjectID: Integer;
begin
  Result := _CurrentGameDef.HEDRNextObjectID;
end;

function wbHeaderSignature: TwbSignature;
begin
  Result := _CurrentGameDef.HeaderSignature;
end;

function wbNexusModsUrl: string;
begin
  Result := _CurrentGameDef.NexusModsUrl;
end;

function wbIgnoreRecords: TStringList;
begin
  Result := _CurrentGameDef.IgnoreRecords;
end;

function wbGroupOrder: TStringList;
begin
  Result := _CurrentGameDef.GroupOrder;
end;

function wbFileMagic: TwbFileMagic;
begin
  Result := _CurrentGameDef.FileMagic;
end;

function wbFilePlugins: string;
begin
  Result := _CurrentGameDef.FilePlugins;
end;

function wbActorValueEnum: IwbEnumDef;
begin
  Result := _CurrentGameDef.ActorValueEnum;
end;

function wbFileHeader: IwbStructDef;
begin
  Result := _CurrentGameDef.FileHeader;
end;

function wbFileChapters: IwbStructDef;
begin
  Result := _CurrentGameDef.FileChapters;
end;

function wbExtractInfo: PByteSet;
begin
  Result := _CurrentGameDef.ExtractInfo;
end;

function wbOfficialDLC: TArray<string>;
begin
  Result := _CurrentGameDef.OfficialDLC;
end;

function wbRecordFlags: IwbIntegerDef;
begin
  Result := _CurrentGameDef.RecordFlags;
end;

function wbMainRecordHeader: IwbValueDef;
begin
  Result := _CurrentGameDef.MainRecordHeader;
end;

function wbSizeOfMainRecordStruct: Integer;
begin
  Result := _CurrentGameDef.SizeOfMainRecordStruct;
end;

function wbRecordDefs: TwbRecordDefEntries;
begin
  Result := _CurrentGameDef.RecordDefs;
end;

function wbArchiveExtension: string;
begin
  Result := _CurrentGameDef.ArchiveExtension;
end;

function Files: TwbFiles;
begin
  Result := _CurrentContext.Files;
end;

function wbIgnoreLight: Boolean;
begin
  Result := _CurrentContext.Settings.IgnoreLight;
end;

function wbPseudoLight: Boolean;
begin
  Result := _CurrentContext.Settings.PseudoLight;
end;

function wbIgnoreMedium: Boolean;
begin
  Result := _CurrentContext.Settings.IgnoreMedium;
end;

function wbPseudoMedium: Boolean;
begin
  Result := _CurrentContext.Settings.PseudoMedium;
end;

function wbIgnoreUpdate: Boolean;
begin
  Result := _CurrentContext.Settings.IgnoreUpdate;
end;

function wbPseudoUpdate: Boolean;
begin
  Result := _CurrentContext.Settings.PseudoUpdate;
end;

function wbRequireLoadOrder: Boolean;
begin
  Result := _CurrentContext.Settings.RequireLoadOrder;
end;

function wbPluginsFileName: string;
begin
  Result := _CurrentContext.Settings.PluginsFileName;
end;

function wbModGroupFileName: string;
begin
  Result := _CurrentContext.Settings.ModGroupFileName;
end;

function wbEnforceAllMasters: Boolean;
begin
  Result := _CurrentContext.Settings.EnforceAllMasters;
end;

function wbAllowESPMasters: Boolean;
begin
  Result := _CurrentContext.Settings.AllowESPMasters;
end;

function wbAllowESPMastersOnSave: Boolean;
begin
  Result := _CurrentContext.Settings.AllowESPMastersOnSave;
end;

function wbAlwaysLoadGameMaster: Boolean;
begin
  Result := _CurrentContext.Settings.AlwaysLoadGameMaster;
end;

function wbUseFalsePlugins: Boolean;
begin
  Result := _CurrentContext.Settings.UseFalsePlugins;
end;

function wbCreateContainedIn: Boolean;
begin
  Result := _CurrentContext.Settings.CreateContainedIn;
end;

function wbDelayLoadRecords: Boolean;
begin
  Result := _CurrentContext.Settings.DelayLoadRecords;
end;

function wbCreationClubContentFileName: string;
begin
  Result := _CurrentContext.Settings.CreationClubContentFileName;
end;

function wbCreationClubContent: TArray<string>;
begin
  Result := _CurrentContext.Settings.CreationClubContent;
end;

function wbDataPath: string;
begin
  Result := _CurrentContext.Settings.DataPath;
end;

function wbOutputPath: string;
begin
  Result := _CurrentContext.Settings.OutputPath;
end;

function wbScriptsPath: string;
begin
  Result := _CurrentContext.Settings.ScriptsPath;
end;

function wbBackupPath: string;
begin
  Result := _CurrentContext.Settings.BackupPath;
end;

function wbCachePath: string;
begin
  Result := _CurrentContext.Settings.CachePath;
end;

function wbTempPath: string;
begin
  Result := _CurrentContext.Settings.TempPath;
end;

function wbSavePath: string;
begin
  Result := _CurrentContext.Settings.SavePath;
end;

function wbMyGamesTheGamePath: string;
begin
  Result := _CurrentContext.Settings.MyGamesTheGamePath;
end;

function wbTheGameIniFileName: string;
begin
  Result := _CurrentContext.Settings.TheGameIniFileName;
end;

function wbCustomIniFileName: string;
begin
  Result := _CurrentContext.Settings.CustomIniFileName;
end;

function wbShouldLoadMOHookFile: Boolean;
begin
  Result := _CurrentContext.Settings.ShouldLoadMOHookFile;
end;

function wbMOProfile: string;
begin
  Result := _CurrentContext.Settings.MOProfile;
end;

function wbMOHookFile: string;
begin
  Result := _CurrentContext.Settings.MOHookFile;
end;

function wbLanguage: string;
begin
  Result := _CurrentContext.Settings.Language;
end;

function wbEncoding: TEncoding;
begin
  Result := _CurrentContext.Settings.Encoding;
end;

function wbEncodingTrans: TEncoding;
begin
  Result := _CurrentContext.Settings.EncodingTrans;
end;

function wbLoadBSAs: Boolean;
begin
  Result := _CurrentContext.Settings.LoadBSAs;
end;

function wbLoadAllBSAs: Boolean;
begin
  Result := _CurrentContext.Settings.LoadAllBSAs;
end;

function wbBuildRefs: Boolean;
begin
  Result := _CurrentContext.Settings.BuildRefs;
end;

function RecordToSkip: TStringList;
begin
  Result := _CurrentContext.RecordToSkip;
end;

function SubRecordToSkip: TStringList;
begin
  Result := _CurrentContext.SubRecordToSkip;
end;

function GroupToSkip: TStringList;
begin
  Result := _CurrentContext.GroupToSkip;
end;

function ChaptersToSkip: TStringList;
begin
  Result := _CurrentContext.ChaptersToSkip;
end;

end.
