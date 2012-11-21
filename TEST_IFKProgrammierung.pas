//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// TEST-IFK Programmierung
// *lash-file von der platte laden
// *flash in der ifk loeschen
// *flash in der ifk neu beschrieben
// *flash in der ifk verifizieren
// *ifk failsave/usermode umschalten
//====================================


unit TEST_IFKProgrammierung;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,UnitMil, ExtCtrls, ComCtrls, Buttons,TEST_GLobaleVariaben, modulbus,
  jpeg;

type
  TIFKProgrammierungForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    IFKProgrammierungProgressBar: TProgressBar;
    ProgrammImage: TImage;
    VerificationImage: TImage;
    function LoadFlashFile(dateiname:string):boolean;
    function MOD_Erase_User_Flash(var ErrorStatus:_DWORD):boolean;
    function UserSaveEnable():boolean;
    function UserFlashprog(var ErrorOut:TStrings):boolean;
    function UserFlashVerify(var ErrorOut:TStrings):boolean;
    function IFKProgrammierung(ProgramTestVer:boolean; var ErrorOut:TStrings):boolean;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  IFKProgrammierungForm: TIFKProgrammierungForm;

implementation

uses TEST_BitMusterTest, TEST_BitteWarten;

{$R *.DFM}

// Flash file laden
function TIFKProgrammierungForm.LoadFlashFile(dateiname:string):boolean;

begin
     //GetDir(0,Anwendungsverzeichnis);

     AssignFile(FileByte, Anwendungsverzeichnis+dateiname);
     {$i-}
          Reset(FileByte);
     {$i+}
     if IOResult = 0 then begin
        ConfigFileSize := FileSize(FileByte);
        result:= true;
     end else begin
        dateiname := '';
        result:=  false;
     end
end;

// Lösche User-Flash
function TIFKProgrammierungForm.MOD_Erase_User_Flash(var ErrorStatus:_DWORD):boolean;

var
   ErrStatus:_DWORD;
   i        :_DWORD;

begin
    ErrStatus := 0;
    i         := 0;

    //Vorbereitung zum loeschen des User-Flash
    modulbus_adr_hw_lw_set($654321,ErrStatus);

   //User Flash loeschen
   if(AuswahlKickerKarte = false) then  modulbus_adr_wr(mod_cstat_erase_user_flash, ifk_comm_status_wr, MBKAdress, IFKAdress,ErrStatus)
   else modulbus_adr_wr(mod_cstat_erase_user_flash, mod_comm_status, MBKAdress, IFKAdress,ErrStatus);

//    PCI_TimerWait(Cardauswahl, 50, 1, ErrStatus);

    repeat
      i:=i+1;
    until (MOD_CommStatusTest(mod_cstat_erase_user_flash) = false) or (i<ProgUserFlashDelCnt);

    if (i = 0) or (i >= ProgUserFlashDelCnt) then begin
       Application.MessageBox('Fehler beim löschen des User-Flash', 'ABBRUCH', 16);
       MOD_Erase_User_Flash := false;
       end
    else MOD_Erase_User_Flash := true;
end;

function TIFKProgrammierungForm.UserSaveEnable():boolean;

var ErrStatus:_DWORD;

begin
     ErrStatus:=0;
     modulbus_adr_wr(mod_cstat_reload_user, ifk_comm_status_wr, MBKAdress, IFKAdress,ErrStatus);
     PCI_TimerWait(Cardauswahl, 2500, 1, ErrStatus);
     if(ErrStatus = 0) then result:= true
     else result:= false;
end;

// UserFlash programmieren
function TIFKProgrammierungForm.UserFlashprog(var ErrorOut:TStrings):boolean;

var
   i        : _WORD;
   x        : _WORD;
   index    : _DWORD;
   data     : _BYTE;
   StatReg  : _WORD;
   ErrStatus: _DWORD;
   ByteCount: _DWORD;

   daten: RECORD CASE BYTE OF
               1: ( r: PACKED RECORD
                         lb: _BYTE;
                         hb: _BYTE;
                       END; );
               2: ( w: _WORD );
             END;

