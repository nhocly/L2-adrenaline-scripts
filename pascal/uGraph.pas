unit uGraph;

{$MODE OBJFPC}

interface

uses Classes;

type
  TNode = class
  strict private
    FName: String;
    FEdges: TList<TNode>;
    function GetEdge(Index: Integer): TNode;
    function GetEdgeCount: Integer;
    function SetName(aName: String);
    function GetName: String;
  public
    constructor Create(const AName: String);
    procedure AddEdge(ANode: TNode);
    procedure AddEdges(const ANodes: array of TNode);
    property Edge[Index: Integer]: TNode read GetEdge;
    property Count: Integer read GetEdgeCount;
    property Name(s: String) write SetName;
    property Name: String read GetName;
    destructor Destroy; override;
  end;

var
  Nodes: TObjectList<TNode>;

  function CreateNode(const AName: String): TNode;

implementation

function CreateNode(const AName: String): TNode;
begin
  Result := TNode.Create(AName);
  Nodes.Add(Result);
end;

{ TNode }

procedure TNode.AddEdge(ANode: TNode);
begin
  FEdges.Add(ANode)
end;

procedure TNode.AddEdges(const ANodes: array of TNode);
var
  Node: TNode;
begin
  for Node in ANodes do
    AddEdge(Node);
end;

constructor TNode.Create(const AName: String);
begin
  FName := AName;
  FEdges := TList<TNode>.Create;
end;

destructor TNode.Destroy;
begin
  FEdges.Free;
  inherited;
end;

procedure SetName(aName: String);
begin
  FName := aName;
end;

function TNode.GetName: String;
begin
  Result := FName;
end;

function TNode.GetEdgeCount: Integer;
begin
  Result := FEdges.Count;
end;

function TNode.GetEdge(Index: Integer): TNode;
begin
  Result := FEdges[Index];
end;

var NewYork,
  London,
  Paris,
  Moscow: TNode;

BEGIN
  Nodes := TObjectList<TNode>.Create(True{say})
  NewYork := CreateNode('New York');
  London := CreateNode('London');
  Paris := CreateNode('Paris');
  Moscow := CreateNode('Moscow');

  NewYork.AddEdge(London);
  London.AddEdges([NewYork, Paris, Moscow]);
  Paris.AddEdges([London, Moscow]);
  Moscow.AddEdge(NewYork);

  London.Edge[2].Name('Mosscow');
  WriteLn(Paris.Edge[1].Name)
END.
