{-# LANGUAGE ScopedTypeVariables #-}
module Main where
import System.Random (randomRIO)
import Text.Read (readMaybe)

message :: String
message = "Welcome to the number guessing game! \n\
          \You have 10 guesses to guess the number.\n\
          \The computer will generate a random number between 1 and 100.\n\
          \Try to guess it in as few attempts as possible."

askNumber :: IO Integer
askNumber = do
    putStrLn "Take a guess: " 
    maybeNumber :: Maybe Integer <- readMaybe <$> getLine
    maybe recurseIfUnparseable recurseIfOutOfRange maybeNumber
    where recurseIfUnparseable = do putStrLn "Only enter integers!"
                                    askNumber
          recurseIfOutOfRange n
              | n < 1 || n > 100 = do putStrLn "Number must be between 1 and 100"
                                      askNumber
              | otherwise        = return n

playGame :: Integer -> IO ()
playGame secretNumber = go 0
    where maxGuesses = 10
          go :: Integer -> IO ()
          go failureCount
              | maxGuesses <= failureCount = putStrLn "You lost!"
              | otherwise = do
                  putStrLn $ "You have " ++ show (maxGuesses - failureCount) ++ " tries left."
                  guess <- askNumber
                  if guess == secretNumber
                      then putStrLn "You guessed the number; you won!"
                      else do
                          putStrLn (if guess > secretNumber
                                    then "Your guess was too high."
                                    else "Your guess was too low.")
                          go (failureCount + 1)

main :: IO () 
main = do
    putStrLn message
    secretNumber <- System.Random.randomRIO (1, 100):: IO Integer
    playGame secretNumber
