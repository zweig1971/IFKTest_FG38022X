//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// TEST-IFK MainMenue
// *Der einstiegspunkt
//====================================

unit TEST_IFKMainMenue;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls;

type
  TIFKMainMenue = class(TForm)
    Panel1: TPanel;
    EXIT_Button: TButton;
    SingelStep_Button: TButton;
    AutomaticTest_Button: TButton;
    MainMenu1: TMainMenu;
    About_Menue: TMenuItem;
    procedure EXIT_ButtonClick(Sender: TObject);
    procedure SingelStep_ButtonClick(Sender: TObject);
    procedure AutomaticTest_ButtonClick(Sender: TObject);
    function  IFKMasterSlaveOnlineTest():boolean;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure About_MenueClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  IFKMainMenue: TIFKMainMenue;


implementation

uses Test_SingelTesTStep, TEST_DatenEingabe, TEST_AutomaticTest,
  TEST_ProtokollShow, UnitMil, TEST_GLobaleVariaben, TEST_Info,
  TEST_IFKProgrammierung;

{$R *.DFM}

procedure TIFKMainMenue.EXIT_ButtonClick(Sender: TObject);
begin
      IFKMainMenue.Close;
end;

procedure TIFKMainMenue.SingelStep_ButtonClick(Sender: TObject);
begin
     EXPMainMenueForm.ShowModal;
end;

procedure TIFKMainMenue.AutomaticTest_ButtonClick(Sender: TObject);

var x:integer;


begin
     IsTestPast:=false;

     TEST_DatenEingabeForm.ShowModal;
     TEST_AutomaticTesTForm.ShowModal;

     if(IsTestPast = true) then begin
       //Leerzeichen einfuegen
       for x:=1 to 10 do begin
          TEST_ProtokollShowForm.ProtokollListBox.Items.Add('');
       end;

       //Unterschrift
       TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeUnterschrift1);
       TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeUnterschrift2);

       //Leerzeichen einfuegen
       for x:=1 to 3 do begin
          TEST_ProtokollShowForm.ProtokollListBox.Items.Add('');
       end;

       //Legende
       TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende1);
       TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende2);
       TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende3);
       TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende4);
       TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende5);
       TEST_ProtokollShowForm.ProtokollListBox.Items.Add(ProtListeLegende6);
       TEST_ProtokollShowForm.ShowModal;
     end;
end;

function  TIFKMainMenue.IFKMasterSlaveOnlineTest():boolean;

var status:_DWORD;
    ErrStatus:_DWORD;
    IFKAntwort:_WORD;
    ErrorFound:boolean;

begin

     status:= StatusOK;
     ErrorFound:= false;

     // Master antesten
     status:= PCI_IfkRead (Cardauswahl, IFKAdressMaster, FktRead, IFKAntwort, ErrStatus);

     if(status <> StatusOK) then begin
       Application.MessageBox('Read IFK-MasterCard Error','Fuck',16);
       ErrorFound:=true;
     end else if(IFKAdressMaster <> IFKAntwort) then begin
       Application.MessageBox(' The answer from Master is wrong ','What ?',16);
       ErrorFound:=true;
     end;

     status:= StatusOK;

     // Slave antesten
     status:= PCI_IfkRead (Cardauswahl, IFKAdressSlave, FktRead, IFKAntwort, ErrStatus);

     if(status <> StatusOK) then begin
       Application.MessageBox('Read IFK-SlaveCard Error','Fuck again',16);
       ErrorFound:=true;
     end else if(IFKAdressSlave <> IFKAntwort) then begin
       Application.MessageBox(' The answer from Slave is wrong ','What now...',16);
       ErrorFound:=true;
     end;

     result:=ErrorFound;
end;


procedure TIFKMainMenue.FormCreate(Sender: TObject);

var status:_DWORD;
    ErrorFound:boolean;
    Abbruch:boolean;
    button:_WORD;
    IFKAntwort:_WORD;
    ErrStatus:_DWORD;
    FoundCards:_WORD;


begin
     ErrorFound:=false;
     abbruch:=false;

     // aktuelles verzeichnis ermitteln
     GetDir(0,Anwendungsverzeichnis);

     //=====================================================
     // PCiI MilKarte suchen und öffnen
     //=====================================================
     FoundCards:= PCI_PCIcardCount();
     if(FoundCards <> 0) then begin
       status:= PCI_DriverOpen(PCIAdress);
       if (status= StatusOK) then Cardauswahl:= PCIAdress
        else begin
          Application.MessageBox('Open PCI-MilCard FAILURE !','Shit',16);
          ErrorFound:=true;
         end;
     end else begin
         Application.MessageBox('No PCI-MilCard found !','Shit happens',16);
         ErrorFound:= true;
     end;

     //Master suchen
     if(ErrorFound =  false) then begin
       while (abbruch = false) do begin
         status:= PCI_IfkRead (Cardauswahl, IFKAdressMaster, FktRead, IFKAntwort, ErrStatus);
         if((status <> StatusOK) or (IFKAntwort <> IFKAdressMaster)) then begin
           button:= Application.MessageBox('Die Prüfbox meldet sich nicht, bitte überprüfen Sie die Verkabelung ','Erfahrung ist die Belohnung des Schmerzes',69);
             case button of
              IDRETRY: begin
                        abbruch:=false;
                        status:=StatusOK;
                        IFKAntwort:=0;
                        ErrStatus:=0;
                       end;

              IDCANCEL:begin
                        abbruch:=true;
                        ErrorFound:= true;
                       end;
             end;
         end else Abbruch:= true;
       end;
     end;

     //=====================================================
     //prüfen ob das verszeichnis für die protokolldatei angelegt ist
     // aktuelles verzeichnis ermitteln
     //======================================================
     //GetDir(0,Anwendungsverzeichnis);
     if (not FileExists(Anwendungsverzeichnis+DateiTestFlash) or
         not FileExists(Anwendungsverzeichnis+DateiTestFinal))then
        begin
             Application.MessageBox('Wichtige Dateien (.rbf) konnten nicht gefunden werden, bitte überprüfen Sie die Installation'
                                   ,'Der Ausweg führt durch die Tür.Warum benutzt niemand die Tür ?',16);
             ErrorFound :=  true;
        end;              

     if(ErrorFound =  true) then begin
       IFKMainMenue.Close;
       Application.Terminate;
     end;
end;

procedure TIFKMainMenue.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     PCI_DriverClose(PCIAdress);
end;

procedure TIFKMainMenue.About_MenueClick(Sender: TObject);
begin
     KickerTest_Info.ShowModal;
end;

end.
