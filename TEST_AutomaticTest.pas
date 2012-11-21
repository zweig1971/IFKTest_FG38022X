//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 18.09.2008
//
// *Test Automatic Test
// *verwaltet die anzeigenmaske
// *pruefling wird mit testsoftware geimpft
// *pruefling wird nach ende mit finalen software geimpft
// *ruft die einzelnen test auf
// *ggf. wird voher initialisiert
// *ergebnisse werden ausgewertet
// *ergebnisse werden protokolliert
// *Folgende test sind hier implementiert:
// - Test_ExterneClockTest
//====================================



unit TEST_AutomaticTest;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TEST_BitMusterTest, TEST_GLobaleVariaben, BitShiftClass,
  UnitMil,TEST_TimingTEST,TEST_SelectTest;

type
  TTest_AutomaticTesTForm = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    Bevel1: TBevel;
    Test2Shape: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    Test3Shape: TShape;
    Label8: TLabel;
    Bevel3: TBevel;
    Test4Shape: TShape;
    Bevel4: TBevel;
    Label9: TLabel;
    Test1Shape: TShape;
    Label10: TLabel;
    Bevel5: TBevel;
    Test1Label: TLabel;
    Test2Label: TLabel;
    Bevel6: TBevel;
    Test3Label: TLabel;
    Bevel7: TBevel;
    Test4Label: TLabel;
    Bevel8: TBevel;
    Label1: TLabel;
    LfdNrPanel: TPanel;
    NextIFKButton: TButton;
    EndTesTButton: TButton;
    Label2: TLabel;
    Bevel9: TBevel;
    Test5Shape: TShape;
    Test5Label: TLabel;
    Bevel10: TBevel;
    Label4: TLabel;
    Bevel11: TBevel;
    Test6Shape: TShape;
    Test6Label: TLabel;
    Bevel12: TBevel;
    Bevel13: TBevel;
    Label3: TLabel;
    Test7Shape: TShape;
    Test7Label: TLabel;
    Bevel14: TBevel;
    Bevel15: TBevel;
    Label5: TLabel;
    Test8Shape: TShape;
    Test8Label: TLabel;
    Bevel16: TBevel;
    ProgramFinalVerPanel: TPanel;
    ProgramFinalVerLabel: TLabel;
    ProgramTestVerPanel: TPanel;
    ProgramTestVerLabel: TLabel;
    Legende_ListBox: TListBox;
    Label11: TLabel;
    Bevel17: TBevel;
    Bevel18: TBevel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Label12: TLabel;
    Test9Shape: TShape;
    Test9Label: TLabel;
    procedure EndTesTButtonClick(Sender: TObject);
    function  Test_AutomaticTest():boolean;
    function  Test_ShiftBitTest(InitZero:boolean; MasterOut:boolean;VGTesT:boolean):boolean;
    function  Test_TimingKanalTest():boolean;
    function  Test_DrqDryInlTest():boolean;
    function  Test_ExterneClockTest():boolean;
    function  Test_DirectionTest():boolean;
    procedure Test_InitTestAnzeige();
    procedure Test_FailureTestAnzeige();
    procedure FormShow(Sender: TObject);
    procedure Test_StartAutomaticTest();
    procedure NextIFKButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

  procedure Test_SetInit(var Config: TConfigRec);

var
  Test_AutomaticTesTForm: TTest_AutomaticTesTForm;
  BitShiftConfig:TConfigRec;
  TestResultString:string;
  TestResultBool:boolean;
  LfdNrDWord:_DWORD;

implementation

uses TEST_ProtokollShow, TEST_SRNummerEingabe,TEST_InterruptTest,
  TEST_IFKProgrammierung, TEST_RichtungsTest;

{$R *.DFM}

function TTest_AutomaticTesTForm.Test_AutomaticTest():boolean;

var status:boolean;
    Button:_WORD;
    ErrorFound:boolean;
    ErrStatus:_DWORD;
    SelectTesT:TSelectTesT;

