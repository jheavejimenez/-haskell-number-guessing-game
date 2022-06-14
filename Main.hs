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
playGame secretNumber = counter 0
    where 
        counter getTries = do
            let maxGeusses = 3
            putStrLn $ "You have " ++ show (maxGeusses - getTries) ++ " tries left."
            guess <- askNumber
            
            if guess == secretNumber && getTries < maxGeusses
                then do
                    putStrLn "You guessed the number!"
                    die "You won!"
                else if getTries < maxGeusses
                    then do
                        if guess > secretNumber
                            then do
                                putStrLn "Your guess was too high" >> counter (getTries + 1)
                                playGame secretNumber
                            else do
                                putStrLn "Your guess was too low" >> counter (getTries + 1)
                                playGame secretNumber
                    else do
                        die "You lost!"


main :: IO () 
main = do
    putStrLn message
    secretNumber <- randomRIO (1, 100):: IO Integer
    putStrLn $ "The secret number is " ++ show secretNumber
    playGame secretNumber
