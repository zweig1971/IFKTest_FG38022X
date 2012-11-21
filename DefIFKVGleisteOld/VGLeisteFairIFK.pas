unit VGLeisteFairIFK;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

const VGLeisteMaxWord = 6;


type
    TIOVGLeiste = array [1..VGLeisteMaxWord] of word;
    TBitShiftVGLeiste = class

private
      IOVGleiste:TIOVGLeiste; // Bits der VGLeiste
      VGLeisteIndex:integer;  // aktuelle position in der VGLeiste
      VGInitZero:boolean;

      procedure resetShVGLZero();// Setzt VGLeiste zurück & init alles mit null
      procedure resetShVGLOne(); // Setzt VGLeiste zurück & init alles mit eins
      procedure oneShVGL(index:byte); // alles 0 & 1 shiften
      procedure zeroShVGL(index:byte); // alles 1 & 0 shiften

public
      constructor Create();
      destructor Destroy();
      procedure resetShVGL(); //Löscht das array IOVGleiste
      procedure VGLeisteInit(InitValue:boolean);// Mit was geshiftet werden
      procedure ShiftVGLeiste(var index:byte);// Bit um eins shiften
      procedure readShVGL(var ReadVGLeiste:TIOVGLeiste);// momentanen stand auslesen
end;

implementation

uses MainTest;

// ----------------- Private --------------------

procedure TBitShiftVGLeiste.resetShVGLZero();

var index:integer;

begin
     // VG-leisten array wird mit nullen vollgeschrieben
     index := 1;
     while(index <= VGLeisteMaxWord) do begin
       IOVGleiste[index]:= 0;
       index:=index+1
     end;

     VGLeisteIndex:=1; // in ausgansposition
     IOVGleiste[1]:=0;
end;

procedure TBitShiftVGLeiste.resetShVGLOne();

var index:integer;

begin
     // VG-leisten array wird mit 1 vollgeschrieben
     index := 1;
     while(index <= VGLeisteMaxWord) do begin
       IOVGleiste[index]:= $FFFF;
       index:=index+1
     end;

     VGLeisteIndex:=1; // in ausgangsposition
     IOVGleiste[1]:=$FFFF;
end;



procedure TBitShiftVGLeiste.oneShVGL(index:byte);

var WordIndex:byte;

begin
     index:=0;
     //welches wort im array ist gültig
     case VGLeisteIndex of
       1..16 : WordIndex:=1;
       17..32: WordIndex:=2;
       33..48: WordIndex:=3;
       49..64: WordIndex:=4;
       65..80: WordIndex:=5;
       81..90: WordIndex:=6;
     end;

     // bei bit 89 aufhören -> zurueck auf los
     if (VGLeisteIndex > 89) then begin
        VGLeisteIndex:=1;
        WordIndex:=1;
        resetShVGLZero();
        IOVGleiste[WordIndex]:= 1;
        // Bei den wort übergängen wird alte wort genullt & das neue mit 1
     end else if (VGLeisteIndex = 1) or (VGLeisteIndex = 17) or (VGLeisteIndex = 33)
                 or(VGLeisteIndex = 49) or(VGLeisteIndex = 65) or (VGLeisteIndex = 81)then begin
         if(WordIndex > 1) then IOVGleiste[WordIndex-1]:=0;
         IOVGleiste[WordIndex]:=1;
         VGLeisteIndex:= VGLeisteIndex+1;
     end else begin // ansonsten einfach shiften
         IOVGleiste[WordIndex]:= IOVGleiste[WordIndex] shl 1;
         VGLeisteIndex:= VGLeisteIndex+1
     end;
end;


// hier ist das array der VGLeiste mit 1 beschrieben & die null muss
// geshiftet werden. -> word invertieren->wort um 1 bit shiften -> word inver.
procedure TBitShiftVGLeiste.zeroShVGL(index:byte);

var WordIndex:byte;
    myWord:word;

begin
     case VGLeisteIndex of
       1..16 : WordIndex:=1;
       17..32: WordIndex:=2;
       33..48: WordIndex:=3;
       49..64: WordIndex:=4;
       65..80: WordIndex:=5;
       81..90: WordIndex:=6;
     end;

     if (VGLeisteIndex > 89) then begin
        VGLeisteIndex:=1;
        WordIndex:=1;
        resetShVGLOne();
        IOVGleiste[WordIndex]:= $FFFE;
     end else if (VGLeisteIndex = 1) or (VGLeisteIndex = 17) or (VGLeisteIndex = 33)
                 or(VGLeisteIndex = 49) or(VGLeisteIndex = 65) or (VGLeisteIndex = 81)then begin
         if(WordIndex > 1) then IOVGleiste[WordIndex-1]:=$FFFF;
         IOVGleiste[WordIndex]:=$FFFE;
         VGLeisteIndex:= VGLeisteIndex+1;
     end else begin
         myWord:= not(IOVGleiste[WordIndex]);// das akt. wort invertieren
         myWord:= myWord shl 1;// um ein bit shiften

         IOVGleiste[WordIndex]:= not(myWord);// dann wieder invertieren & zurueckschreiben
         VGLeisteIndex:= VGLeisteIndex+1
     end;
end;



// ----------------- Public --------------------

constructor TBitShiftVGLeiste.Create();
begin
     inherited;
     VGInitZero:= true;
     resetShVGL();
end;

destructor  TBitShiftVGLeiste.Destroy();
begin
     messagebox(0,'FUCK !','Warnung',16);
end;

procedure TBitShiftVGLeiste.resetShVGL();
begin
     if(VGInitZero = true) then resetShVGLZero()
     else  resetShVGLOne();
end;

procedure TBitShiftVGLeiste.VGLeisteInit(InitValue:boolean);// Mit was geshiftet werden
begin
     if(InitValue = true) then VGInitZero:= true
     else VGInitZero:= false;
end;

procedure TBitShiftVGLeiste.ShiftVGLeiste(var index:byte);
begin
     if(VGInitZero= true) then oneShVGL(index)
     else zeroShVGL(index);
end;

procedure TBitShiftVGLeiste.readShVGL(var ReadVGLeiste:TIOVGLeiste);

var index:byte;

begin
     index:= 1;
     while (index<= VGLeisteMaxWord) do begin
           ReadVGLeiste[index]:= IOVGleiste[index];
           index:=index+1;
     end;
end;

end.