begin
     // Grunderscheinungsbild erstellen
     NextIFKButton.Enabled:= False;
     LfdNrPanel.Caption:= TestLfdNr;

     Test_InitTestAnzeige();

     Application.ProcessMessages();
     PCI_TimerWait(Cardauswahl, 250, 1, ErrStatus);

     TestResultBool:=true;

       //-----------------------------------------
      // Test 1: Visueller Test (D)
     //-----------------------------------------

     Button:= Application.MessageBox('Funktionieren alle LEDs auf der Frontseite ?','Frage',36);
     if(Button = IDYES) then begin
        Test1Shape.Brush.Color:= clLime;
        Test1Label.Caption := '    OK';
        TestResultArray[1]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test1Shape.Brush.Color:= clRed;
        Test1Label.Caption := '  FALSE';
        TestResultArray[1]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;
     Application.ProcessMessages();
       //-----------------------------------------
      //Test 2: VG Leisten shift test (A1)
     //-----------------------------------------

     ErrorFound:=false;
     // VG-Leisten Test: 1 shift Master Out, Slave In
     status:= Test_ShiftBitTest(true, true, true);
     if(status = false) then ErrorFound:=true;
     // VG-Leisten Test: 1 shift Master In, Slave Out
     status:= Test_ShiftBitTest(true, false, true);
     if(status = false) then ErrorFound:=true;

     // VG-Leisten Test: 0 shift Master Out, Slave In
     status:= Test_ShiftBitTest(false,true, true);
     if(status = false) then ErrorFound:=true;
     // VG-Leisten Test: 0 shift Master In, Slave Out
     status:= Test_ShiftBitTest(false, false, true);
     if(status = false) then ErrorFound:=true;

     if(ErrorFound = false) then begin
        Test2Shape.Brush.Color:= clLime;
        Test2Label.Caption := '    OK';
        TestResultArray[2]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test2Shape.Brush.Color:= clRed;
        Test2Label.Caption := '  FALSE';
        TestResultArray[2]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;
     Application.ProcessMessages();

       //-----------------------------------------
      //Test 3: Select-Signal Test  (A2)
     //-----------------------------------------
     ErrorFound:=false;
     SelectTesT:=TSelectTesT.Create;
     status:=SelectTesT.IFKSelectTest();
     if(status = false) then ErrorFound:= true;

     if(ErrorFound = false) then begin
        Test3Shape.Brush.Color:= clLime;
        Test3Label.Caption := '    OK';
        TestResultArray[3]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test3Shape.Brush.Color:= clRed;
        Test3Label.Caption := '  FALSE';
        TestResultArray[3]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;

     SelectTesT.Free;
     Application.ProcessMessages();
       //-----------------------------------------
      //Test 4: Direction Test  (A3)
     //-----------------------------------------
     status:= Test_DirectionTest();

     if(status = false) then ErrorFound:= true;

     if(ErrorFound = false) then begin
        Test4Shape.Brush.Color:= clLime;
        Test4Label.Caption := '    OK';
        TestResultArray[4]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test4Shape.Brush.Color:= clRed;
        Test4Label.Caption := '  FALSE';
        TestResultArray[4]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;

       //-----------------------------------------
      //Test 5: Piggy shift test (B)
     //-----------------------------------------
     ErrorFound:=false;
     // Pgy-Leisten Test: 1 shift Master Out, Slave In
     status:= Test_ShiftBitTest(true, true, false);
     if(status = false) then ErrorFound:= true;
     // Pgy-Leisten Test: 1 shift Master In, Slave Out
     status:= Test_ShiftBitTest(true, false, false);
     if(status = false) then ErrorFound:= true;
     // Pgy-Leisten Test: 0 shift Master Out, Slave In
     status:= Test_ShiftBitTest(false,true, false);
     if(status = false) then ErrorFound:= true;
     // Pgy-Leisten Test: 0 shift Master In, Slave Out
     status:= Test_ShiftBitTest(false, false, false);
     if(status = false) then ErrorFound:= true;

     if(ErrorFound = false) then begin
        Test5Shape.Brush.Color:= clLime;
        Test5Label.Caption:= '    OK';
        TestResultArray[5]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test5Shape.Brush.Color:= clRed;
        Test5Label.Caption:= '  FALSE';
        TestResultArray[5]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;

     Application.ProcessMessages();
       //-----------------------------------------
      //Test 6: Timing Test  (C)
     //-----------------------------------------
     status:= Test_TimingKanalTest();

     if(status = true) then begin
        Test6Shape.Brush.Color:= clLime;
        Test6Label.Caption:= '    OK';
        TestResultArray[6]:= true;
        TestResultString:= TestResultString + ProtListeOK
      end else begin
        Test6Shape.Brush.Color:= clRed;
        Test6Label.Caption:= '  FALSE';
        TestResultArray[6]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
      end;

      Application.ProcessMessages();
       //-----------------------------------------
      //Test 7: DRQ DRY INTRL Test
     //-----------------------------------------
     status:= Test_DrqDryInlTest();

     if(status = true) then begin
        Test7Shape.Brush.Color:= clLime;
        Test7Label.Caption:= '    OK';
        TestResultArray[7]:= true;
        TestResultString:= TestResultString + ProtListeOK
      end else begin
        Test7Shape.Brush.Color:= clRed;
        Test7Label.Caption:= '  FALSE';
        TestResultArray[7]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
      end;

      Application.ProcessMessages();
       //-----------------------------------------
      //Test 8: Externe Clock Test
     //-----------------------------------------
     status:= Test_ExterneClockTest();

     if(status = true) then begin
        Test8Shape.Brush.Color:= clLime;
        Test8Label.Caption:= '    OK';
        TestResultArray[8]:= true;
        TestResultString:= TestResultString + ProtListeOK
      end else begin
        Test8Shape.Brush.Color:= clRed;
        Test8Label.Caption:= '  FALSE';
        TestResultArray[8]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
      end;

      Application.ProcessMessages();

       //-----------------------------------------
      //Test 9: Manchaster test
     //-----------------------------------------
     Application.MessageBox('Bitte Jumper SEL_HD6408 Stecken','Frage',32);

     ErrorFound:=false;
     // VG-Leisten Test: 1 shift Master Out, Slave In
     status:= Test_ShiftBitTest(true, true, true);
     if(status = false) then ErrorFound:=true;
     // VG-Leisten Test: 1 shift Master In, Slave Out
     status:= Test_ShiftBitTest(true, false, true);
     if(status = false) then ErrorFound:=true;

     if(ErrorFound = false) then begin
        Test9Shape.Brush.Color:= clLime;
        Test9Label.Caption := '    OK';
        TestResultArray[9]:= true;
        TestResultString:= TestResultString + ProtListeOK
     end else begin
        Test9Shape.Brush.Color:= clRed;
        Test9Label.Caption := '  FALSE';
        TestResultArray[9]:= false;
        TestResultBool:=false;
        TestResultString:= TestResultString + ProtListeFail
     end;

       //-----------------------------------------
      // Test ende
     //-----------------------------------------
     NextIFKButton.Enabled:= True;
     result:= TestResultBool;
