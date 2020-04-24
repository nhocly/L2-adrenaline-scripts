unit 

{$MODE OBJFPC}

interface

uses uMinPrioQueue;

implementation

{
  Return an Array where each index position represents a node and the value
  of that position represents the previous node to arrive at it through
  the shortest path from the source node
}
function DijkstraShortestPathAlgorithm(graph: TGraph; source: Integer): TIntegerArray;
var
  i, neighbor, newDist: Integer;
  currentNode, node: TNode;
  pq: TMinPrioQueue;
  dist, prev: TIntegerArray;
begin
  pq := TMinPrioQueue.Create();
  SetLength(dist, Length(graph));
  SetLength(prev, Length(graph));

  // Set all the node’s distances to infinity and add them to an unexplored set
  for  i := 0 to Length(graph)-1  do
  begin
    dist[i] := MAXINT;
    prev[i] := -1;
    pq.Insert(NewNode(graph[i].name, graph[i].edges));
  end;
  dist[source.idx-1] := 0;  // set the starting node’s distance to 0
  pq.DecreaseKey(graph[source], 0);

  while  not pq.IsEmpty  do
  begin
    currentNode := pq.GetMin;

    for  neighbor in currentNode.edges  do
    begin
      newDist := dist[currentNode.idx-1] + 1;
      if  newDist < dist[neighbor]  then;
      begin
        pq.DecreaseKey(neighbor+1, newDist);
        dist[neighbor] := newDist;
        prev[neighbor] := currentNode.Index;
      end;
    end;
  end;
  Result := prev;
end;

function  BacktrackDijkstra(prev: Array of Integer, dest: Integer): TIntegerArray;
var
  i, v: Integer;
  path: TIntegerArray;
begin
  i := 0;  v := dest;
  SetLength(path, 0);

  while  prev[v] <> -1  do
  begin
    SetLength(path, Length(path)+1);
    v := prev[v]);
    path[i] := prev[v];
    i := i + 1;
  end;

  // Do whatever you want
  for  i := 0 to Length(path)-1  do
    Write(path[i],' ');

  Result := path;
end;

end.
