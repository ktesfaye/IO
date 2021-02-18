Write different functions that answer the respective questions.

### Part 1

For this part, solve two different questions. The first one is implementing mastermind game and the second one is currency denomination.

## #1 Mastermind game
Mastermind is a board game for two players, in which one player (the codemaster) creates a
secret code of 4 colored pegs, and the other player (the code breaker) must guess the pegs. In
this problem, you will write a function that can correctly report the results of a specific guess,
given the secret code

To solve this question, create two helper functions that check for appropriate black and white peg.

To check for the black peg, what you need to do was check the top elements in both strings. And recursively do that for all.
```
head x == head y = 'b':checkBlack (tail x) (tail y)
```
That part was easy. Checking for white peg was a bit trickier. Checking if an element is in a list is easy. Checking if that element is not at the right spot was trickier. After some research and working with Nathaniel Adair, I used an inbuilt method *elemntIndicies* and checking it against a parameter that keeps track of each index.
```
| ((head x) `elem` y) && not (elem n (elemIndices (head x) y)) = 'w':(checkWhite(n+1) (tail x) y)
| otherwise = checkWhite (n + 1) (tail x) y
```
After doing that, just call both methods and concat them.

```
(checkBlack x y)++(checkWhite 0 x y)
```
## #2 Currency denomination
There are two parts for this question.
### usaChange
Suppose you work in a US supermarket and you need to make
change for x cents using the fewest number of coins. In this problem, you will write a
function usaChange​ that takes an Integer x representing the number of cents of the change
that needs to be made, and will return a list representing the number of quarters, dimes,
nickels, and pennies to return as change. For example, for the input 87 your program should
return [3,1,0,2]​.

This part was really easy. As all I had to do was create a partial function that calls the second part of the problem using the usa currency denomination.
```
change [25, 10, 5, 1] number
```
And print out the list of changes. The real stuff happens in the second part.
### change
Let's make change, part 2! Suppose you work in a supermarket in Haskelland and you need
to make change for x cents using the fewest number of coins. In this problem, you will write
a function change​ ​that takes a list of positive Integers representing Haskelland’s coin
denominations, and an Integer x representing the monetary value of the change that needs to
be made. Your function should return a list of integers indicating how many coins of each
denomination to return. You may assume that the coin denominations are all positive integers
in decreasing order, and that the last one is 1 to ensure that there is a solution for every x.


This question was fairly easy. A simple way to solve it was to take a number, divide it by the first item in the list, and store that. For the next number, just take the mod of those two numbers.
```
(num `div` (head lst)):chan(tail lst)(num `mod` (head lst))
```
In order to optimize this, check and compare with more permutation and return the best one.

A problem I ran into was trying to solve for the hard special cases. But It was like 1 in the morning and I couldn't think so I didn't fix that.

### Part 2
This part also has 2 problems to solve.

## getListOfInts
Write a function getListOfInts​ that allows the user to input integers. The function
should stop accepting inputs when the entered integers add up to 100 or greater. The function
should then return a list of all of the entered integers.

For this part, we need to create 2 helper function. One that gets the input and the other that handles the IO part.

First recursively take ints.
```
num <- getLine
return (read num :: Integer)
```
Then for the second part, all I to do was keep track of the sum and stop and return when the sum is greater than 100. A problem I ran into was breaking out of the if loop. I solved this part by keeping track of the sum as a parameter than a variable.

The rest was pretty easy. Each time it recures, just add the new inputed number and concat each input to a list and return it.
```
listOfInts <- getListOfInts(total + int)
return(int:listOfInts)
```
And then since it returns an IO action, we need a main to call it.
```
main = do
  putStrLn "Enter integers on separate lines:"
  ints <- getListOfInts 0
  putStrLn "-------"
  putStrLn "Here are the integers you entered:"
  putStrLn (show ints)
```
For this part, I collaborated with Brian Li to solve the question.
### mastermind
For this problem you will add to your Mastermind program from Part 1 to make it a playable
game that interacts with a human player. As such, you should copy over your Mastermind
program from Part 1 into mastermind.hs​. You will write a function playMastermind
that takes a solution string (such as “GRBG”​) as its input, and plays the role of the
codemaster while the user is the code breaker.

For this part, all I had to handle was input of the pegs and matching it with random combination of pegs.

Recursively check each input with the secret code and give the user hint.
```
putStrLn $ "The hint pegs are: " ++ (show (checkMastermind code guess))
guesses <- (playMasterMind code)
```
And everytime it recures, keep track of the score by adding one. And return the score.
```
return (succ guesses)
```
A problem I ran into was still breaking out of a loop. After a long time and trying, I solved it by adding a proper base case.
```
let result = checkMastermind code guess
if result == "bbbb"
  then return 1
```
And since this returns an IO function, we need a main.
```
main = do
 gen <- getStdGen
 let code = take 4 $ map (pegs !!) $ randomRs (0, 5) gen
 guesses <- playMastermind code
 putStrLn "You win!"
 putStrLn $ "It took you " ++ (show guesses) ++ " guesses!"
```

## Running the
For part 1 of the project, follow the following steps.
```
ghci -- to load the repl
:l filename.hs --to run the file
```
For the part 3 of the project, follow the following steps.
```
ghc --make filename.hs --to complie the file
./filname --to run the code
```
