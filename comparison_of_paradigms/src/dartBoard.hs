-- @author Hugo Larsson Wilhelmsson and Erik Smit
-- @date 2024-02-18

-- Main function
main :: IO ()
main = do
    -- Get input
    input <- getLine
    let num = read input :: Int
    -- Get the Int
    let res = getScore num 0 ""
    -- Print the output
    putStrLn res


-- Call getScores to get the rest of the results until we have gotten three scores
getOtherScores :: Int -> Int -> String -> String
getOtherScores totNum 1 str = 
    if totNum < 1
        then str
        else getScore totNum 1 (str ++ "\n")
getOtherScores totNum 2 str = 
    if totNum < 1
        then str
        else getScore totNum 2 (str ++ "\n")
getOtherScores totNum 3 str = 
    if (totNum /= 0)
        then "impossible"
        else str

-- Get the current num, iter and output and updates the output
getScore :: Int -> Int -> String -> String
getScore totNum numIter str = 
    -- If last iter is between 20 and 60 or second iter is between 80 and 100 (mot divided by 2 or 3), we need to take a triples and/or doubles of something else than 20
    if (numIter == 2 && totNum > 20 && totNum < 60) || (numIter == 1 && totNum > 80 && totNum < 100 && totNum `mod` 3 /= 0 && totNum `mod` 2 /= 0)
        then getSpecialScore totNum numIter str
        else if totNum >= 60
            then getOtherScores (totNum - 60) (numIter + 1) (str ++ "triple 20")
            else if totNum >= 40 
                then getOtherScores (totNum - 40) (numIter + 1) (str ++ "double 20")
                else if totNum >= 20
                    then getOtherScores (totNum - 20) (numIter + 1) (str ++ "single 20")
                    else if (totNum < 20 && totNum > 0)
                        then getOtherScores 0 (numIter + 1) (str ++ "single " ++ show totNum)
                        else getOtherScores 0 (numIter + 1) (str ++ "0")

-- Get special scores with triples and double of something else than 20
getSpecialScore :: Int -> Int -> String -> String
getSpecialScore totNum numIter str = 
    if (numIter == 1)
        then getSpecificOutput totNum numIter str
        else if (totNum `mod` 3) == 0 && (totNum `div` 3) <= 20
            then str ++ "triple " ++ show (totNum `div` 3)
            else if (totNum `mod` 2) == 0 && (totNum `div` 2) <= 20
                then str ++ "double " ++ show (totNum `div` 2)
                else "impossible"

-- adds triple 19 to the output and calls getSpecialScore to get the last score
getSpecificOutput :: Int -> Int -> String -> String
getSpecificOutput totNum numIter str = getSpecialScore (totNum - 3*19) (numIter + 1) (str ++ "triple 19\n")

                -- 157 = t20 + t19 + d20
                -- 155 = t20 + t19 + d19
                -- 151 = t20 + t19 + d17
                -- 149 = t20 + t19 + d16
                -- 145 = t20 + t19 + d14
                -- 143 = t20 + t19 + d13