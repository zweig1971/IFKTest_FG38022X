program IFKTesT38022X;

uses
  Forms,
  TEST_TimingTEST in 'TEST_TimingTEST.pas',
  TEST_AutomaticTest in 'TEST_AutomaticTest.pas' {Test_AutomaticTesTForm},
  TEST_BitMusterTest in 'TEST_BitMusterTest.pas',
  TEST_DatenEingabe in 'TEST_DatenEingabe.pas' {TEST_DatenEingabeForm},
  TEST_GLobaleVariaben in 'TEST_GLobaleVariaben.pas',
  TEST_IFKMainMenue in 'TEST_IFKMainMenue.pas' {IFKMainMenue},
  TEST_IFKProgrammierung in 'TEST_IFKProgrammierung.pas' {IFKProgrammierungForm},
  UnitMil in 'PCIMilTreiber_DelphiUnits\UnitMil.pas',
  BitShiftClass in 'BitShift\BitShiftClass.pas',
  TEST_ProtokollShow in 'TEST_ProtokollShow.pas' {TEST_ProtokollShowForm},
  modulbus in 'modulbus.pas',
  TEST_SRNummerEingabe in 'TEST_SRNummerEingabe.pas' {SRNummerEingabe},
  TEST_Info in 'TEST_Info.pas' {KickerTest_Info},
  TEST_BitteWarten in 'TEST_BitteWarten.pas' {BitteWartenForm},
  TEST_SelectTest in 'TEST_SelectTest.pas',
  TEST_Debug in 'TEST_Debug.pas' {DebugForm},
  Test_Richtungstest in 'Test_Richtungstest.pas',
  TEST_SingelTesTStep in 'Test_SingelTesTStep.pas' {EXPMainMenueForm},
  TEST_SingelBitMusterForm in 'TEST_SingelBitMusterForm.pas' {SingelBitMusterForm},
  TEST_EXPIFKFlashProg in 'TEST_EXPIFKFlashProg.pas' {EXPIFKFLprogForm},
  TEST_SingelShiftMasterClassTest in 'TEST_SingelShiftMasterClassTest.pas',
  TEST_ExpertSingelShiftTest in 'TEST_ExpertSingelShiftTest.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TIFKMainMenue, IFKMainMenue);
  Application.CreateForm(TTest_AutomaticTesTForm, Test_AutomaticTesTForm);
  Application.CreateForm(TTEST_DatenEingabeForm, TEST_DatenEingabeForm);
  Application.CreateForm(TIFKProgrammierungForm, IFKProgrammierungForm);
  Application.CreateForm(TTEST_ProtokollShowForm, TEST_ProtokollShowForm);
  Application.CreateForm(TSRNummerEingabe, SRNummerEingabe);
  Application.CreateForm(TKickerTest_Info, KickerTest_Info);
  Application.CreateForm(TBitteWartenForm, BitteWartenForm);
  Application.CreateForm(TDebugForm, DebugForm);
  Application.CreateForm(TEXPMainMenueForm, EXPMainMenueForm);
  Application.CreateForm(TSingelBitMusterForm, SingelBitMusterForm);
  Application.CreateForm(TEXPIFKFLprogForm, EXPIFKFLprogForm);
  Application.Run;
end.
