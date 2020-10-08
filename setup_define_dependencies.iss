
; -------------------------------------------------------------------------------------------------------
; Define main modules to use
; -------------------------------------------------------------------------------------------------------

; Ask for uninstall before
#define MIDI_UninstallBefore

; Use or not VCL Styles
;#define MIDI_VclStyles

; Use dependencies
#define MIDI_Dependencies

; Debug switches
;#define MIDI_DBG_OFFICE


; -------------------------------------------------------------------------------------------------------
; SETUP specific strings. Change these values to match your project
; -------------------------------------------------------------------------------------------------------
#define MyAppSetupName 'MyProgram'
#define MyAppCompanyName 'GitHub Project'
#define MyCopyright 'Copyright © 2007-2020'
#define MyAppMutex "MUTEX_@@++@@////"
#define MyAppContactMail "support@mycompany.com"
#define MyAppContactPhone "0000-00000-00000"
#define MyAppURL "http://www.mycompany.com/"
#define MyAppSupportURL "http://www.mycompany.com/"

#define MyAppVersion_Major 6
#define MyAppVersion_Minor 0
#define MyAppVersion_SubVersionMajor 0
#define MyAppVersion_SubVersionMinor 0

; Display a text in the bevel label
#define BeveledLabelText  'InnoSetup wizard'



; ----------------------------------------------------------------------

; -------------------------------------------------------------------------------------------------------
; DEPENDENCIES - Comment out product defines to disable installing them
; -------------------------------------------------------------------------------------------------------
#ifdef MIDI_Dependencies
; 	#define use_dotnetfx35

; 	#define use_dotnetfx40

; 	#define use_dotnetfx46
;	#define use_dotnetfx461

;	#define use_msiproduct
;	#define use_vc2005
;	#define use_vc2008
;	#define use_vc2010
;	#define use_vc2012
;	#define use_vc2013
;	#define use_vc2015
	
; #define use_docker

; #define use_crystalreports13

; #define use_sqlcompact40

; #define use_sql2014express
; #define use_sql2016express - Still CTP. NOT YET IMPLEMENTED

#define use_sql2017express
;#define use_sql2019express

; #define use_vsto2010

; #define use_accessruntime2016

; #define use_custom1
#endif
; -------------------------------------------------------------------------------------------------------
; VCL Styles
; -------------------------------------------------------------------------------------------------------
#ifdef MIDI_VclStyles
	; Use VCLStyleDesigner in 'C:\Program Files (x86)\The Road To Delphi\VCL Styles Inno' to preview style
	#define MyAppTheme "AquaLightSlate.vsf"

	; Change this path if you don't have installed 'VCL Styles Inno' in the default directory
	#define VclInstallPath   "C:\Program Files (x86)\The Road To Delphi\VCL Styles Inno"
#endif

