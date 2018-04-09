; requires Windows 10, Windows 7 Service Pack 1, Windows 8, Windows 8.1, Windows Server 2003 Service Pack 2, Windows Server 2008 R2 SP1, Windows Server 2008 Service Pack 2, Windows Server 2012, Windows Vista Service Pack 2, Windows XP Service Pack 3
; https://docs.docker.com/docker-for-windows/install/#where-to-go-next

[CustomMessages]
docker_title=Docker for Windows
docker_title_x64=Docker for Windows (x64)

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\docker"; Description: {cm:docker_title}; ExtraDiskSpaceRequired: 500000000; Types: custom;  Check: not Is64BitInstallMode;
Name: "dependencies\docker"; Description: {cm:docker_title_x64}; ExtraDiskSpaceRequired: 500000000; Types: custom;  Check: Is64BitInstallMode;

[Code]
const
	docker_source_size=373.0;
	docker_source_size_x64=373.0;
	docker_url='https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe';
	docker_url_x64='https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe';
	docker_productcode = 'Docker for Windows';  /// See HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Docker for Windows
	docker_productcode_x64 = 'Docker for Windows';   /// See HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Docker for Windows

/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns> 
function docker(): Boolean;
var
	applicationSetupName : string;
  uninstallString : string;label 
  Installed;
begin
	Result:=True;
	
	// Store application filename
  applicationSetupName := 'Docker for Windows Installer.exe';
  uninstallString := MIDI_GetUninstallString64 (docker_productcode);

  if uninstallString = '' then begin
    // SuppressibleMsgBox('non installé', mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
  end else begin	
    //SuppressibleMsgBox('installé', mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
    goto Installed;
  end;

  if (not MIDI_IsIA64()) then begin
		if (not MIDI_MsiProduct(MIDI_GetString(docker_productcode, docker_productcode_x64, ''))) then begin
			MIDI_AddProduct(applicationSetupName,
				'/norestart',
        CustomMessage('docker_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (docker_source_size, docker_source_size_x64, 0),
				MIDI_GetString(docker_url, docker_url_x64, ''),
				false, true);
		end else begin
Installed:  
			MIDI_AddInstalledProduct(applicationSetupName,
				CustomMessage('docker_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (docker_source_size, docker_source_size_x64, 0),
				MIDI_GetString(docker_url, docker_url_x64, ''),
				false, false);
		end;
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section