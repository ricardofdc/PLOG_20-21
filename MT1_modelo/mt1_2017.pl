:-dynamic played/4.

%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPlayed, PercentUnlocked).
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

%playedALot(+Player)
playedALot(Player):-
    played(Player, _, HoursPlayed, _),
    HoursPlayed >= 50.

%isAgeAppropriate(+Name, +Game)
isAgeAppropriate(Name, Game):-
    player(Name, _, Age),
    game(Game, _, MinAge),
    Age >= MinAge.

%updatePlayer(+Player, +Game, ?Hours, ?Percentage)
updatePlayer(Player, Game, Hours, Percentage):-
    played(Player, Game, _, _), !,
    retract(played(Player, Game, PastH, PastP)),
    NewH is PastH + Hours,
    NewP is PastP + Percentage,
    assert(played(Player, Game, NewH, NewP)).

updatePlayer(Player, Game, Hours, Percentage):-
    assert(played(Player, Game, Hours, Percentage)).
