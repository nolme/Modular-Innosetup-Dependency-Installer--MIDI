; 

[Code]
type
	MIDI_NetFXType = (NetFx10, NetFx11, NetFx20, NetFx30, NetFx35, NetFx40Client, NetFx40Full, NetFx4x);

const
	MIDI_REG_NetFx = 'Software\Microsoft\NET Framework Setup\NDP\';

/// <summary>
/// Check if Microsoft .NET framework is installed or not
/// </summary>
/// <returns>True is installed. False otherwise.</returns>
function NetFxInstalled(version: MIDI_NetFXType; lcid: string): boolean;
var
	regVersion: cardinal;
	regVersionString: string;
begin
	if (lcid <> '') then
		lcid := '\' + lcid;

	if (version = NetFx10) then begin
		RegQueryStringValue(HKLM, 'Software\Microsoft\.NETFramework\Policy\v1.0\3705', 'Install', regVersionString);
		Result := regVersionString <> '';
	end else begin
		case version of
			NetFx11:
				RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v1.1.4322' + lcid, 'Install', regVersion);
			NetFx20:
				RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v2.0.50727' + lcid, 'Install', regVersion);
			NetFx30:
				RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v3.0\Setup' + lcid, 'InstallSuccess', regVersion);
			NetFx35:
				RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v3.5' + lcid, 'Install', regVersion);
			NetFx40Client:
				RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v4\Client' + lcid, 'Install', regVersion);
			NetFx40Full:
				RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v4\Full' + lcid, 'Install', regVersion);
			NetFx4x:
			begin
				RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v4\Full' + lcid, 'Release', regVersion);
				Result := (regVersion >= 378389); // 4.5.0+
				Exit;
			end;
		end;
		Result := (regVersion <> 0);
	end;
end;

/// <summary>
/// Get Microsoft .NET framework SP version
/// </summary>
/// <returns>Service pack version.</returns>
function NetFxSpVersion(version: MIDI_NetFXType; lcid: string): integer;
var
	regVersion: cardinal;
begin
	if (lcid <> '') then
		lcid := '\' + lcid;

	case version of
		NetFx10:
			//not supported
			regVersion := -1;
		NetFx11:
			if (not RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v1.1.4322' + lcid, 'SP', regVersion)) then
				regVersion := -1;
		NetFx20:
			if (not RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v2.0.50727' + lcid, 'SP', regVersion)) then
				regVersion := -1;
		NetFx30:
			if (not RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v3.0' + lcid, 'SP', regVersion)) then
				regVersion := -1;
		NetFx35:
			if (not RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v3.5' + lcid, 'SP', regVersion)) then
				regVersion := -1;
		NetFx40Client:
			if (not RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v4\Client' + lcid, 'Servicing', regVersion)) then
				regVersion := -1;
		NetFx40Full:
			if (not RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v4\Full' + lcid, 'Servicing', regVersion)) then
				regVersion := -1;
		NetFx4x:
			if (RegQueryDWordValue(HKLM, MIDI_REG_NetFx + 'v4\Full' + lcid, 'Release', regVersion)) then begin
				if (regVersion >= 394254) then
					regVersion := 61 // 4.6.1+
				else if (regVersion >= 393295) then
					regVersion := 60 // 4.6+
				else if (regVersion >= 379893) then
					regVersion := 52 // 4.5.2+
				else if (regVersion >= 378675) then
					regVersion := 51 // 4.5.1+
				else if (regVersion >= 378389) then
					regVersion := 50 // 4.5.0+
				else
					regVersion := -1;
			end;
	end;
	Result := regVersion;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section