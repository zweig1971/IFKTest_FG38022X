//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// *unfinished prototype
//====================================

unit TEST_SingelBitMusterForm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons,unitmil, BitShiftClass, TEST_SingelShiftMasterClassTest;

type
  TSingelBitMusterForm = class(TForm)
    Panel1: TPanel;
    Panel4: TPanel;
    RWort1HBPanel: TPanel;
    Label2: TLabel;
    RWort1LBPanel: TPanel;
    Label1: TLabel;
    RWort2HBPanel: TPanel;
    RWort2LBPanel: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    RWort3HBPanel: TPanel;
    RWort3LBPanel: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    RWort4HBPanel: TPanel;
    RWort4LBPanel: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    RWort5HBPanel: TPanel;
    RWort5LBPanel: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    RWort6HBPanel: TPanel;
    RWort6LBPanel: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Panel15: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    SWort1HBPanel: TPanel;
    SWort1LBPanel: TPanel;
    SWort2HBPanel: TPanel;
    SWort2LBPanel: TPanel;
    SWort3HBPanel: TPanel;
    SWort3LBPanel: TPanel;
    SWort4HBPanel: TPanel;
    SWort4LBPanel: TPanel;
    SWort5HBPanel: TPanel;
    SWort5LBPanel: TPanel;
    SWort6HBPanel: TPanel;
    SWort6LBPanel: TPanel;
    Label26: TLabel;
    StepButton: TButton;
    ResetButton: TButton;
    Bevel1: TBevel;
    OneShiftSpeedButton: TSpeedButton;
    Bevel2: TBevel;
    Label28: TLabel;
    ErrorPanel: TPanel;
    ClearCountsButton: TButton;
    SysMessListBox: TListBox;
    Label29: TLabel;
    ClearSysMessButton: TButton;
    RunSpeedButton: TSpeedButton;
    CloseButton: TButton;
    SingelStepButton: TButton;
    GroupBox1: TGroupBox;
    MDrOupEnabelButton: TButton;
    MDrDirecButton: TButton;
    MOutputRegButton: TButton;
    MInputRegButton: TButton;
    GroupBox2: TGroupBox;
    SDrOupEnabelButton: TButton;
    SDrDirecButton: TButton;
    SOuttRegButton: TButton;
    SInputRegButton: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure ShowBitShiftVGLeiste(WriteVGShiftArray: TBitShiftArray);
    procedure ShowBitVGLeiste(ReadVGBitShiftArray: TBitShiftArray);
    procedure ResetButtonClick(Sender: TObject);
    procedure SingelStepButtonClick(Sender: TObject);
    function  ReadStatusIFK(IFKAress:_BYTE; RegAdress:_WORD; var Regdata:string):boolean;
    procedure SDrOupEnabelButtonClick(Sender: TObject);
    procedure SDrDirecButtonClick(Sender: TObject);
    procedure SOuttRegButtonClick(Sender: TObject);
    procedure SInputRegButtonClick(Sender: TObject);
    procedure MDrOupEnabelButtonClick(Sender: TObject);
    procedure MDrDirecButtonClick(Sender: TObject);
    procedure MOutputRegButtonClick(Sender: TObject);
    procedure MInputRegButtonClick(Sender: TObject);
    procedure StepButtonClick(Sender: TObject);
    procedure RunSpeedButtonClick(Sender: TObject);
    procedure OneShiftSpeedButtonClick(Sender: TObject);
    procedure ClearCountsButtonClick(Sender: TObject);
    procedure ClearSysMessButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  SingelBitMusterForm: TSingelBitMusterForm;
  SingelShiftTest:TSingelShiftTest;

implementation

uses TEST_GLobaleVariaben;

{$R *.DFM}


procedure TSingelBitMusterForm.CloseButtonClick(Sender: TObject);
begin
     SingelShiftTest.CloseButtonPress();
     SingelShiftTest.Free;
     SingelBitMusterForm.Close;
end;

procedure TSingelBitMusterForm.ShowBitShiftVGLeiste(WriteVGShiftArray: TBitShiftArray);

begin
// --------------------------
     ReadWord.w:= WriteVGShiftArray[1];
     SWort1LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SWort1HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= WriteVGShiftArray[2];
     SWort2LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SWort2HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= WriteVGShiftArray[3];
     SWort3LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SWort3HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= WriteVGShiftArray[4];
     SWort4LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SWort4HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= WriteVGShiftArray[5];
     SWort5LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SWort5HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= WriteVGShiftArray[6];
     SWort6LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SWort6HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
end;

procedure TSingelBitMusterForm.ShowBitVGLeiste(ReadVGBitShiftArray: TBitShiftArray);
begin

// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[1];
     RWort1LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     RWort1HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[2];
     RWort2LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     RWort2HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[3];
     RWort3LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     RWort3HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[4];
     RWort4LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     RWort4HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[5];
     RWort5LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     RWort5HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[6];
     RWort6LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     RWort6HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
end;

procedure TSingelBitMusterForm.ResetButtonClick(Sender: TObject);
begin
     SingelShiftTest.ResetButtonPress();
end;