end;



function TTest_AutomaticTesTForm.Test_ShiftBitTest(InitZero:boolean;
                                                   MasterOut:boolean;
                                                   VGTesT:boolean):boolean;

var ErrStatus:_DWORD;
    BitMusterTesT:TBitMusterTest;
    myBitShift:TBitShift;
    index:byte;
    IndexBit:_Word;
    IndexArray:_Word;
    MaxIndexArray:_Byte;
    MaxIndexBit:_Byte;
    TestSuccess:boolean;

begin
     index:=0;
     IndexBit:=1;
     ErrStatus:=0;
     IndexArray:=1;
     TestSuccess:= true;
     
     //---------------Test 1: VG-Leisten bit shift test ------------

     // object für das ein & auslesen der VGL erzeugen
     BitMusterTesT:= TBitMusterTest.Create;
     BitMusterTesT.Init(BitShiftConfig);

     // richtunge festlegen
     if (MasterOut = true) then BitMusterTesT.SetMasterOutSlaveIn(ErrStatus)
     else BitMusterTesT.SetMasterInSlaveOut(ErrStatus);

     // object für das shiften anlegen
     myBitShift:= TBitShift.Create;

     // mit 1 shiften oder mit 0
     if (VGTesT = true) then begin
        myBitShift.InitBitShift(InitZero, VglMaxword, VglMaxBit);
        MaxIndexArray:= VglMaxword;
        MaxIndexBit:= VglMaxBit;
     end else begin
        myBitShift.InitBitShift(InitZero, PgyMaxword, PgyMaxBit);
        MaxIndexArray:= PgyMaxword;
        MaxIndexBit:= PgyMaxBit;
     end;

     myBitShift.resetBitShift();

     while(IndexBit <= MaxIndexBit) do begin
         // ums eins shiften und lesen
         myBitShift.ShiftBitShift(index);
         myBitShift.readBitShift(SetBitShiftArray);

         if(MasterOut = true) then begin
            // An die Master-VG leiste oder Piggy versenden
            if (VGTesT = true) then BitMusterTesT.WrBitVGMaster(ErrStatus)
            else BitMusterTesT.WrPgyMaster(ErrStatus);
         end else begin
            if (VGTesT = true) then BitMusterTesT.WrBitVGSlave(ErrStatus)
            else BitMusterTesT.WrPgySlave(ErrStatus);
         end;

         if(MasterOut = true) then begin
            // Vom Slave-VG leiste oder Piggy lesen
            if (VGTesT = true) then BitMusterTesT.RdBitVGSlave(ErrStatus)
            else BitMusterTesT.RdPgySlave(ErrStatus);
         end else begin
             if(VGTesT = true) then BitMusterTesT.RdBitVGMaster(ErrStatus)
             else BitMusterTesT.RdPgyMaster(ErrStatus);
         end;

         // Wenn Master In gesetzt ist muss bei der VG-Leiste
         // das Bit D1 ignoriert werden
         if((MasterOut = false) and (VGTesT = true)) then begin
           SetBitShiftArray [2]:= SetBitShiftArray [2] and $FFFE;
           ReadBitShiftArray[2]:= ReadBitShiftArray[2] and $FFFE;
         end;

         // Wird mit einsen init. dann mus das 6ste wort angepasst werden
         // da es ja nur bis D88 geht
         if((InitZero = false) and (VGTesT = true)) then begin
           SetBitShiftArray[6]:= SetBitShiftArray[6] and $1FF;
         end;

         // wird der piggy-stecker getestet & mit einsen init.
         //dann muss das 3te wort angepasst werden da es ja nur
         //bis D45 geht
         if((InitZero = false) and (VGTesT = false)) then begin
           SetBitShiftArray[3]:= SetBitShiftArray[3] and $3FFF;
         end;

         while(IndexArray <= MaxIndexArray) do begin
           if(SetBitShiftArray[IndexArray] <> ReadBitShiftArray[IndexArray]) then TestSuccess:= false;
           IndexArray:= IndexArray + 1;
         end;

         IndexBit:= IndexBit+1;
         IndexArray:= 1;
     end;

     // Objecte wieder freigeben
     myBitShift.Free();
     BitMusterTesT.Free();

     if(ErrStatus<> StatusOK) or (TestSuccess <> true) then result:=false
     else result:=true;
