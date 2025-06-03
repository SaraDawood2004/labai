% Facts for distances between cities
distance(a, b, 10).
distance(b, c, 20).
distance(c, d, 15).
distance(d, a, 25).
distance(a, c, 35).
distance(b, d, 30).

% Make the graph undirected
path(X, Y, D) :- distance(X, Y, D).
path(X, Y, D) :- distance(Y, X, D).

% Find all permutations and calculate cost
tsp(Start, Path, Cost) :-
    findall(C, (distance(C, _, _); distance(_, C, _)), Cities),
    sort(Cities, UniqueCities),
    delete(UniqueCities, Start, Rest),
    permute(Rest, Perm),
    travel(Start, Perm, Path, Cost).

travel(Start, [H|T], [Start, H|Rest], Cost) :-
    path(Start, H, C1),
    travel(H, T, Rest, C2),
    Cost is C1 + C2.
travel(Start, [], [Start], 0).

% Permutation helper
permute([], []).
permute(L, [H|T]) :- select(H, L, R), permute(R, T).
