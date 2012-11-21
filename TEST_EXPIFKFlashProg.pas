unit TEST_EXPIFKFlashProg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TEST_Debug;

type
  TEXPIFKFLprogForm = class(TForm)
    Panel1: TPanel;
    IFKTestProgButton: TButton;
    IFKFirProgButton: TButton;
    CLOSEButton: TButton;
    procedure CLOSEButtonClick(Sender: TObject);
    procedure IFKTestProgButtonClick(Sender: TObject);
    procedure IFKFirProgButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  EXPIFKFLprogForm: TEXPIFKFLprogForm;

implementation

uses TEST_IFKProgrammierung, UnitMil;

{$R *.DFM}

procedure TEXPIFKFLprogForm.CLOSEButtonClick(Sender: TObject);
begin
     DebugForm.Close;
     EXPIFKFLprogForm.Close;
end;

procedure TEXPIFKFLprogForm.IFKTestProgButtonClick(Sender: TObject);

var StatusBool:boolean;
    ErrorOut:TStrings;

begin
     ErrorOut:= TStringList.Create;
     DebugForm.Button1.Click;
     DebugForm.DebugListBox.Items.Add('TestSoftware Programmieren');

     //-------------------------------------------------------------
     //------ Prüfling mit testsoftware impfen ---
     //-------------------------------------------------------------
     IFKProgrammierungForm.Show;
     StatusBool:=IFKProgrammierungForm.IFKProgrammierung(true,ErrorOut);
     //StatusBool := true;
     if(StatusBool = false) then begin
       DebugForm.DebugListBox.Items.Add('');
       DebugForm.DebugListBox.Items:= ErrorOut;
       Application.MessageBox('Prüfling konnte nicht mit der Testsoftware prog. werden.','Wer kriecht, kann nicht stolpern', 16);
     end else DebugForm.DebugListBox.Items.Add('-- OK --');
end;

procedure TEXPIFKFLprogForm.IFKFirProgButtonClick(Sender: TObject);

var StatusBool:boolean;
    ErrorOut:TStrings;

begin
    ErrorOut:= TStringList.Create;
    DebugForm.Button1.Click;
    DebugForm.DebugListBox.Items.Add('FinalenSoftware Programmieren');

     //-------------------------------------------------------------
     //------ Prüfling mit finalen software impfen ---
     //-------------------------------------------------------------
     IFKProgrammierungForm.Show;
     StatusBool:=IFKProgrammierungForm.IFKProgrammierung(false,ErrorOut);
     //StatusBool := true;
     if(StatusBool = false) then begin
       DebugForm.DebugListBox.Items.Add('');
       DebugForm.DebugListBox.Items:= ErrorOut;
       Application.MessageBox('Prüfling konnte nicht mit der Firmenware prog. werden.','Unwissenheit ist ein Segen', 16);
     end else DebugForm.DebugListBox.Items.Add('-- OK --');
end;
procedure TEXPIFKFLprogForm.FormShow(Sender: TObject);
begin
     DebugForm.Show;
end;

end.
