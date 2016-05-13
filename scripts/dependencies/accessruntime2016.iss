; requires Windows 7, 8, 8.1, 10 or Windows Server 2008 R2, Server 2012, Server 2012 R2
; https://www.microsoft.com/en-us/download/details.aspx?id=50040
;
; WARNING : 
;	this installation is not compatible with OneClick installation of Microsoft Office
;	Access Runtime must use the same MS Office platform (x86/x64)
;
[CustomMessages]
accessruntime2016_title=Microsoft Access Runtime 2016 (32 bit)
accessruntime2016_title_x64=Microsoft Access Runtime 2016 (64 bit)

en.accessruntime2016_url=https://download.microsoft.com/download/D/B/D/DBD20EF9-A945-4768-AEB0-617BCEA2214A/accessruntime_4288-1001_x86_en-us.exe
en.accessruntime2016_url_x64=https://download.microsoft.com/download/D/B/D/DBD20EF9-A945-4768-AEB0-617BCEA2214A/accessruntime_4288-1001_x64_en-us.exe
de.accessruntime2016_url=https://download.microsoft.com/download/7/A/9/7A9EFEDC-15B0-4FFC-88E2-C7C5E6C740B7/accessruntime_4288-1001_x86_de-de.exe
de.accessruntime2016_url_x64=https://download.microsoft.com/download/7/A/9/7A9EFEDC-15B0-4FFC-88E2-C7C5E6C740B7/accessruntime_4288-1001_x64_de-de.exe
fr.accessruntime2016_url=https://download.microsoft.com/download/2/7/F/27F33487-9306-42FA-AC49-55323C7F6A55/accessruntime_4288-1001_x86_fr-fr.exe
fr.accessruntime2016_url_x64=https://download.microsoft.com/download/2/7/F/27F33487-9306-42FA-AC49-55323C7F6A55/accessruntime_4288-1001_x64_fr-fr.exe
fi.accessruntime2016_url=https://download.microsoft.com/download/D/9/1/D91677EB-C4A7-4CFF-BA2C-9E47C169FD04/accessruntime_4288-1001_x86_fi-fi.exe
fi.accessruntime2016_url_x64=https://download.microsoft.com/download/D/9/1/D91677EB-C4A7-4CFF-BA2C-9E47C169FD04/accessruntime_4288-1001_x64_fi-fi.exe
sp.accessruntime2016_url=https://download.microsoft.com/download/5/4/E/54EABEFE-2A9C-499E-878F-65A4F689DABC/accessruntime_4288-1001_x86_es-es.exe
sp.accessruntime2016_url_x64=https://download.microsoft.com/download/5/4/E/54EABEFE-2A9C-499E-878F-65A4F689DABC/accessruntime_4288-1001_x64_es-es.exe
nl.accessruntime2016_url=https://download.microsoft.com/download/1/8/8/188B7E3F-ECF0-4780-BC03-BD1931E3C3DC/accessruntime_4288-1001_x86_nl-nl.exe
nl.accessruntime2016_url_x64=https://download.microsoft.com/download/1/8/8/188B7E3F-ECF0-4780-BC03-BD1931E3C3DC/accessruntime_4288-1001_x64_nl-nl.exe
it.accessruntime2016_url=https://download.microsoft.com/download/2/C/F/2CFAEBF1-241B-4B2E-8744-22213B682B6D/accessruntime_4288-1001_x86_it-it.exe
it.accessruntime2016_url_x64=https://download.microsoft.com/download/2/C/F/2CFAEBF1-241B-4B2E-8744-22213B682B6D/accessruntime_4288-1001_x64_it-it.exe
pl.accessruntime2016_url=https://download.microsoft.com/download/7/D/7/7D7C230C-27E8-4DFE-80F0-F463106B0CFC/accessruntime_4288-1001_x86_pl-pl.exe
pl.accessruntime2016_url_x64=https://download.microsoft.com/download/7/D/7/7D7C230C-27E8-4DFE-80F0-F463106B0CFC/accessruntime_4288-1001_x64_pl-pl.exe
ru.accessruntime2016_url=https://download.microsoft.com/download/5/8/C/58C85E62-97B4-4B79-B81C-EB68CA32DE6C/accessruntime_4288-1001_x86_ru-ru.exe
ru.accessruntime2016_url_x64=https://download.microsoft.com/download/5/8/C/58C85E62-97B4-4B79-B81C-EB68CA32DE6C/accessruntime_4288-1001_x64_ru-ru.exe

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\ms_accessruntime2016"; Description: {cm:accessruntime2016_title}; ExtraDiskSpaceRequired: 246305632; Types: custom; Check: accessruntime2016_CheckX86;
Name: "dependencies\ms_accessruntime2016"; Description: {cm:accessruntime2016_title_x64}; ExtraDiskSpaceRequired: 329702152; Types: custom; Check: accessruntime2016_CheckX64;

[Code]
const
	accessruntime2016_size=234.0;
	accessruntime2016_size_x64=314.0;

/// <summary>
/// Check requirements for this dependency for x86 architecture
/// </summary>
/// <returns>True is product match requirements, False otherwise.</returns>
function accessruntime2016_CheckX86() : Boolean;
begin
	if IsWin64 () then begin
		if MIDI_IsX64OfficeInstalled () then begin
			Result := False;
		end else begin
			Result := True;
		end;
	end else begin
		// Microsoft recommend to use x86 Office version (even on x64 Windows installation).
		Result := True;
	end;
end;


/// <summary>
/// Check requirements for this dependency for x86 architecture
/// </summary>
/// <returns>True is product match requirements, False otherwise.</returns>
function accessruntime2016_CheckX64() : Boolean;
begin
	if IsWin64 then begin
		if MIDI_IsOfficeInstalled () then begin
			if MIDI_OfficeInstalledAs64Bits then begin
				Result := True;
			end else begin
				// Office x86 installed
				Result := False;
			end;
		end else begin
			// Office not installed
			Result := True;
		end;
	end else begin
		// x86 architecture
		Result := False;
	end;
end;

/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function accessruntime2016() : Boolean;
var
	majorVersion: Integer;
	minorVersion : String;
	hKey : Integer;
begin
	Result  := True;
	majorVersion := MIDI_Office2016_MajorVersion;
	minorVersion := '.0';

	// For x64 architecture, check 32/64 office installation
	if IsWin64 then begin
		if MIDI_IsOfficeInstalled () then begin
			if MIDI_IsX64OfficeInstalled () then begin
				hKey := HKLM64;
			end else begin
				hKey := HKLM32;
			end;
		end else begin
			hKey := HKLM32;   // Install x86 version on x64 machine
		end;
	end else begin
		hKey := HKLM32;
	end;

	// Check dependency presence
	if (not RegKeyExists(hKey, 'SOFTWARE\Microsoft\Office\' + IntToStr (majorVersion) + minorVersion + '\Access Connectivity Engine\InstallRoot')) then begin
		// Add new dependency
		MIDI_AddProduct('accessruntime2016.exe',
			'/passive',
			CustomMessage('accessruntime2016_title'),
			MIDI_GetSizeString (accessruntime2016_size, accessruntime2016_size_x64, 00),
			CustomMessage('accessruntime2016_url'),
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('accessruntime2016.exe',
			CustomMessage('accessruntime2016_title'),
			MIDI_GetSizeString (accessruntime2016_size, accessruntime2016_size_x64, 00),
			CustomMessage('accessruntime2016_url'),
			false, false);
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section