end;

function TTest_AutomaticTesTForm.Test_TimingKanalTest():boolean;

var TimingTest:TTimingTest;
    Status:boolean;

begin
     TimingTest:= TTimingTest.Create;
     Status:= TimingTesT.TimingKanalTest();
     TimingTesT.Free;
     result:= status;
end;

function TTest_AutomaticTesTForm.Test_DrqDryInlTest():boolean;

var DrqDryInlTest:TInterruptTest;
    status:boolean;

begin
    DrqDryInlTest:= TInterruptTest.Create;
    status:= DrqDryInlTest.InterruptTest();
    DrqDryInlTest.Free;

    result:=status;
end;

function TTest_AutomaticTesTForm.Test_ExterneClockTest():boolean;

var ErrStatus:_DWORD;
    RdInpRegIFK:_WORD;
    ErrorFound:boolean;


begin
     ErrStatus:= StatusOK;
     ErrorFound:= false;

     //An den Master wird ein INL auf das output-reg geschrieben
     PCI_IfkWrite (Cardauswahl, IFKAdressMaster, IntIFKWR, IntIFKINL, ErrStatus);

     //Slave auslesen. Im register sollte ext-clk gesetzt werden
     PCI_IfkRead (Cardauswahl, IFKAdressSlave, IntputIFKRegRd, RdInpRegIFK, ErrStatus);

     //prüfen
     if(((RdInpRegIFK  and ExtClk) = ExtClk) and (ErrStatus = StatusOK)) then ErrorFound:= false
     else ErrorFound:= true;

     //Master output-reg löschen
     PCI_IfkWrite (Cardauswahl, IFKAdressMaster, IntIFKWR, $0, ErrStatus);

     //Slave auslesen. Im register sollte ext-clk nicht gesetzt werden
     PCI_IfkRead (Cardauswahl, IFKAdressSlave, IntputIFKRegRd, RdInpRegIFK, ErrStatus);

     //prüfen
     if(((RdInpRegIFK  and ExtClk) = $0) and (ErrStatus = StatusOK)) then ErrorFound:= false
     else ErrorFound:= true;

     if(ErrorFound  = true) then result:= false
     else  result:= true;
