% @author Hugo Larsson Wilhelmsson and Erik Smit
% @date 2024-02-22
:- [kattio].

% Får in en sträng och gör varje ord till ett emelemt i en lista och sorterar den
string_to_list(Buses, SortedList) :-
% Skapa en lista, BusListStr, som bryter ut varje ord från en sträng till element i listan
split_string(Buses, " ", "", BusListStr),
% konvertera string-listan till en ny lista av typen Int. atom_number används för att konvertera en atom (strängen) till ett heltal eller flyttal
maplist(atom_number, BusListStr, BusListInt),
% Sortera listan
sort(BusListInt, SortedList).


% Basfall. Om listan endast har ett element, printa det
check_first_two_elem([First | []]) :-
    write(First).


% Om listan innehåller ett element, där nästkommande element != elementet + 1 så skriv ut elementet
check_first_two_elem([First, Second | Rest]) :-
% Kolla om Second != First + 1
    Second =\= First + 1,
    write(First),
    write(' '),
% Rekursivt anropa sig själv med listan - det första elementet
    check_first_two_elem([Second|Rest]).


% Om listan innehåller ett element, där nästkommande element == elementet + 1, skriv ut det första elementet och anropa check_when_same_in_row
check_first_two_elem([First, Second | Rest]) :-
% Kolla om Second == First + 1
    Second =:= First + 1,
    write(First),
% Anropa check_when_same_in_row
    check_when_same_in_row([Second|Rest],1).


% Basfall. Om nästkommande element inte är detsamma som det tidigare elementet + 1 (när - ska ta slut)
check_when_same_in_row([First, Second | Rest], N) :-
    Second =\= First + 1,
    N =\= 1,
    write('-'),
    write(First),
    write(' '),
    check_first_two_elem([Second|Rest]).


% Basfall. Om nästkommande element inte är detsamma som det tidigare elementet + 1 (när - ska ta slut, men inte skrivas ut)
check_when_same_in_row([First, Second | Rest], N) :-
    Second =\= First + 1,
    N =:= 1,
    write(' '),
    write(First),
    write(' '),
    check_first_two_elem([Second|Rest]).


% Basfall. Om - fortsätter tills listan är slut och antalet element som ska bindas med - är mer än 2
check_when_same_in_row([First | []], N) :-
    N =\= 1,
    write('-'),
    write(First),
    write(' ').


% Basfall. Om - fortsätter tills listan är slut och antalet element som ska bindas med - är lika med 2
check_when_same_in_row([First | []], N) :-
    N =:= 1,
    write(' '),
    write(First).


% Rekursivt anropa sig själv om nästa element är detsamma som det aktuella elementet + 1
check_when_same_in_row([First, Second | Rest], N) :-
    Second =:= First + 1,
    check_when_same_in_row([Second|Rest], (N+1)).


main :-
% Tar emot en ström, en rad av input (user_input)
    read_line_to_string(user_input,_),
% Samma som ovan fast den andra raden. Returnerar strängen Buses
    read_line_to_string(user_input,Buses),
% Konverterar strängen, Buses, till en lista
    string_to_list(Buses, SortedList),
% Ny rad
    nl,
% Starta processen
    check_first_two_elem(SortedList).