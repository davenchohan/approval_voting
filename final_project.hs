-- final_project.hs
--Daven Chohan
--Student ID: 301401324
--Final Project for CMPT 383

--Learned from class notes
removeDups2 :: Eq a => [a] -> [a] 
removeDups2 lst = foldr op [] lst
        where op x acc = if x `elem` acc
                         then acc
                         else x : acc

--Learned from class notes
count :: Eq a => a -> [a] -> Int
count v xs = length (filter (==v) xs)

--Was not sure if we were allowed to import Data.List as mentioned in the lecture as rubric says use only
--standard functions, instead I used this insertion sort which I learned from the class notes
insert :: Ord a => a -> [a] -> [a]
insert a [] = [a]
insert a (x:xs) | a <= x    = a:x:xs
                | otherwise = x : (insert a xs)

-- insertion sort from class notes
sort :: Ord a => [a] -> [a]
sort []     = []
sort (x:xs) = insert x (sort xs)

findEmpty :: [[[Char]]] -> Int
findEmpty lst = (length (filter (== ["none"]) lst))

removeEmpty :: [[[Char]]] -> [[[Char]]]
removeEmpty lst = (filter (/= ["none"]) (lst))

findFull :: (Eq a, Foldable t) => t [a] -> [a]
findFull lst = (removeDups2 $ concat (lst))

fullCount :: Eq a => [[a]] -> Int
fullCount lst = (length (filter (== (length (findFull lst))) (map length lst)))

formatList :: Show a => ([Char], a) -> [Char]
formatList lst = (((fst lst) ++ ": ") ++ (show (snd lst)))

listToString :: [[Char]] -> [Char] -> [Char]
listToString lst string= if ((length (tail lst)) == 0)
                  then (string ++ ((head lst) ++ "\n"))
                  else ((string ++ ((head lst) ++ "\n")) ++ (listToString (tail lst) string))

--Part of it learned from class notes and lecture
approvalCount :: Ord a => [[a]] -> [(a, Int)]
approvalCount ballots = map (\(x,y) -> (y,x)) results
                        where 
                           allVotes   = concat (map removeDups2 ballots)
                           candidates = findFull ballots
                           rawCounts  = [(count c allVotes, c) | c<-candidates]
                           results    = reverse (sort rawCounts)

-- learned from class notes
myGetLine :: IO (String)
myGetLine = do c <- getChar
               if c == '\n' then
                  return ""
               else
                  do cs <- myGetLine
                     return (c:cs)

main = do
    let file = ""
    putStrLn("\n")
    putStrLn "What is the name of the ballot file?"
    file <- myGetLine
    contents <- readFile file --reading input learned from https://www.tutorialspoint.com/haskell/haskell_input_and_output.htm
    putStrLn("\n")
    print("Total # of ballots: " ++ (show (length (lines contents))))
    putStrLn("\n")
    putStrLn(listToString ((map formatList (approvalCount (map removeDups2 (removeEmpty (map words (lines contents))))))) "")
    putStrLn (show ("empty: " ++ (show (findEmpty (map words (lines contents))))))
    putStrLn(show("full: " ++ (show (fullCount (map removeDups2 (removeEmpty (map words (lines contents))))))))
    return()

