{-# LANGUAGE TypeApplications #-}

module Main where

import System.Random ( randomRIO )
import Text.Read (readMaybe)   -- Check @ShapeofMatter answer for this

data EndGame = Win | Loose | TooHigh | TooLow

-- The pure function for one guess. Clear and simple
playRound :: Int -> Int -> Int -> EndGame
playRound numguess solution guess
 | numguess <= 0     = Loose
 | guess > solution  = TooHigh
 | guess < solution  = TooLow
 | solution == guess = Win

-- This function just executes playRound given users input. 
-- It makes some validations you can even factor out in other function
playGame :: Int -> Int -> IO ()
playGame guesses_left solution = do
    putStrLn $ "\nYou have " ++ show guesses_left ++ " tries left."
    putStrLn "Take a guess: "
    input <- readMaybe @Int <$> getLine
    case input of
      -- Input is badformed
      Nothing -> do
        putStrLn "input isn't a number"
        playGame guesses_left solution

      -- Input is out of range
      Just guess | guess < 1 || guess > 100 -> do
        putStrLn "Number must be between 1 and 100"
        playGame guesses_left solution

      -- Input is ok
      Just guess -> do
        case playRound guesses_left solution guess of
          Loose -> putStrLn "You lost!"
          Win -> do
            putStrLn "You guessed the number!"
            putStrLn "You Won!"
          TooHigh -> do
            putStrLn "Your guess was too high"
            playGame (guesses_left - 1) solution
          TooLow -> do
            putStrLn "Your guess was too low"
            playGame (guesses_left - 1) solution

message :: String
message = "Welcome to the number guessing game! \n\
          \You have 10 guesses to guess the number.\n\
          \The computer will generate a random number between 1 and 100.\n\
          \Try to guess it in as few attempts as possible.\n"

main :: IO ()
main = do
    putStrLn message
    -- putStrLn "Set the max number of guesses:" 
    -- max_guesses <- readLn 
    secretNumber <- randomRIO (1, 100) :: IO Int
    playGame 10 secretNumber

