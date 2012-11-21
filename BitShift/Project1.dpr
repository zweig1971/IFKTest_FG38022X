program Project1;

uses
  Forms,
  VGLeisteFairIFK in 'VGLeisteFairIFK.pas',
  MainTest in 'MainTest.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