end;

function  TTest_AutomaticTesTForm.Test_DirectionTest():boolean;

var RichtungsTesT:TRichtungsTesT;
    status:boolean;

begin
     RichtungsTesT:=TRichtungsTesT.Create;
     status:=RichtungsTesT.DirectionTesT();
     RichtungsTesT.Free;
     result:=status;
end;

procedure TTest_AutomaticTesTForm.EndTesTButtonClick(Sender: TObject);
begin
     Test_AutomaticTesTForm.Close;
end;

procedure TTest_AutomaticTesTForm.Test_InitTestAnzeige();

begin
     Test1Shape.Brush.Color:= clWhite;
     Test2Shape.Brush.Color:= clWhite;
     Test3Shape.Brush.Color:= clWhite;
     Test4Shape.Brush.Color:= clWhite;
     Test5Shape.Brush.Color:= clWhite;
     Test6Shape.Brush.Color:= clWhite;
     Test7Shape.Brush.Color:= clWhite;
     Test8Shape.Brush.Color:= clWhite;
     Test9Shape.Brush.Color:= clWhite;

     Test1Label.Caption := '..ready..';
     Test2Label.Caption := '..ready..';
     Test3Label.Caption := '..ready..';
     Test4Label.Caption := '..ready..';
     Test5Label.Caption := '..ready..';
     Test6Label.Caption := '..ready..';
     Test7Label.Caption := '..ready..';
     Test8Label.Caption := '..ready..';
     Test8Label.Caption := '..ready..';
     Test9Label.Caption := '..ready..';

     Application.ProcessMessages();
end;

