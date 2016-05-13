; 

[CustomMessages]
MIDI_SqlLanguage=ENU
fr.MIDI_SqlLanguage=FRA
de.MIDI_SqlLanguage=DEU
;fi.MIDI_SqlLanguage=not available
sp.MIDI_SqlLanguage=ESN
;nl.MIDI_SqlLanguage=not available
it.MIDI_SqlLanguage=ITA
;pl.MIDI_SqlLanguage=not available
ru.MIDI_SqlLanguage=RUS

[Code]
const
	SqlServer2014_MajorVersion = 12;
	SqlServer2016_MajorVersion = 13;
	SqlServer_MajorVersion = SqlServer2016_MajorVersion;

var
    DataPage_ServerNameTextBox: TEdit;
    DataPage_WindowsRadioButton: TRadioButton;
    DataPage_SqlRadioButton: TRadioButton;
    DataPage_UserName: TEdit;
    DataPage_Password: TEdit;

// Source http://stackoverflow.com/questions/19181336/custom-page-wizard-of-inno-setup  
function AuthenticateDataPage(Page: TWizardPage): Boolean;
begin
    Result :=True;
    if DataPage_ServerNameTextBox.Text <> '' then
    begin
        if DataPage_SqlRadioButton.Checked then
            begin
                if DataPage_UserName.Text =''  then
                    begin
                        MsgBox('You should enter user name', mbError, MB_OK);
                            Result :=False;
                        end
                    else
                        begin
                            if DataPage_Password.Text ='' then
                                begin
                                    MsgBox('You should enter password', mbError, MB_OK);
                                    Result :=False;
                            end
                        end
                    end
                end
            else
            begin
                MsgBox('You should enter path to SQL Server Database', mbError, MB_OK);
                Result :=False;
    end;
end;

function CreateDataPage(PreviousPageId: Integer): Integer;
var
    Page: TWizardPage;
    DataPage_FirstLabel: TLabel;
    DataPage_SecondLabel: TLabel;
    DataPage_ThirdLabel: TLabel;
    DataPage_FourthLabel: TLabel;
    
begin
    Page :=CreateCustomPage(PreviousPageId,'SQL Server Database Setup',
    'Choose SQL Server database you will be using (ask your administrator about its parameters');

    DataPage_FirstLabel :=TLabel.Create(Page);
    with DataPage_FirstLabel do
    begin
        Parent :=Page.Surface;
        Caption :='Server Name';
        Left :=ScaleX(16);
        Top :=ScaleY(0);
        Width :=ScaleX(84);
        Height :=ScaleY(17);
    end;

    DataPage_SecondLabel :=TLabel.Create(Page);
    With DataPage_SecondLabel Do
    begin
        Parent :=Page.Surface;
        Caption :='Enter Path to SQL Server (e.g. .\SQLEXPRESS; DEVSERVER)';
        Left :=ScaleX(16);
        Top :=ScaleY(56);
        Width :=ScaleX(300);
        Height :=ScaleY(17);
    end;

    DataPage_ThirdLabel :=TLabel.Create(Page);
    with DataPage_ThirdLabel do
        begin
            Parent :=Page.Surface;
            Caption :='User name';
            Left :=ScaleX(56);
            Top :=ScaleY(136);
            Width :=ScaleX(70);
            Height :=ScaleY(17);
        end;

    DataPage_FourthLabel :=TLabel.Create(Page);
    with DataPage_FourthLabel do
    begin
            Parent :=Page.Surface;
            Caption :='Password';
            Left :=ScaleX(56);
            Top :=ScaleY(168);
            Width :=ScaleX(63);
            Height :=ScaleY(17);
    end;

    DataPage_ServerNameTextBox :=TEdit.Create(Page);
    with DataPage_ServerNameTextBox do
    begin
            Parent :=Page.Surface;
            Left :=ScaleX(16);
            Top :=ScaleY(24);
            Width :=ScaleX(257);
            Height :=ScaleY(25);
            TabOrder :=0;
            Text :='';
    end;


    DataPage_WindowsRadioButton :=TRadioButton.Create(Page);
    with DataPage_WindowsRadioButton do
    begin
        Parent :=Page.Surface;
        Caption :='Use Windows Authentication';
        Left :=ScaleX(16);
        Top :=ScaleY(88);
        Width :=ScaleX(225);
        Height :=ScaleY(17);
        Checked :=True;
        TabOrder :=1;
        TabStop :=True;
    end;

    DataPage_SqlRadioButton :=TRadioButton.Create(Page);
    with DataPage_SqlRadioButton do
        begin
        Parent :=Page.Surface;
        Caption :='Use SQL Authentication';
        Left :=ScaleX(16);
        Top :=ScaleY(112);
        Width :=ScaleX(193);
        Height :=ScaleY(17);
        TabOrder :=2;
    end;


    DataPage_UserName :=TEdit.Create(Page);
    with DataPage_UserName do
    begin
        Parent :=Page.Surface;
        Left :=ScaleX(136);
        Top :=ScaleY(136);
        Width :=ScaleX(121);
        Height :=ScaleY(25);
        TabOrder :=3;
        Text :='';
    end;

    DataPage_Password :=TEdit.Create(Page);
    with DataPage_Password do
    begin
        Parent :=Page.Surface;
        Left :=ScaleX(136);
        Top :=ScaleY(168);
        Width :=ScaleX(121);
        Height :=ScaleY(25);
        TabOrder :=4;
        PasswordChar :='*';
        Text :='';
    end;


    with Page do
    begin
        OnNextButtonClick :=@AuthenticateDataPage;
    end;

    Result :=Page.ID;
end;


// Leave the [Code] Section
[Tasks]
; Leave the [Code] Section