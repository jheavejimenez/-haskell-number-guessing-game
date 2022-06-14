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


askNumber :: IO Integer
askNumber = do
    putStrLn "Take a guess: " 
    input <- getLine

    let number = read input :: Integer
    if number < 1 || number > 100
        then do
            putStrLn "Number must be between 1 and 100"
            askNumber
        else return number


playGame :: Integer -> IO ()
playGame secretNumber = do
    guess <- askNumber

    let maxGeusses = 10
    let getTries = 0

    if guess == secretNumber && getTries < maxGeusses
        then do
            putStrLn "You guessed the number!"
            putStrLn "You won!"
        else if getTries < maxGeusses
            then do
                if guess > secretNumber
                    then do
                        putStrLn "Your guess was too high"
                        playGame secretNumber
                    else do
                        putStrLn "Your guess was too low"
                        playGame secretNumber
            else do
                putStrLn "You lost!"


main :: IO () 
main = do
    putStrLn message
    secretNumber <- randomRIO (1, 100):: IO Integer
    playGame secretNumber
