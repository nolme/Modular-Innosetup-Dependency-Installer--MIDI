[Code]
/// <summary>
/// Generate a buffer filled with spaces
/// </summary>
/// <param name="width">Number of shift to put in buffer</param>
function MIDI_GetShiftBuffer(width : Integer) : String;
var
	i: integer;
begin
	Result := '';
	for i := 0 to width do begin
		Result := Result + ' ';
	end;
end;

/// <summary>
/// Dump TWinControl
/// </summary>
/// <param name="input">Control properties to dump.</param>
/// <param name="level">Object level in log.</param>
procedure MIDI_DumpTWinControl(input : TWinControl; level : Integer);
begin
	Log (MIDI_GetShiftBuffer (level) + 'TWinControl: ' + input.Name);
	Log (MIDI_GetShiftBuffer (level) + ' Position: ' + IntToStr (input.Left) + 'x' + IntToStr (input.Top) + ' - Size: ' + IntToStr (input.Width) + 'x' + IntToStr (input.Height));
	Log (MIDI_GetShiftBuffer (level) + ' Hint: ' + input.Hint + ' (' + MIDI_BoolToStr (input.ShowHint) + ')');
	Log (MIDI_GetShiftBuffer (level) + ' Visible: ' + MIDI_BoolToStr (input.Visible) + ' - Enabled: ' + MIDI_BoolToStr (input.Enabled));
	// Log (MIDI_GetShiftBuffer (level) + ' Caption: ' + input.Caption);
end;

/// <summary>
/// Dump TNewStaticText
/// </summary>
/// <param name="input">Control properties to dump.</param>
/// <param name="level">Object level in log.</param>
procedure MIDI_DumpTNewStaticText(input : TNewStaticText; level : Integer);
begin
	Log (MIDI_GetShiftBuffer (level) + 'TNewStaticText: ' + input.Name);
	Log (MIDI_GetShiftBuffer (level) + ' Caption: ' + input.Caption);
	MIDI_DumpTWinControl (input, level+1);
end;

/// <summary>
/// Dump TNewButton
/// </summary>
/// <param name="input">Control properties to dump.</param>
/// <param name="level">Object level in log.</param>
procedure MIDI_DumpTNewButton(input : TNewButton; level : Integer);
begin
	Log (MIDI_GetShiftBuffer (level) + 'TNewButton: ' + input.Name);
	Log (MIDI_GetShiftBuffer (level) + ' Caption: ' + input.Caption);
	MIDI_DumpTWinControl (input, level+1);
end;

/// <summary>
/// Dump TNewRadioButton
/// </summary>
/// <param name="input">Control properties to dump.</param>
/// <param name="level">Object level in log.</param>
procedure MIDI_DumpTNewRadioButton(input : TNewRadioButton; level : Integer);
begin
	Log (MIDI_GetShiftBuffer (level) + 'TNewRadioButton: ' + input.Name);
	Log (MIDI_GetShiftBuffer (level) + ' Caption: ' + input.Caption);
	MIDI_DumpTWinControl (input, level+1);
end;

/// <summary>
/// Dump TNewEdit
/// </summary>
/// <param name="input">Control properties to dump.</param>
/// <param name="level">Object level in log.</param>
procedure MIDI_DumpTNewEdit(input : TNewEdit; level : Integer);
begin
	Log (MIDI_GetShiftBuffer (level) + 'TNewEdit: ' + input.Name);
	Log (MIDI_GetShiftBuffer (level) + ' Text: ' + input.Text);
	MIDI_DumpTWinControl (input, level+1);
end;

/// <summary>
/// Dump TWizardForm
/// </summary>
procedure MIDI_DumpWizardForm();
begin
	Log ('[MIDI] TWizardForm:');
	//Log ('[MIDI] NextButton: ' + WizardForm.NextButton.Text);
	MIDI_DumpTNewButton     (WizardForm.CancelButton, 1);
	MIDI_DumpTNewButton     (WizardForm.BackButton, 1);
	MIDI_DumpTNewButton     (WizardForm.NextButton, 1);
	MIDI_DumpTNewStaticText (WizardForm.DiskSpaceLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.PasswordLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.PasswordEditLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.WelcomeLabel1, 1);
	MIDI_DumpTWinControl    (WizardForm.InfoBeforeMemo, 1);
	MIDI_DumpTNewStaticText (WizardForm.InfoBeforeClickLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.PageNameLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.PageDescriptionLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.ReadyLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.FinishedLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.WelcomeLabel2, 1);
	MIDI_DumpTNewStaticText (WizardForm.LicenseLabel1, 1);
	MIDI_DumpTWinControl    (WizardForm.LicenseMemo, 1);
	MIDI_DumpTWinControl    (WizardForm.InfoAfterMemo, 1);
	MIDI_DumpTNewStaticText (WizardForm.InfoAfterClickLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.ComponentsDiskSpaceLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.BeveledLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.StatusLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.FilenameLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.SelectDirLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.SelectStartMenuFolderLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.SelectComponentsLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.SelectTasksLabel, 1);
	MIDI_DumpTNewRadioButton(WizardForm.LicenseAcceptedRadio, 1);
	MIDI_DumpTNewRadioButton(WizardForm.LicenseNotAcceptedRadio, 1);
	MIDI_DumpTNewStaticText (WizardForm.UserInfoNameLabel, 1);
	MIDI_DumpTNewEdit       (WizardForm.UserInfoNameEdit, 1);
	MIDI_DumpTNewStaticText (WizardForm.UserInfoOrgLabel, 1);
	MIDI_DumpTNewEdit       (WizardForm.UserInfoOrgEdit, 1);
	MIDI_DumpTNewStaticText (WizardForm.PreparingLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.FinishedHeadingLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.UserInfoSerialLabel, 1);
	MIDI_DumpTNewEdit       (WizardForm.UserInfoSerialEdit, 1);
	MIDI_DumpTNewStaticText (WizardForm.SelectDirBrowseLabel, 1);
	MIDI_DumpTNewStaticText (WizardForm.SelectStartMenuFolderBrowseLabel, 1);
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section