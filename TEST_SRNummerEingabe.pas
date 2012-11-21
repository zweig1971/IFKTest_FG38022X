//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// * Test Serienummer eingabe
// * seriennummer wird automatisch um 1 erhöht
// * kann manuell die seriennummer eingegeben werden
// * dialog kann unterdrückt werden
//====================================



unit TEST_SRNummerEingabe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask;

type
  TSRNummerEingabe = class(TForm)
    Panel1: TPanel;
    DontShowCheckBox: TCheckBox;
    Label3: TLabel;
    OKButton: TButton;
    LfdNrMaskEdit: TMaskEdit;
    procedure OKButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  SRNummerEingabe: TSRNummerEingabe;

implementation

uses TEST_GLobaleVariaben, TEST_DatenEingabe, UnitMil;

{$R *.DFM}

procedure TSRNummerEingabe.OKButtonClick(Sender: TObject);

var testLfdboll: boolean;
    button:_WORD;
    myTestLfdNr:string;

begin
    // Eingabe der seriennummer
    testLfdboll:= TEST_DatenEingabeForm.LfdNrTest(LfdNrMaskEdit.Text, myTestLfdNr);
    if(testLfdboll <> true) then begin
      button:=Application.MessageBox('Ungültige Seriennummer, bitte wiederholen Sie die Eingabe'
                                    ,'Apfelstrudel sind sogar für Nichtschwimmer ungefährlich',69);
      case button of
      IDRETRY  : begin testLfdboll:=false;end;

      IDCANCEL : begin
                 LfdNrMaskEdit.Text:= TestLfdNr;
                 testLfdboll:= true;
                 end;
      end;
    end else begin
       //die Leerzeichen müssen raus
       TestLfdNr:= delChar(myTestLfdNr, ' ');

       // Nochmal diesen dialog anzeigen oder nicht
       if(DontShowCheckBox.Checked = true) then LfdNrDontShow:= true
       else LfdNrDontShow:=  false;

       //habe fertig
       SRNummerEingabe.Close;
     end;
end;

procedure TSRNummerEingabe.FormShow(Sender: TObject);
begin
     LfdNrMaskEdit.Text:= TestLfdNr;
     DontShowCheckBox.Checked:= false;

end;

end.
