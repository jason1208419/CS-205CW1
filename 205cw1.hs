--Name: Kin Wah Lee (689591)
--Name: Chun Man Kwok (689613)
--This is our own solution of the group

import Test.QuickCheck

--1 a)
maxNum :: Int -> Int -> Int
maxNum x y = if x >= y then x
	else y

max1 :: Int -> Int -> Int -> Int
max1 x y z = maxNum z(maxNum x y)
--result: 876543

max2 :: Int -> Int -> Int -> Int
max2 x y z
	| x > y && x > z = x
	| y > x && y > z  = y
	| otherwise = z
--result: 876543

--1 b)
checkCorrectness :: Int -> Int -> Int -> Bool
checkCorrectness x y z =
	max1 x y z == max2 x y z
--response: +++ OK, passed 100 tests.
--weakness: if max1 and max2 are wrong in the same way (such as both functions are finding the minimun), it can still pass the tests
--ways of improve: one of the function should be checked with the build in function

--2
insertElement :: Ord a => a -> [a] -> [a]
insertElement x [] = [x]
insertElement x (y:ys) = if (x<y) then x:y:ys
	else y:insertElement x ys

insertionSort :: Ord a => [a] -> [a]
insertionSort [] = []
insertionSort (x:xs) = insertElement x (insertionSort xs)

qsort :: [Int] -> [Int]
qsort [] = []
qsort (x:xs) =
	qsort smaller ++ [x] ++ qsort larger
	where
		smaller = [a | a <- xs, a <= x]
		larger = [b | b <- xs, b > x]

merge :: [Int] -> [Int] -> [Int]
merge [] xs = xs
merge ys [] = ys
merge (x:xs) (y:ys) = if x > y then y:merge (x:xs) ys
	else x : merge xs (y:ys)

split :: [Int] -> ([Int], [Int])
split [] = ([], [])
split [x] = ([x], [])
split (x:y:zs) = (x:xs, y:ys)
	where (xs, ys) = split zs

msort :: [Int] -> [Int]
msort [] = []
msort [x] = [x]
msort xs = merge (msort ys) (msort zs)
	where (ys, zs) = split xs

pairs :: [a] -> [(a,a)]
pairs xs = zip xs (tail xs)

sorted :: Ord a => [a] -> Bool
sorted xs =
	and [x <= y | (x,y) <- pairs xs]

sortCompare :: [Int] -> Bool
sortCompare xs = msort xs == qsort xs && insertionSort xs == qsort xs && sorted (qsort xs)
--check one sorting if it's correct and then call the other sorting to compare and check with the checked one
--output: True


--3 a)
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

prime :: Int -> Bool
prime n = factors n == [1,n]

primesbelow :: Int -> [Int]
primesbelow n = [x | x <- [1..n], prime x]

--3 b)
allprimes :: [Int]
allprimes = [x | x <- [2..], prime x]

primeTest :: [Bool]
primeTest = map prime [0..]

primeTest2 :: [(Int,Bool)]
primeTest2 = zip [0..] primetest

--3 c)
isPrimeTwins :: (Int,Int) -> Bool
isPrimeTwins (x,y) = y - x == 2

primeTwinsNum :: Int -> Int
primeTwinsNum n = length(filter isPrimeTwins(zip (take n(allprimes)) (tail allprimes)))

--3 d)
--302

--4
travel :: Int -> [Int]
travel 1 = [1]
travel k = if even k
    then
    k:travel (k`div`2)
	else
	k:travel (3*k+1)

unique :: [Int] -> [Int]
unique [] = []
unique (x:xs) = x:unique(filter (/=x) xs)

numOfCity :: [Int] -> Int
numOfCity x = length (unique x)

maxCity :: [Int] -> Int
maxCity x = maximum x

--689591:
--[689591,2068774,1034387,3103162,1551581,4654744,2327372,1163686,581843,1745530,872765,2618296,1309148,654574,327287,981862,490931,1472794,736397,2209192,1104596,552298,276149,828448,414224,207112,103556,51778,25889,77668,38834,19417,58252,29126,14563,43690,21845,65536,32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2,1]
--54 cities visited
--largest number: 4654744

--689613:
--[689613,2068840,1034420,517210,258605,775816,387908,193954,96977,290932,145466,72733,218200,109100,54550,27275,81826,40913,122740,61370,30685,92056,46028,23014,11507,34522,17261,51784,25892,12946,6473,19420,9710,4855,14566,7283,21850,10925,32776,16388,8194,4097,12292,6146,3073,9220,4610,2305,6916,3458,1729,5188,2594,1297,3892,1946,973,2920,1460,730,365,1096,548,274,137,412,206,103,310,155,466,233,700,350,175,526,263,790,395,1186,593,1780,890,445,1336,668,334,167,502,251,754,377,1132,566,283,850,425,1276,638,319,958,479,1438,719,2158,1079,3238,1619,4858,2429,7288,3644,1822,911,2734,1367,4102,2051,6154,3077,9232,4616,2308,1154,577,1732,866,433,1300,650,325,976,488,244,122,61,184,92,46,23,70,35,106,53,160,80,40,20,10,5,16,8,4,2,1]
--155 cities visited
--largest number: 2068840

