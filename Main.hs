{--
    Number guessing game
    -- Ask the user to stake a bet
    -- Generate a random number between 1 and 100
    -- Ask the user to guess the number
    -- If the user guesses the number, congratulate them
    -- If the user guesses incorrectly, tell them if they guessed too high or too low
    -- If the user guesses correctly return the amount that he user bet * 2.5 / guess count
    -- If the user runs out of guesses, tell them they lost
--}

module Main where
import System.Random
import Control.Monad ()

generateRandomNumber :: IO Int
generateRandomNumber = getStdRandom (randomR (1, 100))

main :: IO () 
main = show generateRandomNumber