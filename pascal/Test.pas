program Test;

{$MODE OBJFPC}

function DoSomething(arr: Array of Integer): Boolean;
var
  i: Integer;
begin
  for  i in arr  do
    WriteLn(i);
end;

procedure pass(arr: Array of Integer);
begin
  DoSomething(arr);
end;

procedure Main;
var
  arr: Array of Integer;
begin
  arr := [1, 2, 3];
  pass(arr);
end;

begin
  Main();
end.
