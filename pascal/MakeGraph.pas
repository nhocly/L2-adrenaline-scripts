unit MakeGraph;

{$MODE OBJFPC}

uses
  Classes, SysUtils, StrUtils, uMinPrioQueue;

type
  TCity = (NY = 0, LONDON = 1, PARIS = 2, MOSCOW = 3);
  TNode = record
    Index: Integer;
    Edges: Array of TNode;
  end;
  TSetOfNode = Set of Integer;
  TIntegerArray = Array of Integer;

const
  TCities: Array[0..3] of TCity = (NY, LONDON, MOSCU, OTHER);
  CityNames: Array[0..3] of String = ('new york','london','moscu','other city');
  Destinations: Array[0..3] of String = ('london,moscu',
    'moscu',
    '"new york","other city"',
    ''); // 'other city' doesn''t have destinations

function AnsiIndexStr(const AText: string; const AValues: array of string): Integer;
var
  i : longint;
begin
  Result := -1;
  if (High(AValues) = -1) or (High(AValues) > MaxInt) Then
    Exit;
  for i := Low(AValues) to High(Avalues) do
      if (avalues[i] = AText) Then
        exit(i);  // make sure it is the first val.
end;

function MakeGraph: TGraph;
var
  i, j: Integer;
  Edge: Array of Integer;
  DestList: TStringList;
  Graph: TGraph;
begin
  SetLength(Graph, Length(TCities));
  for  i := 0 to Length(TCities) - 1  do
  begin
    DestList := TStringList.Create;
    DestList.Delimiter := ',';
    DestList.DelimitedText := Destinations[i];
    WriteLn('Destinations from ' + CityNames[ord(TCities[i])] + ': ');
    Graph[i].Index := i;
    SetLength(Edge, DestList.Count);

    for  j := 0 to pred(DestList.Count)  do
    begin
      WriteLn(DestList[j] + ' ' + IntToStr(AnsiIndexStr(DestList[j], CityNames)));
      Edge[j] := AnsiIndexStr(DestList[j], CityNames);
    end;

    WriteLN();
  end;
  Result := Graph;
end;

var
  Graph: TGraph;
  Queue: TMinPrioQueue;
  Prev: Array of Integer;

procedure Main;
begin
  Graph := MakeGraph();
  Queue := TMinPrioQueue.Create;
  Queue.Insert

  //Prev := DijkstraAlgorithm(Graph, 1);
  //BacktrackDijkstra(Prev, 0);
end;

begin
end.
