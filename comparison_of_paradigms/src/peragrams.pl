% @author Hugo Larsson Wilhelmsson and Erik Smit
% @date 2024-02-21
:- [kattio].

% Tar reda på hur antalet Chars som förekommer udda antal gånger i en sträng, Input, och sparar detta i Oddoccurrences
count_odd_occurrences(Input, Oddoccurrences) :-
% Gör om en sträng till en lista av Chars
    string_chars(Input, ListChars),
% Sortera ListChars och ta bort dubbletter
    sort(ListChars, ListUniqueChars),
% Resulterar i en lista av "tuplar" som innehåller antalet gånger varje element från ListUniqueChars förekommer i ListChars
    get_tuple_occurrences(ListUniqueChars, ListChars, Counts),
% Gör en ny lista, OddCounts, som innehåller de element från listan Counts som uppfyller predikatet if_odd
    include(if_odd, Counts, OddCounts),
% Beräkna längden av listan OddCounts och spara detta i Oddoccurrences
    length(OddCounts, Oddoccurrences).

% Rekursiv funktion som får in en lista med unika Chars och en lista med Chars och räknar, för varje unikt Char i den första listan, 
% ut antalet gånger den förekommer i den andra listan. Funktionen returnerar en lista med "tuplar" som innehåller varje unik Char och 
% antalet gånger det förekommer i den andra listan
% Basfall, om den unika listan är tom returneras en tom lista
get_tuple_occurrences([], _, []).
get_tuple_occurrences([Char|ListUniqueChars], AllChars, [Count-Char|Counts]) :-
% Tar reda på antalet gånger det första elementet i den unika listan föremommer i den andra listan
    count_char_in_list(Char, AllChars, Count),
% Anropar sig själv med resterande element i den unika listan
    get_tuple_occurrences(ListUniqueChars, AllChars, Counts).

% Tar reda på antalet gånger en Char, Char, förekommer i en lista, CharList, och sparar detta i Count
count_char_in_list(Char, CharList, Count) :-
% Lägger till alla Char som förekommer i CharList i ListOfChar
    include(=(Char), CharList, ListOfChar),
% Tar reda på längden av listan ListOfChar
    length(ListOfChar, Count).

% Returnerar True om Count är udda
if_odd(Count-_) :-
% Returnerar True om Count mod 2 == 1
    Count mod 2 =:= 1.

% Printa 0 om längden av strängen är jämn och det inte förekommer något tecken udda antal gånger
print_minNum(Len,0) :-
	modulo_calculation(Len,2,Result),
	Result =:= 0,
	write('0').

% Printa 0 om längden av strängen är udda och endast ett tecken förekommer udda antal gånger
print_minNum(Len,1) :-
	modulo_calculation(Len,2,Result),
	Result =:= 1,
	write('0').

% Printa antalet udda tecken som finns - 1. Detta görs om inget av ovanstående regler stämmer
print_minNum(_,Oddoccurrences) :-
	Result is Oddoccurrences - 1,
	write(Result).

% Beräkna modulo av X med Y och spara resultatet i Resultat
modulo_calculation(X,Y,Result) :-
	Result is X mod Y.

% Tar emot en sträng, beräknar antalet tecken som förekommer udda antal gånger, längden av strängen och anropar print_minNum
main :-
    read_string(Input), 
    count_odd_occurrences(Input, Oddoccurrences),
    length(Input, Len),
	print_minNum(Len,Oddoccurrences).
