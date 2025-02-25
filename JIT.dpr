program JIT ;

{$APPTYPE CONSOLE}

uses
  Windows, SysUtils;

//==============================================================================

procedure XorEncryptDecrypt(var Data: array of Byte; K: Byte);
var
  I: Integer;
begin
  for I := 0 to High(Data) do
    Data[I] := Data[I] xor K;
end;

//==============================================================================

function AllocateExecutableMemory(Code: array of Byte): Pointer;
begin
  Result := VirtualAlloc(nil, Length(Code), MEM_COMMIT or MEM_RESERVE, PAGE_EXECUTE_READWRITE);
  if Assigned(Result) then
    Move(Code[0], Result^, Length(Code));
end;

//==============================================================================

type
  TFunc = function(A, B: Integer): Integer; stdcall;

//==============================================================================

const
  EncKey = $5A;
  EncCode: array[0..8] of Byte = (
    $D1, $1E, $7E, $5E,
    $69, $1E, $7E, $52,
    $99
  );

//==============================================================================

var
  CodePtr: Pointer;
  JFunc: TFunc;
  ResVal: Integer;
  DecCode: array of Byte;
begin
  SetLength(DecCode, Length(EncCode));
  Move(EncCode[0], DecCode[0], Length(EncCode));
  XorEncryptDecrypt(DecCode, EncKey);
  CodePtr := AllocateExecutableMemory(DecCode);
  if not Assigned(CodePtr) then
  begin
    Writeln('Memory allocation failed');
    Exit;
  end;
  JFunc := TFunc(CodePtr);
  ResVal := JFunc(10, 20);
  Writeln('Result : ', ResVal);
  XorEncryptDecrypt(DecCode, EncKey);
  VirtualFree(CodePtr, 0, MEM_RELEASE);
  FillChar(DecCode[0], Length(DecCode), 0);
  Readln;
end.
