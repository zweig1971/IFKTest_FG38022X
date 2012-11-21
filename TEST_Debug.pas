//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// *debug window
// *for programmers only
//=====================================
unit TEST_Debug;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TDebugForm = class(TForm)
    DebugListBox: TListBox;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  DebugForm: TDebugForm;

implementation

{$R *.DFM}

procedure TDebugForm.Button1Click(Sender: TObject);
begin
   DebugListBox.Clear;
end;

end.
