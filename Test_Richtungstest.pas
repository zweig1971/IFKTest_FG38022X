//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 16.10.2008
//
// TEST Richtungs test
// *pruefung ob sich die treiber in der richtung  (m->s, s->m)
// gegenseitig beeinflussen.
// * werden nacheinander die treiber von A bis Srest
// auf master -> slave geschaltet, eingänge auf 1
// * die übrigen treiber werden von slave -> master
// geschaltet, eingänge auf 0
// * master & slave werden ausgelesen und mit
// den gesetzten werten verglichen.
//====================================


unit TEST_RichtungsTest;

interface

uses UnitMil,TEST_GLobaleVariaben;

type TVGLRdData = array [1..6] of word;

     TRichtTesTDaten = record
                         SetMasterDir:_WORD;// Treiberrichtung fuer den master festlegen
                         SetSlaveDir:_WORD; // Treiberrichtung fuer den slave festlegen
                         VGLWRMaData:array [1..6] of word;//Daten an die master VG-reg. geschrieben werden
                       end;

     TRichtungsTesT = class


private
 procedure SetEnDisDriver(MSIFKAdress:_BYTE; EnDis:boolean; var ErrStatus:_DWORD);
 procedure SetDriverDir  (MSIFKAdress:_BYTE; SetDirection:_WORD; var ErrStatus:_DWORD);
 procedure WriteVG(MSIFKAdress:_BYTE; FCVG:_Byte; data:_Word; var ErrStatus:_DWORD);
 procedure ReadVG(MSIFKAdress:_BYTE; FCVG:_Byte; var data:_Word; var ErrStatus:_DWORD);

 procedure InitMasterSlave(var ErrStatus:_DWORD);
 procedure SetEnMasterSlave (var ErrStatus:_DWORD);
 procedure SetDisMasterSlave(var ErrStatus:_DWORD);

public
 function SetDirecAndTesT(DireTesTData:TRichtTesTDaten):boolean;
 function DirectionTesT():boolean;
end;

implementation

// -------------- private------------------

// Enabelt oder disabelt die treiber auf der IFK
procedure TRichtungsTesT.SetEnDisDriver(MSIFKAdress:_BYTE; EnDis:boolean; var ErrStatus:_DWORD);

var EnabelDisabel:_DWORD;

begin
     // Treiber enabeln oder disabeln
     if(EnDis = true) then EnabelDisabel:= EnableTreiber
     else EnabelDisabel:= DisableTreiber;
     // Verschiken
     PCI_IfkWrite(PCIAdress, MSIFKAdress, FCWR_EnabelTreiber,
                  EnabelDisabel, ErrStatus);
end;

// legt die treiberrichtung der IFK fest
procedure TRichtungsTesT.SetDriverDir(MSIFKAdress:_BYTE; SetDirection:_WORD; var ErrStatus:_DWORD);

begin
     PCI_IfkWrite(PCIAdress, MSIFKAdress, FCWR_DirectTreiber, SetDirection, ErrStatus);
end;


// schreibt ein datum an  die IFK VG-Leiste
procedure TRichtungsTesT.WriteVG(MSIFKAdress:_BYTE; FCVG:_Byte; data:_Word; var ErrStatus:_DWORD);
begin
     PCI_IfkWrite(PCIAdress, MSIFKAdress, FCVG, data, ErrStatus);
end;

//  liest ein datum von der VG-Leiste
procedure TRichtungsTesT.ReadVG(MSIFKAdress:_BYTE; FCVG:_Byte; var data:_Word; var ErrStatus:_DWORD);
begin
    PCI_IfkRead(PCIAdress, MSIFKAdress, FCVG, data, ErrStatus);
end;

//nullt die VGL-reg. des master & slaves
procedure TRichtungsTesT.InitMasterSlave(var ErrStatus:_DWORD);
begin
     WriteVG(IFKAdressSlave, WrVgl1, $0, ErrStatus);
     WriteVG(IFKAdressSlave, WrVgl2, $0, ErrStatus);
     WriteVG(IFKAdressSlave, WrVgl3, $0, ErrStatus);
     WriteVG(IFKAdressSlave, WrVgl4, $0, ErrStatus);
     WriteVG(IFKAdressSlave, WrVgl5, $0, ErrStatus);
     WriteVG(IFKAdressSlave, WrVgl6, $0, ErrStatus);

     WriteVG(IFKAdressMaster, WrVgl1, $0, ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl2, $0, ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl3, $0,ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl4, $0, ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl5, $0, ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl6, $0,ErrStatus);
