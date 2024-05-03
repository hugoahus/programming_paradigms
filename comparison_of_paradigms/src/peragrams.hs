-- @author Hugo Larsson Wilhelmsson and Erik Smit
-- @date 2024-02-16
import Data.List

-- Main function
main :: IO ()
main = do
    -- Get input
    input <- getLine
    -- Get the Int
    let numCharRemove = minNum input
    -- Print the output
    putStrLn (show numCharRemove)

-- Find the minimum number of letters that needs to be removed to create a Peragram
minNum :: String -> Int
minNum [] = 0
minNum (x:xs) = do
    if ((length (x:xs)) `mod` 2 == 0) && (checkOddTuples (createTuples (x:xs)) == 0)
        then 0
        else if ((length (x:xs)) `mod` 2 /= 0) && (checkOddTuples (createTuples (x:xs)) == 1)
            then 0
            else checkOddTuples (createTuples (x:xs)) - 1

-- Create tuples for each Char together with the number of times it occures in the String
createTuples :: String -> [(Char, Int)]
createTuples xs = map (\x -> (head x, length x)) (group (sort(xs)))

-- Calculates the number of tuples that have an odd number
checkOddTuples :: [(Char,Int)] -> Int
checkOddTuples [] = 0
checkOddTuples ((char,num):xs) = do
    if (num `mod` 2) == 0
        then checkOddTuples xs
        else 1 + checkOddTuples xs