begin
     index := 0;
     ErrStatus := 0;
     ByteCount := 0;
     //Fenster fuer Fortschrittsanzeige init. & anzeigen
     IFKProgrammierungForm.Caption := 'burn baby burn...';
     IFKProgrammierungForm.Label1.Caption := 'Programming in progress.......please wait....';
     IFKProgrammierungForm.IFKProgrammierungProgressBar.Min := 0;
     IFKProgrammierungForm.IFKProgrammierungProgressBar.Max := ConfigFileSize;
     IFKProgrammierungForm.IFKProgrammierungProgressBar.Perform($0409, 0, clGreen);
     IFKProgrammierungForm.ProgrammImage.Visible:=true;
     IFKProgrammierungForm.VerificationImage.Visible:=false;
     IFKProgrammierungForm.Update;
     Application.ProcessMessages();

     //Config-File von anfang an lesen
     {$i-}
         Reset(FileByte);
     {$i+}

   //User Flash loeschen
    if not(MOD_Erase_User_Flash(ErrStatus)) then begin
       mod_rd_commstatus(StatReg);
       ErrorOut.Add('ERROR: Timeout User Flash konnte nicht gelöscht werden ! StatReg:$'+IntToHex(StatReg,4));
       UserFlashprog := false;
       IFKProgrammierungForm.Close;
       exit;
       end;


     while not eof(FileByte) do begin

           //FiFo loeschen
           MOD_Erase_FiFo(ErrStatus);

           // Daten sollen ab der adresse null geschrieben werden
           if modulbus_adr_hw_lw_set(index, ErrStatus) = false then begin
              mod_rd_commstatus(StatReg);
              ErrorOut.Add('ERROR: Start-Adresse vom FiFo kann nicht gesetzt werden StatReg:$'
                                   +IntToHex(StatReg,4)+ '  Adresse:'+IntToStr(index));
              UserFlashprog := false;
              IFKProgrammierungForm.Close;
              exit;
              end;

            // Daten sollen ins FiFo geschrieben werden
            if(AuswahlKickerKarte = false) then modulbus_adr_wr(mod_cstat_wr_fifo, ifk_comm_status_wr, MBKAdress, IFKAdress, ErrStatus)
            else modulbus_adr_wr(mod_cstat_wr_fifo, mod_comm_status, MBKAdress, IFKAdress, ErrStatus);

           i:=0;

           repeat
             // HB Lesen
             Read(FileByte, data);
             daten.r.hb := data;

             if not eof(FileByte) then begin
                // LW Lesen
                Read(FileByte, data);
                daten.r.lb := data;
             end else daten.r.lb := $FF;

             // Daten schreiben
             if(AuswahlKickerKarte = false) then modulbus_adr_wr(daten.w, ifk_data_reg_wr, MBKAdress, IFKAdress,ErrStatus)
             else modulbus_adr_wr(daten.w, mod_data_reg, MBKAdress, IFKAdress,ErrStatus);

             i:=i+1;
             ByteCount:=ByteCount + 2;

           until(i=128) or eof(FileByte);

           //FiFo muss jetzt voll sein
           if   (MOD_CommStatusTest(mod_cstat_wr_fifo) = true) and not(eof(FileByte)) then begin
                mod_rd_commstatus(StatReg);
                ErrorOut.Add('ERROR ! '+IntToStr(i)+'x geschrieben FiFo ist nicht voll. StatusReg:$'
                +IntToHex(StatReg,4));
                UserFlashprog := false;
                IFKProgrammierungForm.Close;
                exit;
                end;

           //User Flash programmieren
           if(AuswahlKickerKarte = false) then modulbus_adr_wr(mod_cstat_fifo_to_user, ifk_comm_status_wr, MBKAdress, IFKAdress,ErrStatus)
           else modulbus_adr_wr(mod_cstat_fifo_to_user, mod_comm_status, MBKAdress, IFKAdress,ErrStatus);

           x:=0;
           repeat
                 x:=x+1;
                 PCI_TimerWait(Cardauswahl, 10, 1, ErrStatus);
           until (MOD_CommStatusTest(mod_cstat_fifo_to_user) = false) or (x > ProgFiFoUserCnt);

           //ErrorOut.Items. Add('Programmierung :'+IntToStr(x));

           if (x > ProgFiFoUserCnt) then begin
              ErrorOut.Add('ERROR ! TimeOut beim Programmieren! fifo -> user!');
              UserFlashprog := false;
              IFKProgrammierungForm.Close;
              exit;
              end;

//           if x = 1 then
//              ErrorOut.Items. Add('WARNING ! Programierung vermutlich fehlerhaft ! (x=1)');

           index := index + 256;
           LoopCounter := LoopCounter + 1;

           // Statusbalken updaten & abbruch button pruefen
           if (LoopCounter mod 10 = 0) or (eof(FileByte)) then begin
              IFKProgrammierungForm.IFKProgrammierungProgressBar.Position := ByteCount;
              IFKProgrammierungForm.Update;
              Application.ProcessMessages
           end;
    end;

