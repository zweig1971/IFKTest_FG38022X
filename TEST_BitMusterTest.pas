//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// *TEST BitMuster Test
// *stellt alle nötigen funktionen für den
//  bitshifttest. VGL und Piggy
// *Logik & auswertung geschieht nicht hier
// *schiebt eine 1 oder 0 durch
// *schreibt diese an die VGL oder Piggy
// *beide  richtungen m->s, m<-s möglich
// *BitMusterTest ist unabhaengig. muss voher
// initialisiert werden
//====================================


unit TEST_BitMusterTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons,UnitMil, BitShiftClass, TEST_GLobaleVariaben;

type
     TConfigRec = record
                PCI_CardAdress:integer;
                IFKMasterAdr:_BYTE;
                IFKSlaveAdr:_BYTE;

                FCWR_EnabelDriver:_WORD;
                FCRD_EnabelDriver:_WORD;

                FCWR_DirectDriver:_WORD;
                FCRD_DirectDriver :_WORD;

                EnableDriver:_DWORD;
                DisableDriver:_DWORD;

                DirectOut:_DWORD;
                DirectIn :_DWORD;

                WrVgl1:_WORD;
                WrVgl2:_WORD;
                WrVgl3:_WORD;
                WrVgl4:_WORD;
                WrVgl5:_WORD;
                WrVgl6:_WORD;

                RdVgl1:_WORD;
                RdVgl2:_WORD;
                RdVgl3:_WORD;
                RdVgl4:_WORD;
                RdVgl5:_WORD;
                RdVgl6:_WORD;

                WrPgy1:_WORD;
                WrPgy2:_WORD;
                WrPgy3:_WORD;

                RdPgy1:_WORD;
                RdPgy2:_WORD;
                RdPgy3:_WORD;

                ZeroOneShift:boolean;
                MaxArry:_BYTE;
                MaxBit:_BYTE;
                end;
     TBitMusterTest = class

private

 ConfigRec:TConfigRec;

 procedure SetEnDisDriver(MSIFKAdress:_BYTE; EnDis:boolean; var ErrStatus:_DWORD);
 procedure RdEnDisDriver(MSIFKAdress:_BYTE; var Result:_WORD; var ErrStatus:_DWORD);

 procedure SetDriverDir(MSIFKAdress:_BYTE; InOutput:boolean; var ErrStatus:_DWORD);
 procedure RdDriverDir(MSIFKAdress:_BYTE; var Result:_WORD; var ErrStatus:_DWORD);

 procedure WrVGBitShiftArray(MSIFKAdress:_BYTE; var ErrStatus:_DWORD);
 procedure RdVGBitShiftArray(MSIFKAdress:_BYTE; var ErrStatus:_DWORD);

 procedure WrPGYBitShiftArray(MSIFKAdress:_BYTE; var ErrStatus:_DWORD);
 procedure RdPGYBitShiftArray(MSIFKAdress:_BYTE; var ErrStatus:_DWORD);

public

 procedure Init(UserConfigRec:TConfigRec);

 function intToBinary(Value:longint; digits:Byte):string;

 procedure SetMasterInSlaveOut(var ErrStatus:_DWORD);
 procedure SetMasterOutSlaveIn(var ErrStatus:_DWORD);

 procedure RdBitVGMaster(var ErrStatus:_DWORD);
 procedure WrBitVGMaster(var ErrStatus:_DWORD);

 procedure RdBitVGSlave(var ErrStatus:_DWORD);
 procedure WrBitVGSlave(var ErrStatus:_DWORD);

 procedure RdPgyMaster(var ErrStatus:_DWORD);
 procedure WrPgyMaster(var ErrStatus:_DWORD);

 procedure RdPgySlave(var ErrStatus:_DWORD);
 procedure WrPgySlave(var ErrStatus:_DWORD);
end;

var SetBitShiftArray:TBitShiftArray;
    ReadBitShiftArray:TBitShiftArray;

