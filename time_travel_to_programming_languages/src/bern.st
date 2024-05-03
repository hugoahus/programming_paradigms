"Written by Hugo Larsson Wilhelmsson and Erik Smit"
Object subclass: #Bernoulli.
"Creates a new class that extends the subclass"
Bernoulli class extend [
    "Bernoulli algorithm"
    "A method that takes n as a parameter"
    bernoulli: n [
        "Initialize variables"
        | B size |
        size := n+1.
        "Create an Array to store B(0)-B(20)"
        B := Array new: size.

        "Set B(0) to 1"
        B at: 1 put: 1.
        2 to: size do: [:m |
            B at: m put: 0.
             1 to: (m-1) do: [:k |
                B at: m put: ((B at: m) - ((Bernoulli binom: m k: (k-1)) * (B at: (k)))).
            ].    

            B at: m put: (B at: m) / m.
        ].
        "Return B(n)"
        ^(B at: size)
    ]

    "Binom algorithm"
    "A method that takes n and k as parameters"
    binom: n k: k [
        | r |
        r := 1.
        1 to: k do: [:i |
            r := r * (n - i + 1) / i.
        ].
        "Return r"
        ^ r
    ]
]

"Print B(0)-B(20)"
"Change 20 to the number we want tp print up to"
0 to: 20 do: [:n |
    | z |
    z := Bernoulli bernoulli: n.
    Transcript show: 'B[', n printString, '] = ', z printString; cr.
].

