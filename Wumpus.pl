% (Y,X) == (ROW, COLUMN) counting from bottom to up for row and from left to right for column.


%%%%%%%%%%%
%* * * * *%
%* * P * *%
%* W GS P *%
%* * P * *%
%* * * * *%
%%%%%%%%%%%


wumpus((3,2)).                    
gold((3,3)).
pit((2,3)).
pit((4,3)).
pit((3,4)).     
wumpusdead(1).
pos((3,3)).

%Check whether we inside our playground.
not_wall((Y,X)):-
    X @>= 1,
    X @=< 5,
    Y @>= 1,
    Y @=< 5.



% check adjacent around X
adjacent((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1).

% Spreading stenches around wumpus
stench((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    wumpus((Y, Xminus)).
stench((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    wumpus((Y,Xplus)).
stench((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    wumpus((Yminus ,X)).
stench((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    wumpus((Yplus, X)).



% Spreading breezes around pits.
breez((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    not_wall((Y,X)),
    pit((Y,Xminus)).

breez((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    not_wall((Y,X)),
    pit((Y,Xplus)).

breez((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    Yminus is Y-1, Yplus is Y+1),  
    not_wall((Y,X)), 
    pit((Yminus ,X)).

breez((Y,X)):-
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    not_wall((Y,X)),
    pit((Yplus, X)).




 

%check if case Y , X is safe
safe((Y,X)):-
     not_wall((Y,X)),
   (not(pit((Y,X))), not(wumpus((Y,X)))).

safe((Y,X)):-
    not_wall((Y,X)),
    not(pit((Y,X))),
    (wumpusdead(1)).



nextsafe():-
    pos((Y,X)),
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    condition(Y,Xplus).
        
nextsafe():-
    pos((Y,X)),
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    condition(Yplus,X).

nextsafe():-
    pos((Y,X)),
    P is X-1,
    condition(Y,P).

nextsafe():-
    pos((Y,X)),
    (Xminus is X-1, Xplus is X+1),
    (Yminus is Y-1, Yplus is Y+1),
    condition(Yminus,X).

condition(A,B):-not_wall((A,B)),
            safe((A,B)),
            write('You can move to ('),
            write((A,B)),
            write(')').

condition(A,B):-not(not_wall((A,B))),
            write('You cant move to ('),
            write((A,B)),
            writeln(') It is outside the map'),
            false.

condition(A,B):-
            not(safe((A,B))),
            write('You cant move to ('),
            write((A,B)),
            writeln(') It is not safe'),
            false.

    







%check if it is possible to shoot the wumpus
shootwumpus():-
    pos((Y,X)),
    stench((Y,X)),
    wumpusdead(0),
    write('You can shoot the wumpus!').

shootwumpus():-
    pos((Y,X)),
    (not(stench((Y,X)));
    wumpusdead(1)),
    write('You cant shoot the wumpus!'),
    false.

%check if the gold is in case Y , X
isgold():-
    pos((Y,X)),
    gold((Y,X)).

%check if it is possible to grab the gold
grabgold():-
    isgold(),
    write('You can grab the gold!').

grabgold():-
    not(isgold()),
    write('You cant grab the gold!'),
    false.


