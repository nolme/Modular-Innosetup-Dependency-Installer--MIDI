
#include "MIDI.Messages.iss"


; Inno Download Plugin
; See https://code.google.com/p/inno-download-plugin/source/browse/examples/multilang.iss?r=5d8a4a7dc6591d23f73271e6caf36060f1c1abf7
#include <idp.iss>
#include <idplang\finnish.iss>
#include <idplang\french.iss> 
#include <idplang\german.iss> 
#include <idplang\italian.iss>
#include <idplang\polish.iss>
#include <idplang\russian.iss>

; Add IDP extended languages in current project folder
#ifdef UNICODE
	#include "idplang\unicode\spanish.iss"
#else
    #include "idplang\ansi\spanish.iss"
#endif

; shared code for installing the MIDI_Products
#include "MIDI.Core.NativeMethods.iss"
#include "MIDI.Core.Base.iss"
#include "MIDI.Core.Registry.iss"
#include "MIDI.Core.Version.iss"
#include "MIDI.Core.Debug.iss"

#include "MIDI.System.iss"
#include "MIDI.Drawing.iss"
#include "MIDI.Customize.iss"

#include "MIDI.Office.iss"

#include "MIDI.Products.iss"
#include "MIDI.Database.iss"
#include "MIDI.Dependencies.Base.iss"
#include "MIDI.Dependencies.iss"

; (see http://www.jrsoftware.org/ishelp/index.php?topic=winvernotes)
#define OS_WindowsXp       '0,5.1'
#define OS_WindowsXpSp3    '0,5.1sp3'
#define OS_WindowsVista    '0,6.0.6000'#define OS_WindowsVistaSp1 '0,6.0.6001'
#define OS_Windows7        '0,6.1.7600'
#define OS_Windows7sp1     '0,6.1.7601'
#define OS_Windows8        '0,6.2'
#define OS_Windows81       '0,6.3'
#define OS_Windows10       '0,10.0'


[Files]
; Internal files used during setup only
Source: "tools\7z\7z.exe"; Flags: dontcopy noencryption

[Types]
; Using custom Types allow to select Components individually
Name: "custom"; Description: {cm:MIDI_CustomInstallType}; Flags: iscustom

[Code]
/// <summary>
/// InitializeWizard
/// </summary>
procedure MIDI_InitializeWizard();
begin
	#ifdef MIDI_VclStylesinno
		InitializeTheme ();
	#endif
end;


/// <summary>
/// InitializeSetup
/// </summary>
/// <param name="guid">Application GUID</param>
/// <param name="apSetupName">Application setup name</param>
function MIDI_InitializeSetup(guid, appSetupName : String): Boolean;
begin
	#ifdef MIDI_VclStyles
		// Load theme for install
		MIDI_InitializeSetupTheme ();
	#endif

	#ifdef MIDI_UninstallBefore
		// In case of application upgrade, ask for uninstall before
		MIDI_UninstallBeforeUpgrade (guid, appSetupName);
	#endif

	Result := True;
end;


/// <summary>
/// DeinitializeSetup
/// </summary>
procedure MIDI_DeinitializeSetup();
begin
	#ifdef MIDI_VclStyles
		// Unload theme for install
		MIDI_DeInitializeSetupTheme ();
	#endif
end;


/// <summary>
/// Called after a new wizard page (specified by CurPageID) is shown
/// </summary>
procedure MIDI_CurPageChanged(CurPageID: Integer);
begin
	// DEBUG MSGBOX
	//SuppressibleMsgBox(IntToStr(CurPageID), mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES)
	// END DEBUG MSGBOX

	//MIDI_DumpWizardForm ();

	#ifdef MIDI_Dependencies
		// This page  is displayed after components selection. Initialize dependencies according to user choice
		// This value may change. Be careful when adding pages to this setup.
		if (CurPageID = 9) then
			MIDI_InitializeDependencies ();
	#endif

	if CurPageID = wpFinished then begin
		BottomFinishedLabel.Caption := WizardForm.FinishedLabel.Caption;
	end;

	if CurPageID = wpSelectDir then begin
		// Hide the text which indicate program size
		WizardForm.DiskSpaceLabel.Visible := False;
	end;
end;

/// <summary>
/// InitializeUninstall
/// </summary>
function MIDI_InitializeUninstall: Boolean;
begin
	#ifdef MIDI_VclStyles
		// Load theme for uninstall
		MIDI_InitializeUninstallTheme ();
	#endif

	Result := True; 
end;

   
/// <summary>
/// DeinitializeUninstall
/// </summary>
procedure MIDI_DeinitializeUninstall();
begin
	#ifdef MIDI_VclStyles
		// Unload theme
		MIDI_DeinitializeUninstallTheme ();
	#endif

	#ifdef MIDI_Dependencies
		// Remove some specific dependencies
		MIDI_UninstallDependencies ();
	#endif
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section