program CToWatCompiler;

{$mode objfpc}{$H+}

uses
  SysUtils;

procedure RemoveSpaces(var Line: string);
var
  i: Integer;
  Temp: string;
begin
  Temp := '';
  for i := 1 to Length(Line) do
    if not (Line[i] in [' ', #9]) then
      Temp := Temp + Line[i];
  Line := Temp;
end;

procedure CompileToWat(InputFile, OutputFile: string);
var
  InF, OutF: Text;
  Line: string;
  LabelCount: Integer = 0;
  Num: Integer;
begin
  AssignFile(InF, InputFile);
  Reset(InF);
  AssignFile(OutF, OutputFile);
  Rewrite(OutF);

  Writeln(OutF, '(module');
  Writeln(OutF, '  (func $main (result i32)');
  Writeln(OutF, '    (local $i i32)');

  while not EOF(InF) do
  begin
    ReadLn(InF, Line);
    RemoveSpaces(Line);

    if Pos('int', Line) = 1 then
    begin
      Val(Copy(Line, 4, Length(Line)-4), Num);
      Writeln(OutF, '    i32.const ', Num);
      Writeln(OutF, '    set_local $i');
    end
    else if (Pos('i+=1', Line) > 0) or (Pos('i=i+1', Line) > 0) or (Pos('i++', Line) > 0) then
    begin
      Writeln(OutF, '    get_local $i');
      Writeln(OutF, '    i32.const 1');
      Writeln(OutF, '    i32.add');
      Writeln(OutF, '    set_local $i');
    end
    else if (Pos('i-=1', Line) > 0) or (Pos('i=i-1', Line) > 0) or (Pos('i--', Line) > 0) then
    begin
      Writeln(OutF, '    get_local $i');
      Writeln(OutF, '    i32.const 1');
      Writeln(OutF, '    i32.sub');
      Writeln(OutF, '    set_local $i');
    end
    else if Pos('while(i<', Line) = 1 then
    begin
      Val(Copy(Line, 9, Length(Line) - 9), Num);
      Writeln(OutF, '    block $L', LabelCount);
      Writeln(OutF, '    loop $L', LabelCount, '_loop');
      Writeln(OutF, '      get_local $i');
      Writeln(OutF, '      i32.const ', Num);
      Writeln(OutF, '      i32.lt_s');
      Writeln(OutF, '      i32.eqz');
      Writeln(OutF, '      br_if $L', LabelCount);
      Inc(LabelCount);
    end
    else if Line = '}' then
    begin
      Dec(LabelCount);
      Writeln(OutF, '      br $L', LabelCount, '_loop');
      Writeln(OutF, '    end');
      Writeln(OutF, '  end');
    end
    else if Pos('return', Line) = 1 then
    begin
      Writeln(OutF, '    i32.const 0');
      Writeln(OutF, '    return');
    end;
  end;

  Writeln(OutF, '  )');
  Writeln(OutF, '  (export "main" (func $main))');
  Writeln(OutF, ')');

  CloseFile(InF);
  CloseFile(OutF);
end;

var
  InName, OutName: string;
begin
  Write(chr(27)+'[43;30m\nFicheiro C de entrada: ');
  ReadLn(InName);
  Write('Ficheiro .wat de saída: ');
  ReadLn(OutName);
  CompileToWat(InName, OutName);
end.
