#define GameName "Adventures on LEGO Island"
#define GameVersion "Pre-Alpha (October 1996)"
#define GamePublisher "Mindscape Inc."

[Setup]
; Core Settings
MinVersion=6.0
AppId={#GameName}
AppName={#GameName}
AppVerName={#GameVersion}
AppCopyright=1996 {#GamePublisher}

; Uninstallation Settings
UninstallFilesDir={app}
UninstallDisplayIcon=../res/isle.ico
CreateUninstallRegKey=yes
UninstallDisplayName={#GameName}

; Binary Output Settings
OutputDir=../bin
OutputBaseFilename=adventuresinstaller

; Misc Settings
DisableWelcomePage=no
DisableDirPage=no
DisableProgramGroupPage=yes
WizardImageFile=../res/install.bmp
SetupIconFile=../res/isle.ico

DefaultDirName={commonpf}\LEGO Island
DefaultGroupName=Lego

[Languages]
Name: "English"; MessagesFile: "compiler:Default.isl"

[Messages]
; Override WelcomeLabel2 as the default string is awkward in this scenario
English.WelcomeLabel2=This will install {#GameName} {#GameVersion} on your computer.

[Files]
Source: "../res/d3drm.dll"; DestDir: "{app}"
Source: "{code:GetSourceDrive}DATA\DISK\*"; DestDir: "{app}"; Flags: external
Source: "{code:GetSourceDrive}LEGO\*"; DestDir: "{app}\LEGO"; Flags: external recursesubdirs
Source: "{code:GetSourceDrive}SETUP\REGISTRY.EXE"; DestDir: "{app}"; Flags: external
Source: "{code:GetSourceDrive}MSREG\MSRUN.EXE"; DestDir: "{app}"; Flags: external
Source: "{code:GetSourceDrive}MSREG\MSREG.INI"; DestDir: "{app}"; Flags: external
Source: "{code:GetSourceDrive}MSREG\MSREG32.DLL"; DestDir: "{app}"; Flags: external

[Registry]
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\{#GameName}"; ValueType: none; Flags: uninsdeletekey
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\{#GameName}"; ValueType: string; ValueName: "cdpath"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\{#GameName}"; ValueType: string; ValueName: "diskpath"; ValueData: "{app}"; Flags: uninsdeletevalue
Root: "HKLM"; Subkey: "SOFTWARE\Mindscape\{#GameName}"; ValueType: string; ValueName: "savepath"; ValueData: "{app}"; Flags: uninsdeletevalue

[Icons]
; Shortcuts
Name: "{group}\{#GameName}"; Filename: "{app}\STARTUP.EXE"; WorkingDir: "{app}"

; Points to a non-existent executable, but the original installer creates this shortcut so we'll keep it here for accuracy
Name: "{group}\LEGO_Mindscape On-line"; Filename: "{app}\ONLINE.EXE"; WorkingDir: "{app}"

Name: "{group}\Register for Free Fonts!"; Filename: "{app}\MSRUN.EXE"; Parameters: "LaunchRegistration"
Name: "{group}\Technical Support"; Filename: "{code:GetSourceDrive}W95TECHS.HLP"; WorkingDir: "{code:GetSourceDrive}"

[Code]
// Adapted from Island Alternate Installer

#include "finddisc.pas"

var
	SourceDrive: string;

function GetSourceDrive(Param: String): String;
begin
	Result:=SourceDrive;
end;

procedure InitializeWizard();
begin
  WizardForm.WizardSmallBitmapImage.Visible := False;
	SourceDrive:=GetSourceCDDrive();
end;
