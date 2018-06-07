; GZ CALCULATOR
#define MyAppName "SciTE"
#define MyAppVersion "4.1"
#define MyAppPublisher "Syrows, Inc. Salomon S.A."
#define MyAppURL "www.syrows.com/"
#define MyAppExeName "SciTE.exe"

[Setup]
AppId                                   = {{4765E449-8BCE-460A-8E3E-CDCA395E2715}
AppName                                 = {#MyAppName}
AppVersion                              = {#MyAppVersion}
;AppVerName                             = {#MyAppName} {#MyAppVersion}  
AppVerName                              = {#MyAppName}
AppPublisher                            = {#MyAppPublisher}
AppPublisherURL                         = {#MyAppURL}
AppSupportURL                           = {#MyAppURL}
AppUpdatesURL                           = {#MyAppURL}
Compression                             = lzma
SolidCompression                        = yes
DefaultDirName                          = {pf}\SciTE
DefaultGroupName                        = Syrows
LicenseFile                             = img\license.rtf
OutputDir                               = bin\
OutputBaseFilename                      = SciTE.401.x64
SetupIconFile                           = ..\scite\win32\SciBall.ico
WizardImageFile                         = img\img.bmp
WizardSmallImageFile                    = img\mini.bmp
ArchitecturesAllowed                    = x64
ArchitecturesInstallIn64BitMode         = x64
UninstallDisplayIcon                    = "SciTE"
; Tell Windows Explorer to reload the environment
ChangesEnvironment=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "..\x64\Release\SciTE.exe";                              DestDir: "{app}";                         Flags: ignoreversion
Source: "..\scite\win32\Toolbar.json";                           DestDir: "{app}\theme";                   Flags: ignoreversion
Source: "Files\api\*";                                           DestDir: "{app}\api";                     Flags: ignoreversion
Source: "Files\languages\*";                                     DestDir: "{app}\languages";               Flags: ignoreversion
Source: "Files\theme\theme.global.defaults.properties";          DestDir: "{app}\theme";                   Flags: ignoreversion
Source: "Files\tools\*";                                         DestDir: "{app}\tools";                   Flags: ignoreversion
Source: "Files\SciTE.properties";                                DestDir: "{app}";                         Flags: ignoreversion
Source: "Files\SciTEGlobal.properties";                          DestDir: "{app}";                         Flags: ignoreversion

Source: "Files\abbrev.properties";                               DestDir: "{userappdata}\SciTE";           Flags: ignoreversion
Source: "Files\SciTEUser.properties";                            DestDir: "{userappdata}\SciTE";           Flags: ignoreversion

[Ini]
filename: {app}\SciTE.ini; section: dirs; key: SciTE_HOME;     string: "{app}";               Flags: UninsDeleteEntry;
filename: {app}\SciTE.ini; section: dirs; key: SciTE_USERHOME; string: "{userappdata}\SciTE"; Flags: UninsDeleteEntry; 
;// this is used in the installation, and will be deleted in post-install



[UninstallDelete]
Type: filesandordirs; Name: "{userappdata}\SciTE\api";
Type: filesandordirs; Name: "{userappdata}\SciTE\languages";
Type: files;          Name: "{userappdata}\SciTE\SciTE.session";
Type: files;          Name: "{app}\SciTE.ini";

[Icons]
Name: "{group}\{#MyAppName}";                              Filename: "{app}\{#MyAppExeName}"
Name: "{commondesktop}\{#MyAppName}";                      Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Registry]
Root: HKCR; Subkey: "*\shell\Open with SciTE\command"; ValueType: string; ValueData: "{app}\{#MyAppExeName} -check.if.already.open=1 %1"
Root: HKCR; Subkey: "*\shell\Open with SciTE"; ValueType: string; ValueName: "Icon"; ValueData: "{app}\{#MyAppExeName},0"; Flags: preservestringtype
;Root: HKCR; Subkey: "*\shell\Open with SciTE"; ValueType: string; ValueName: "Position"; ValueData: "Top|Buttom"; Flags: preservestringtype

;Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: string; ValueName: "SciTE_HOME"; ValueData: "{commonappdata}\SciTE"; Flags: preservestringtype
;Root: HKLM; Subkey: "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"; ValueType: string; ValueName: "SciTE_USERHOME"; ValueData: "{commonappdata}\SciTE"; Flags: preservestringtype

;[Code]
;RegDeleteValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'SciTE_HOME');
;RegDeleteValue(HKLM, 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', 'SciTE_USERHOME');

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

;function RegDeleteKeyIncludingSubkeys(const RootKey: Integer; const SubkeyName: String): Boolean;
;function RegDeleteKeyIfEmpty         (const RootKey: Integer; const SubkeyName: String): Boolean;
;function RegDeleteValue              (const RootKey: Integer; const SubKeyName, ValueName: String): Boolean;

[Code]
procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then
  begin
    if RegKeyExists(HKCR, '*\shell\Open with SciTE') then
      if MsgBox('Do you want to delete registry keys?', mbConfirmation, MB_YESNO) = IDYES then
        RegDeleteKeyIncludingSubkeys(HKCR,  '*\shell\Open with SciTE');
  end;
end;