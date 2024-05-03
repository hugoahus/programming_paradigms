<?php
// Written by Hugo Larsson Wilhelmsson and Erik Smit

// Anropar funktionen bernoulli() för att starta beräkningen
bernoulli();

// Function to calculate the Bernoulli numbers
function bernoulli() {
    // Ändra $n om annat tal önskas
    $n = 20;
    // Creates an Array of size n+1, that starts from 0, and sets every element to 0
    $bernoulli_numbers = array_fill(0, $n + 1, 0);
    // Sets B(0) = 1
    $bernoulli_numbers[0] = 1;

    // Print B(0)
    echo "B[0] = " . number_format($bernoulli_numbers[0], 9) . "\n";

    // Bernoulli algorithm
    for ($m = 1; $m <= $n; $m++) {
        $bernoulli_numbers[$m] = 0;
        for ($k = 0; $k < $m; $k++) { 
            $bernoulli_numbers[$m] = $bernoulli_numbers[$m] - binomial($m + 1, $k) * $bernoulli_numbers[$k];
        }
        $bernoulli_numbers[$m] = $bernoulli_numbers[$m]/($m + 1);
        // Print B(n)
        echo "B[$m] = " . number_format($bernoulli_numbers[$m], 9) . "\n";
    }
}

// Function to calculate the binomial coefficient
function binomial($n, $k) {
    $r = 1;
    for ($i = 1; $i <= $k; $i++) { 
        $r = $r * ($n - $i + 1) / $i;
    }
    // Return r
    return $r;
}
?>