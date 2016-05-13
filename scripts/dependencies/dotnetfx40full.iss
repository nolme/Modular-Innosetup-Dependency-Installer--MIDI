; requires Windows 7, Windows 7 Service Pack 1, Windows Server 2003 Service Pack 2, Windows Server 2008, Windows Server 2008 R2, Windows Server 2008 R2 SP1, Windows Vista Service Pack 1, Windows XP Service Pack 3
; requires Windows Installer 3.1
; requires Internet Explorer 5.01
; WARNING: express setup (downloads and installs the components depending on your OS) if you want to deploy it on cd or network download the full bootsrapper on website below
; http://www.microsoft.com/downloads/en/details.aspx?FamilyID=9cfb2d51-5ff4-4491-b0e5-b386f32c0992

[CustomMessages]
dotnetfx40full_title=Microsoft .NET Framework 4.0 Full

[Code]
const
	dotnetfx40full_size_min=3;
	dotnetfx40full_size_max=197;
	dotnetfx40full_url='https://download.microsoft.com/download/1/B/E/1BE39E79-7E39-46A3-96FF-047F95396215/dotNetFx40_Full_setup.exe';
	
/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
procedure dotnetfx40full();
begin
	if (not netfxinstalled(NetFx40Full, '')) then begin
		MIDI_AddProduct('dotNetFx40_Full_setup.exe',
			'/lcid ' + CustomMessage('MIDI_lcid') + ' /passive /norestart',
			CustomMessage('dotnetfx40full_title'),
			MIDI_GetSizeString (dotnetfx40full_size_min, dotnetfx40full_size_min, 0) + ' - ' + MIDI_GetSizeString (dotnetfx40full_size_max, dotnetfx40full_size_max, 0),
			dotnetfx40full_url,
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('dotNetFx40_Full_setup.exe',
			CustomMessage('dotnetfx40full_title'),
			MIDI_GetSizeString (dotnetfx40full_size_min, dotnetfx40full_size_min, 0) + ' - ' + MIDI_GetSizeString (dotnetfx40full_size_max, dotnetfx40full_size_max, 0),
			dotnetfx40full_url,
			false, false);
  end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section