implementation

// ---------------- Private---------------------


// Enabelt oder disabelt die treiber auf der IFK
procedure TBitMusterTest.SetEnDisDriver(MSIFKAdress:_BYTE; EnDis:boolean; var ErrStatus:_DWORD);

var EnabelDisabel:_DWORD;

begin
     // Treiber enabeln oder disabeln
     if(EnDis = true) then EnabelDisabel:= ConfigRec.EnableDriver
     else EnabelDisabel:= ConfigRec.DisableDriver;
     // Verschiken
     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.FCWR_EnabelDriver,
                  EnabelDisabel, ErrStatus);
end;


// Liest aus ob die treiber der IFK enabelt oder disabelt sind
procedure TBitMusterTest.RdEnDisDriver(MSIFKAdress:_BYTE; var Result:_WORD; var ErrStatus:_DWORD);
begin
     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.FCRD_EnabelDriver,
                Result, ErrStatus);
end;

// legt die treiberrichtung der IFK fest(IN=true, Out=false)
procedure TBitMusterTest.SetDriverDir(MSIFKAdress:_BYTE; InOutput:boolean; var ErrStatus:_DWORD);

var InputOutput:_DWORD;

begin
     // Treiberrichtung wird festgelegt
     if(InOutPut= true) then InputOutput:= ConfigRec.DirectIn
     else InputOutput:= ConfigRec.DirectOut;
     // weg damit
     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.FCWR_DirectDriver,
                   InputOutput, ErrStatus);
end;

// liest die aktuelle treiberrichtung aus
procedure TBitMusterTest.RdDriverDir(MSIFKAdress:_BYTE; var Result:_WORD; var ErrStatus:_DWORD);
begin
     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.FCRD_DirectDriver,
                 Result, ErrStatus);
end;

// schreibt das BitShiftArray zur IFK VG-Leiste
procedure TBitMusterTest.WRVGBitShiftArray(MSIFKAdress:_BYTE; var ErrStatus:_DWORD);
begin
     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrVgl1,
                  SetBitShiftArray[1], ErrStatus);

     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrVgl2,
                  SetBitShiftArray[2], ErrStatus);

     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrVgl3,
                  SetBitShiftArray[3], ErrStatus);

     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrVgl4,
                  SetBitShiftArray[4], ErrStatus);

     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrVgl5,
                  SetBitShiftArray[5], ErrStatus);

     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrVgl6,
                  SetBitShiftArray[6], ErrStatus);
end;

// liesst das die VG-leiste aus & schreibt es in ein array
procedure TBitMusterTest.RDVGBitShiftArray(MSIFKAdress:_BYTE; var ErrStatus:_DWORD);
begin
     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdVgl1,
                 ReadBitShiftArray[1],ErrStatus);

     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdVgl2,
                 ReadBitShiftArray[2],ErrStatus);

     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdVgl3,
                 ReadBitShiftArray[3],ErrStatus);

     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdVgl4,
                 ReadBitShiftArray[4],ErrStatus);

     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdVgl5,
                 ReadBitShiftArray[5],ErrStatus);

     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdVgl6,
                 ReadBitShiftArray[6],ErrStatus);
end;

// Schreibt das Bitshiftarray an den piggy-stecker
procedure TBitMusterTest.WrPGYBitShiftArray(MSIFKAdress:_BYTE; var ErrStatus:_DWORD);
begin
     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrPgy1 ,
                  SetBitShiftArray[1], ErrStatus);

     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrPgy2 ,
                  SetBitShiftArray[2], ErrStatus);

     PCI_IfkWrite(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.WrPgy3 ,
                  SetBitShiftArray[3], ErrStatus);
end;