--876543:
--[876543,2629630,1314815,3944446,1972223,5916670,2958335,8875006,4437503,13312510,6656255,19968766,9984383,29953150,14976575,44929726,22464863,67394590,33697295,101091886,50545943,151637830,75818915,227456746,113728373,341185120,170592560,85296280,42648140,21324070,10662035,31986106,15993053,47979160,23989580,11994790,5997395,17992186,8996093,26988280,13494140,6747070,3373535,10120606,5060303,15180910,7590455,22771366,11385683,34157050,17078525,51235576,25617788,12808894,6404447,19213342,9606671,28820014,14410007,43230022,21615011,64845034,32422517,97267552,48633776,24316888,12158444,6079222,3039611,9118834,4559417,13678252,6839126,3419563,10258690,5129345,15388036,7694018,3847009,11541028,5770514,2885257,8655772,4327886,2163943,6491830,3245915,9737746,4868873,14606620,7303310,3651655,10954966,5477483,16432450,8216225,24648676,12324338,6162169,18486508,9243254,4621627,13864882,6932441,20797324,10398662,5199331,15597994,7798997,23396992,11698496,5849248,2924624,1462312,731156,365578,182789,548368,274184,137092,68546,34273,102820,51410,25705,77116,38558,19279,57838,28919,86758,43379,130138,65069,195208,97604,48802,24401,73204,36602,18301,54904,27452,13726,6863,20590,10295,30886,15443,46330,23165,69496,34748,17374,8687,26062,13031,39094,19547,58642,29321,87964,43982,21991,65974,32987,98962,49481,148444,74222,37111,111334,55667,167002,83501,250504,125252,62626,31313,93940,46970,23485,70456,35228,17614,8807,26422,13211,39634,19817,59452,29726,14863,44590,22295,66886,33443,100330,50165,150496,75248,37624,18812,9406,4703,14110,7055,21166,10583,31750,15875,47626,23813,71440,35720,17860,8930,4465,13396,6698,3349,10048,5024,2512,1256,628,314,157,472,236,118,59,178,89,268,134,67,202,101,304,152,76,38,19,58,29,88,44,22,11,34,17,52,26,13,40,20,10,5,16,8,4,2,1]
--264 cities visited
--largest number: 341185120

--5
import Data.Char
surnames = ["Smith", "Smyth", "Smyth", "Smid", "Schmidt", "Smithers", "Jonas", "Johns", "Johnson", "Macdonald", "Nest O'Malett", "Ericsson", "Erikson", "Saunas", "Van Damme"]

ignoreCase :: String-> String
ignoreCase x = map toLower x

onlyAlpha :: String -> String
onlyAlpha x = filter isAlpha x

(&&&) :: (a -> Bool) -> (a -> Bool) -> (a -> Bool)
(&&&) f g x = (f x) && (g x)

discard :: String -> String
discard x = (head x):(filter ((/= 'a') &&& (/= 'e') &&& (/= 'i') &&& (/= 'h') &&& (/= 'o') &&& (/= 'u') &&& (/= 'w') &&& (/= 'y')) (tail x))

equivalent :: String -> String
equivalent [] = []
equivalent (x:xs)
	| (x == 'e' || x == 'i' || x == 'o' || x == 'u') = 'a':equivalent xs
	| (x == 'g' || x == 'j' || x == 'k' || x == 'q' || x == 's' || x == 'x' || x == 'y' || x == 'z') = 'c':equivalent xs
	| (x == 'f' || x == 'p' || x == 'v' || x == 'w') = 'b':equivalent xs
	| x == 't' = 'd':equivalent xs
	| x == 'n' = 'm':equivalent xs
	| otherwise = x:equivalent xs

safehead :: [Char] -> Char
safehead x = if x == [] then '.' else head x
	
consecutive :: String -> String
consecutive [] = []
consecutive (x:xs)
    | ((x == safehead xs) && (x == 'a' || x == 'c' || x == 'b' || x == 'd' || x == 'm')) = consecutive xs
    | otherwise = x:consecutive xs

target :: String -> String
target x = consecutive(equivalent(discard(ignoreCase(onlyAlpha x))))

result :: String -> [String]
result x = filter (\y -> target y == target x) surnames

printResult :: [String] -> IO()
printResult [] = putStr ""
printResult (x:xs) = do
    putStr x
    if (x == last (result x)) then putStr "\n" else putStr ", "
    printResult xs
	
myProgram :: [String] -> IO()
myProgram [] = putStr ""
myProgram (x:xs) = do
    putStr x
    putStr ": "
    printResult (result x)
    myProgram xs