end;

// Enabelt die master & slave treiber
procedure TRichtungsTesT.SetEnMasterSlave (var ErrStatus:_DWORD);
begin
     // Master Treiber enabeln
     SetEnDisDriver(IFKAdressMaster, true, ErrStatus);
     // Slave Treiber enabeln
     SetEnDisDriver(IFKAdressSlave, true, ErrStatus);
end;

// Disabelt  die master  & slave treiber
procedure TRichtungsTesT.SetDisMasterSlave(var ErrStatus:_DWORD);
begin
    // Master Treiber disabeln
     SetEnDisDriver(IFKAdressMaster, false, ErrStatus);
     // Slave Treiber disabeln
     SetEnDisDriver(IFKAdressSlave, false, ErrStatus);
end;

// ----------------- public ------------------


function TRichtungsTesT.SetDirecAndTesT(DireTesTData:TRichtTesTDaten):boolean;

var ErrStatus:_DWord;
    VGLRdData:TVGLRdData;
    ErrorFound:boolean;

begin

     ErrorFound:= false;
     ErrStatus:= StatusOK;

// Treiber disabeln
     SetDisMasterSlave(ErrStatus);

// VGL-Reg. nullen
     InitMasterSlave(ErrStatus);

// Treiberrichtung festlegen

     //Master
     SetDriverDir(IFKAdressMaster, DireTesTData.SetMasterDir ,ErrStatus);
     //Slave
     SetDriverDir(IFKAdressSlave, DireTesTData.SetSlaveDir ,ErrStatus);

// Treiber enabeln
     SetEnMasterSlave(ErrStatus);

// Daten Master schreiben

     WriteVG(IFKAdressMaster, WrVgl1, DireTesTData.VGLWRMaData[1] ,ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl2, DireTesTData.VGLWRMaData[2] ,ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl3, DireTesTData.VGLWRMaData[3] ,ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl4, DireTesTData.VGLWRMaData[4] ,ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl5, DireTesTData.VGLWRMaData[5] ,ErrStatus);
     WriteVG(IFKAdressMaster, WrVgl6, DireTesTData.VGLWRMaData[6] ,ErrStatus);

//  Daten Master lesen
{
     ReadVG(IFKAdressMaster, RdVgl1, VGLRdData[1], ErrStatus);
     ReadVG(IFKAdressMaster, RdVgl2, VGLRdData[2], ErrStatus);
     ReadVG(IFKAdressMaster, RdVgl3, VGLRdData[3], ErrStatus);
     ReadVG(IFKAdressMaster, RdVgl4, VGLRdData[4], ErrStatus);
     ReadVG(IFKAdressMaster, RdVgl5, VGLRdData[5], ErrStatus);
     ReadVG(IFKAdressMaster, RdVgl6, VGLRdData[6], ErrStatus);

// Gelesene daten vom master müssen gleich der gesendete sein

     if VGLRdData[1] <> DireTesTData.VGLWRMaData[1] then ErrorFound:= true;
     if VGLRdData[2] <> DireTesTData.VGLWRMaData[2] then ErrorFound:= true;
     if VGLRdData[3] <> DireTesTData.VGLWRMaData[3] then ErrorFound:= true;
     if VGLRdData[4] <> DireTesTData.VGLWRMaData[4] then ErrorFound:= true;
     if VGLRdData[5] <> DireTesTData.VGLWRMaData[5] then ErrorFound:= true;
     if VGLRdData[6] <> DireTesTData.VGLWRMaData[6] then ErrorFound:= true;  }

//  Daten Slave lesen

     ReadVG(IFKAdressSlave, RdVgl1, VGLRdData[1], ErrStatus);
     ReadVG(IFKAdressSlave, RdVgl2, VGLRdData[2], ErrStatus);
     ReadVG(IFKAdressSlave, RdVgl3, VGLRdData[3], ErrStatus);
     ReadVG(IFKAdressSlave, RdVgl4, VGLRdData[4], ErrStatus);
     ReadVG(IFKAdressSlave, RdVgl5, VGLRdData[5], ErrStatus);
     ReadVG(IFKAdressSlave, RdVgl6, VGLRdData[6], ErrStatus);


