//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// TEST-Interrupt Test
//
//====================================

unit TEST_InterruptTest;

interface

uses TEST_GLobaleVariaben,UnitMil;

type TInterruptTest = class

 private
  function IFKSLSetDRQYINL(SetInt:_WORD; var Errstatus:_DWORD):boolean;
  function IFKSLClearDRQYINL(ClearInt:_WORD; var Errstatus:_DWORD):boolean;
  function PCTestDRQYINL(TestIFKInt:_WORD; TestPCIInt:_WORD; var ErrStatus:_DWORD):boolean;
  function DrqDryInlOnlyTest(TestIFKInt:_WORD; var ErrStatus:_DWORD):boolean;

 public
  function InterruptTest():boolean;

end;


implementation

// ---------------- Private---------------------
function TInterruptTest.IFKSLSetDRQYINL(SetInt:_WORD; var Errstatus:_DWORD):boolean;

var ReadInt:_WORD;

begin
    //interrupt register lesen
    PCI_IfkRead(PCIAdress, IFKAdressSlave, IntIFKRD, ReadInt, Errstatus);
    //interrupt setzten
    ReadInt:= ReadInt or SetInt;
    //ins interrupt register schreiben
    PCI_IfkWrite(PCIAdress, IFKAdressSlave, IntIFKWR, ReadInt, Errstatus);
    if(Errstatus = StatusOK) then result:= true
    else result:= false;
end;

function TInterruptTest.IFKSLClearDRQYINL(ClearInt:_WORD; var Errstatus:_DWORD):boolean;

var ReadInt:_WORD;

begin
    //interrupt register lesen
    PCI_IfkRead(PCIAdress, IFKAdressSlave, IntIFKRD, ReadInt, Errstatus);
    //interrupt löschen
    ReadInt:= ReadInt and not(ClearInt);
   //ins interrupt register schreiben
    PCI_IfkWrite(PCIAdress, IFKAdressSlave, IntIFKWR, ReadInt, Errstatus);
    if(Errstatus = StatusOK) then result:= true
    else result:= false;
end;


function TInterruptTest.PCTestDRQYINL(TestIFKInt:_WORD; TestPCIInt:_WORD; var ErrStatus:_DWORD):boolean;

var StatusReg:_DWORD;


begin
     //Status Register lesen
     PCI_StatusRegRead(PCIAdress, StatusReg, ErrStatus);
     // es interessieren nur die ersten drei bits
     StatusReg:= StatusReg and  $7;
      //Prüfen
     if(StatusReg and TestPCIInt) = TestPCIInt then result:=true
     else result:= false;
end;

function TInterruptTest.DrqDryInlOnlyTest(TestIFKInt:_WORD; var ErrStatus:_DWORD):boolean;

var status:boolean;
    TestPCIInt:_WORD;

begin
    // setze interrupt
    IFKSLSetDRQYINL(TestIFKInt, Errstatus);
    case TestIFKInt of
         IntIFKDRQ: TestPCIInt:= Dta_Req;
         IntIFKDRY: TestPCIInt:= Dta_Rdy;
         IntIFKINL: TestPCIInt:= Interlock;
         IntIFKDRQYINL: TestPCIInt:= Dta_Req+Dta_Rdy+Interlock;
    end;
    // Warten
    PCI_TimerWait(PCIAdress, IntrWaitTime, 0, ErrStatus);

    // Testen
    status:= PCTestDRQYINL(TestIFKInt,TestPCIInt, ErrStatus);
    // rücksetzten
    IFKSLClearDRQYINL(TestIFKInt, ErrStatus);

    result:=status;

end;

// ---------------- Public---------------------

function TInterruptTest.InterruptTest():boolean;

var StatDRQ:boolean;
    StatDRY:boolean;
    StatINL:boolean;
    StatALL:boolean;

    Errstatus:_DWORD;

begin
    ErrStatus:=0;
    // alle interrupts zuruecksetzen
    IFKSLClearDRQYINL(IntIFKDRQYINL, ErrStatus);


    StatDRQ:= DrqDryInlOnlyTest(IntIFKDRQ, ErrStatus);
    StatDRY:= DrqDryInlOnlyTest(IntIFKDRY, ErrStatus);
    StatINL:= DrqDryInlOnlyTest(IntIFKINL, ErrStatus);
    StatALL:= DrqDryInlOnlyTest(IntIFKDRQYINL, ErrStatus);

    if (((StatDRQ and StatDRY and StatINL and StatALL) = true) and (ErrStatus = StatusOK)) then result:= true
    else result:= false;
end;


end.
