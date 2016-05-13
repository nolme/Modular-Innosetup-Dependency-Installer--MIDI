; http://wiki.scn.sap.com/wiki/display/BOBJ/Crystal+Reports+v.+9.1+to+SAP+Crystal+Reports+2013,+Runtime+Distribution+and+Supported+Operating+Systems

[CustomMessages]
crystalreports13_title=SAP Crystal Reports 13 (32-Bit - support pack 16)
crystalreports13_title_x64=SAP Crystal Reports 13 (64-Bit - support pack 16)

crystalreports13_url=http://downloads.businessobjects.com/akdlm/crnetruntime/clickonce/CRRuntime_32bit_13_0_16.msi
crystalreports13_url_x64=http://downloads.businessobjects.com/akdlm/crnetruntime/clickonce/CRRuntime_64bit_13_0_16.msi

[Components]
; You must duplicate size of each component because ExtraDiskSpaceRequired flag cannot use variable 
Name: "dependencies\sap_crystalreports13"; Description: {cm:crystalreports13_title}; ExtraDiskSpaceRequired: 77709312; Types: custom; Check: not Is64BitInstallMode;
Name: "dependencies\sap_crystalreports13"; Description: {cm:crystalreports13_title_x64}; ExtraDiskSpaceRequired: 85819392; Types: custom; Check: Is64BitInstallMode;

[Code]
const
	crystalreports13_size=75.8;
	crystalreports13_size_x64=83.8;
	crystalreports13_productcode = '{C5CFC037-B60E-4ECA-BCF0-2791A1153614}';
	crystalreports13_productcode_x64 = '{A92879C4-34FA-4FF3-B9F6-CD4C3B7616D6}';

/// <summary>
/// Install dependency
/// </summary>
/// <returns>True if successful, False otherwise.</returns>
function crystalreports13() : Boolean;
begin
	Result := True;
	if (not MIDI_IsIA64()) then begin
		if (not MIDI_MsiProduct(MIDI_GetString(crystalreports13_productcode, crystalreports13_productcode_x64, ''))) then begin
			MIDI_AddProduct('crystalreports13' + MIDI_GetArchitectureString() + '.msi',
				'/qn',
				CustomMessage('crystalreports13_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (crystalreports13_size, crystalreports13_size_x64, 0),
				MIDI_GetString(CustomMessage('crystalreports13_url'), CustomMessage('crystalreports13_url_x64'), ''),
				false, false);
		end else begin	
			MIDI_AddInstalledProduct('crystalreports13' + MIDI_GetArchitectureString() + '.msi',
				CustomMessage('crystalreports13_title' + MIDI_GetArchitectureString()),
				MIDI_GetSizeString (crystalreports13_size, crystalreports13_size_x64, 0),
				MIDI_GetString(CustomMessage('crystalreports13_url'), CustomMessage('crystalreports13_url_x64'), ''),
				false, false);
		end;
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section