% Skriven av Hugo Larsson Wilhelmsson och Erik Smit

% Skapar en modul bern, som räknar ut Bernoullital
-module(bern).
% Funktionerna som är synliga utanför modulen
-export([bernoulli/1, bern/0]).

% Funktion för att beräkna ett Bernoullital N
% N kan inte vara mindre än 0
bernoulli(N) when N >= 0 ->
    % Returnerar det sista talet i listan
    lists:last(
        % Skapar en lista med N-1 element där M är 1 till N 
        % och Acc är i början listan med ett element, 1.
        % fun(M, Acc) är en funktion som genomförs på varje element
        lists:foldl(
            fun(M, Acc) ->
                % Anropar hjälpfunktionen calc_b för att fortsätta algoritmen
                Bm = calc_b(M, Acc),
                % Lägger till Bm i listan Acc
                Acc ++ [Bm]
            end, [1], lists:seq(1, N)
        )
    ).

% Funktion för att beräkna binomialkoefficienten
binom(N, K) ->
    R = 1,
    % Loopar igenom koden fun(I, Acc) K-1 gånger där N har värdet 1 till K. 
    % Acc börjar med värdet R = 1 och uppdateras med det nya värdet i varje 
    % loop och returneras i slutet
    lists:foldl(
        fun(I, Acc) ->
            Acc * (N - I + 1) / I
        end, R, lists:seq(1, K)
    ).

% Hjälpfunktion för att beräkna B[m] enligt algoritmen
calc_b(M, B) ->
    % Loopar M-1 gånger där M är 0 till M-1. Acc är i början 0. 
    % Värdet på Acc ändras i varje loop.
    Bm = lists:foldl(
        fun(K, Acc) ->
            % Anropar Binom och multiplicerar det med B[k].
            % K+1 är index i B och vi tar K+1 eftersom listor 
            % börjar på index 1 i Erlang
            Acc - binom(M + 1, K) * lists:nth(K+1, B)
        end, 0, lists:seq(0, M-1)),
    % Sista steget i algoritmen. Funktionen returnerar sedan Bm
    Bm / (M + 1).

% Funktion för att skriva ut de 20 första Bernoullitalen
bern() ->
    % Ändra N för att skriva ut de N första talen
    N = 20,
    [io:format("B[~p]: ~s~n", [X, format_bernoulli(bernoulli(X))]) || X <- lists:seq(0, N)].

format_bernoulli(Number) ->
    io_lib:format("~.9f", [float(Number)]).
