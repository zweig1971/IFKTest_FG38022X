//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// *unfinished prototype
//====================================

unit TEST_SingelTesTStep;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TEXPMainMenueForm = class(TForm)
    Panel1: TPanel;
    IFKFlashProgButton: TButton;
    Test2Button: TButton;
    Test3Button: TButton;
    CloseButton: TButton;
    Test4Button: TButton;
    Panel2: TPanel;
    Test5Button: TButton;
    Test6Button: TButton;
    Test7Button: TButton;
    Test8Button: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure IFKFlashProgButtonClick(Sender: TObject);
    procedure Test2ButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  EXPMainMenueForm: TEXPMainMenueForm;

implementation

uses TEST_SingelBitMusterForm, TEST_EXPIFKFlashProg, TEST_IFKProgrammierung,
  TEST_SingelShiftMasterClassTest, TEST_ExpertSingelShiftTest;

{$R *.DFM}

procedure TEXPMainMenueForm.CloseButtonClick(Sender: TObject);
begin
     EXPMainMenueForm.Close;
end;

procedure TEXPMainMenueForm.IFKFlashProgButtonClick(Sender: TObject);
begin
     EXPIFKFLprogForm.ShowModal;
end;

procedure TEXPMainMenueForm.Test2ButtonClick(Sender: TObject);
begin
     SingelShiftTest:= TExpertSingelShiftTest.Create;
     SingelBitMusterForm.ShowModal;
end;

end.
