-- ******************************************************************************
-- *
-- * Name:	        Kirubel Tesfaye
-- *
-- * Date:	        April 20, 2018
-- *
-- * Assignment:	Project 8
-- *
-- * Purpose:	        Interactive mastermind game
-- *
-- *****************************************************************************
import Data.List
import System.Random 

-- Take two chars and compare locations accordingly and return the correct pegs
checkMastermind :: [Char] -> [Char] -> [Char]
checkMastermind x y =
   -- Get the correct pegs and concatenate them
  (checkBlack x y)++(checkWhite 0 x y)
  
-- Returns 'b' for the black pegs or the correct location
checkBlack :: [Char] -> [Char] -> [Char]
checkBlack [][] = []
checkBlack x y
  -- Check if the first thing is the same in either strings and do the same for the rest
  | head x == head y = 'b':checkBlack (tail x) (tail y)
  | otherwise = checkBlack (tail x) (tail y)
  
-- Return 'w' for the white pegs that are elemnts in wrong location.
-- Take a numer to keep track of the index and two strings to compare
checkWhite :: Int-> [Char] -> [Char] -> [Char]
checkWhite _ [] _= ""
checkWhite n x y
  -- Check if each element in x is in y and not in the same index
  -- CITE: https://stackoverflow.com/questions/872782/elemindices-in-haskell
  -- DESC: How elemIndices work.
  | ((head x) `elem` y) && not (elem n (elemIndices (head x) y)) = 'w':(checkWhite(n+1) (tail x) y)
  | otherwise = checkWhite (n + 1) (tail x) y

-- Take a string and check it againist master mind. And return the score at the end
playMasterMind :: [Char] -> IO Integer
playMasterMind code = do
  putStrLn "Enter your guess: "
  guess <- getLine
  -- Grab a guess and a secret code and grab the correct b or w pegs
  let result = checkMastermind code guess
  -- Everytime you go, add 1 and stop if all pegs are all b's
  if result == "bbbb"
    then return 1
    else do
    putStrLn $ "The hint pegs are: " ++ (show (checkMastermind code guess))
    guesses <- (playMasterMind code)
    -- At every recursive call, increment the score
    return (succ guesses)

-- A list of the possible pegs      
pegs = "ROYGBP"
  
main = do
  -- Create a standard generator for the random generator
 gen <- getStdGen
 -- and randomly grab 4 pegs from the list of pegs
 let code = take 4 $ map (pegs !!) $ randomRs (0, 5) gen
 -- Grab the solved peg from checking guess against the secret code
 guesses <- playMasterMind code
 -- Print out the score
 putStrLn "You win!"
 putStrLn $ "It took you " ++ (show guesses) ++ " guesses!"  
  
