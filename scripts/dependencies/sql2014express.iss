; requires Windows 7, 8, 8.1 or Windows Server 2008 R2, Server 2012, Server 2012 R2
; requires Microsoft .NET Framework 3.5 SP 1 or later
; requires Windows Installer 4.5 or later
; setup will install MS VC++ 2010
; SQL Server Express is supported on x64 and EMT64 systems in Windows On Windows (WOW). SQL Server Express is not supported on IA64 systems
; SQLEXPR32.EXE is a smaller package that can be used to install SQL Server Express on 32-bit operating systems only. The larger SQLEXPR.EXE package supports installing onto both 32-bit and 64-bit (WOW install) operating systems. There is no other difference between these packages.
; https://www.microsoft.com/fr-fr/download/details.aspx?id=46697

[CustomMessages]
sql2014express_title=Microsoft SQL Server 2014 SP1 Express (32 bit)
sql2014express_title_x64=Microsoft SQL Server 2014 SP1 Express (64 bit)

en.sql2014express_url=https://download.microsoft.com/download/1/5/6/156992E6-F7C7-4E55-833D-249BD2348138/ENU/x86/SQLEXPR_x86_ENU.exe
en.sql2014express_url_x64=https://download.microsoft.com/download/1/5/6/156992E6-F7C7-4E55-833D-249BD2348138/ENU/x64/SQLEXPR_x64_ENU.exe
de.sql2014express_url=https://download.microsoft.com/download/2/D/6/2D6264A9-FA30-4731-920F-F21548052577/DEU/x86/SQLEXPR_x86_DEU.exe
de.sql2014express_url_x64=https://download.microsoft.com/download/2/D/6/2D6264A9-FA30-4731-920F-F21548052577/DEU/x64/SQLEXPR_x64_DEU.exe
fr.sql2014express_url=https://download.microsoft.com/download/8/A/3/8A3873CE-7E2A-45A6-8FF1-C32A7EE0C588/FRA/x86/SQLEXPR_x86_FRA.exe
fr.sql2014express_url_x64=https://download.microsoft.com/download/8/A/3/8A3873CE-7E2A-45A6-8FF1-C32A7EE0C588/FRA/x64/SQLEXPR_x64_FRA.exe
;fi.sql2014express_url=
;fi.sql2014express_url_x64=
sp.sql2014express_url=https://download.microsoft.com/download/4/7/F/47FF987C-C857-4446-BE6A-63C48C386BB8/ESN/x86/SQLEXPR_x86_ESN.exe
sp.sql2014express_url_x64=https://download.microsoft.com/download/4/7/F/47FF987C-C857-4446-BE6A-63C48C386BB8/ESN/x64/SQLEXPR_x64_ESN.exe
;nl.sql2014express_url=
;nl.sql2014express_url_x64=
it.sql2014express_url=https://download.microsoft.com/download/9/5/D/95D484C4-6BA3-4F92-A202-E09232135973/ITA/x86/SQLEXPR_x86_ITA.exe
it.sql2014express_url_x64=https://download.microsoft.com/download/9/5/D/95D484C4-6BA3-4F92-A202-E09232135973/ITA/x64/SQLEXPR_x64_ITA.exe
;pl.sql2014express_url=
;pl.sql2014express_url_x64=
ru.sql2014express_url=https://download.microsoft.com/download/F/9/1/F91E80C3-15EC-4E6A-AD62-894556A72BFD/RUS/x86/SQLEXPR_x86_RUS.exe
ru.sql2014express_url_x64=https://download.microsoft.com/download/F/9/1/F91E80C3-15EC-4E6A-AD62-894556A72BFD/RUS/x64/SQLEXPR_x64_RUS.exe

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_sql2014express"; Description: {cm:sql2014express_title}; ExtraDiskSpaceRequired: 296756232; Types: custom; Check: not Is64BitInstallMode;
Name: "dependencies\ms_sql2014express"; Description: {cm:sql2014express_title_x64}; ExtraDiskSpaceRequired: 342155768; Types: custom; Check: Is64BitInstallMode;

[Code]
const
	sql2014express_size=283.0;
	sql2014express_size_x64=326.0;
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function sql2014express() : Boolean;
var
	version: string;
	versionToCheck : string;
	applicationSetupName : string;
begin
	Result := True;
	versionToCheck :=  IntToStr(SqlServer2014_MajorVersion) + '.0';

	// Store application filename
	applicationSetupName := 'SQLEXPR' + MIDI_GetArchitectureStringEx() + '_' + CustomMessage('MIDI_SqlLanguage') + '.exe';;

	if (not MIDI_IsIA64()) then begin
		// Check if the full version fo the SQL Server 2014 is installed
		RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Microsoft SQL Server\SQLSERVER\MSSQLServer\CurrentVersion', 'CurrentVersion', version);
		if (version < versionToCheck) or (version = '') then begin
			// If the full version is not found then check for the Express edition
			RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Microsoft SQL Server\SQLEXPRESS\MSSQLServer\CurrentVersion', 'CurrentVersion', version);
			if (MIDI_CompareVersion(version, versionToCheck) < 0) then begin
				// Add product to list
				MIDI_AddProduct(applicationSetupName,
				'/QS /ACTION=Install /IAcceptSQLServerLicenseTerms /FEATURES=SQL,AS,RS,IS,Tools /INSTANCENAME=SQLEXPRESS /SQLSVCACCOUNT="NT AUTHORITY\Network Service" /SQLSYSADMINACCOUNTS="builtin\administrators"',
				CustomMessage('sql2014express_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (sql2014express_size, sql2014express_size_x64, 00),
				MIDI_GetString(CustomMessage('sql2014express_url'), CustomMessage('sql2014express_url_x64'), ''),
				false, false);
			end else begin
				// Express version of SQL Server 2014 already installed.
				MIDI_AddInstalledProduct(applicationSetupName,
					CustomMessage('sql2014express_title' + MIDI_GetArchitectureString()),
					MIDI_GetSizeString (sql2014express_size, sql2014express_size_x64, 00),
					MIDI_GetString(CustomMessage('sql2014express_url'), CustomMessage('sql2014express_url_x64'), ''),
					false, false);
			end;
		end else begin
			Log ('[MIDI] Full version of SQL Server 2014 already installed.');
		end;
	end else begin
		Log ('[MIDI] IA64 architeture not supported.');
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section