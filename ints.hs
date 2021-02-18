-- ******************************************************************************
-- *
-- * Name:	        Kirubel Tesfaye
-- *
-- * Date:	        April 20, 2018
-- *
-- * Assignment:	Term Project exampels
-- *
-- * Purpose:	        List on ints with sum less than 100
-- *
-- *****************************************************************************
import System.IO

-- Recuresively get integers
getNum :: IO Integer         
getNum = do  
  num <- getLine
  return (read num :: Integer)

 -- Keep track of the sum using a parameter
getListOfInts :: Integer -> IO [Integer]
getListOfInts total = do
  int <- getNum
  -- If the sum of the numbers is greater than 100, stop 
  if total + int > 99
    -- Return a list of ints in which their sum is less than 100
    then return [int]
    else do
    -- Everytime you recure, add the number and a new input 
    listOfInts <- getListOfInts(total + int)
    -- and concat them in a list
    return(int:listOfInts)

-- When compiled, print out the appropriate list
main = do
  putStrLn "Enter integers on separate lines:"
  ints <- getListOfInts 0
  putStrLn "-------"
  putStrLn "Here are the integers you entered:"
  putStrLn (show ints)

  
  