// liest den piggy-stecker aus
procedure TBitMusterTest.RdPGYBitShiftArray(MSIFKAdress:_BYTE; var ErrStatus:_DWORD);
begin
     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdPgy1 ,
                 ReadBitShiftArray[1], ErrStatus);

     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdPgy2 ,
                 ReadBitShiftArray[2], ErrStatus);

     PCI_IfkRead(ConfigRec.PCI_CardAdress, MSIFKAdress, ConfigRec.RdPgy3 ,
                 ReadBitShiftArray[3], ErrStatus);
end;

// ---------------- Public ---------------------
procedure TBitMusterTest.Init(UserConfigRec:TConfigRec);
begin
     ConfigRec:= UserConfigRec;
end;

// Wandelt ein long longinteger binaeres string um
function TBitMusterTest.intToBinary(Value:longint; digits:Byte):string;

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

// Setzt treiberrichtung des master auf IN & slave auf OUT
procedure TBitMusterTest.SetMasterInSlaveOut(var ErrStatus:_DWORD);
begin
     // Master auf IN
     SetDriverDir(ConfigRec.IFKMasterAdr, true, ErrStatus);
     // Master treiber enabeln
     SetEnDisDriver(ConfigRec.IFKMasterAdr, true, ErrStatus);

     // Slave auf OUT
     SetDriverDir(ConfigRec.IFKSlaveAdr, false, ErrStatus);
     // Slave treiber enabeln
     SetEnDisDriver(ConfigRec.IFKSlaveAdr, true, ErrStatus);
end;

// setzt treiberrichtung des slaves auf IN & Master auf OUT
procedure TBitMusterTest.SetMasterOutSlaveIn(var ErrStatus:_DWORD);
begin
     // Master auf OUT
     SetDriverDir(ConfigRec.IFKMasterAdr, false, ErrStatus);
     // Master treiber enabeln
     SetEnDisDriver(ConfigRec.IFKMasterAdr, true, ErrStatus);

     // Slave auf IN
     SetDriverDir(ConfigRec.IFKSlaveAdr, true, ErrStatus);
     // Slave treiber enabeln
     SetEnDisDriver(ConfigRec.IFKSlaveAdr, true, ErrStatus);
end;

// liest die VG-Leiste des masters aus
procedure TBitMusterTest.RdBitVGMaster(var ErrStatus:_DWORD);
begin
     RDVGBitShiftArray(ConfigRec.IFKMasterAdr, ErrStatus);
end;

// schreibt daten auf die VG-leiste des masters
procedure TBitMusterTest.WrBitVGMaster(var ErrStatus:_DWORD);
begin
     WRVGBitShiftArray(ConfigRec.IFKMasterAdr, ErrStatus);
end;

// liest die VG-leiste des slaves aus
procedure TBitMusterTest.RdBitVGSlave(var ErrStatus:_DWORD);
begin
     RDVGBitShiftArray(ConfigRec.IFKSlaveAdr, ErrStatus);
end;

//  schreibt daten auf die VG-leiste des slaves
procedure TBitMusterTest.WrBitVGSlave(var ErrStatus:_DWORD);
begin
     WRVGBitShiftArray(ConfigRec.IFKSlaveAdr, ErrStatus);
end;

// liest daten an das master-piggy
procedure TBitMusterTest.RdPgyMaster(var ErrStatus:_DWORD);
begin
     RdPGYBitShiftArray(ConfigRec.IFKMasterAdr, ErrStatus);
end;

// schreibt daten vom master-piggy
procedure TBitMusterTest.WrPgyMaster(var ErrStatus:_DWORD);
begin
     WrPGYBitShiftArray(ConfigRec.IFKMasterAdr, ErrStatus);
end;

// liest daten vom slave-piggy
procedure TBitMusterTest.RdPgySlave(var ErrStatus:_DWORD);
begin
     RdPGYBitShiftArray(ConfigRec.IFKSlaveAdr, ErrStatus);
end;

// schreibt daten an slave-piggy
procedure TBitMusterTest.WrPgySlave(var ErrStatus:_DWORD);
begin
     WrPGYBitShiftArray(ConfigRec.IFKSlaveAdr, ErrStatus);
end;
end.