procedure TTest_AutomaticTesTForm.Test_FailureTestAnzeige();
begin
     Test1Shape.Brush.Color:= clRed;
     Test2Shape.Brush.Color:= clRed;
     Test3Shape.Brush.Color:= clRed;
     Test4Shape.Brush.Color:= clRed;
     Test5Shape.Brush.Color:= clRed;
     Test6Shape.Brush.Color:= clRed;
     Test7Shape.Brush.Color:= clRed;
     Test8Shape.Brush.Color:= clRed;
     Test9Shape.Brush.Color:= clRed;

     Test1Label.Caption := '..ready..';
     Test2Label.Caption := '..ready..';
     Test3Label.Caption := '..ready..';
     Test4Label.Caption := '..ready..';
     Test5Label.Caption := '..ready..';
     Test6Label.Caption := '..ready..';
     Test7Label.Caption := '..ready..';
     Test8Label.Caption := '..ready..';
     Test9Label.Caption := '..ready..';

     Application.ProcessMessages();
end;

procedure TTest_AutomaticTesTForm.FormShow(Sender: TObject);
begin
     //------------------------------------------------
     // Grunderscheinungsbild erstellen

     NextIFKButton.Caption:= 'START TEST';
     LfdNrPanel.Caption:= TestLfdNr;

     Test_InitTestAnzeige();
     ProgramTestVerPanel.Color:= clBtnFace;
     ProgramFinalVerPanel.Color:= clBtnFace;

     Legende_ListBox.Clear;
     Legende_ListBox.Items.Add(ProtListeLegende1);
     Legende_ListBox.Items.Add(ProtListeLegende2);
     Legende_ListBox.Items.Add(ProtListeLegende3);
     Legende_ListBox.Items.Add(ProtListeLegende4);
     Legende_ListBox.Items.Add(ProtListeLegende5);
     Legende_ListBox.Items.Add(ProtListeLegende6);
     //---------------------------------------------------
     // variable initi.
     LfdNrDontShow:=false;
     Test_SetInit(BitShiftConfig);
end;


// Hier wird der Test_AutomaticTest gestartet, protokolliert,
// die anzeigen gesteuert etc..
procedure TTest_AutomaticTesTForm.Test_StartAutomaticTest();

var i:integer;
    abbruch:boolean;
    ErrorFound:boolean;
    status:_DWORD;
    StatusBool:boolean;
    IFKAntwort:_WORD;
    ErrStatus:_DWORD;
    button:_WORD;
    myTestLfdNr:string;
    ErrorOut:TStrings;