{    if(AuswahlKickerKarte = false) then modulbus_adr_wr(mod_cstat_reload_failsave, ifk_comm_status_wr, MBKAdress, IFKAdress,ErrStatus)
    else modulbus_adr_wr(mod_cstat_reload_failsave, mod_comm_status, MBKAdress, IFKAdress,ErrStatus);
    MOD_CommStatusTest(mod_cstat_fifo_to_user);  }

    IFKProgrammierungForm.Close;
    Application.ProcessMessages();
    UserFlashprog := true;
end;

// UserFlash verification
function TIFKProgrammierungForm.UserFlashVerify(var ErrorOut:TStrings):boolean;

var
   x        : _WORD;
   i        : _WORD;
   DataByte : _BYTE;
   FiFoData : _WORD;
   StatReg  : _WORD;
   ErrStatus: _DWORD;
   index    : _DWORD;
   ErrCount : _DWORD;
   ByteCount: _DWORD;

   FileData: RECORD CASE BYTE OF
               1: ( r: PACKED RECORD
                         lb: _BYTE;
                         hb: _BYTE;
                       END; );
               2: ( w: _WORD );
             END;


begin
     StatReg   := 0;
     ErrStatus := 0;
     ErrCount  := 0;
     index     := 0;
     ByteCount := 0;

     //Fenster fuer Fortschrittsanzeige init. & anzeigen
     IFKProgrammierungForm.Caption := 'Verification';
     IFKProgrammierungForm.Label1.Caption := 'Verification in progress...please wait...';
     IFKProgrammierungForm.IFKProgrammierungProgressBar.Min := 0;
     IFKProgrammierungForm.IFKProgrammierungProgressBar.Max := ConfigFileSize;
     IFKProgrammierungForm.IFKProgrammierungProgressBar.Perform($0409, 0, clGreen);
     IFKProgrammierungForm.ProgrammImage.Visible:=false;
     IFKProgrammierungForm.VerificationImage.Visible:=true;
     IFKProgrammierungForm.Show;
     IFKProgrammierungForm.Update;
     Application.ProcessMessages();

     //Config-File von anfang an lesen
     {$i-}
         Reset(FileByte);
     {$i+}

      while not eof(FileByte) do begin
           x:= 0;
           i:= 0;

           // Daten sollen ab der adresse null gelesen werden
           if modulbus_adr_hw_lw_set(index, ErrStatus) = false then begin
              mod_rd_commstatus(StatReg);
              ErrorOut.Add('Verify:ERROR Start-Adresse vom FiFo kann nicht gesetzt werden $'
                                   +IntToHex(StatReg,4));
              UserFlashVerify := false;
              IFKProgrammierungForm.Close;
              exit
              end;

           //FiFo loeschen
           MOD_Erase_FiFo(ErrStatus);

           // Daten sollen aus dem FiFo gelesen werden
           if(AuswahlKickerKarte = false) then modulbus_adr_wr(mod_cstat_rd_user_flash, ifk_comm_status_wr, MBKAdress, IFKAdress,ErrStatus)
           else modulbus_adr_wr(mod_cstat_rd_user_flash, mod_comm_status, MBKAdress, IFKAdress,ErrStatus);

           //Prüfen ob Bit 13, lese User-Flash daten gültig, gesetzt ist
           repeat
                 x:=x+1;
                 PCI_TimerWait(Cardauswahl, 10, 1, ErrStatus);
           until (MOD_CommStatusTest(mod_cstat_rd_user_flash) <> true) or (x>ProgRdUserFDataValid);

           if (x>ProgRdUserFDataValid) then begin
           ErrorOut.Add('Verify:ERROR ! Transfer Data User-Flash -> RDFiFo Time-Out !');
           UserFlashVerify := false;
           IFKProgrammierungForm.Close;
           exit
           end;

           // Daten vom FiFo lesen wenn gültig
           repeat
                 //Daten aus dem FiFo nur lesen wenn daten gueltig
                 if(MOD_CommStatusTest(mod_cstat_rd_user_flash) <> true) then
                    if(AuswahlKickerKarte = false) then modulbus_adr_rd(FiFoData, ifk_data_reg_rd, MBKAdress, IFKAdress,ErrStatus)
                    else modulbus_adr_rd(FiFoData, mod_data_reg, MBKAdress, IFKAdress,ErrStatus)
                 else begin
                     ErrorOut.Add('Verify:ERROR! READ User-Flash Time-Out !');
                     UserFlashVerify := false;
                     IFKProgrammierungForm.Close;
                     exit
                     end;

                 //Daten vom config-file lesen
                 // HB Lesen
                 Read(FileByte, DataByte);
                 FileData.r.hb := DataByte;

                 // LW Lesen
                 if not eof(FileByte) then begin
                    Read(FileByte, DataByte);
                 end else DataByte:= $FF;

                 FileData.r.lb := DataByte;

                 if(FileData.w <> FiFoData) then begin
                   ErrCount:=ErrCount+1;
                   if(ErrCount<500) then
                   ErrorOut.Add('Verification error: soll:$'+IntToHex(FileData.w,4)
                                +'ist:$'+IntToHex(FiFoData,4)+' ErrCnt:'+IntToStr(ErrCount));
                 end;

                 i:=i+1;

                 ByteCount:=ByteCount + 2;

           until (MOD_CommStatusTest(mod_cstat_Rdfifo_empty)) or (i > 128) or eof(FileByte);

           index:=index+256;

           //FiFo muss leer sein -> sonst fehler !
           if not (MOD_CommStatusTest(mod_cstat_Rdfifo_empty)) and not (eof(FileByte)) then begin
              ErrorOut.Add('Verify:ERROR! Fehler beim lesen des FiFo StatusReg:$'+IntToHex(StatReg,4));
              UserFlashVerify := false;
              IFKProgrammierungForm.Close;
              exit
              end;

           LoopCounter := LoopCounter + 1;

           // Statusbalken updaten & abbruch button pruefen
           if (LoopCounter mod 10 = 0) or (eof(FileByte)) then begin
             IFKProgrammierungForm.IFKProgrammierungProgressBar.Position := ByteCount;
             IFKProgrammierungForm.Update;
             Application.ProcessMessages
           end;
     end; //while not eof(FileByte) do begin

     if(ErrCount = 0) then begin
        UserFlashVerify := true;
        IFKProgrammierungForm.Close;
        Application.ProcessMessages();
        end
     else begin
          ErrorOut.Add('Verify:ERROR! Fehler beim daten verification! ErrorCounter :'+IntToStr(ErrCount));
          UserFlashVerify := false;
          IFKProgrammierungForm.Close;
          Application.ProcessMessages();
     end;
