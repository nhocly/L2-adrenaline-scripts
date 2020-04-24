unit QueueModule;

{$MODE OBJFPC}

interface

type
  TQueue = class(TObject)
  private
    FFront, FRear, FSize, FCapacity: Integer;
    FQueue: Array of Integer;
    function IsFull(): Boolean;
    function IsEmpty(): Boolean;
    function GetPeek(): Integer;
    function GetSize(): Integer;
  public
    constructor Create(DefaultCapacity: Integer = 16);
    function Enqueue(n: Integer): Boolean;
    function Dequeue(): Integer;
    function Contains(n: Integer): Boolean;
    property Size: Integer read GetSize;
    property Peek: Integer read GetPeek;
  end;

implementation

constructor TQueue.Create(DefaultCapacity: Integer);
begin
  Assert(DefaultCapacity <> 0, 'TQueue.Create: capacity must be greater than zero');
  FCapacity := DefaultCapacity;
  SetLength(FQueue, DefaultCapacity);
  FFront := 0;
  FRear := FCapacity - 1;
  FSize := 0;
end;

function TQueue.IsFull(): Boolean;
begin
  Result := (FSize = FCapacity);
end;

function TQueue.IsEmpty(): Boolean;
begin
  Result := (FSize = 0);
end;

function TQueue.Enqueue(n: Integer): Boolean;
begin
  if (IsFull) then
    exit(False);
  FRear := (FRear + 1) mod FCapacity;
  FQueue[FRear] := n;
  FSize := FSize + 1;
  Result := True;
end;

function TQueue.Dequeue(): Integer;
begin
  if  IsEmpty()  then
    exit(MAXINT);
  Result := FQueue[FFront];
  FFront := (FFront + 1) mod FCapacity;
  FSize := FSize - 1;
end;

function TQueue.Contains(n: Integer): Boolean;
var
  i: Integer;
begin
  i := FRear;
  while  i <> FFront  do
  begin
    if  n = FQueue[i]  then
      exit(True);
    i := (i + 1) mod FCapacity;
  end;
  Result := False;
end;

function TQueue.GetSize: Integer;
var
  i, cnt: Integer;
begin
  i := FRear;
  cnt := 0;
  while  i <> FFront  do
  begin
    i := (i + 1) mod FCapacity;
    cnt := cnt + 1;
  end;
  Result := cnt;
end;

function TQueue.GetPeek: Integer;
begin
  if  IsEmpty()  then
  begin
    Result := -1;
    exit;
  end;
  Result := FQueue[FFront];
end;

procedure Main;
var
  q: TQueue;
begin
  q := TQueue.Create;
  with q do
  begin
    Enqueue(10);
    Enqueue(20);
    Enqueue(30);
    WriteLn(q.Peek);
    Free;
  end;
end;

begin
  Main;
end.
