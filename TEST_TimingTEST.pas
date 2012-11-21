//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// *Test Timing Test
// *Testet timing reg.
// *reg wird mit zero und eins shift beschrieben & gelesen
// *daten werden verglichen muessen gleich sein
// *die klasse TBitShift wird benoetigt
//====================================

unit TEST_TimingTEST;

interface

uses TEST_GLobaleVariaben,UnitMil,BitShiftClass;


type TTimingTest = class

 private
  BitShift:TBitShift;
  BitShiftArray:TBitShiftArray;

  function WriteReadCheck(daten:_WORD; var ErrStatus:_DWORD):boolean;
  function TimingTest(ZeroInit:boolean):boolean;

 public
  function TimingKanalTest():boolean;

 end;

implementation
// ---------------- Private---------------------
function TTimingTest.WriteReadCheck(daten:_WORD; var ErrStatus:_DWORD):boolean;

var status:_DWORD;
    antwort:_WORD;

begin

     status:= PCI_IFKWrite(PCIAdress, IFKAdressSlave, WrTiming, daten, ErrStatus);
     status:= PCI_IFKRead(PCIAdress, IFKAdressSlave, RdTiming, antwort, ErrStatus);

     if(daten <> antwort) or (status <> StatusOK) then result:= false
     else result:= true;
end;

function TTimingTest.TimingTest(ZeroInit:boolean):boolean;

var TestStatus:boolean;
    ErrStatus:_DWORD;
    index:_WORD;
    Bitindex:_BYTE;

begin
     index:=0;
     BitShift:= TBitShift.Create;
     BitShift.InitBitShift(ZeroInit, 1, 16);
     BitShift.resetBitShift();

     while(index <=16) do begin
        BitShift.readBitShift(BitShiftArray);
        TestStatus:=WriteReadCheck(BitShiftArray[1], ErrStatus);
        BitShift.ShiftBitShift(Bitindex);
        index:=index+1;
     end;

     BitShift.Free;
     result:= TestStatus;
end;

// ---------------- public---------------------
function TTimingTest.TimingKanalTest():boolean;

var TestStatus:boolean;

begin
    TestStatus:= TimingTest(true);
    TestStatus:= TimingTest(false);
    result:=TestStatus;
end;


end.
