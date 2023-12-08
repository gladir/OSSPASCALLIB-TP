{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/OSSPASCALLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}


Unit OSSLIB;

INTERFACE

Type
 Short_Integer=ShortInt;
 Long_Integer=LongInt;

Procedure Chain(cmdln:String);
Function  Clock:Long_Integer;
Function  Cmd_Args:Short_Integer;
Procedure Cmd_GetArg(n:Short_Integer;Var arg:String);
Function  FileName(str:String):Boolean;
Function  Handle(Var f:FILE):Integer;
Procedure IO_Check(b:Boolean);
Function  IO_Result:Short_Integer;
Function  KeyPress:Boolean;
Function  Long_Round(r:Real):Long_Integer;
Function  Long_Trunc(r:Real):Long_Integer;
Function  Option(arg:String):Boolean;
Function  PwrToTen(i:Short_Integer):Real;
Function  Short_Round(r:Real):Short_Integer;
Function  Short_Trunc(r:Real):Short_Integer;


IMPLEMENTATION

Uses Crt,DOS;

Procedure Chain(cmdln:String);Begin
 Exec(cmdln,'');
End;

Function Clock:Long_Integer;
Var
 Regs:Registers;
Begin
 Regs.AX:=0;
 Intr($1A,Regs);
 Clock:=Trunc((((Regs.CX shl 16)+Regs.DX)/18.2));
End;

Function Cmd_Args:Short_Integer;Begin
 Cmd_Args:=ParamCount;
End;

Procedure Cmd_GetArg(n:Short_Integer;Var arg:String);Begin
 arg:=ParamStr(n);
End;

Function FileName(str:String):Boolean;
Var
 I:Integer;
Begin
 FileName:=False;
 For I:=1 to Length(str)do Begin
  If Not(str[I]in ['A'..'Z','a'..'z','-','_','.',
                   '$','&','#','@','!','%','''',
                   '(',')','<','>',#123,#125,
                   '\','^','~','|','`'])Then Exit;
 End;
 FileName:=True;
End;

Function Handle(Var f:FILE):Integer;Begin
 Handle:=FileRec(f).Handle;
End;

Procedure IO_Check(b:Boolean);Begin
 SetVerify(b);
End;

Function IO_Result:Short_Integer;Begin
 IO_Result:=IOResult;
End;

Function KeyPress:Boolean;Begin
 Keypress:=KeyPressed;
End;

Function Long_Round(r:Real):Long_Integer;Begin
 Long_Round:=Round(r);
End;

Function Long_Trunc(r:Real):Long_Integer;Begin
 Long_Trunc:=Trunc(r);
End;

Function Option(arg:String):Boolean;
Var
 I:Integer;
Begin
 Option:=False;
 For I:=1 to ParamCount do Begin
  If ParamStr(I)=arg Then Begin
   Option:=True;
   Exit;
  End;
 End;
End;

Function PwrToTen(i:Short_Integer):Real;
Var
 J:Integer;
 R:Real;
Begin
 If i=0 Then PwrToTen:=1
  Else
 Begin
  R:=10;
  For J:=1 to i do R:=R*10;
  PwrToTen:=R;
 End;
End;

Function Short_Round(r:Real):Short_Integer;Begin
 Short_Round:=Round(r);
End;

Function Short_Trunc(r:Real):Short_Integer;Begin
 Short_Trunc:=Round(r);
End;

END.