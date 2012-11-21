//-----------------------------
// GSI Gesellschaft für 
// Schwerionenforschung mbH, 
// Darmstadt, Germany 
//
// modulbus.pas
//
// Autor           : Zweig,Marcus
// Version         : 0.01
// letzte Änderung : 20.07.05
//------------------------------

unit modulbus;

interface

uses
  Forms,Classes,UnitMil,SysUtils,StdCtrls,Graphics,Windows,TEST_GLobaleVariaben;


const

 c_fc_mod_wr      = $10;
 c_fc_mod_adr_set = $11;
 c_fc_mod_rd      = $90;

 mod_comm_status  = $F0;

 mod_data_reg     = $F2;

 mod_cstat_reload_failsave = $1;
 mod_cstat_reload_user     = $2;
 mod_cstat_wr_lw_adress    = $4;
 mod_cstat_wr_hw_adress    = $8;
 mod_cstat_erase_fifo      = $40;
 mod_cstat_wr_fifo         = $80;
 mod_cstat_fifo_to_user    = $100;
 mod_cstat_Rdfifo_empty    = $800;
 mod_cstat_Rdfifo_not_full = $1000;
 mod_cstat_rd_user_flash   = $2000;
 mod_cstat_erase_user_flash= $4000;
 mod_cstat_reload_user_l    =$8000;

 ifk_comm_status_rd         = $9D;
 ifk_comm_status_wr         = $66;
 ifk_data_reg_rd            = $9C;
 ifk_data_reg_wr            = $65;

 //==========================================================

procedure modulbus_adr_set( sub_adr, mod_adr: _BYTE; modulbus_cntrl_adr: _BYTE;
                            VAR ErrStatus: _DWORD);

procedure modulbus_wr( data:_WORD; modulbus_cntrl_adr:_BYTE; VAR ErrStatus: _DWORD);

PROCEDURE modulbus_rd( VAR data: _WORD; modulbus_cntrl_adr: _BYTE;
                       VAR ErrStatus: _DWORD);

PROCEDURE modulbus_adr_rd( VAR data: _WORD;
                           sub_adr, mod_adr: _BYTE;
                           modulbus_cntrl_adr: _BYTE;
                           VAR ErrStatus: _DWORD);

PROCEDURE modulbus_adr_wr( data: WORD;
                           sub_adr, mod_adr: BYTE;
                           modulbus_cntrl_adr: BYTE;
                           VAR ErrStatus: _DWORD);

//==========================================================

// Testet das kommando statusregister ab
function MOD_CommStatusTest(StatusBit:_DWORD):boolean;

//Auslesen des kommando statusregister
procedure mod_rd_commstatus(var statusbits:_WORD);

//Schreibt HW-Adresse und LW-Adresse
function modulbus_adr_hw_lw_set(Adresse:_DWORD; VAR ErrStatus: _DWORD):boolean;

// FiFo loeschen
function MOD_Erase_FiFo(ErrorStatus:_DWORD):boolean;

// Datei Convertieren
function ConvertFile(FileTXT:TStringlist; ConvFile:TStringlist):boolean;

// ModulbusKarten suchen
procedure MBKFound(var MBKOnline: TStrings; MBKOnlineNr: TStrings ;var MBKCount: Integer);

//==========================================================

implementation

// Grundlegende Modulbus-zugriffe
//==========================================================

procedure modulbus_adr_set( sub_adr, mod_adr: _BYTE; modulbus_cntrl_adr: _BYTE;
                            VAR ErrStatus: _DWORD);

VAR
    address: RECORD CASE BYTE OF
               1: ( r: PACKED RECORD
                         lb: _BYTE;
                         hb: _BYTE;
                       END; );
               2: ( w: _WORD );
             END;

BEGIN
     address.r.lb := sub_adr;
     address.r.hb := mod_adr;

     PCI_IfkWrite(Cardauswahl, modulbus_cntrl_adr, c_fc_mod_adr_set, address.w, ErrStatus);
END;


procedure modulbus_wr( data:_WORD; modulbus_cntrl_adr:_BYTE; VAR ErrStatus: _DWORD);

BEGIN
     PCI_IfkWrite(Cardauswahl, modulbus_cntrl_adr, c_fc_mod_wr, data, ErrStatus );
END;


PROCEDURE modulbus_rd( VAR data: _WORD; modulbus_cntrl_adr: _BYTE;
                                  VAR ErrStatus: _DWORD);

