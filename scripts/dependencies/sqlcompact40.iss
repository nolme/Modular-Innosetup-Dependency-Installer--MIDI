; Added by vinny_cwb - http://www.codeproject.com/script/Membership/View.aspx?mid=4840075
; https://www.microsoft.com/fr-fr/download/details.aspx?id=30709

[CustomMessages]
sqlcompact40_title=Microsoft SQL Server Compact 4.0 Service Pack 1 (x86)
sqlcompact40_title_x64=Microsoft SQL Server Compact 4.0 Service Pack 1 (x64)

en.sqlcompact40_url=https://download.microsoft.com/download/F/F/D/FFDF76E3-9E55-41DA-A750-1798B971936C/ENU/SSCERuntime_x86-ENU.exe
en.sqlcompact40_url_x64=https://download.microsoft.com/download/F/F/D/FFDF76E3-9E55-41DA-A750-1798B971936C/ENU/SSCERuntime_x64-ENU.exe
de.sqlcompact40_url=https://download.microsoft.com/download/C/2/F/C2FD744D-BADB-40E9-A826-8160E14B7722/DEU/SSCERuntime_x86-DEU.exe
de.sqlcompact40_url_x64=https://download.microsoft.com/download/C/2/F/C2FD744D-BADB-40E9-A826-8160E14B7722/DEU/SSCERuntime_x64-DEU.exe
fr.sqlcompact40_url=https://download.microsoft.com/download/4/E/C/4ECA90FE-D678-47BD-8DF9-3F8C5CD65EE6/FRA/SSCERuntime_x86-FRA.exe
fr.sqlcompact40_url_x64=https://download.microsoft.com/download/4/E/C/4ECA90FE-D678-47BD-8DF9-3F8C5CD65EE6/FRA/SSCERuntime_x64-FRA.exe
;fi.sqlcompact40_url=
;fi.sqlcompact40_url_x64=
sp.sqlcompact40_url=https://download.microsoft.com/download/9/F/7/9F7DA9D6-EA12-4105-A2FD-2F2B963C215A/ESN/SSCERuntime_x86-ESN.exe
sp.sqlcompact40_url_x64=https://download.microsoft.com/download/9/F/7/9F7DA9D6-EA12-4105-A2FD-2F2B963C215A/ESN/SSCERuntime_x64-ESN.exe
;nl.sqlcompact40_url=
;nl.sqlcompact40_url_x64=
it.sqlcompact40_url=https://download.microsoft.com/download/1/B/3/1B3F0DA9-0DC1-4741-85CC-4A60A6FFBB4B/ITA/SSCERuntime_x86-ITA.exe
it.sqlcompact40_url_x64=https://download.microsoft.com/download/1/B/3/1B3F0DA9-0DC1-4741-85CC-4A60A6FFBB4B/ITA/SSCERuntime_x64-ITA.exe
pl.sqlcompact40_url=https://download.microsoft.com/download/1/B/3/1B3F0DA9-0DC1-4741-85CC-4A60A6FFBB4B/ITA/SSCERuntime_x64-ITA.exe
pl.sqlcompact40_url_x64=https://download.microsoft.com/download/5/9/A/59AC6BBC-686F-466F-A943-32BEC591B061/PLK/SSCERuntime_x64-PLK.exe
ru.sqlcompact40_url=https://download.microsoft.com/download/2/1/B/21BD14B2-F928-46A9-BCDB-A2EB05B03986/RUS/SSCERuntime_x86-RUS.exe
ru.sqlcompact40_url_x64=https://download.microsoft.com/download/2/1/B/21BD14B2-F928-46A9-BCDB-A2EB05B03986/RUS/SSCERuntime_x64-RUS.exe
 
[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_sqlcompact40"; Description: {cm:sqlcompact40_title}; ExtraDiskSpaceRequired: 2397488; Types: custom; Check: not Is64BitInstallMode;
Name: "dependencies\ms_sqlcompact40"; Description: {cm:sqlcompact40_title_x64}; ExtraDiskSpaceRequired: 2638632; Types: custom; Check: Is64BitInstallMode;

[Code]
const
	sqlcompact40_size=2.3;
	sqlcompact40_size_x64=2.5;
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function sqlcompact40() : Boolean;
var
	applicationSetupName : string;
begin
	Result:=True;
	
	// Store application filename
    applicationSetupName := 'SQLEXPR' + MIDI_GetArchitectureStringEx() + '_' + CustomMessage('MIDI_SqlLanguage') + '.exe';;
   
	if (not RegKeyExists(HKLM, 'SOFTWARE\Microsoft\Microsoft SQL Server Compact Edition\v4.0')) then begin
		// Add new dependency
		MIDI_AddProduct(applicationSetupName,
			'"/package SSCERuntime' + MIDI_GetArchitectureStringEx() + '-' + CustomMessage('MIDI_SqlLanguage') + '.msi /quiet"',
			CustomMessage('sqlcompact40_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (sqlcompact40_size, sqlcompact40_size_x64, 00),
			CustomMessage('sqlcompact40_url' + MIDI_GetArchitectureString()),
			false, false);
	end else begin	
		MIDI_AddInstalledProduct(applicationSetupName,
			CustomMessage('sqlcompact40_title' + MIDI_GetArchitectureString()),
			MIDI_GetSizeString (sqlcompact40_size, sqlcompact40_size_x64, 00),
			CustomMessage('sqlcompact40_url' + MIDI_GetArchitectureString()),
			false, false);
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section