begin
     ErrorFound:= false;
     abbruch:= false;
     ErrorOut:= TStringList.Create;

     //Anzeige rücksetzten
     Test_InitTestAnzeige();
     ProgramTestVerPanel.Color:= clBtnFace;
     ProgramFinalVerPanel.Color:= clBtnFace;

     //Beim ersten durchlauf darf die Lfd nicht geändert werden
     if(NextIFKButton.Caption= 'NEXT IFK') then begin
        LfdNrDWord:= StrToInt(TestLfdNr);
        LfdNrDWord:= LfdNrDWord + 1;
        TestLfdNr:= IntToStr(LfdNrDWord);
     end;

     //Beim ersten durchlauf darf die änderung der Lfd
     //nicht angezeigt werden
     if((NextIFKButton.Caption= 'NEXT IFK') and (LfdNrDontShow = false))then SRNummerEingabe.ShowModal;

     //Ausgabe LfdNr
     LfdNrPanel.Caption:= TestLfdNr;

     //-----------------------------------------
     // für das protokoll
     myTestLfdNr:= TestLfdNr;

     // mit Leerzeichen auffüllen
     while length(myTestLfdNr) < AbstandLfdTest do begin
          myTestLfdNr:= myTestLfdNr+' ';
     end;

     TestResultString:=myTestLfdNr;
     IsTestPast:=true;

     //-------- Pgrogrammtestfelder rücksetzten----------
     ProgramTestVerPanel.Color:= clBtnFace;
     ProgramFinalVerPanel.Color:= clBtnFace;
     Application.ProcessMessages();

     //-------------------------------------------------------------
     //------ Prüfling mit testsoftware impfen ---
     //-------------------------------------------------------------
     IFKProgrammierungForm.Show;
     StatusBool:=IFKProgrammierungForm.IFKProgrammierung(true,ErrorOut);
     StatusBool := true;
     if(StatusBool = true) then begin
          ProgramTestVerPanel.Color:= clLime;
          TestResultString:= TestResultString+ProtListeOK
     end else begin
          Test_FailureTestAnzeige();
          ProgramTestVerPanel.Color:= clRed;
          ProgramFinalVerPanel.Color:= clRed;
          Application.MessageBox('Prüfling konnte nicht mit der Testsoftware prog. werden. Der Test wird abgebrochen','Mist', 16);
          TestResultString:= TestResultString+ProtListeFail;
          ErrorFound:= true;
          abbruch:=true;
     end;

     Application.ProcessMessages();
     //-------------------------------------------------------------
     //---------- SLAVE suchen --------------
     //-------------------------------------------------------------
      while (abbruch = false) do begin
       status:= PCI_IfkRead (Cardauswahl, IFKAdressSlave, FktRead, IFKAntwort, ErrStatus);
       if((status <> StatusOK) or (IFKAntwort <> IFKAdressSlave)) then begin
         button:= Application.MessageBox('Der Prüfling meldet sich nicht, bitte überprüfen Sie die Verkabelung ','Oh...Oh...',69);
         case button of
           IDRETRY: begin
                     abbruch:=false;
                      IFKAntwort:=0;
                     ErrStatus:=0;
                    end;

           IDCANCEL:begin
                     abbruch:=true;
                     ErrorFound:= true;
                     Test_FailureTestAnzeige();
                    end;
         end;
       end else Abbruch:= true;
     end;

     //-------------------------------------------------------------
     //---------------Test 1 bis 9 ---------------
     //-------------------------------------------------------------
     //Ist vorher kein fehler aufgetreten wir soll der test 1-9
     //durchgeführt werden.  Ansonsten wird abgebrochen
     if(ErrorFound= false) then StatusBool:= Test_AutomaticTest()
     else begin
       for i:=1 to 10 do begin
        TestResultString:= TestResultString+ProtListeNA;
       end;
     end;

     //-------------------------------------------------------------
     //----------Prüfling mit der finalen firmware impfen-----------
     //-------------------------------------------------------------
     if(ErrorFound= false) then begin
       IFKProgrammierungForm.Show;
       if (IFKProgrammierungForm.IFKProgrammierung(false,ErrorOut)= false) then begin
          Test_FailureTestAnzeige();
          Application.MessageBox('Prüfling konnte nicht mit der Finalen Version prog. werden. Der Test ist fehlgeschlagen','Mist', 16);
          ErrorFound:= true;
        end;    

        //---------- SLAVE suchen --------------
        if(ErrorFound= false) then  abbruch:= false
        else  abbruch:= true;

        while (abbruch = false) do begin
          status:= PCI_IfkRead (Cardauswahl, IFKAdressSlave, FktRead, IFKAntwort, ErrStatus);
          if((status <> StatusOK) or (IFKAntwort <> IFKAdressSlave)) then begin
            button:= Application.MessageBox('Der Prüfling meldet sich nicht, bitte überprüfen Sie die Verkabelung ','Oh...Oh...',69);
            case button of
             IDRETRY: begin
                       abbruch:=false;
                       IFKAntwort:=0;
                       ErrStatus:=0;
                      end;

             IDCANCEL:begin
                       abbruch:=true;
                       ErrorFound:= true;
                       Application.MessageBox('Prüfling konnte nicht nach dem prog. der F-Version angesprochen werden. Der Test ist fehlgeschlagen','Fuck', 16);
                      end;
            end;
          end else Abbruch:= true;
        end;

        //ausgang master disable
        PCI_IfkWrite(Cardauswahl, IFKAdressMaster, FCWR_EnabelTreiber, DisableTreiber, ErrStatus);

        if(ErrorFound= false) then begin
          ProgramFinalVerPanel.Color:= clLime;
          TestResultString:= TestResultString+ProtListeOK
        end else begin
          ProgramFinalVerPanel.Color:= clRed;
          TestResultString:= TestResultString+ProtListeFail;
        end;
     end;

     //-------------------------------------------------------------
     //------- Protokoll vervollstaendigen und rausschreiben--------
     //-------------------------------------------------------------
     //Sind die test erfolgreich gewesen
     if((StatusBool= true) and (ErrorFound= false)) then TestResultString:=TestResultString+ ProtLiaResSucs
     else TestResultString:=TestResultString+ ProtLiaResFail;

     //Rauschreiben
     TEST_ProtokollShowForm.ProtokollListBox.Items.Add(TestResultString);
     TestResultString:='';
     // Next
     NextIFKButton.Caption:= 'NEXT IFK';
