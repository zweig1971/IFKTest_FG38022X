unit TEST_SingelShiftMasterClassTest;

interface

uses
    BitShiftClass,TEST_GLobaleVariaben;

type TSingelShiftTest = class

public
      procedure SingelStepButtonPress(); virtual; abstract;
      procedure StepButtonPress(); virtual; abstract;
      procedure RunSpedButtonPress(); virtual; abstract;

      procedure OneShiftButtonPress(); virtual; abstract;
      procedure ResetButtonPress(); virtual; abstract;

      procedure FormOnShow();virtual; abstract;
      procedure CloseButtonPress();virtual;abstract;

      procedure ShowBitShiftVGLeiste(myBitShiftArray: TBitShiftArray);
      procedure ShowBitVGLeiste(ReadVGBitShiftArray: TBitShiftArray);

      function intToBinary(value:LongInt; digits:Byte):string;

      procedure ClearCountsButtonPress();
      procedure ClearSysMessButtonPress();
end;

implementation

uses TEST_SingelBitMusterForm;


procedure TSingelShiftTest.ShowBitShiftVGLeiste(myBitShiftArray: TBitShiftArray);
begin
// --------------------------
     ReadWord.w:= myBitShiftArray[1];
     SingelBitMusterForm.SWort1LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.SWort1HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= myBitShiftArray[2];
     SingelBitMusterForm.SWort2LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.SWort2HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= myBitShiftArray[3];
     SingelBitMusterForm.SWort3LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.SWort3HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= myBitShiftArray[4];
     SingelBitMusterForm.SWort4LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.SWort4HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= myBitShiftArray[5];
     SingelBitMusterForm.SWort5LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.SWort5HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= myBitShiftArray[6];
     SingelBitMusterForm.SWort6LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.SWort6HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
end;

procedure TSingelShiftTest.ShowBitVGLeiste(ReadVGBitShiftArray: TBitShiftArray);
begin
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[1];
     SingelBitMusterForm.RWort1LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.RWort1HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[2];
     SingelBitMusterForm.RWort2LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.RWort2HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[3];
     SingelBitMusterForm.RWort3LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.RWort3HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[4];
     SingelBitMusterForm.RWort4LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.RWort4HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[5];
     SingelBitMusterForm.RWort5LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.RWort5HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
// --------------------------
     ReadWord.w:= ReadVGBitShiftArray[6];
     SingelBitMusterForm.RWort6LBPanel.Caption:= intToBinary(ReadWord.r.lb, 8);
     SingelBitMusterForm.RWort6HBPanel.Caption:= intToBinary(ReadWord.r.hb, 8);
end;


function TSingelShiftTest.intToBinary(value:LongInt; digits:Byte):string;

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


procedure TSingelShiftTest.ClearCountsButtonPress();
begin
     SingelBitMusterForm.ErrorPanel.Caption:= '0';
end;

procedure TSingelShiftTest.ClearSysMessButtonPress();
begin
     SingelBitMusterForm.SysMessListBox.Clear;
end;

end.
