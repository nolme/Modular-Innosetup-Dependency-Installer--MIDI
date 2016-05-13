; requires Windows 7 Service Pack 1, Windows 8, Windows 8.1, Windows Server 2008 R2 SP1, Windows Server 2008 Service Pack 2, Windows Server 2012, Windows Server 2012 R2, Windows Vista Service Pack 2
; WARNING: express setup (downloads and installs the components depending on your OS) if you want to deploy it on cd or network download the full bootsrapper on website below
; http://www.microsoft.com/en-us/download/details.aspx?id=48137

[CustomMessages]
dotnetfx46_title=Microsoft .NET Framework 4.6

[Code]
const
	dotnetfx46_size_min=1;
	dotnetfx46_size_max=63;
	dotnetfx46_url='https://download.microsoft.com/download/1/4/A/14A6C422-0D3C-4811-A31F-5EF91A83C368/NDP46-KB3045560-Web.exe';

/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
procedure dotnetfx46(MinVersion: integer);
begin
	if (not netfxinstalled(NetFx4x, '') or (netfxspversion(NetFx4x, '') < MinVersion)) then begin
		MIDI_AddProduct('dotnetfx46.exe',
			'/lcid ' + CustomMessage('MIDI_lcid') + ' /passive /norestart',
			CustomMessage('dotnetfx46_title'),
			MIDI_GetSizeString (dotnetfx46_size_min, dotnetfx46_size_min, 0) + ' - ' + MIDI_GetSizeString (dotnetfx46_size_max, dotnetfx46_size_max, 0),
			dotnetfx46_url,
			false, false);
	end else begin	
		MIDI_AddInstalledProduct('dotnetfx46.exe',
			CustomMessage('dotnetfx46_title'),
			MIDI_GetSizeString (dotnetfx46_size_min, dotnetfx46_size_min, 0) + ' - ' + MIDI_GetSizeString (dotnetfx46_size_max, dotnetfx46_size_max, 0),
			dotnetfx46_url,
			false, false);
  end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section