//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// TEST_info
// *allgemeine programm informationen
//====================================


unit TEST_Info;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,UnitMil, ExtCtrls;

type
  TKickerTest_Info = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  KickerTest_Info: TKickerTest_Info;

implementation

{$R *.DFM}

procedure TKickerTest_Info.Button1Click(Sender: TObject);
begin
     KickerTest_Info.Close;
end;

end.
