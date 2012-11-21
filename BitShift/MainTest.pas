unit MainTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,VGLeisteFairIFK, Buttons;

type
  TForm1 = class(TForm)
    Word_Panel1: TPanel;
    Word_Panel2: TPanel;
    Word_Panel3: TPanel;
    Word_Panel4: TPanel;
    Word_Panel5: TPanel;
    Word_Panel6: TPanel;
    Shift_Button: TButton;
    reset_Button: TButton;
    Init_SpeedButton: TSpeedButton;
    WordSpeedButton: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure reset_ButtonClick(Sender: TObject);
    procedure Init_SpeedButtonClick(Sender: TObject);
    procedure Shift_ButtonClick(Sender: TObject);
    procedure ReadShiftVGLeiste();
    procedure WordSpeedButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  myBitShiftArray: TBitShiftArray;
  myBitShift:TBitShift;
  MaxWord:byte;
  MaxBit:byte;
  ZeroOneShift:boolean;

implementation

{$R *.DFM}


function intToBinary(value:LongInt; digits:Byte):string;

var i:Byte;
    mask:LongInt;

begin
     SetLength (result, digits);
     for i := 0 to digits-1 do begin
         mask := 1 shl i;
         if(mask and value) = mask then
             result[digits-i] := '1'
         else
             result[digits-i] := '0'
     end
end;

// =========================================================


procedure TForm1.FormCreate(Sender: TObject);
begin
     MaxWord:=6;
     MaxBit:= 89;
     ZeroOneShift:= true;
     myBitShift:= TBitShift.Create;
     myBitShift.InitBitShift(ZeroOneShift,MaxWord,MaxBit);
     ReadShiftVGLeiste();
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if(myBitShift <> nil) then myBitShift.Free;
end;

procedure TForm1.reset_ButtonClick(Sender: TObject);
begin
     myBitShift.resetBitShift();
     ReadShiftVGLeiste();
end;

procedure TForm1.Init_SpeedButtonClick(Sender: TObject);
begin
     if(Init_SpeedButton.Down = true) then begin
       Init_SpeedButton.Caption := 'One';
       ZeroOneShift:= false;
     end;

     if(Init_SpeedButton.Down = false) then begin
       Init_SpeedButton.Caption := 'Zero';
       ZeroOneShift:= true;
     end;

     myBitShift.InitBitShift(ZeroOneShift,MaxWord,MaxBit);
     myBitShift.resetBitShift();
     ReadShiftVGLeiste();


end;

procedure TForm1.Shift_ButtonClick(Sender: TObject);

var index:byte;

begin
     index:=0;
     myBitShift.ShiftBitShift(index);
     ReadShiftVGLeiste();
end;


procedure TForm1.ReadShiftVGLeiste();
begin
     myBitShift.readBitShift(myBitShiftArray);
     Word_Panel6.Caption := intToBinary(myBitShiftArray[1], 16);
     Word_Panel5.Caption := intToBinary(myBitShiftArray[2], 16);
     Word_Panel4.Caption := intToBinary(myBitShiftArray[3], 16);
     Word_Panel3.Caption := intToBinary(myBitShiftArray[4], 16);
     Word_Panel2.Caption := intToBinary(myBitShiftArray[5], 16);
     Word_Panel1.Caption := intToBinary(myBitShiftArray[6], 16);
end;


procedure TForm1.WordSpeedButtonClick(Sender: TObject);
begin
     if(WordSpeedButton.Down = true) then begin
       WordSpeedButton.Caption:= '3 Word';
       MaxWord:= 3;
       MaxBit:= 46;
     end else begin
       WordSpeedButton.Caption:= '6 Word';
       MaxWord:=6;
       MaxBit:= 89;
     end;

     myBitShift.InitBitShift(ZeroOneShift,MaxWord,MaxBit);
     myBitShift.resetBitShift();
     ReadShiftVGLeiste();
end;

end.
