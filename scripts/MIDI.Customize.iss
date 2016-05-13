#ifdef MIDI_VclStyles
	#define VCLStylesSkinPath "{localappdata}\VCLStylesSkin"
#endif
[Files]
#ifdef MIDI_VclStyles
	Source: {#VclInstallPath}\VclStylesinno.dll; DestDir: {#VCLStylesSkinPath}; Flags: uninsneveruninstall
	Source: {#VclInstallPath}\Styles\{#MyAppTheme}; DestDir: {#VCLStylesSkinPath}; Flags: uninsneveruninstall
#endif


[Messages]
; Display a message on bottom (see http://www.jrsoftware.org/ishelp/index.php?topic=messagessection)
#ifdef BeveledLabelText
	BeveledLabel={#BeveledLabelText}
#endif


[Code]
var
	LinkLabel: TLabel;    // Label displayed during setup on bottom
	TopFinishedLabel: TLabel;
	BottomFinishedLabel: TLabel;
	FinishImage : TBitmapImage;
  
#ifdef MIDI_VclStyles
	// Import the LoadVCLStyle function from VclStylesInno.DLL
	procedure LoadVCLStyle(VClStyleFile: String); external 'LoadVCLStyleW@files:VclStylesInno.dll stdcall setuponly';
	procedure LoadVCLStyle_UnInstall(VClStyleFile: String); external 'LoadVCLStyleW@{#VCLStylesSkinPath}\VclStylesInno.dll stdcall uninstallonly';
	// Import the UnLoadVCLStyles function from VclStylesInno.DLL
	procedure UnLoadVCLStyles; external 'UnLoadVCLStyles@files:VclStylesInno.dll stdcall setuponly';
	procedure UnLoadVCLStyles_UnInstall; external 'UnLoadVCLStyles@{#VCLStylesSkinPath}\VclStylesInno.dll stdcall uninstallonly';

	/// <summary>
	/// Initialize setup theme
	/// </summary>
	function MIDI_InitializeSetupTheme(): Boolean;
	begin
		ExtractTemporaryFile(ExpandConstant('{#MyAppTheme}'));
		LoadVCLStyle(ExpandConstant('{tmp}\{#MyAppTheme}'));
		Result := True;
	end;

	/// <summary>
	/// Deinitialize setup theme
	/// </summary>
	procedure MIDI_DeInitializeSetupTheme();
	begin
		UnLoadVCLStyles;
	end;

	/// <summary>
	/// Initialize uninstall theme
	/// </summary>
	function MIDI_InitializeUninstallTheme: Boolean;
	begin
		Result := True;
		LoadVCLStyle_UnInstall(ExpandConstant('{#VCLStylesSkinPath}\{#MyAppTheme}'));
	end;

	/// <summary>
	/// Deinitialize uninstall theme
	/// </summary>
	procedure MIDI_DeinitializeUninstallTheme();
	begin
		UnLoadVCLStyles_UnInstall;
	end;
#endif


/// <summary>
/// Function called when user click on label on bottom of form
/// </summary>
procedure MIDI_LinkClick(Sender: TObject);
var
	  ErrorCode: Integer;
	  WizardLinkLabel: TLabel; 
begin
	  WizardLinkLabel := TLabel(Sender);  // Cast sender into TLabel
	  ShellExec('', WizardLinkLabel.Hint, '', '', SW_SHOW, ewNoWait, ErrorCode);
end;


/// <summary>
/// Called after a new wizard page (specified by CurPageID) is shown
/// </summary>
procedure MIDI_AddBottomUrl(Name: String; Url : String);
begin
	LinkLabel := TLabel.Create(WizardForm);
	LinkLabel.Parent := WizardForm;
	LinkLabel.Left := 10;
	LinkLabel.Top := WizardForm.ClientHeight - LinkLabel.ClientHeight - 16;
	LinkLabel.Cursor := crHand;
	LinkLabel.Font.Color := clBlue;
	LinkLabel.Font.Style := [fsUnderline];
	LinkLabel.Caption := Name;
	LinkLabel.Hint := Url;
	LinkLabel.OnClick := @MIDI_LinkClick;
end;


/// <summary>
/// Show / hide the bottom URL
/// </summary>
procedure MIDI_ShowBottomUrl(Visible : Boolean);
begin
	if LinkLabel <> nil then begin
		LinkLabel.Visible := Visible;
	end;
end;


/// <summary>
/// Duplicate control size to another control
/// </summary>
procedure MIDI_InheritBoundsRect(ASource, ATarget: TControl);
begin
	ATarget.Left := ASource.Left;
	ATarget.Top := ASource.Top;
	ATarget.Width := ASource.Width;
	ATarget.Height := ASource.Height;
end;

/// <summary>
/// Define a background and left image for the Welcome page
/// </summary>
/// <url>https://stackoverflow.com/questions/11963522/welcome-label-transparent-on-inno-setup/11963915#11963915</url>
procedure MIDI_CustomizeWelcomePage(backImage : String; frontImage: String);
var
	TopWelcomeLabel: TLabel;
	BottomWelcomeLabel: TLabel;
	WelcomeImage : TBitmapImage;
	brush : TBrush;
	pen : TPen;
	delta : Integer;
begin

	// DEBUG MSGBOX
	//if WizardForm.WizardBitmapImage <> nil then
	//  SuppressibleMsgBox('WizardForm.WizardBitmapImage: ' +     'x:'+ IntToStr(WizardForm.WizardBitmapImage.Left) + \
	//                                            'y:'+ IntToStr(WizardForm.WizardBitmapImage.Top) + \
	//                                            'width:'+ IntToStr(WizardForm.WizardBitmapImage.Width) + \
	//                                            'height:'+ IntToStr(WizardForm.WizardBitmapImage.Height) \
	//  , mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);

	//if WelcomeImage <> nil then
	//  SuppressibleMsgBox('WelcomeImage: ' +     'x:'+ IntToStr(WelcomeImage.Left) + \
	//                                            'y:'+ IntToStr(WelcomeImage.Top) + \
	//                                            'width:'+ IntToStr(WelcomeImage.Width) + \
	//                                            'height:'+ IntToStr(WelcomeImage.Height) \
	//  , mbConfirmation, MB_YESNO or MB_DEFBUTTON1, IDYES);
	// END DEBUG MSGBOX

  
	// Set the image on the left
	if frontImage <> '' then begin
		ExtractTemporaryFile(frontImage);
		WelcomeImage := TBitmapImage.Create (WizardForm);
		WelcomeImage.Parent := WizardForm.WelcomeLabel1.Parent;
		WelcomeImage.Align := alLeft;
		WelcomeImage.Bitmap.LoadFromFile(ExpandConstant('{tmp}\' + frontImage));
		WelcomeImage.Top := 0;
		WelcomeImage.Left := 0;
		WelcomeImage.Width := WelcomeImage.Bitmap.Width;
		WelcomeImage.Height := WelcomeImage.Bitmap.Height;

		// Draw vertical separator between front and back image
		brush := WelcomeImage.Bitmap.Canvas.Brush;
		brush.Color :=  MIDI_StringToRGB ('$2F2F2F');
		pen := WelcomeImage.Bitmap.Canvas.Pen;
		pen.Color :=  MIDI_StringToRGB ('$9F9F9F');
		WelcomeImage.Bitmap.Canvas.Rectangle (WelcomeImage.Width-2,0, WelcomeImage.Width, WelcomeImage.Height);
		WelcomeImage.BringToFront();
	end;

	// Set the background image
	if backImage <> '' then begin
		ExtractTemporaryFile(backImage);
		WizardForm.WizardBitmapImage.Align := alClient;
		WizardForm.WizardBitmapImage.Bitmap.LoadFromFile(ExpandConstant('{tmp}\' + backImage));
	end;

	// Create new title message
	TopWelcomeLabel := TLabel.Create(WizardForm);
	TopWelcomeLabel.Parent := WizardForm.WelcomeLabel1.Parent;
	TopWelcomeLabel.Font := WizardForm.WelcomeLabel1.Font;
	TopWelcomeLabel.Font.Style := [fsBold];
	TopWelcomeLabel.Caption := WizardForm.WelcomeLabel1.Caption;
	TopWelcomeLabel.WordWrap := WizardForm.WelcomeLabel1.WordWrap;
	MIDI_InheritBoundsRect(WizardForm.WelcomeLabel1, TopWelcomeLabel);

	// Hide previous title label
	WizardForm.WelcomeLabel1.Visible := False;

	// Create new main text message
	BottomWelcomeLabel := TLabel.Create(WizardForm);
	BottomWelcomeLabel.Parent := WizardForm.WelcomeLabel2.Parent;
	BottomWelcomeLabel.Font := WizardForm.WelcomeLabel2.Font;
	BottomWelcomeLabel.Caption := WizardForm.WelcomeLabel2.Caption;
	BottomWelcomeLabel.WordWrap := WizardForm.WelcomeLabel2.WordWrap;
	MIDI_InheritBoundsRect(WizardForm.WelcomeLabel2, BottomWelcomeLabel);

	// Hide previous main text label
	WizardForm.WelcomeLabel2.Visible := False;
	// If no left image set, change labels position
	if frontImage = '' then begin
		delta := 30;
		TopWelcomeLabel.Width := TopWelcomeLabel.Width + (TopWelcomeLabel.Left - delta);
		TopWelcomeLabel.Left := delta;

		BottomWelcomeLabel.Width := BottomWelcomeLabel.Width + (BottomWelcomeLabel.Left - delta);
		BottomWelcomeLabel.Left := delta;
	end;
end;

/// <summary>
/// Define a background and left image for the Finish page
/// </summary>
/// <url>https://stackoverflow.com/questions/11963522/welcome-label-transparent-on-inno-setup/11963915#11963915</url>
procedure MIDI_CustomizeFinishPage(backImage : String; frontImage: String);
var
	brush : TBrush;
	pen : TPen;
	delta : Integer;begin

	// Set the image on the left
	if frontImage <> '' then begin
		ExtractTemporaryFile(frontImage);
		FinishImage := TBitmapImage.Create (WizardForm);
		FinishImage.Parent := WizardForm.FinishedPage;
		FinishImage.Align := alLeft;
		FinishImage.Bitmap.LoadFromFile(ExpandConstant('{tmp}\' + frontImage));
		FinishImage.Top := 0;
		FinishImage.Left := 0;
		FinishImage.Width := FinishImage.Bitmap.Width;
		FinishImage.Height := FinishImage.Bitmap.Height;

		// Draw vertical separator between front and back image
		brush := FinishImage.Bitmap.Canvas.Brush;
		brush.Color :=  MIDI_StringToRGB ('$2F2F2F');
		pen := FinishImage.Bitmap.Canvas.Pen;
		pen.Color :=  MIDI_StringToRGB ('$9F9F9F');
		FinishImage.Bitmap.Canvas.Rectangle (FinishImage.Width-2,0, FinishImage.Width, FinishImage.Height);
		FinishImage.BringToFront();
	end;

	// Set the background image
	if backImage <> '' then begin
		ExtractTemporaryFile(backImage);
		WizardForm.WizardBitmapImage2.Align := alClient;
		WizardForm.WizardBitmapImage2.Bitmap.LoadFromFile(ExpandConstant('{tmp}\' + backImage));
	end;
  
	  // Create new title message
	  TopFinishedLabel := TLabel.Create(WizardForm);
	  TopFinishedLabel.Parent := WizardForm.FinishedHeadingLabel.Parent;
	  TopFinishedLabel.Font := WizardForm.FinishedHeadingLabel.Font;
	  TopFinishedLabel.Font.Style := [fsBold];
	  TopFinishedLabel.Caption := WizardForm.FinishedHeadingLabel.Caption;
	  TopFinishedLabel.WordWrap := WizardForm.FinishedHeadingLabel.WordWrap;
	  MIDI_InheritBoundsRect(WizardForm.FinishedHeadingLabel, TopFinishedLabel);
	  
	  // Hide previous Welcome label
	  WizardForm.FinishedHeadingLabel.Visible := False;

	  // Create new main text message
	  BottomFinishedLabel := TLabel.Create(WizardForm);
	  BottomFinishedLabel.Parent := WizardForm.FinishedLabel.Parent;
	  BottomFinishedLabel.Font := WizardForm.FinishedLabel.Font;
	  BottomFinishedLabel.Caption := SetupMessage (msgFinishedLabelNoIcons) ; //WizardForm.FinishedLabel.Caption;
	  BottomFinishedLabel.WordWrap := WizardForm.FinishedLabel.WordWrap;
	  MIDI_InheritBoundsRect(WizardForm.FinishedLabel, BottomFinishedLabel);
	  
	  // Hide previous main text label
	  WizardForm.FinishedLabel.Visible := False; 

	// Manage runlist
	// [TODO] WizardForm.RunList.Left := 210;
	WizardForm.RunList.Height := 90;
	WizardForm.RunList.Top    := WizardForm.Bevel.Top - WizardForm.RunList.Height - 10;
	WizardForm.RunList.Color  :=  MIDI_StringToRGB ('$CFCFCF');

	// If no left image set, change labels position
	if frontImage = '' then begin
		delta := 30;
		TopFinishedLabel.Width := TopFinishedLabel.Width + (TopFinishedLabel.Left - delta);
		TopFinishedLabel.Left := delta;

		BottomFinishedLabel.Width := BottomFinishedLabel.Width + (BottomFinishedLabel.Left - delta);
		BottomFinishedLabel.Left := delta;
	end;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section