//  Gelesene daten vom slave müssen gleich der gesendete zum master sein

     if VGLRdData[1] <> DireTesTData.VGLWRMaData[1] then ErrorFound:= true;
     if VGLRdData[2] <> DireTesTData.VGLWRMaData[2] then ErrorFound:= true;
     if VGLRdData[3] <> DireTesTData.VGLWRMaData[3] then ErrorFound:= true;
     if VGLRdData[4] <> DireTesTData.VGLWRMaData[4] then ErrorFound:= true;
     if VGLRdData[5] <> DireTesTData.VGLWRMaData[5] then ErrorFound:= true;
     if VGLRdData[6] <> DireTesTData.VGLWRMaData[6] then ErrorFound:= true;

     if ErrStatus <> StatusOK then ErrorFound:= true;

     result:= not ErrorFound;
end;


function TRichtungsTesT.DirectionTesT():boolean;

var DireTesTData:TRichtTesTDaten;
    ErrorFound:boolean;

begin

     ErrorFound:= false;

// ---------- Treiber  A ----------------

     DireTesTData.SetMasterDir:= EnabelDriverA;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverA));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $0;
     DireTesTData.VGLWRMaData[5]:= $0;
     DireTesTData.VGLWRMaData[6]:= $FF;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  B ----------------

     DireTesTData.SetMasterDir:= EnabelDriverB;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverB));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $0;
     DireTesTData.VGLWRMaData[5]:= $F000;
     DireTesTData.VGLWRMaData[6]:= $0;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  C ----------------

     DireTesTData.SetMasterDir:= EnabelDriverC;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverC));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $0;
     DireTesTData.VGLWRMaData[5]:= $FF;
     DireTesTData.VGLWRMaData[6]:= $0;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  D ----------------

     DireTesTData.SetMasterDir:= EnabelDriverD;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverD));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $7F00;
     DireTesTData.VGLWRMaData[5]:= $0;
     DireTesTData.VGLWRMaData[6]:= $0;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  E ----------------

     DireTesTData.SetMasterDir:= EnabelDriverE;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverE));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $F8;
     DireTesTData.VGLWRMaData[5]:= $0;
     DireTesTData.VGLWRMaData[6]:= $0;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  F ----------------

     DireTesTData.SetMasterDir:= EnabelDriverF;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverF));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $0;
     DireTesTData.VGLWRMaData[5]:= $300;
     DireTesTData.VGLWRMaData[6]:= $0;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  G ----------------

     DireTesTData.SetMasterDir:= EnabelDriverG;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverG));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $0;
     DireTesTData.VGLWRMaData[5]:= $C00;
     DireTesTData.VGLWRMaData[6]:= $0;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  H ----------------

     DireTesTData.SetMasterDir:= EnabelDriverH;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverH));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $8000;
     DireTesTData.VGLWRMaData[5]:= $0;
     DireTesTData.VGLWRMaData[6]:= $0;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  I ----------------

     DireTesTData.SetMasterDir:= EnabelDriverI;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverI));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $0;
     DireTesTData.VGLWRMaData[5]:= $0;
     DireTesTData.VGLWRMaData[6]:= $100;

     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;

// ---------- Treiber  S ----------------

     DireTesTData.SetMasterDir:= EnabelDriverS;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverS));

     DireTesTData.VGLWRMaData[1]:= $FFFF;
     DireTesTData.VGLWRMaData[2]:= $0;
     DireTesTData.VGLWRMaData[3]:= $0;

     DireTesTData.VGLWRMaData[4]:= $0;
     DireTesTData.VGLWRMaData[5]:= $0;
     DireTesTData.VGLWRMaData[6]:= $0;

// ---------- Treiber  Srest ----------------

     DireTesTData.SetMasterDir:= EnabelDriverSr;
     DireTesTData.SetSlaveDir := _WORD(not(EnabelDriverSr));

     DireTesTData.VGLWRMaData[1]:= $0;
     DireTesTData.VGLWRMaData[2]:= $FFFF;
     DireTesTData.VGLWRMaData[3]:= $FFFF;

     DireTesTData.VGLWRMaData[4]:= $7;
     DireTesTData.VGLWRMaData[5]:= $0;
     DireTesTData.VGLWRMaData[6]:= $0;

     // hat alles geklappt
     if(SetDirecAndTesT(DireTesTData)) <> true then ErrorFound:=true;
     result:= not ErrorFound;
end;





end.
