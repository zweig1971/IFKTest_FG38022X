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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure reset_ButtonClick(Sender: TObject);
    procedure Init_SpeedButtonClick(Sender: TObject);
    procedure Shift_ButtonClick(Sender: TObject);
    procedure ReadShiftVGLeiste();
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  myVGLeiste: TBitShiftVGLeiste;
  myIOVGLeiste:TIOVGLeiste;

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
     myVGLeiste:= TBitShiftVGLeiste.Create;
     myVGLeiste.VGLeisteInit(true);
     ReadShiftVGLeiste();
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if(myVGLeiste <> nil) then myVGLeiste.Free;
    //myVGLeiste.Destroy;
end;

procedure TForm1.reset_ButtonClick(Sender: TObject);
begin
     myVGLeiste.resetShVGL();
     ReadShiftVGLeiste();
end;

procedure TForm1.Init_SpeedButtonClick(Sender: TObject);
begin
     if(Init_SpeedButton.Down = true) then begin
       Init_SpeedButton.Caption := 'One';
       myVGLeiste.VGLeisteInit(false);
       myVGLeiste.resetShVGL();
       ReadShiftVGLeiste();
     end;

     if(Init_SpeedButton.Down = false) then begin
       Init_SpeedButton.Caption := 'Zero';
       myVGLeiste.VGLeisteInit(true);
       myVGLeiste.resetShVGL();
       ReadShiftVGLeiste();
     end;
end;

procedure TForm1.Shift_ButtonClick(Sender: TObject);

var index:byte;

begin
     index:=0;
     myVGLeiste.ShiftVGLeiste(index);
     ReadShiftVGLeiste();
end;


procedure TForm1.ReadShiftVGLeiste();
begin
     myVGLeiste.readShVGL(myIOVGLeiste);
     Word_Panel6.Caption := intToBinary(myIOVGLeiste[1], 16);
     Word_Panel5.Caption := intToBinary(myIOVGLeiste[2], 16);
     Word_Panel4.Caption := intToBinary(myIOVGLeiste[3], 16);
     Word_Panel3.Caption := intToBinary(myIOVGLeiste[4], 16);
     Word_Panel2.Caption := intToBinary(myIOVGLeiste[5], 16);
     Word_Panel1.Caption := intToBinary(myIOVGLeiste[6], 16);
end;


end.
