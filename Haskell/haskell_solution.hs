import System.Environment

remove [] char = []
remove (n:ns) char = (if n /= char then [n] else [""]) ++ remove ns char

main = do
     args <- getArgs
     let input_file = head args
     putStrLn (remove input_file '.')

