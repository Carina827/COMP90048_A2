%  Author      : Jing Du
%  Origin      : Saturday April 27 2019
%  Student Num : 775074
%  Email       : du2@student.unimelb.edu.au
%  Project     : Assignment 2, COMP90048
%  Purpose     : Implementation of three functions
%
%  correspond(E1, L1, E2, L2):
%  this function holds when in one place where list L1 has the value E1, L2 has E2
%
%  interleave(Ls, L):
%  this function holds when Ls is a list of lists, and L is a list of all 
%  the elements of all the lists in Ls, interleaved
%  
%  partial eval(Expr0, Var, Val, Expr):
%  this function holds when Expr is the arithmetic expression Expr0 with atom Var replaced by number Val
%   


correspond(E1, [E1|_], E2, [E2|_]).
correspond(E1, [_|T1], E2, [_|T2]) :-
    correspond(E1, T1, E2, T2).






getinterleave([], [], []).
getinterleave([], [Head|Tail], [L|Ls]) :-
    getinterleave([L|Ls], [Head|Tail], []).

getinterleave([[Head|[]]|Lists1], [Head|Tail], Lists2) :-
    getinterleave(Lists1, Tail, Lists2).

getinterleave([[Head|[E|Elts]]|Lists1], [Head|Tail], Lists2) :-
    append(Lists2, [[E|Elts]], Lists3),
    getinterleave(Lists1, Tail, Lists3).

samelength([]).
samelength([_]).
samelength([E1,E2|Tail]) :-
    length(E1,N),
    length(E2,N),
    samelength([E1|Tail]).


interleave(Ls, L) :-
    getinterleave(Ls, L, []),
    samelength(Ls).







partial_eval(X, _, _, X) :-
    number(X).


partial_eval(X, Y, Val1, Val2) :-
    atom(X),
    ( X = Y ->
        Val2 = Val1
    ;   Val2 = X
    ).


partial_eval(X+Y, Val1, Val2, E) :-
    partial_eval(X, Val1, Val2, E1),
    partial_eval(Y, Val1, Val2, E2),
    ( number(E1), number(E2) ->
        E is E1 + E2
    ;   E = E1 + E2
    ).


partial_eval(X-Y, Val1, Val2, E) :-
    partial_eval(X, Val1, Val2, E1),
    partial_eval(Y, Val1, Val2, E2),
    ( number(E1), number(E2) ->
        E is E1 - E2
    ;   E = E1 - E2
    ).


partial_eval(X*Y, Val1, Val2, E) :-
    partial_eval(X, Val1, Val2, E1),
    partial_eval(Y, Val1, Val2, E2),
    ( number(E1), number(E2) ->
        E is E1 * E2
    ;   E = E1 * E2
    ).


partial_eval(X/Y, Val1, Val2, E) :-
    partial_eval(X, Val1, Val2, E1),
    partial_eval(Y, Val1, Val2, E2),
    ( number(E1), number(E2) ->
        E is E1 / E2
    ;   E = E1 / E2
    ).


partial_eval(X//Y, Val1, Val2, E) :-
    partial_eval(X, Val1, Val2, E1),
    partial_eval(Y, Val1, Val2, E2),
    ( number(E1), number(E2) ->
        E is E1 // E2
    ;   E = E1 // E2
    ).
