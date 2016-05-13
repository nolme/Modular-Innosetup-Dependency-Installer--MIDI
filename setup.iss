; Contribute on https://github.com/nolme/Modular-InnoSetup-Dependency-Installer

; Manage dependencies
#include "setup_define_dependencies.iss"
#include "scripts\MIDI.Core.iss"


[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{78F3A65F-0000-0000-0000-000000000000}
AppName={#MyAppSetupName}
AppVersion={#MyAppVersion_Major}.{#MyAppVersion_Minor}.{#MyAppVersion_SubVersionMajor}.{#MyAppVersion_SubVersionMinor}
AppVerName={#MyAppSetupName} {#MyAppVersion_Major}.{#MyAppVersion_Minor}.{#MyAppVersion_SubVersionMajor}.{#MyAppVersion_SubVersionMinor}
AppCopyright={#MyCopyright} {#MyAppCompanyName}
VersionInfoVersion={#MyAppVersion_Major}.{#MyAppVersion_Minor}.{#MyAppVersion_SubVersionMajor}.{#MyAppVersion_SubVersionMinor}
VersionInfoCompany={#MyAppCompanyName}
AppPublisher={#MyAppCompanyName}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppSupportURL}
AppUpdatesURL={#MyAppURL}
AppContact={#MyAppContactMail}
AppSupportPhone={#MyAppContactPhone}
AppMutex={#MyAppMutex}
OutputBaseFilename={#MyAppSetupName}-{#MyAppVersion_Major}.{#MyAppVersion_Minor}.{#MyAppVersion_SubVersionMajor}.{#MyAppVersion_SubVersionMinor}
DefaultGroupName={#MyAppCompanyName} - {#MyAppSetupName}
DefaultDirName={pf}\{#MyAppCompanyName}\{#MyAppSetupName}
UninstallDisplayIcon={app}\MyProgram.exe
OutputDir=bin
SourceDir=.
AllowNoIcons=yes
;SetupIconFile=MyProgramIcon
SolidCompression=yes

; Display user information page (see http://www.jrsoftware.org/ishelp/index.php?topic=setup_userinfopage). 
UserInfoPage= yes

PrivilegesRequired=admin
ArchitecturesAllowed=x86 x64
ArchitecturesInstallIn64BitMode=x64

DisableWelcomePage=no
DisableDirPage=no

; Wizard image files (see http://www.jrsoftware.org/ishelp/index.php?topic=setup_wizardimagefile)
WizardSmallImageFile=".\images\logo-github.bmp"

; Enable setup logging (see http://www.jrsoftware.org/ishelp/index.php?topic=setup_setuplogging)
SetupLogging=yes

; Display an information file before user selects the destination directory (see http://www.jrsoftware.org/ishelp/index.php?topic=setup_infobeforefile)
InfoBeforeFile=src\history.txt

; (see http://www.jrsoftware.org/ishelp/index.php?topic=setup_alwaysshowcomponentslist)
AlwaysShowComponentsList=yes

; (see http://www.jrsoftware.org/ishelp/index.php?topic=setup_closeapplications)
CloseApplications=force

; Set minimum OS
; (see http://www.jrsoftware.org/ishelp/index.php?topic=setup_minversion)
MinVersion={#OS_WindowsXpSp3}

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl";            LicenseFile: "src\license\License_English.txt";
Name: "de"; MessagesFile: "compiler:Languages\German.isl";   LicenseFile: "src\license\License_English.txt";
Name: "fr"; MessagesFile: "compiler:Languages\French.isl";   LicenseFile: "src\license\License_English.txt";
Name: "fi"; MessagesFile: "compiler:Languages\Finnish.isl";  LicenseFile: "src\license\License_English.txt";
Name: "sp"; MessagesFile: "compiler:Languages\Spanish.isl";  LicenseFile: "src\license\License_English.txt";
Name: "nl"; MessagesFile: "compiler:Languages\Dutch.isl";    LicenseFile: "src\license\License_English.txt";
Name: "it"; MessagesFile: "compiler:Languages\Italian.isl";  LicenseFile: "src\license\License_English.txt";
Name: "pl"; MessagesFile: "compiler:Languages\Polish.isl";   LicenseFile: "src\license\License_English.txt";
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl";  LicenseFile: "src\license\License_English.txt";

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
; Internal files used during setup only
Source: "images\welcome.bmp"; Flags: dontcopy noencryption
Source: "images\left.bmp"; Flags: dontcopy noencryption

; Application files
Source: "src\MyProgram-x64.exe"; DestDir: "{app}"; DestName: "MyProgram.exe"; Check: MIDI_IsX64; Components: main
Source: "src\MyProgram.exe"; DestDir: "{app}"; Check: not Is64BitInstallMode; Components: main
Source: "src\history.txt"; DestDir: "{app}"; Components: main
Source: "src\readme.txt"; DestDir: "{app}"; Flags: isreadme; Components: main
Source: "src\help\*"; DestDir: "{app}"; Components: help

[Components]
Name: "main"; Description: {cm:MIDI_Component_Main}; Types: custom; Flags: fixed
Name: "help"; Description: {cm:MIDI_Component_Help}; Types: custom;

[Icons]
Name: "{group}\{#MyAppSetupName}"; Filename: "{app}\MyProgram.exe"
Name: "{group}\{cm:UninstallProgram,{#MyAppSetupName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppSetupName}"; Filename: "{app}\MyProgram.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppSetupName}"; Filename: "{app}\MyProgram.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\MyProgram.exe"; Parameters: ""; Description: "{cm:LaunchProgram,{#MyAppSetupName}}"; Flags: nowait postinstall skipifsilent

[Registry]
Root: HKLM; Subkey: SOFTWARE\{#MyAppCompanyName}\{#MyAppSetupName}; Flags: uninsdeletekey
Root: HKLM; Subkey: SOFTWARE\{#MyAppCompanyName}; Flags: uninsdeletekeyifempty

; For user informations form
Root: HKLM; Subkey: SOFTWARE\{#MyAppCompanyName}\{#MyAppSetupName}; ValueType:string; ValueName:UserName; ValueData:{userinfoname};
Root: HKLM; Subkey: SOFTWARE\{#MyAppCompanyName}\{#MyAppSetupName}; ValueType:string; ValueName:UserCompany; ValueData: {userinfoorg};

[Code]
/// <summary>
/// InitializeWizard
/// </summary>
procedure InitializeWizard();
begin
	MIDI_InitializeWizard ();

	// Add a link label on form bottom left
	MIDI_AddBottomUrl (ExpandConstant ('{#MyAppCompanyName}'), ExpandConstant ('{#MyAppSupportURL}'));

	// Define background image during welcome page
	//SetBackgroundImageForWizard ('welcome.bmp', 'left.bmp'); // Uncomment [Files] section to use the second bitmap
	MIDI_CustomizeWelcomePage ('welcome.bmp', '');
	// Define background image for the finish page
	MIDI_CustomizeFinishPage  ('welcome.bmp', 'left.bmp');

	// Database test - UNDER DEV
	//CreateDataPage(wpLicense); 
end;


/// <summary>
/// InitializeSetup
/// </summary>
function InitializeSetup(): Boolean;
var
	sApplicationGuid: String;
begin
	// Check application GUID (ask for uninstall before)
	sApplicationGuid := ExpandConstant('{#emit SetupSetting("AppId")}_is1');

	Result := MIDI_InitializeSetup (sApplicationGuid, ExpandConstant ('{#MyAppSetupName}'));
end;


/// <summary>
/// DeinitializeSetup
/// </summary>
procedure DeinitializeSetup();
begin
	MIDI_DeinitializeSetup ();
end;


/// <summary>
/// Called after a new wizard page (specified by CurPageID) is shown
/// </summary>
/// <url>http://www.jrsoftware.org/ishelp/index.php?topic=scriptevents</url>
procedure CurPageChanged(CurPageID: Integer);
begin
	MIDI_CurPageChanged (CurPageID);
end;


/// <summary>
/// InitializeUninstall
/// </summary>
function InitializeUninstall: Boolean;
begin
	Result := MIDI_InitializeUninstall (); 
end;


/// <summary>
/// DeinitializeUninstall
/// </summary>
procedure DeinitializeUninstall();
begin
	MIDI_DeinitializeUninstall ();
end;