// Skriven av Hugo Larsson Wilhelmsson och Erik Smit

// Funktion för att beräkna Bernoullitalen
fn bernoulli() {
    // Skapar en vektor, bernoulli_numbers, som är mutable. Vi säger att den har ett element, 1f64 = 1 i 64 bitar
    // ! står innan makron
    let mut bernoulli_numbers = vec![1f64];

    // Algoritmen från uppgiften
    // Loopar från 1 till 21
    // Ändra 21 till annat önskas N+1 om så önskas, ändra även nere i printen
    for m in 1..=21 {
        // Lägger till elementet 0f64 = 0 i vektorn bernoulli_numbers
        bernoulli_numbers.push(0f64);
        // Loop från 0 till m-1
        for k in 0..m {
            bernoulli_numbers[m] -= binomial(m + 1, k) * bernoulli_numbers[k];
        }
        // Konverterar m till f64 och adderar med 1f64 = 1
        bernoulli_numbers[m] /= m as f64 + 1f64;
    }

    // Printar de 21 första Bernoullitalen (0-20) med 9 decimaler
    // Ändra 20 till annat önskat N om så önskas, ändra även i loopen ovan
    for n in 0..=20 {
        println!("B[{}] = {:.9}", n, bernoulli_numbers[n]);
    }
}

// Funkttion för att beräkna binomialkoefficienten
fn binomial(n: usize, k: usize) -> f64 {
    // Initierar variabeln r som är mutable
    let mut r = 1f64;
    // Loopar från 1 till k
    for i in 1..=k {
        r *= (n - i + 1) as f64 / i as f64;
    }
    r
}

// main-funktionen som anropar bernoulli()
fn main() {
    bernoulli();
}