procedure TSingelBitMusterForm.SingelStepButtonClick(Sender: TObject);

begin
     SingelShiftTest.SingelStepButtonPress();
end;


// Liest von einen Register der Master oder Slave karte & gibt das ergebnis
// als string zurueck
function TSingelBitMusterForm.ReadStatusIFK(IFKAress:_BYTE; RegAdress:_WORD; var Regdata:string):boolean;

var status:_DWORD;
    ErrorStatus:_DWORD;
    data:_WORD;

begin
     ErrorStatus:= 0;

     // Register der IFK lesen
     //-----------------------------
     status:= PCI_IfkRead(PCIAdress,IFKAress,RegAdress,data,ErrorStatus);
     if(status = StatusOK) then begin
       Regdata:=Regdata + IntToHex(data, 4);
       result:= true;
     end else begin
         Regdata:=Regdata + 'READ ERROR ' + IntToHex(status, 4);
         result:= false;
     end;
end;

// Register vom slave "Driver output enabel" auslesen
procedure TSingelBitMusterForm.SDrOupEnabelButtonClick(Sender: TObject);

var ResultString:string;

begin
     ResultString:= 'Rd.Slave output reg :';
     ReadStatusIFK(IFKAdressSlave,FCRD_EnabelTreiber,ResultString);

     SysMessListBox.Items.Add(ResultString);
end;

// Register vom slave "Driver direction" auslesen
procedure TSingelBitMusterForm.SDrDirecButtonClick(Sender: TObject);

var ResultString:string;

begin
     ResultString:= 'Rd.Slave direction reg :';
     ReadStatusIFK(IFKAdressSlave,FCRD_DirectTreiber,ResultString);

     SysMessListBox.Items.Add(ResultString);
end;

// Register vom slave "Output register" auslesen
procedure TSingelBitMusterForm.SOuttRegButtonClick(Sender: TObject);

var ResultString:string;

begin
     ResultString:= 'Rd.Slave output reg :';
     ReadStatusIFK(IFKAdressSlave,IntIFKRD,ResultString);

     SysMessListBox.Items.Add(ResultString);
end;

// Register vom slave "Input Register" auslesen
procedure TSingelBitMusterForm.SInputRegButtonClick(Sender: TObject);

var ResultString:string;

begin
     ResultString:= 'Rd.Slave input reg :';
     ReadStatusIFK(IFKAdressSlave,IntputIFKRegRd,ResultString);

     SysMessListBox.Items.Add(ResultString);
end;

// Register vom master "Driver output enabel" auslesen
procedure TSingelBitMusterForm.MDrOupEnabelButtonClick(Sender: TObject);

var ResultString:string;

begin
     ResultString:= 'Rd.Master output reg :';
     ReadStatusIFK(IFKAdressMaster,FCRD_EnabelTreiber,ResultString);

     SysMessListBox.Items.Add(ResultString);
end;

// Register vom master "Driver direction" auslesen
procedure TSingelBitMusterForm.MDrDirecButtonClick(Sender: TObject);

var ResultString:string;

begin
     ResultString:= 'Rd.Master direction reg :';
     ReadStatusIFK(IFKAdressMaster,FCRD_DirectTreiber,ResultString);

     SysMessListBox.Items.Add(ResultString);
end;

// Register vom master "Output register" auslesen
procedure TSingelBitMusterForm.MOutputRegButtonClick(Sender: TObject);

var ResultString:string;

begin
     ResultString:= 'Rd.Master output reg :';
     ReadStatusIFK(IFKAdressMaster,IntIFKRD,ResultString);

     SysMessListBox.Items.Add(ResultString);
end;

// Register vom master "input register" auslesen
procedure TSingelBitMusterForm.MInputRegButtonClick(Sender: TObject);

var ResultString:string;

begin
     ResultString:= 'Rd.Master input reg :';
     ReadStatusIFK(IFKAdressMaster,IntputIFKRegRd,ResultString);

     SysMessListBox.Items.Add(ResultString);
end;

procedure TSingelBitMusterForm.StepButtonClick(Sender: TObject);
begin
     SingelShiftTest.StepButtonPress();
end;

procedure TSingelBitMusterForm.RunSpeedButtonClick(Sender: TObject);
begin
     SingelShiftTest.RunSpedButtonPress();
end;

procedure TSingelBitMusterForm.OneShiftSpeedButtonClick(Sender: TObject);
begin
     if (SingelBitMusterForm.OneShiftSpeedButton.Down = true) then SingelBitMusterForm.OneShiftSpeedButton.Caption := 'Zero shift'
     else SingelBitMusterForm.OneShiftSpeedButton.Caption := 'One shift';
     SingelShiftTest.OneShiftButtonPress();
end;

procedure TSingelBitMusterForm.ClearCountsButtonClick(Sender: TObject);
begin
     SingelShiftTest.ClearCountsButtonPress();
end;

procedure TSingelBitMusterForm.ClearSysMessButtonClick(Sender: TObject);
begin
     SingelShiftTest.ClearSysMessButtonPress();
end;

procedure TSingelBitMusterForm.FormShow(Sender: TObject);
begin
     SingelShiftTest.FormOnShow();
end;

end.
