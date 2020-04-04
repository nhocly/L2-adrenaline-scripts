unit helloworldunit;

uses Classes;
procedure helloWorld;
begin
  with TStringList.Create do
    try
      Add('Hello, World!');
      Add('GG');
      SaveToFile('hello.txt');
    finally
      Free;
    end;
end.