BEGIN
     PCI_IfkRead(Cardauswahl, modulbus_cntrl_adr, c_fc_mod_rd, data, ErrStatus);
END;


PROCEDURE modulbus_adr_rd( VAR data: _WORD;
                           sub_adr, mod_adr: _BYTE;
                           modulbus_cntrl_adr: _BYTE;
                           VAR ErrStatus: _DWORD);
BEGIN
     if(AuswahlKickerKarte = true) then begin
      modulbus_adr_set( sub_adr, mod_adr, modulbus_cntrl_adr, ErrStatus );
      IF ErrStatus = 0 THEN modulbus_rd( data, modulbus_cntrl_adr, ErrStatus );
     end else begin
       PCI_IfkRead(Cardauswahl, modulbus_cntrl_adr, sub_adr, data, ErrStatus);
     end;
END;


PROCEDURE modulbus_adr_wr( data: WORD;
                           sub_adr, mod_adr: BYTE;
                           modulbus_cntrl_adr: BYTE;
                           VAR ErrStatus: _DWORD);
BEGIN
  if(AuswahlKickerKarte = true) then begin
    modulbus_adr_set( sub_adr, mod_adr, modulbus_cntrl_adr, ErrStatus );
    IF ErrStatus = 0 THEN modulbus_wr( data, modulbus_cntrl_adr, ErrStatus );
  end else begin
    PCI_IfkWrite(Cardauswahl, modulbus_cntrl_adr, sub_adr, data, ErrStatus );
  end;
END;

// Weitere Modulbus-zugriffe
//==========================================================

// Testet das kommando statusregister ab
function MOD_CommStatusTest(StatusBit:_DWORD):boolean;

var
    data      :_WORD;
    ErrStatus :_DWORD;

begin
     data      := 0;
     ErrStatus := 0;
     if(AuswahlKickerKarte = false) then modulbus_adr_rd(data, ifk_comm_status_rd, MBKAdress, IFKAdress, ErrStatus)
     else modulbus_adr_rd(data, mod_comm_status, MBKAdress, IFKAdress, ErrStatus);

     if data and StatusBit = StatusBit then MOD_CommStatusTest := true
     else MOD_CommStatusTest := false;
end;

//Auslesen des kommando statusregister
procedure mod_rd_commstatus(var statusbits:_WORD);

var
    ErrStatus :_DWORD;

begin
     ErrStatus := 0;
     if(AuswahlKickerKarte = false) then modulbus_adr_rd(statusbits, ifk_comm_status_rd, MBKAdress, IFKAdress, ErrStatus)
     else modulbus_adr_rd(statusbits, mod_comm_status, MBKAdress, IFKAdress, ErrStatus);
end;

//Schreibt HW-Adresse und LW-Adresse
function modulbus_adr_hw_lw_set(Adresse:_DWORD; VAR ErrStatus: _DWORD):boolean;

VAR
    address: RECORD CASE _DWORD OF
                1: ( dw: _DWORD );
                2: ( r: PACKED RECORD
                     lw: _WORD;
                     hw: _WORD;
                     END; );
                END;

