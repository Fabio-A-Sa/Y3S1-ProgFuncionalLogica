module Tests where
import Polynom

test :: String -> String -> String -> String
test testName str1 str2 = if str1/=str2 then "Test " ++ testName ++ " failed:\n"++ "    Obtained: " ++ str1 ++ "\n    Expected: " ++ str2 ++ "\n" else ""

testResults :: [String]
testResults = [

    -- Unit testing

    test "Norm[0]"      (normalize "x") "x",
    test "Norm[1]"      (normalize "x^1") "x",
    test "Norm[2]"      (normalize "0") "0",
    test "Norm[3]"      (normalize "x + y^2") "y^2 + x",
    test "Norm[4]"      (normalize "    -3    +4x^12 -     y   +1z") "4x^12 - y + z - 3",
    test "Norm[5]"      (normalize "1 + 2x - 3y^2 + 2z^3") "2z^3 - 3y^2 + 2x + 1",
    test "Norm[6]"      (normalize "z^9 - z^10 + 7z - 5z") "-z^10 + z^9 + 2z",
    test "Norm[7]"      (normalize "3x^3 - 2x^2*y^2") "-2x^2*y^2 + 3x^3",
    test "Norm[8]"      (normalize "-2x^20*y^20*z^20 - x^20*z^20*y^20 + 5y^20*x^20*z^20") "2x^20*y^20*z^20",
    test "Norm[9]"      (normalize "-1x^2 + 2*y^2*x^2 + 0*x^2 + 0") "2x^2*y^2 - x^2",
    test "Add[0]"       (add "0" "x") "x",
    test "Add[1]"       (add "0" "0") "0",
    test "Add[2]"       (add "x" "x") "2x",
    test "Add[3]"       (add "x + 5" "-x - 1") "4",
    test "Add[4]"       (add "2x" "2y") "2x + 2y",
    test "Add[5]"       (add "x" "2x^2") "2x^2 + x",
    test "Add[6]"       (add "2x + 2y" "-z+y+x") "3x + 3y - z",
    test "Add[7]"       (add "2x^2*y^2" "2x^2 - 2y^2") "2x^2*y^2 + 2x^2 - 2y^2",
    test "Add[8]"       (add "2x^2*y^2 - 2y^2*z^2" "x^2*y^2 + 3x^2*y^2 + y^2*z^2") "6x^2*y^2 - y^2*z^2",
    test "Add[9]"       (add "z^5 - x + 2y^3" "-3y^2 - 10z^5") "-9z^5 + 2y^3 - 3y^2 - x",
    test "Multi[0]"     (multi "0" "x") "0",
    test "Multi[1]"     (multi "x" "x") "x^2",
    test "Multi[2]"     (multi "x" "y") "x*y",
    test "Multi[3]"     (multi "1" "z") "z",
    test "Multi[4]"     (multi "2x*y" "-2x^3") "-4x^4*y",
    test "Multi[5]"     (multi "2x*y" "3x*y") "6x^2*y^2",
    test "Multi[6]"     (multi "3x^2 + 4" "2") "6x^2 + 8",
    test "Multi[7]"     (multi "2x^2 + 3x^2" "3y^2") "15x^2*y^2",
    test "Multi[8]"     (multi "2x^2*z^5" "-2y*x^2*z^2") "-4x^4*y*z^7",
    test "Multi[9]"     (multi "2x^2 + 3y^2" "3x - 2y") "6x^3 - 4x^2*y + 9x*y^2 - 6y^3",
    test "Multi[10]"    (multi "-2x^2*y^3 + 2z" "4x - 3y^2*z") "6x^2*y^5*z - 8x^3*y^3 - 6y^2*z^2 + 8x*z",
    test "Derive[0]"    (derive 'x' "0") "0",
    test "Derive[1]"    (derive 'x' "1") "0",
    test "Derive[2]"    (derive 'x' "x") "1",
    test "Derive[3]"    (derive 'x' "2x") "2",
    test "Derive[4]"    (derive 'x' "y") "0",
    test "Derive[5]"    (derive 'x' "2x^2") "4x",
    test "Derive[6]"    (derive 'x' "2x*y^2") "2y^2",
    test "Derive[7]"    (derive 'x' "-4y^3*z^2*x - 5 + x^2 + z") "-4y^3*z^2 + 2x",
    test "Derive[8]"    (derive 'x' "0x^3 + 2x*y - 3x^3*z^2 + 4*z + 1") "-9x^2*z^2 + 2y",
    test "Derive[9]"    (derive 'x' "2x^3*y^2 + 3x^3*y^2 - 4x^3") "15x^2*y^2 - 12x^2",

    -- Testing some properties

    test "AddCommutative[0]"     (add "4" "2")          (add "2" "4"),
    test "AddCommutative[1]"     (add "2x" "3x")        (add "3x" "2x"),
    test "AddCommutative[2]"     (add "2x^2" "3x")      (add "3x" "2x^2"),
    
    test "MultiCommutative[0]"   (multi "2x" "3x")      (multi "3x" "2x"),
    test "MultiCommutative[1]"   (multi "4" "2")        (multi "2" "4"),
    test "MultiCommutative[2]"   (multi "2x" "3y")      (multi "3y" "2x"),
    test "MultiCommutative[3]"   (multi "2x^2" "3x")    (multi "3x" "2x^2"),

    test "MultiAssociative[0]"   (multi (multi "2x" "3x") "4x")                 (multi "2x" (multi "3x" "4x")),
    test "MultiAssociative[1]"   (multi (multi "4" "2") "0")                    (multi "2" (multi "4" "0")),
    test "MultiAssociative[2]"   (multi (multi "2x" "3y") "3x")                 (multi "2x" (multi "3y" "3x")),
    test "MultiAssociative[3]"   (multi (multi "2x^2" "3x") "4z")               (multi "2x^2" (multi "3x" "4z")),
    test "MultiAssociative[4]"   (multi (multi "3y^2-x^2" "4z^3*y") "3x+4z")    (multi "3y^2-x^2" (multi "4z^3*y" "3x+4z")),

    test "MultiDistributive[0]"  (multi "5x" (add "2x" "3x"))          (add (multi "5x" "2x") (multi "5x" "3x")),
    test "MultiDistributive[1]"  (multi "4" (add "2" "0"))             (add (multi "4" "2") (multi "4" "0")),
    test "MultiDistributive[2]"  (multi "5z" (add "2x" "3y"))          (add (multi "5z" "2x") (multi "5z" "3y")),
    test "MultiDistributive[3]"  (multi "2x^2" (add "3x" "2y^2"))      (add (multi "2x^2" "3x") (multi "2x^2" "2y^2")),

    test "DeriveCommutative[0]"  (derive 'x' (derive 'y' "2x^2+y"))            (derive 'y' (derive 'x' "2x^2+y")),
    test "DeriveCommutative[1]"  (derive 'x' (derive 'y' "2x^3*y^2*z + 5x"))   (derive 'y' (derive 'x' "2x^3*y^2*z + 5x")),

    test "DeriveAdd[0]" (derive 'x' (add "3x" "2y"))                            (add (derive 'x' "3x") (derive 'x' "2y")),
    test "DeriveAdd[1]" (derive 'x' (add "4x^3*y^2+2x" "5y^4*x+5x^3*y^2"))      (add (derive 'x' "4x^3*y^2+2x") (derive 'x' "5y^4*x+5x^3*y^2")),

    test "DeriveMulti[0]" (derive 'x' (multi "3x" "2y"))                (add (multi (derive 'x' "3x") "2y") (multi "3x" (derive 'x' "2y"))),
    test "DeriveMulti[1]" (derive 'x' (multi "4x^3*y^2" "5y^4*x"))      (add (multi (derive 'x' "4x^3*y^2") "5y^4*x") (multi "4x^3*y^2" (derive 'x' "5y^4*x")))
    ]
    
runAllTests :: IO()
runAllTests = do 
    if all (==[]) testResults then putStrLn "All tests passed" else putStr $ concat testResults
