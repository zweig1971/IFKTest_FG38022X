//---------------------------------
//        BitShiftClass
//
// Marcus Zweig GSI Darmstadt
// Version 01   30.06.08
//
// ---------------------------------

// Können bits 0 oder 1geschiftet werden
// Maximal 6 wort lang
// bis zum x bit kann eingestellt werden
// muss erst mit den werten initialisiert werden
// z.B.
// eins soll geschitet werde
// also mit 0 gefuellt
// ueber 6 worte aber bur bis zum 80 bit
// also 0-80
// InitBitShift(true, 6, 80);



unit BitShiftClass;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
    TBitShiftArray = array [1..10] of word;
    TBitShift = class

private
      BitShiftArray:TBitShiftArray; // Bits der VGLeiste
      BitShiftIndex:integer;  // aktuelle position in der VGLeiste
      BitShiftInitZero:boolean;
      BitShiftMaxWord:byte;
      BitShiftMaxBit:byte;

      procedure resetBitShiftZero();// Setzt VGLeiste zurück & init alles mit null
      procedure resetBitShiftOne(); // Setzt VGLeiste zurück & init alles mit eins
      procedure oneBitShift(index:byte); // alles 0 & 1 shiften
      procedure zeroBitShift(index:byte); // alles 1 & 0 shiften

public
      constructor Create();
      procedure resetBitShift(); //Löscht das array IOVGleiste
      procedure InitBitShift(InitZero:boolean; MaxWord:byte; MaxBit:byte);// Mit was geshiftet werden
      procedure ShiftBitShift(var index:byte);// Bit um eins shiften
      procedure readBitShift(var ReadBitShift:TBitShiftArray);// momentanen stand auslesen
end;

implementation

uses UnitMil, TEST_GLobaleVariaben;


// ----------------- Private --------------------

procedure TBitShift.resetBitShiftZero();

var index:integer;

begin
     //VG-leisten array wird mit nullen vollgeschrieben
     index := 1;
     while(index <= BitShiftMaxWord) do begin
       BitShiftArray[index]:= 0;
       index:=index+1
     end;

     BitShiftIndex:=1; // in ausgansposition
     BitShiftArray[1]:=0;
end;

procedure TBitShift.resetBitShiftOne();

var index:integer;

begin
     // VG-leisten array wird mit 1 vollgeschrieben
     index := 1;
     while(index <= BitShiftMaxWord) do begin
       BitShiftArray[index]:= $FFFF;
       index:=index+1
     end;

     BitShiftIndex:=1; // in ausgangsposition
     BitShiftArray[1]:=$FFFF;
end;



procedure TBitShift.oneBitShift(index:byte);

var WordIndex:byte;

begin
     index:=0;
     //welches wort im array ist gültig
     case BitShiftIndex of
       1..16 : WordIndex:=1;
       17..32: WordIndex:=2;
       33..48: WordIndex:=3;
       49..64: WordIndex:=4;
       65..80: WordIndex:=5;
       81..90: WordIndex:=6;
     end;

     // bei bit 89 aufhören -> zurueck auf los
     if (BitShiftIndex > BitShiftMaxBit) then begin
        BitShiftIndex:=1;
        resetBitShift();
        //BitShiftArray[WordIndex]:= 1;
        // Bei den wort übergängen wird alte wort genullt & das neue mit 1
     end else if (BitShiftIndex = 1) or (BitShiftIndex = 17) or (BitShiftIndex = 33)
                 or(BitShiftIndex = 49) or(BitShiftIndex = 65) or (BitShiftIndex = 81)then begin
         if(WordIndex > 1) then BitShiftArray[WordIndex-1]:=0;
         BitShiftArray[WordIndex]:=1;
         BitShiftIndex:= BitShiftIndex+1;
     end else begin // ansonsten einfach shiften
         BitShiftArray[WordIndex]:= BitShiftArray[WordIndex] shl 1;
         BitShiftIndex:= BitShiftIndex+1
     end;
end;


// hier ist das array der VGLeiste mit 1 beschrieben & die null muss
// geshiftet werden. -> word invertieren->wort um 1 bit shiften -> word inver.
procedure TBitShift.zeroBitShift(index:byte);

var WordIndex:byte;
    myWord:word;

begin
     case BitShiftIndex of
       1..16 : WordIndex:=1;
       17..32: WordIndex:=2;
       33..48: WordIndex:=3;
       49..64: WordIndex:=4;
       65..80: WordIndex:=5;
       81..90: WordIndex:=6;
     end;

     if (BitShiftIndex > BitShiftMaxBit) then begin
        BitShiftIndex:=1;
        WordIndex:=1;
        resetBitShiftOne();
        //BitShiftArray[WordIndex]:= $FFFE;
        BitShiftArray[WordIndex]:= $FFFF;
     end else if (BitShiftIndex = 1) or (BitShiftIndex = 17) or (BitShiftIndex = 33)
                 or(BitShiftIndex = 49) or(BitShiftIndex = 65) or (BitShiftIndex = 81)then begin
         if(WordIndex > 1) then BitShiftArray[WordIndex-1]:=$FFFF;
         BitShiftArray[WordIndex]:=$FFFE;
         BitShiftIndex:= BitShiftIndex+1;
     end else begin
         myWord:= not(BitShiftArray[WordIndex]);// das akt. wort invertieren
         myWord:= myWord shl 1;// um ein bit shiften

         BitShiftArray[WordIndex]:= not(myWord);// dann wieder invertieren & zurueckschreiben
         BitShiftIndex:= BitShiftIndex+1
     end;
end;



// ----------------- Public --------------------

constructor TBitShift.Create();
begin
     //inherited;

     BitShiftInitZero:= true;
     resetBitShift();
end;

procedure TBitShift.resetBitShift();
begin
     if(BitShiftInitZero = true) then resetBitShiftZero()
     else  resetBitShiftOne();
end;

procedure TBitShift.InitBitShift(InitZero:boolean; MaxWord:byte; MaxBit:byte);// Mit was geshiftet werden
begin
     if(InitZero = true) then BitShiftInitZero:= true
     else BitShiftInitZero:= false;
     BitShiftMaxWord:= MaxWord;
     BitShiftMaxBit:= MaxBit;
end;

procedure TBitShift.ShiftBitShift(var index:byte);
begin
     if(BitShiftInitZero= true) then oneBitShift(index)
     else zeroBitShift(index);
end;

procedure TBitShift.readBitShift(var ReadBitShift:TBitShiftArray);

var index:byte;

begin
     index:= 1;
     while (index<= BitShiftMaxWord) do begin
           ReadBitShift[index]:= BitShiftArray[index];
           index:=index+1;
     end;
end;

end.
