//====================================
// GSI Darmstadt
// Marcus Zweig, BELAP
// Letzte Änderung : 05.09.2008
//
// TEST Protokoll Show
// * zeigt alles was protokolliert worden ist an
// * ermöglicht das zusaetzliche  speichern
// * ermöglicht das ausdrucken
// * zangsspeicher des protokolls
//====================================


unit TEST_ProtokollShow;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Printers;

type
  TTEST_ProtokollShowForm = class(TForm)
    Panel1: TPanel;
    ProtokollListBox: TListBox;
    PrintButton: TButton;
    SaveButton: TButton;
    ButtonClose: TButton;
    PrintDialog1: TPrintDialog;
    SaveDialog1: TSaveDialog;
    function DirExists(s:string):boolean;
    procedure ButtonCloseClick(Sender: TObject);
    procedure PrintButtonClick(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  TEST_ProtokollShowForm: TTEST_ProtokollShowForm;
  PrintButtonPress:boolean;

implementation

uses TEST_GLobaleVariaben, UnitMil;

{$R *.DFM}


function TTEST_ProtokollShowForm.DirExists(s:string):boolean;

var i:integer;

begin
     i:= GetFileAttributes(PChar(s));
     Result:= (i<> -1) and (FILE_ATTRIBUTE_DIRECTORY and i <> 0);
end;

procedure TTEST_ProtokollShowForm.ButtonCloseClick(Sender: TObject);

var button:_WORD;

begin
     if(PrintButtonPress = false) then begin
       button:= Application.MessageBox('Protokoll ohne zu drucken schliessen ?','echt jetzt...?',36);
       if (button = IDYES) then TEST_ProtokollShowForm.Close;
     end
end;

procedure TTEST_ProtokollShowForm.PrintButtonClick(Sender: TObject);

var Line:Integer;
    PrintText:TextFile;

begin
     if PrintDialog1.Execute then begin
        AssignPrn(PrintText);
        Rewrite(PrintText);
        Printer.Canvas.Font := ProtokollListBox.Font;
        for Line := 0 to ProtokollListBox.items.Count - 1 do
            Writeln(PrintText,DruckLinkerRand, ProtokollListBox.items[Line]);
        CloseFile(PrintText);
     end;

     PrintButtonPress:= true;
end;

procedure TTEST_ProtokollShowForm.SaveButtonClick(Sender: TObject);

var dateiname:string;

begin
  dateiname:='';
  SaveDialog1.Filter:='Textdateien(*.TXT|*.TXT';
  SaveDialog1.DefaultExt:='TXT';
  if SaveDialog1.Execute then begin
        dateiname := SaveDialog1.FileName;
        if FileExists(dateiname) then begin
          messagebox(0,'Datei existiert bereits, anderen Namen wählen !','Uffbasse',16);
          dateiname :='';
  end;

  if (dateiname<> '') then
    ProtokollListBox.Items.SaveToFile(dateiname);
    IsProtSave:=true;
  end;
end;

procedure TTEST_ProtokollShowForm.FormShow(Sender: TObject);

var DateiSaveProtokollVerzeichnis:string;
    myDate:string;
    myTime:string;
    mySaveProtDatei:string;

begin
     PrintButtonPress:= false;

     // Verzeichnis fuer die protokolle ggf erstellen
     DateiSaveProtokollVerzeichnis:=Anwendungsverzeichnis+DateiSaveProtVerz;
     if not DirExists(DateiSaveProtokollVerzeichnis) then begin
        mkdir(DateiSaveProtokollVerzeichnis);
     end;

     //aus dem datum das zeichen '.' entfernen
     mydate:= delChar(TestDatum,'.');

     //aus der uhrzeit das zeichen ':' entfernen
     mytime:= delChar(TestUhrzeit,':');

     //Name für die datei zusammenbasteln, datum+uhrzeit
     mySaveProtDatei:= DateiSaveProtokollVerzeichnis+ '\'+ DateiSaveProtName+ myDate+'_'+ myTime +'.txt';

     //falls dern name schon existiert dialog öffnen
     if FileExists(mySaveProtDatei) then begin
       //dialog öffnen
       SaveDialog1.FileName:= mySaveProtDatei;
       if SaveDialog1.Execute then begin
         mySaveProtDatei := SaveDialog1.FileName;
         if FileExists(mySaveProtDatei) then begin
           messagebox(0,'Datei existiert bereits, anderen Namen wählen !','Uffbasse',16);
           dateiname :='';
         end;
       end;
     end;
     ProtokollListBox.Items.SaveToFile(mySaveProtDatei);

     TEST_ProtokollShowForm.SaveButton.Click;
end;

end.