end;


// setzt die init fuer bitshift
procedure Test_SetInit(var Config:TConfigRec);
begin
     Config.PCI_CardAdress:= Cardauswahl;
     Config.IFKMasterAdr:= IFKAdressMaster;
     Config.IFKSlaveAdr:=  IFKAdressSlave;

     Config.FCWR_EnabelDriver:= FCWR_EnabelTreiber;
     Config.FCRD_EnabelDriver:= FCRD_EnabelTreiber;

     Config.FCWR_DirectDriver:= FCWR_DirectTreiber;
     Config.FCRD_DirectDriver:= FCRD_DirectTreiber;

     Config.EnableDriver:= EnableTreiber;
     Config.DisableDriver:= DisableTreiber;

     Config.DirectOut:= DirectOut;
     Config.DirectIn:=  DirectIn;

     Config.WrVgl1:= WrVgl1;
     Config.WrVgl2:= WrVgl2;
     Config.WrVgl3:= WrVgl3;
     Config.WrVgl4:= WrVgl4;
     Config.WrVgl5:= WrVgl5;
     Config.WrVgl6:= WrVgl6;

     Config.RdVgl1:= RdVgl1;
     Config.RdVgl2:= RdVgl2;
     Config.RdVgl3:= RdVgl3;
     Config.RdVgl4:= RdVgl4;
     Config.RdVgl5:= RdVgl5;
     Config.RdVgl6:= RdVgl6;

     Config.WrPgy1:= WrPgy1;
     Config.WrPgy2:= WrPgy2;
     Config.WrPgy3:= WrPgy3;

     Config.RdPgy1:= RdPgy1;
     Config.RdPgy2:= RdPgy2;
     Config.RdPgy3:= RdPgy3;

     Config.MaxArry:=6;
     Config.MaxBit:= 89;
     Config.ZeroOneShift:=false;
end;

// Hier wird der test getsartet, vorher wird geprueft ob
// die pruefbox(MasterIFK) sich meldet
procedure TTest_AutomaticTesTForm.NextIFKButtonClick(Sender: TObject);

var status:_DWORD;
    ErrorFound:boolean;
    Abbruch:boolean;
    IFKAntwort:_WORD;
    ErrStatus:_DWORD;
    button:_WORD;

begin
    ErrorFound:=false;
    abbruch:=false;

     //Master suchen
     while (abbruch = false) do begin
       status:= PCI_IfkRead (Cardauswahl, IFKAdressMaster, FktRead, IFKAntwort, ErrStatus);
       if((status <> StatusOK) or (IFKAntwort <> IFKAdressMaster)) then begin
         button:= Application.MessageBox('Die Prüfbox meldet sich nicht, bitte überprüfen Sie die Verkabelung ','Die Ente quakt gleich doppelt so laut, wenn man ihr auf den Bürzel haut',69);
           case button of
            IDRETRY: begin
                     abbruch:=false;
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

     if(ErrorFound) = false then Test_StartAutomaticTest;
end;

end.
