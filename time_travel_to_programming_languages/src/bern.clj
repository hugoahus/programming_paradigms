; Written by Hugo Larsson Wilhelmsson and Erik Smit
(defn binomial [n k]
  (let [r (atom 1)]
    (doseq [i (range 1 (inc k))]
      (swap! r * (/ (+ (- n i) 1) i)))
    @r))

(defn bernoulli [n]
  (let [b (atom (vec (conj (repeat (dec (+ n 1)) 0) 1)))] ; Create an atom to hold the mutable vector b
    (doseq [m (range 1 (inc n))] ; Iterate from 1 to n
      (doseq [k (range m)] ; Iterate from 0 to m-1
        (let [binom-val (binomial (+ m 1) k)] ; Calculate the binomial coefficient
          (swap! b #(assoc %1 m (- (%1 m) (* binom-val (%1 k))))))) ; Update b[m] based on the binomial calculation
      (swap! b #(assoc %1 m (float (/ (%1 m) (+ m 1))))) ; Divide b[m] by m+1
) ; Print the value of b[m] after inner loop calculation
    @b)) ; Return the vector b


(defn -main []
  ; Change 20 to another number if you want to calculate up to that instead
  (let [result (bernoulli 20)] ; Call the bernoulli function with n = 20 and store the result
    (doseq [[i number] (map-indexed vector result)] ; Iterate over each number in the result vector
      (printf "B[%d]:%.7f\n" i (float number))))) ; Print each number on its own line
(-main)