end;


function TIFKProgrammierungForm.IFKProgrammierung(ProgramTestVer:boolean; var ErrorOut:TStrings):boolean;

var ErrStatus:_DWORD;
    status:boolean;
    ErrorFound:boolean;
    //ErrorOut:TStrings;

begin
     ErrStatus:= 0;
     ErrorFound:= false;
     //ErrorOut:= TStringList.Create;

     //als erstes muss beim master die treiberrichtung
     //S0-S15 auf out gesetzt werden
     PCI_IfkWrite(Cardauswahl, IFKAdressMaster, FCWR_DirectTreiber, ProgSetMasterOut, ErrStatus);

     //mastertreiber anablen
     PCI_IfkWrite(Cardauswahl, IFKAdressMaster, FCWR_EnabelTreiber, EnableTreiber, ErrStatus);

     //Slave muss seine adresse ueber den master bekommen
     //dazu wird d0-15 die adresse vom slvae (2) angelegt
     PCI_IfkWrite(Cardauswahl, IFKAdressMaster, WrVgl1, IFKAdressSlave, ErrStatus);

     //slave soll programmiert werden
     IFKAdress:= IFKAdressSlave;

     //Flasch für den test oder finale version laden
     if(ProgramTestVer = true) then status:= LoadFlashFile(DateiTestFlash)
     else  status:= LoadFlashFile(DateiTestFinal);

     //wegen der entprellung der interfacekartenadresse erst mal einen kaffee 
     PCI_TimerWait(Cardauswahl, 100, 1, ErrStatus);

      //Flash programmieren
     if (status = false) then begin
        Application.MessageBox('Test Konfigurationsfile konnte nicht geladen werden !','Shit',16);
        ErrorFound:= true
     end else status:=UserFlashprog(ErrorOut);
     if(status = false) then ErrorFound:= true;

     //noch einen Kaffee
     PCI_TimerWait(Cardauswahl, 1000, 1, ErrStatus);

     //Programmiertes flash ueberprüfen
     if(ErrorFound = false) then status:= UserFlashVerify(ErrorOut);
     if(status = false) then ErrorFound:= true;

     //noch einen kaffee hinterher
     PCI_TimerWait(Cardauswahl, 1000, 1, ErrStatus);

     // auf UserSave umschalten
     if(ErrorFound = false) then begin
       BitteWartenForm.Show;
       Application.ProcessMessages();
       status:= UserSaveEnable();
       BitteWartenForm.Close;
       Application.ProcessMessages();
     end;

     if(status = false) then ErrorFound:= true;

     //Master out und slave in setzten dient dazu um
     //längere kurschlüsse unter den treibern zu vermeiden
    // PCI_IfkWrite(Cardauswahl, IFKAdressMaster, FCWR_EnabelTreiber, DisableTreiber, ErrStatus);

     if(ErrorFound = false) then result:= true
     else result:= false;
end;
end.