begin
    address.dw := adresse;

    //PCI_TimerWait(Cardauswahl, 100, 1, ErrStatus);

    //lw-adresse festsetzen und pruefen bit muss von 0->1
    if(AuswahlKickerKarte = false) then modulbus_adr_wr(mod_cstat_wr_lw_adress, ifk_comm_status_wr, MBKAdress, IFKAdress, ErrStatus)
    else modulbus_adr_wr(mod_cstat_wr_lw_adress, mod_comm_status, MBKAdress, IFKAdress, ErrStatus);

     if MOD_CommStatusTest(mod_cstat_wr_lw_adress) <> true then begin
       // Application.MessageBox('Fehler beim schreiben auf die LW-Adresse', '0->1', 16);
        modulbus_adr_hw_lw_set := false;
        exit;
        end;

     //in lw-adresse schreiben & pruefen, bit mus von 1->0
     if(AuswahlKickerKarte = false) then modulbus_adr_wr(address.r.lw, ifk_data_reg_wr, MBKAdress, IFKAdress, ErrStatus)
     else modulbus_adr_wr(address.r.lw, mod_data_reg, MBKAdress, IFKAdress, ErrStatus);

     if MOD_CommStatusTest(mod_cstat_wr_lw_adress) = true then begin
       // Application.MessageBox('Fehler beim schreiben auf die LW-Adresse', '1->0', 16);
        modulbus_adr_hw_lw_set := false;
        exit;
        end;

    //PCI_TimerWait(Cardauswahl, 50, 1, ErrStatus);

    //hw-adresse festsetzen und pruefen bit muss von 0->1
    if(AuswahlKickerKarte = false) then modulbus_adr_wr(mod_cstat_wr_hw_adress, ifk_comm_status_wr, MBKAdress, IFKAdress, ErrStatus)
    else modulbus_adr_wr(mod_cstat_wr_hw_adress, mod_comm_status, MBKAdress, IFKAdress, ErrStatus);

     if MOD_CommStatusTest(mod_cstat_wr_hw_adress) <> true then begin
      //  Application.MessageBox('Fehler beim schreiben auf die HW-Adresse', '0->1', 16);
        modulbus_adr_hw_lw_set := false;
        exit;
        end;

     //in hw-adresse schreiben & pruefen, bit mus von 1->0
     if(AuswahlKickerKarte = false) then modulbus_adr_wr(address.r.hw, ifk_data_reg_wr, MBKAdress, IFKAdress, ErrStatus)
     else modulbus_adr_wr(address.r.hw, mod_data_reg, MBKAdress, IFKAdress, ErrStatus);

     if MOD_CommStatusTest(mod_cstat_wr_hw_adress) = true then begin
      //  Application.MessageBox('Fehler beim schreiben auf die HW-Adresse', '1->0', 16);
        modulbus_adr_hw_lw_set := false;
        exit;
        end;

     modulbus_adr_hw_lw_set := true;
end;

// FiFo loeschen
function MOD_Erase_FiFo(ErrorStatus:_DWORD):boolean;
var
   ErrStatus:_DWORD;
   i        :_DWORD;

begin
   ErrStatus := 0;
   i         := 0;

   if(AuswahlKickerKarte = false) then modulbus_adr_wr(mod_cstat_erase_fifo, ifk_comm_status_wr, MBKAdress, IFKAdress,ErrStatus)
   else modulbus_adr_wr(mod_cstat_erase_fifo, mod_comm_status, MBKAdress, IFKAdress,ErrStatus);

    repeat
      i:=i+1;
    until (MOD_CommStatusTest(mod_cstat_erase_fifo) = true) or (i<256);

    if (i = 0) or (i >= 256) then begin
       Application.MessageBox('Fehler beim löschen des FIFO', 'ABBRUCH', 16);
       MOD_Erase_FiFo := false;
       end
    else MOD_Erase_FiFo := true;
end;

//=================================================================================

// Datei Convertieren
function ConvertFile(FileTXT:TStringlist; ConvFile:TStringlist):boolean;

var   i       :word;
      index   :word;
      buffer  :string;

begin

     i     := 1;
     index := 0;
     ConvFile.Clear;

     while i < FileTXT.Count-1 do begin
         buffer := '';
         index := i;
         index := index + 3;
         while index >   i do begin
           if FileTXT.Text[i] = ' ' then begin
              i:=i+1
              end
           else begin
               buffer := buffer + FileTXT.Text[i];
               i := i + 1;
               end;
         end;

         if FileTXT.Text[i] <> ',' then begin
             Application.MessageBox('ACHTUNG ! Dateiformat ungültig','ERROR',16);
             ConvertFile := false;
             exit;
         end;
         i := i + 1;

         if FileTXT.Text[i] = char($0d) then begin
            i := i + 2;
         end;
         ConvFile.Add(buffer);
     end;
     ConvFile.Count;
     ConvertFile:= true;
end;


procedure MBKFound(var MBKOnline: TStrings; MBKOnlineNr: TStrings ;var MBKCount: Integer);

var
   i         : _WORD;
   data      : _WORD;
   index     : _WORD;
   ErrStatus : _DWORD;

begin
     i         := 0;
     data      := 0;
     index     := 0;
     ErrStatus := 0;
     MBKCount  := 0;

     repeat
          modulbus_adr_rd(data, $FE, i, IFKAdress,ErrStatus);
           if(ErrStatus = 0) then begin
             index := (data and $FF);
             if(index > 256) then messagebox(0,'Modul ID zu hoch !','Warnung',16)
             else begin
                  MBKOnline.Add(IntToHex(i,2)+'('+IntToHex(data,4)+')'+' '+MDK_IDCODE.Strings[index]);
                  MBKOnlineNr.Add(IntToHex(i,2));
                  MBKCount:=MBKCount+1;
                  end;
           end;
          ErrStatus :=0;
          i:=i+1;
     until (i=$1F);
end;


end.
