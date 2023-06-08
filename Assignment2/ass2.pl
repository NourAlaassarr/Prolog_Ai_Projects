search(Open, Closed, Goal):-
    getBestState(Open, [CurrentState,Parent,G,H,F], _), 
    CurrentState = Goal,  
    write("Search is complete!"), nl,
    printSolution([CurrentState,Parent,G,H,F], Closed), !.

search(Open, Closed, Goal):-
    getBestState(Open, CurrentNode, TmpOpen),
    getAllValidChildren(CurrentNode,TmpOpen,Closed,Goal,Children),
    addChildren(Children, TmpOpen, NewOpen),  
    append(Closed, [CurrentNode], NewClosed),    
    search(NewOpen, NewClosed, Goal).
getAllValidChildren(Node, Open, Closed, Goal, Children):-
    findall(Next, getNextState(Node,Open,Closed,Goal,Next),
            Children).
getNextState([State,_,G,_,_],Open,Closed,Goal,[Next,State,NewG,NewH,NewF]):-
    move(State, Next, MoveCost),
    isOkay(Next),
    calculateH(Next, Goal, NewH),
    NewG is G + MoveCost,
    NewF is NewG + NewH,
    ( not(member([Next,_,_,_,_], Open)) ; memberButBetter(Next,Open,NewF) ),
    ( not(member([Next,_,_,_,_],Closed));memberButBetter(Next,Closed,NewF)).

memberButBetter(Next, List, NewF):-
    findall(F, member([Next,_,_,_,F], List), Numbers),
    min_list(Numbers, MinOldF),
    MinOldF > NewF.

addChildren(Children, Open, NewOpen):-
    append(Open, Children, NewOpen).

getBestState(Open, BestChild, Rest):-
    findMin(Open, BestChild),
    delete(Open, BestChild, Rest).

findMin([X], X):- !.

findMin([Head|T], Min):-
    findMin(T, TmpMin),
    Head = [_,_,_,HeadH,HeadF],
    TmpMin = [_,_,_,TmpH,TmpF],
    (TmpH < HeadH -> Min = TmpMin ; Min = Head).

printSolution([State, null, G, H, F],_):-
    write([State, G, H, F]), nl.
printSolution([State, Parent, G, H, F], Closed):-
    member([Parent, GrandParent, PrevG, Ph, Pf], Closed),
    printSolution([Parent, GrandParent, PrevG, Ph, Pf], Closed),
    write([State, G, H, F]), nl.


move(State, [X,Y]) :-
  nth0(Y, State, Row),
  (X > 0, nth0(X-1, Row, empty), \+ coversBomb(h, X-1, Y, State), \+ adjacentToDomino(h, X-1, Y, State)) ;
  (X < 4, nth0(X+1, Row, empty), 
   \+ coversBomb(h, X, Y, State), 
   \+ adjacentToDomino(h, X, Y, State)) ;
  (Y > 0, nth0(Y-1, State, Row1), nth0(X, Row1, empty), \+ coversBomb(v, X, Y-1, State), \+ adjacentToDomino(v, X, Y-1, State)) ;
  (Y < 4, nth0(Y+1, State, Row1), nth0(X, Row1, empty), \+ coversBomb(v, X, Y, State), \+ adjacentToDomino(v, X, Y, State)).

adjacentToDomino(h, X, Y, State) :-
  (X > 0, nth0(Y, State, Row), nth0(X-1, Row, h)) ;
  (X < 4, nth0(Y, State, Row), nth0(X+1, Row, h)) ;
  (Y > 0, nth0(Y-1, State, Row1), nth0(X, Row1, v), nth0(X+1, Row1, empty)) ;
  (Y < 4, nth0(Y+1, State, Row1), nth0(X, Row1, v), nth0(X+1, Row1, empty)).

adjacentToDomino(v, X, Y, State) :-
  (X > 0, nth0(Y, State, Row), nth0(X-1, Row, h), nth0(Y+1, Row, empty)) ;
  (X < 4, nth0(Y, State, Row), nth0(X+1, Row, h), nth0(Y+1, Row, empty)) ;
  (Y > 0, nth0(Y-1, State, Row1), nth0(X, Row1, v)) ;
  (Y < 3, nth0(Y+2, State, Row1), nth0(X, Row1, v)).

coversBomb(h, X, Y, State) :-
  bombs(BombCells),
  member([X,Y], BombCells) ;
  member([X+1,Y], BombCells).

coversBomb(v, X, Y, State) :-
  bombs(BombCells),
  member([X,Y], BombCells) ;
  member([X,Y+1], BombCells).

isOkay(_):- true.
calculateH([], [], 0):- !.
calculateH([Head|T1], [Head|T2], Hvalue):-
    !, calculateH(T1, T2, Hvalue).
calculateH([_|T1], [_|T2], Hvalue):-
    calculateH(T1, T2, Count),
    Hvalue is Count + 1.
