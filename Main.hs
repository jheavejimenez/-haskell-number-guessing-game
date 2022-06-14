{--
    Number guessing game
    -- Generate a random number between 1 and 100
    -- Ask the user to guess the number
    -- If the user guesses the number, congratulate them
    -- If the user guesses incorrectly, tell them if they guessed too high or too low
    -- If the user runs out of guesses, tell them they lost
--}

module Main where
import System.Random
import System.Exit (die)

message :: String
message = "Welcome to the number guessing game! \n\
          \You have 10 guesses to guess the number.\n\
          \The computer will generate a random number between 1 and 100.\n\
          \Try to guess it in as few attempts as possible.\n"


