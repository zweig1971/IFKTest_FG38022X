unit  TEST_ExpertSingelShiftTest;

interface

uses  Forms,BitShiftClass,SysUtils,TEST_SingelShiftMasterClassTest,UnitMil,TEST_SingelBitMusterForm,TEST_GLobaleVariaben;

type TExpertSingelShiftTest = class (TSingelShiftTest)


public
 procedure SingelStepButtonPress(); override;
 procedure StepButtonPress(); override;
 procedure RunSpedButtonPress(); override;

 procedure OneShiftButtonPress(); override;
 procedure ResetButtonPress(); override;

 procedure FormOnShow();override;
 procedure CloseButtonPress();override;
end;

const
    Maxword = 6;
    MaxBit = 89;
    ZeroOneShift = true;


var
  myBitShiftArray: TBitShiftArray;
  ReadVGBitShiftArray:TBitShiftArray;
  myBitShift:TBitShift;

implementation


procedure TExpertSingelShiftTest.SingelStepButtonPress();

var index:byte;
    Errorfound:boolean;
    ErrStatus:_DWORD;
    ErrorCount:_DWORD;


begin
//------------------
     index:=0;
     ErrStatus:=0;
     myBitShift.ShiftBitShift(index);
     myBitShift.readBitShift(myBitShiftArray);
     ShowBitShiftVGLeiste(myBitShiftArray);
//------------------
     PCI_IfkWrite(PCIAdress, IFKAdressMaster ,$30, myBitShiftArray[1], ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster ,$31, myBitShiftArray[2], ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster ,$32, myBitShiftArray[3], ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster ,$33, myBitShiftArray[4], ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster ,$34, myBitShiftArray[5], ErrStatus);
     PCI_IfkWrite(PCIAdress, IFKAdressMaster ,$35, myBitShiftArray[6], ErrStatus);
     if(ErrStatus <> 0) then SingelBitMusterForm.SysMessListBox.Items.Add('Write Bitshift array FAILURE !');
 //-------------------
     ErrStatus :=0;
     PCI_IfkRead(PCIAdress, IFKAdressSlave, $A0, ReadVGBitShiftArray[1], ErrStatus);
     PCI_IfkRead(PCIAdress, IFKAdressSlave, $A1, ReadVGBitShiftArray[2], ErrStatus);
     PCI_IfkRead(PCIAdress, IFKAdressSlave, $A2, ReadVGBitShiftArray[3], ErrStatus);
     PCI_IfkRead(PCIAdress, IFKAdressSlave, $A3, ReadVGBitShiftArray[4], ErrStatus);
     PCI_IfkRead(PCIAdress, IFKAdressSlave, $A4, ReadVGBitShiftArray[5], ErrStatus);
     PCI_IfkRead(PCIAdress, IFKAdressSlave, $A5, ReadVGBitShiftArray[6], ErrStatus);
     if(ErrStatus <> 0) then SingelBitMusterForm.SysMessListBox.Items.Add('Read Bitshift array FAILURE !');
     ShowBitVGLeiste(ReadVGBitShiftArray);
 //-------------------

     // Daten miteinander vergleichen
     ErrorFound:=false;
     index:= 1;
     while(index<= 6) do begin
        if(myBitShiftArray[index] <>  ReadVGBitShiftArray[index]) then ErrorFound:= true;
        index:=index+1;
     end;

     If (ErrorFound = true) then begin
        ErrorCount:= StrToInt(SingelBitMusterForm.ErrorPanel.Caption);
        ErrorCount:= ErrorCount +1;
        SingelBitMusterForm.ErrorPanel.Caption:= IntToStr(ErrorCount);
     end;
end;

procedure TExpertSingelShiftTest.StepButtonPress();

var i:integer;

begin
     for i:= 1 to 8 do begin
       SingelBitMusterForm.SingelStepButton.Click;
     end;
end;

procedure TExpertSingelShiftTest.RunSpedButtonPress();
begin
     while (SingelBitMusterForm.RunSpeedButton.Down = true) do begin
       SingelBitMusterForm.StepButton.Click;
       Application.ProcessMessages();
     end;
end;

procedure TExpertSingelShiftTest.OneShiftButtonPress();
begin
   // Objekt erzeugen & initialisieren
   if (myBitShift<> nil) then myBitShift.Free;
   myBitShift:= TBitShift.Create();

   if (SingelBitMusterForm.OneShiftSpeedButton.Down = true) then myBitShift.InitBitShift(false, MaxWord, MaxBit)
   else myBitShift.InitBitShift(true, MaxWord, MaxBit);

   ShowBitShiftVGLeiste(myBitShiftArray);
   ShowBitVGLeiste(ReadVGBitShiftArray);
end;

procedure TExpertSingelShiftTest.ResetButtonPress();
begin
     myBitShift.resetBitShift();
     ShowBitShiftVGLeiste(myBitShiftArray);
end;

procedure TExpertSingelShiftTest.FormOnShow();

var status:integer;
    ErrorStatus:_DWORD;

begin
    // Treiber für IFK-Master enablen
     status:= PCI_IfkWrite(PCIAdress,IFKAdressMaster,FCWR_EnabelTreiber,EnableTreiber,ErrorStatus);
     if(status = StatusOK) then SingelBitMusterForm.SysMessListBox.Items.Add('Enable Driver MasterCard OK !')
     else SingelBitMusterForm.SysMessListBox.Items.Add('Enable Driver MasterCard ERROR !');
     SingelBitMusterForm.SysMessListBox.Items.Add('---');

     // Treiber für IFK-Slave enablen
     status:= PCI_IfkWrite(PCIAdress,IFKAdressSlave,FCWR_EnabelTreiber,EnableTreiber,ErrorStatus);
     if(status = StatusOK) then SingelBitMusterForm.SysMessListBox.Items.Add('Enable Driver SlaveCard OK !')
     else SingelBitMusterForm.SysMessListBox.Items.Add('Enable Driver SlaveCard ERROR !');
     SingelBitMusterForm.SysMessListBox.Items.Add('---');

// --------------------------------------------------------

     // Treiberrichtung fuer master auf output
     status:= PCI_IfkWrite(PCIAdress,IFKAdressMaster,FCWR_DirectTreiber,DirectOut,ErrorStatus);
     if(status = StatusOK) then SingelBitMusterForm.SysMessListBox.Items.Add('Direction Master Output OK !')
     else SingelBitMusterForm.SysMessListBox.Items.Add('Direction Master Output ERROR !');
     SingelBitMusterForm.SysMessListBox.Items.Add('---');

     // Treiberrichtung fuer slave auf input
     status:= PCI_IfkWrite(PCIAdress,IFKAdressSlave,FCWR_DirectTreiber,DirectIn,ErrorStatus);
     if(status = StatusOK) then SingelBitMusterForm.SysMessListBox.Items.Add('Direction Slave Input OK !')
     else SingelBitMusterForm.SysMessListBox.Items.Add('Direction Slave Input ERROR !');
     SingelBitMusterForm.SysMessListBox.Items.Add('---');
// --------------------------------------------------------

   // Objekt erzeugen & initialisieren
   if (myBitShift= nil) then myBitShift:= TBitShift.Create();
   myBitShift.InitBitShift(ZeroOneShift, MaxWord, MaxBit);
   ShowBitShiftVGLeiste(myBitShiftArray);
   ShowBitVGLeiste(ReadVGBitShiftArray);
end;

procedure TExpertSingelShiftTest.CloseButtonPress();
begin
end;



end.
 