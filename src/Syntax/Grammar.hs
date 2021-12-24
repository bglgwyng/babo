{-# OPTIONS_GHC -w #-}
module Syntax.Grammar where

import Syntax.Tokens

import Data.List.NonEmpty (NonEmpty(..), toList, fromList)
import Syntax.AST
import Common
import qualified Syntax.Pattern as P
import Syntax.Pattern hiding (List, Literal, Tuple, Variable)
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.20.0

data HappyAbsSyn t10
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 (Source)
	| HappyAbsSyn5 (String)
	| HappyAbsSyn6 (TopLevelStatement)
	| HappyAbsSyn7 (Variant)
	| HappyAbsSyn8 ([Variant])
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 (Argument)
	| HappyAbsSyn12 ([Argument])
	| HappyAbsSyn14 ([Expression])
	| HappyAbsSyn15 (LocalName)
	| HappyAbsSyn16 (NonEmpty LocalName)
	| HappyAbsSyn18 (NonEmpty Argument)
	| HappyAbsSyn19 (NonEmpty String)
	| HappyAbsSyn20 (Either P.Implicit P.Pattern)
	| HappyAbsSyn21 (NonEmpty (Either P.Implicit P.Pattern))
	| HappyAbsSyn22 ([Pattern])
	| HappyAbsSyn23 (P.Pattern)
	| HappyAbsSyn26 (NonEmpty P.Pattern)
	| HappyAbsSyn27 (Case)
	| HappyAbsSyn28 ([Case])
	| HappyAbsSyn29 (Expression)
	| HappyAbsSyn33 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,543) ([0,0,56,0,0,0,56,0,0,0,0,0,0,0,16384,0,0,0,24576,0,0,0,24576,0,0,0,0,0,0,0,56,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,64,0,0,0,8448,0,0,8192,0,0,0,0,8192,0,0,0,8200,0,0,65472,1091,0,0,65472,1091,0,0,65472,1091,0,0,8192,0,0,0,0,8192,0,0,0,4096,0,0,0,128,0,0,0,0,0,0,16384,0,0,0,65472,1091,0,0,0,256,0,0,0,48,0,0,64576,1089,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,65472,1091,0,0,8192,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,324,0,0,65472,1219,0,0,65472,1091,0,0,0,16384,0,0,0,512,0,0,0,64,0,0,0,0,0,0,8192,0,0,0,65472,1091,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,65472,1091,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,16384,0,0,0,0,2048,0,0,0,4096,0,0,0,4224,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,68,0,0,0,272,0,0,0,0,0,0,8192,4,0,0,29696,1093,0,0,8192,4,0,0,0,8192,0,0,0,256,0,0,0,8,0,0,0,0,0,0,65472,1219,0,0,64576,1089,0,0,64576,1089,0,0,16384,0,0,0,0,512,0,0,0,32,0,0,0,48,0,0,0,8,0,0,0,0,0,0,65472,1091,0,0,29696,1093,0,0,65472,1091,0,0,0,0,0,0,29696,1093,0,0,0,0,0,0,0,16,0,0,0,16384,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,29696,1093,0,0,29696,3141,0,0,0,8192,0,0,64576,1089,0,0,29696,1093,0,0,0,0,0,0,0,0,0,0,65472,1091,0,0,65472,1091,0,0,0,0,0,0,0,0,0,0,65472,1091,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,512,0,0,0,0,0,0,65472,1091,0,0,0,4096,0,0,0,2048,0,0,0,0,0,0,0,128,0,0,0,4096,0,0,0,0,0,0,29696,1093,0,0,65472,1091,0,0,0,0,0,0,29696,1093,0,0,0,0,0,0,0,0,0,0,0,0,0,0,29696,1093,0,0,0,4096,0,0,0,512,0,0,0,4096,0,0,64576,1089,0,0,0,0,0,0,0,128,0,0,65472,1091,0,0,0,0,0,0,65472,1091,0,0,0,8,0,0,29696,1093,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,29696,1093,0,0,0,0,0,0,0,0,0,0,29696,1093,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,128,0,0,29696,1093,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,29696,1093,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Name","Statement","Variant","Variants","LocalName","LocalNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","BinaryExpression","Juxtaposition","Atom","IntegerLiteral","FloatLiteral","StringLiteral","data","decl","def","type","let","case","forall","int","float","string","lsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 64
        bit_end = (st Prelude.+ 1) Prelude.* 64
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..63]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (36) = happyShift action_3
action_0 (37) = happyShift action_4
action_0 (38) = happyShift action_5
action_0 (4) = happyGoto action_6
action_0 (6) = happyGoto action_7
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (36) = happyShift action_3
action_1 (37) = happyShift action_4
action_1 (38) = happyShift action_5
action_1 (6) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyFail (happyExpListPerState 2)

action_3 (47) = happyShift action_13
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (46) = happyShift action_10
action_4 (47) = happyShift action_11
action_4 (5) = happyGoto action_12
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (46) = happyShift action_10
action_5 (47) = happyShift action_11
action_5 (5) = happyGoto action_9
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (64) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (36) = happyShift action_3
action_7 (37) = happyShift action_4
action_7 (38) = happyShift action_5
action_7 (4) = happyGoto action_8
action_7 (6) = happyGoto action_7
action_7 _ = happyReduce_1

action_8 _ = happyReduce_2

action_9 (55) = happyShift action_15
action_9 (13) = happyGoto action_17
action_9 _ = happyReduce_21

action_10 _ = happyReduce_4

action_11 _ = happyReduce_3

action_12 (55) = happyShift action_15
action_12 (13) = happyGoto action_16
action_12 _ = happyReduce_21

action_13 (55) = happyShift action_15
action_13 (13) = happyGoto action_14
action_13 _ = happyReduce_21

action_14 (57) = happyShift action_26
action_14 (62) = happyShift action_27
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (46) = happyShift action_25
action_15 (9) = happyGoto action_21
action_15 (10) = happyGoto action_22
action_15 (11) = happyGoto action_23
action_15 (12) = happyGoto action_24
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (62) = happyShift action_20
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (52) = happyShift action_18
action_17 (62) = happyShift action_19
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (39) = happyShift action_35
action_18 (40) = happyShift action_36
action_18 (41) = happyShift action_37
action_18 (42) = happyShift action_38
action_18 (43) = happyShift action_39
action_18 (44) = happyShift action_40
action_18 (45) = happyShift action_41
action_18 (46) = happyShift action_42
action_18 (47) = happyShift action_43
action_18 (48) = happyShift action_44
action_18 (49) = happyShift action_45
action_18 (50) = happyShift action_46
action_18 (55) = happyShift action_47
action_18 (59) = happyShift action_48
action_18 (29) = happyGoto action_58
action_18 (30) = happyGoto action_29
action_18 (31) = happyGoto action_30
action_18 (32) = happyGoto action_31
action_18 (33) = happyGoto action_32
action_18 (34) = happyGoto action_33
action_18 (35) = happyGoto action_34
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (39) = happyShift action_35
action_19 (40) = happyShift action_36
action_19 (41) = happyShift action_37
action_19 (42) = happyShift action_38
action_19 (43) = happyShift action_39
action_19 (44) = happyShift action_40
action_19 (45) = happyShift action_41
action_19 (46) = happyShift action_42
action_19 (47) = happyShift action_43
action_19 (48) = happyShift action_44
action_19 (49) = happyShift action_45
action_19 (50) = happyShift action_46
action_19 (55) = happyShift action_47
action_19 (59) = happyShift action_48
action_19 (29) = happyGoto action_57
action_19 (30) = happyGoto action_29
action_19 (31) = happyGoto action_30
action_19 (32) = happyGoto action_31
action_19 (33) = happyGoto action_32
action_19 (34) = happyGoto action_33
action_19 (35) = happyGoto action_34
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (39) = happyShift action_35
action_20 (40) = happyShift action_36
action_20 (41) = happyShift action_37
action_20 (42) = happyShift action_38
action_20 (43) = happyShift action_39
action_20 (44) = happyShift action_40
action_20 (45) = happyShift action_41
action_20 (46) = happyShift action_42
action_20 (47) = happyShift action_43
action_20 (48) = happyShift action_44
action_20 (49) = happyShift action_45
action_20 (50) = happyShift action_46
action_20 (55) = happyShift action_47
action_20 (59) = happyShift action_48
action_20 (29) = happyGoto action_56
action_20 (30) = happyGoto action_29
action_20 (31) = happyGoto action_30
action_20 (32) = happyGoto action_31
action_20 (33) = happyGoto action_32
action_20 (34) = happyGoto action_33
action_20 (35) = happyGoto action_34
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (46) = happyShift action_25
action_21 (9) = happyGoto action_21
action_21 (10) = happyGoto action_55
action_21 _ = happyReduce_16

action_22 (62) = happyShift action_54
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (61) = happyShift action_53
action_23 _ = happyReduce_19

action_24 (56) = happyShift action_52
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_15

action_26 (47) = happyShift action_51
action_26 (7) = happyGoto action_49
action_26 (8) = happyGoto action_50
action_26 _ = happyReduce_12

action_27 (39) = happyShift action_35
action_27 (40) = happyShift action_36
action_27 (41) = happyShift action_37
action_27 (42) = happyShift action_38
action_27 (43) = happyShift action_39
action_27 (44) = happyShift action_40
action_27 (45) = happyShift action_41
action_27 (46) = happyShift action_42
action_27 (47) = happyShift action_43
action_27 (48) = happyShift action_44
action_27 (49) = happyShift action_45
action_27 (50) = happyShift action_46
action_27 (55) = happyShift action_47
action_27 (59) = happyShift action_48
action_27 (29) = happyGoto action_28
action_27 (30) = happyGoto action_29
action_27 (31) = happyGoto action_30
action_27 (32) = happyGoto action_31
action_27 (33) = happyGoto action_32
action_27 (34) = happyGoto action_33
action_27 (35) = happyGoto action_34
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (57) = happyShift action_84
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (53) = happyShift action_82
action_29 (54) = happyShift action_83
action_29 _ = happyReduce_66

action_30 (39) = happyShift action_35
action_30 (43) = happyShift action_39
action_30 (44) = happyShift action_40
action_30 (45) = happyShift action_41
action_30 (46) = happyShift action_42
action_30 (47) = happyShift action_43
action_30 (48) = happyShift action_44
action_30 (49) = happyShift action_45
action_30 (55) = happyShift action_81
action_30 (59) = happyShift action_48
action_30 (32) = happyGoto action_80
action_30 (33) = happyGoto action_32
action_30 (34) = happyGoto action_33
action_30 (35) = happyGoto action_34
action_30 _ = happyReduce_69

action_31 _ = happyReduce_72

action_32 _ = happyReduce_82

action_33 _ = happyReduce_83

action_34 _ = happyReduce_84

action_35 _ = happyReduce_81

action_36 (46) = happyShift action_79
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (39) = happyShift action_35
action_37 (40) = happyShift action_36
action_37 (41) = happyShift action_37
action_37 (42) = happyShift action_38
action_37 (43) = happyShift action_39
action_37 (44) = happyShift action_40
action_37 (45) = happyShift action_41
action_37 (46) = happyShift action_42
action_37 (47) = happyShift action_43
action_37 (48) = happyShift action_44
action_37 (49) = happyShift action_45
action_37 (50) = happyShift action_46
action_37 (55) = happyShift action_47
action_37 (59) = happyShift action_48
action_37 (29) = happyGoto action_78
action_37 (30) = happyGoto action_29
action_37 (31) = happyGoto action_30
action_37 (32) = happyGoto action_31
action_37 (33) = happyGoto action_32
action_37 (34) = happyGoto action_33
action_37 (35) = happyGoto action_34
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (46) = happyShift action_25
action_38 (51) = happyShift action_73
action_38 (9) = happyGoto action_69
action_38 (15) = happyGoto action_76
action_38 (16) = happyGoto action_77
action_38 _ = happyFail (happyExpListPerState 38)

action_39 _ = happyReduce_85

action_40 _ = happyReduce_86

action_41 _ = happyReduce_87

action_42 _ = happyReduce_77

action_43 _ = happyReduce_78

action_44 _ = happyReduce_79

action_45 _ = happyReduce_80

action_46 (46) = happyShift action_25
action_46 (51) = happyShift action_73
action_46 (55) = happyShift action_74
action_46 (57) = happyShift action_75
action_46 (9) = happyGoto action_69
action_46 (15) = happyGoto action_70
action_46 (17) = happyGoto action_71
action_46 (18) = happyGoto action_72
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (39) = happyShift action_35
action_47 (40) = happyShift action_36
action_47 (41) = happyShift action_37
action_47 (42) = happyShift action_38
action_47 (43) = happyShift action_39
action_47 (44) = happyShift action_40
action_47 (45) = happyShift action_41
action_47 (46) = happyShift action_42
action_47 (47) = happyShift action_43
action_47 (48) = happyShift action_44
action_47 (49) = happyShift action_45
action_47 (50) = happyShift action_46
action_47 (55) = happyShift action_47
action_47 (56) = happyShift action_68
action_47 (59) = happyShift action_48
action_47 (29) = happyGoto action_67
action_47 (30) = happyGoto action_29
action_47 (31) = happyGoto action_30
action_47 (32) = happyGoto action_31
action_47 (33) = happyGoto action_32
action_47 (34) = happyGoto action_33
action_47 (35) = happyGoto action_34
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (39) = happyShift action_35
action_48 (40) = happyShift action_36
action_48 (41) = happyShift action_37
action_48 (42) = happyShift action_38
action_48 (43) = happyShift action_39
action_48 (44) = happyShift action_40
action_48 (45) = happyShift action_41
action_48 (46) = happyShift action_42
action_48 (47) = happyShift action_43
action_48 (48) = happyShift action_44
action_48 (49) = happyShift action_45
action_48 (50) = happyShift action_46
action_48 (55) = happyShift action_47
action_48 (59) = happyShift action_48
action_48 (14) = happyGoto action_65
action_48 (29) = happyGoto action_66
action_48 (30) = happyGoto action_29
action_48 (31) = happyGoto action_30
action_48 (32) = happyGoto action_31
action_48 (33) = happyGoto action_32
action_48 (34) = happyGoto action_33
action_48 (35) = happyGoto action_34
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (63) = happyShift action_64
action_49 _ = happyReduce_13

action_50 (58) = happyShift action_63
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (55) = happyShift action_15
action_51 (13) = happyGoto action_62
action_51 _ = happyReduce_21

action_52 _ = happyReduce_22

action_53 (46) = happyShift action_25
action_53 (9) = happyGoto action_21
action_53 (10) = happyGoto action_22
action_53 (11) = happyGoto action_23
action_53 (12) = happyGoto action_61
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (39) = happyShift action_35
action_54 (40) = happyShift action_36
action_54 (41) = happyShift action_37
action_54 (42) = happyShift action_38
action_54 (43) = happyShift action_39
action_54 (44) = happyShift action_40
action_54 (45) = happyShift action_41
action_54 (46) = happyShift action_42
action_54 (47) = happyShift action_43
action_54 (48) = happyShift action_44
action_54 (49) = happyShift action_45
action_54 (50) = happyShift action_46
action_54 (55) = happyShift action_47
action_54 (59) = happyShift action_48
action_54 (29) = happyGoto action_60
action_54 (30) = happyGoto action_29
action_54 (31) = happyGoto action_30
action_54 (32) = happyGoto action_31
action_54 (33) = happyGoto action_32
action_54 (34) = happyGoto action_33
action_54 (35) = happyGoto action_34
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_17

action_56 _ = happyReduce_7

action_57 (52) = happyShift action_59
action_57 _ = happyFail (happyExpListPerState 57)

action_58 _ = happyReduce_8

action_59 (39) = happyShift action_35
action_59 (40) = happyShift action_36
action_59 (41) = happyShift action_37
action_59 (42) = happyShift action_38
action_59 (43) = happyShift action_39
action_59 (44) = happyShift action_40
action_59 (45) = happyShift action_41
action_59 (46) = happyShift action_42
action_59 (47) = happyShift action_43
action_59 (48) = happyShift action_44
action_59 (49) = happyShift action_45
action_59 (50) = happyShift action_46
action_59 (55) = happyShift action_47
action_59 (59) = happyShift action_48
action_59 (29) = happyGoto action_117
action_59 (30) = happyGoto action_29
action_59 (31) = happyGoto action_30
action_59 (32) = happyGoto action_31
action_59 (33) = happyGoto action_32
action_59 (34) = happyGoto action_33
action_59 (35) = happyGoto action_34
action_59 _ = happyFail (happyExpListPerState 59)

action_60 _ = happyReduce_18

action_61 _ = happyReduce_20

action_62 (62) = happyShift action_116
action_62 _ = happyReduce_10

action_63 _ = happyReduce_5

action_64 (47) = happyShift action_51
action_64 (7) = happyGoto action_49
action_64 (8) = happyGoto action_115
action_64 _ = happyReduce_12

action_65 (60) = happyShift action_114
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (61) = happyShift action_113
action_66 _ = happyReduce_23

action_67 (56) = happyShift action_111
action_67 (61) = happyShift action_112
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_74

action_69 _ = happyReduce_25

action_70 _ = happyReduce_29

action_71 (46) = happyShift action_25
action_71 (51) = happyShift action_73
action_71 (55) = happyShift action_74
action_71 (9) = happyGoto action_69
action_71 (15) = happyGoto action_70
action_71 (17) = happyGoto action_71
action_71 (18) = happyGoto action_110
action_71 _ = happyReduce_31

action_72 (53) = happyShift action_108
action_72 (57) = happyShift action_109
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_26

action_74 (46) = happyShift action_25
action_74 (51) = happyShift action_73
action_74 (9) = happyGoto action_69
action_74 (15) = happyGoto action_76
action_74 (16) = happyGoto action_107
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (43) = happyShift action_39
action_75 (45) = happyShift action_41
action_75 (46) = happyShift action_101
action_75 (47) = happyShift action_102
action_75 (49) = happyShift action_103
action_75 (51) = happyShift action_104
action_75 (55) = happyShift action_105
action_75 (59) = happyShift action_106
action_75 (19) = happyGoto action_94
action_75 (23) = happyGoto action_95
action_75 (25) = happyGoto action_96
action_75 (27) = happyGoto action_97
action_75 (28) = happyGoto action_98
action_75 (33) = happyGoto action_99
action_75 (35) = happyGoto action_100
action_75 _ = happyReduce_57

action_76 (46) = happyShift action_25
action_76 (51) = happyShift action_73
action_76 (9) = happyGoto action_69
action_76 (15) = happyGoto action_76
action_76 (16) = happyGoto action_93
action_76 _ = happyReduce_27

action_77 (62) = happyShift action_92
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (57) = happyShift action_91
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (52) = happyShift action_90
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_70

action_81 (39) = happyShift action_35
action_81 (40) = happyShift action_36
action_81 (41) = happyShift action_37
action_81 (42) = happyShift action_38
action_81 (43) = happyShift action_39
action_81 (44) = happyShift action_40
action_81 (45) = happyShift action_41
action_81 (46) = happyShift action_89
action_81 (47) = happyShift action_43
action_81 (48) = happyShift action_44
action_81 (49) = happyShift action_45
action_81 (50) = happyShift action_46
action_81 (55) = happyShift action_47
action_81 (56) = happyShift action_68
action_81 (59) = happyShift action_48
action_81 (9) = happyGoto action_88
action_81 (29) = happyGoto action_67
action_81 (30) = happyGoto action_29
action_81 (31) = happyGoto action_30
action_81 (32) = happyGoto action_31
action_81 (33) = happyGoto action_32
action_81 (34) = happyGoto action_33
action_81 (35) = happyGoto action_34
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (39) = happyShift action_35
action_82 (43) = happyShift action_39
action_82 (44) = happyShift action_40
action_82 (45) = happyShift action_41
action_82 (46) = happyShift action_42
action_82 (47) = happyShift action_43
action_82 (48) = happyShift action_44
action_82 (49) = happyShift action_45
action_82 (55) = happyShift action_47
action_82 (59) = happyShift action_48
action_82 (30) = happyGoto action_87
action_82 (31) = happyGoto action_30
action_82 (32) = happyGoto action_31
action_82 (33) = happyGoto action_32
action_82 (34) = happyGoto action_33
action_82 (35) = happyGoto action_34
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (39) = happyShift action_35
action_83 (43) = happyShift action_39
action_83 (44) = happyShift action_40
action_83 (45) = happyShift action_41
action_83 (46) = happyShift action_42
action_83 (47) = happyShift action_43
action_83 (48) = happyShift action_44
action_83 (49) = happyShift action_45
action_83 (55) = happyShift action_47
action_83 (59) = happyShift action_48
action_83 (30) = happyGoto action_86
action_83 (31) = happyGoto action_30
action_83 (32) = happyGoto action_31
action_83 (33) = happyGoto action_32
action_83 (34) = happyGoto action_33
action_83 (35) = happyGoto action_34
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (47) = happyShift action_51
action_84 (7) = happyGoto action_49
action_84 (8) = happyGoto action_85
action_84 _ = happyReduce_12

action_85 (58) = happyShift action_142
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (54) = happyShift action_83
action_86 _ = happyReduce_68

action_87 (53) = happyShift action_82
action_87 (54) = happyShift action_83
action_87 _ = happyReduce_67

action_88 (52) = happyShift action_141
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (52) = happyReduce_15
action_89 _ = happyReduce_77

action_90 (39) = happyShift action_35
action_90 (40) = happyShift action_36
action_90 (41) = happyShift action_37
action_90 (42) = happyShift action_38
action_90 (43) = happyShift action_39
action_90 (44) = happyShift action_40
action_90 (45) = happyShift action_41
action_90 (46) = happyShift action_42
action_90 (47) = happyShift action_43
action_90 (48) = happyShift action_44
action_90 (49) = happyShift action_45
action_90 (50) = happyShift action_46
action_90 (55) = happyShift action_47
action_90 (59) = happyShift action_48
action_90 (29) = happyGoto action_140
action_90 (30) = happyGoto action_29
action_90 (31) = happyGoto action_30
action_90 (32) = happyGoto action_31
action_90 (33) = happyGoto action_32
action_90 (34) = happyGoto action_33
action_90 (35) = happyGoto action_34
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (43) = happyShift action_39
action_91 (45) = happyShift action_41
action_91 (46) = happyShift action_101
action_91 (47) = happyShift action_102
action_91 (49) = happyShift action_103
action_91 (51) = happyShift action_104
action_91 (55) = happyShift action_105
action_91 (59) = happyShift action_106
action_91 (19) = happyGoto action_94
action_91 (23) = happyGoto action_95
action_91 (25) = happyGoto action_96
action_91 (27) = happyGoto action_97
action_91 (28) = happyGoto action_139
action_91 (33) = happyGoto action_99
action_91 (35) = happyGoto action_100
action_91 _ = happyReduce_57

action_92 (39) = happyShift action_35
action_92 (40) = happyShift action_36
action_92 (41) = happyShift action_37
action_92 (42) = happyShift action_38
action_92 (43) = happyShift action_39
action_92 (44) = happyShift action_40
action_92 (45) = happyShift action_41
action_92 (46) = happyShift action_42
action_92 (47) = happyShift action_43
action_92 (48) = happyShift action_44
action_92 (49) = happyShift action_45
action_92 (50) = happyShift action_46
action_92 (55) = happyShift action_47
action_92 (59) = happyShift action_48
action_92 (29) = happyGoto action_138
action_92 (30) = happyGoto action_29
action_92 (31) = happyGoto action_30
action_92 (32) = happyGoto action_31
action_92 (33) = happyGoto action_32
action_92 (34) = happyGoto action_33
action_92 (35) = happyGoto action_34
action_92 _ = happyFail (happyExpListPerState 92)

action_93 _ = happyReduce_28

action_94 (43) = happyShift action_39
action_94 (45) = happyShift action_41
action_94 (46) = happyShift action_101
action_94 (47) = happyShift action_102
action_94 (49) = happyShift action_103
action_94 (51) = happyShift action_104
action_94 (55) = happyShift action_137
action_94 (59) = happyShift action_106
action_94 (19) = happyGoto action_132
action_94 (20) = happyGoto action_133
action_94 (21) = happyGoto action_134
action_94 (23) = happyGoto action_135
action_94 (24) = happyGoto action_136
action_94 (33) = happyGoto action_99
action_94 (35) = happyGoto action_100
action_94 _ = happyReduce_42

action_95 _ = happyReduce_52

action_96 (53) = happyShift action_131
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (63) = happyShift action_130
action_97 _ = happyReduce_58

action_98 (58) = happyShift action_129
action_98 _ = happyFail (happyExpListPerState 98)

action_99 _ = happyReduce_47

action_100 _ = happyReduce_48

action_101 _ = happyReduce_43

action_102 _ = happyReduce_33

action_103 _ = happyReduce_34

action_104 _ = happyReduce_49

action_105 (43) = happyShift action_39
action_105 (45) = happyShift action_41
action_105 (46) = happyShift action_101
action_105 (47) = happyShift action_102
action_105 (49) = happyShift action_103
action_105 (51) = happyShift action_104
action_105 (55) = happyShift action_105
action_105 (59) = happyShift action_106
action_105 (19) = happyGoto action_94
action_105 (22) = happyGoto action_127
action_105 (23) = happyGoto action_95
action_105 (25) = happyGoto action_128
action_105 (33) = happyGoto action_99
action_105 (35) = happyGoto action_100
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (43) = happyShift action_39
action_106 (45) = happyShift action_41
action_106 (46) = happyShift action_101
action_106 (47) = happyShift action_102
action_106 (49) = happyShift action_103
action_106 (51) = happyShift action_104
action_106 (55) = happyShift action_105
action_106 (59) = happyShift action_106
action_106 (60) = happyShift action_126
action_106 (19) = happyGoto action_94
action_106 (23) = happyGoto action_95
action_106 (25) = happyGoto action_124
action_106 (26) = happyGoto action_125
action_106 (33) = happyGoto action_99
action_106 (35) = happyGoto action_100
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (62) = happyShift action_123
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (39) = happyShift action_35
action_108 (43) = happyShift action_39
action_108 (44) = happyShift action_40
action_108 (45) = happyShift action_41
action_108 (46) = happyShift action_42
action_108 (47) = happyShift action_43
action_108 (48) = happyShift action_44
action_108 (49) = happyShift action_45
action_108 (55) = happyShift action_47
action_108 (59) = happyShift action_48
action_108 (32) = happyGoto action_122
action_108 (33) = happyGoto action_32
action_108 (34) = happyGoto action_33
action_108 (35) = happyGoto action_34
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (43) = happyShift action_39
action_109 (45) = happyShift action_41
action_109 (46) = happyShift action_101
action_109 (47) = happyShift action_102
action_109 (49) = happyShift action_103
action_109 (51) = happyShift action_104
action_109 (55) = happyShift action_105
action_109 (59) = happyShift action_106
action_109 (19) = happyGoto action_94
action_109 (23) = happyGoto action_95
action_109 (25) = happyGoto action_96
action_109 (27) = happyGoto action_97
action_109 (28) = happyGoto action_121
action_109 (33) = happyGoto action_99
action_109 (35) = happyGoto action_100
action_109 _ = happyReduce_57

action_110 _ = happyReduce_32

action_111 _ = happyReduce_73

action_112 (39) = happyShift action_35
action_112 (40) = happyShift action_36
action_112 (41) = happyShift action_37
action_112 (42) = happyShift action_38
action_112 (43) = happyShift action_39
action_112 (44) = happyShift action_40
action_112 (45) = happyShift action_41
action_112 (46) = happyShift action_42
action_112 (47) = happyShift action_43
action_112 (48) = happyShift action_44
action_112 (49) = happyShift action_45
action_112 (50) = happyShift action_46
action_112 (55) = happyShift action_47
action_112 (59) = happyShift action_48
action_112 (14) = happyGoto action_120
action_112 (29) = happyGoto action_66
action_112 (30) = happyGoto action_29
action_112 (31) = happyGoto action_30
action_112 (32) = happyGoto action_31
action_112 (33) = happyGoto action_32
action_112 (34) = happyGoto action_33
action_112 (35) = happyGoto action_34
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (39) = happyShift action_35
action_113 (40) = happyShift action_36
action_113 (41) = happyShift action_37
action_113 (42) = happyShift action_38
action_113 (43) = happyShift action_39
action_113 (44) = happyShift action_40
action_113 (45) = happyShift action_41
action_113 (46) = happyShift action_42
action_113 (47) = happyShift action_43
action_113 (48) = happyShift action_44
action_113 (49) = happyShift action_45
action_113 (50) = happyShift action_46
action_113 (55) = happyShift action_47
action_113 (59) = happyShift action_48
action_113 (14) = happyGoto action_119
action_113 (29) = happyGoto action_66
action_113 (30) = happyGoto action_29
action_113 (31) = happyGoto action_30
action_113 (32) = happyGoto action_31
action_113 (33) = happyGoto action_32
action_113 (34) = happyGoto action_33
action_113 (35) = happyGoto action_34
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_76

action_115 _ = happyReduce_14

action_116 (39) = happyShift action_35
action_116 (40) = happyShift action_36
action_116 (41) = happyShift action_37
action_116 (42) = happyShift action_38
action_116 (43) = happyShift action_39
action_116 (44) = happyShift action_40
action_116 (45) = happyShift action_41
action_116 (46) = happyShift action_42
action_116 (47) = happyShift action_43
action_116 (48) = happyShift action_44
action_116 (49) = happyShift action_45
action_116 (50) = happyShift action_46
action_116 (55) = happyShift action_47
action_116 (59) = happyShift action_48
action_116 (29) = happyGoto action_118
action_116 (30) = happyGoto action_29
action_116 (31) = happyGoto action_30
action_116 (32) = happyGoto action_31
action_116 (33) = happyGoto action_32
action_116 (34) = happyGoto action_33
action_116 (35) = happyGoto action_34
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_9

action_118 _ = happyReduce_11

action_119 _ = happyReduce_24

action_120 (56) = happyShift action_159
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (58) = happyShift action_158
action_121 _ = happyFail (happyExpListPerState 121)

action_122 _ = happyReduce_63

action_123 (39) = happyShift action_35
action_123 (40) = happyShift action_36
action_123 (41) = happyShift action_37
action_123 (42) = happyShift action_38
action_123 (43) = happyShift action_39
action_123 (44) = happyShift action_40
action_123 (45) = happyShift action_41
action_123 (46) = happyShift action_42
action_123 (47) = happyShift action_43
action_123 (48) = happyShift action_44
action_123 (49) = happyShift action_45
action_123 (50) = happyShift action_46
action_123 (55) = happyShift action_47
action_123 (59) = happyShift action_48
action_123 (29) = happyGoto action_157
action_123 (30) = happyGoto action_29
action_123 (31) = happyGoto action_30
action_123 (32) = happyGoto action_31
action_123 (33) = happyGoto action_32
action_123 (34) = happyGoto action_33
action_123 (35) = happyGoto action_34
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (61) = happyShift action_156
action_124 _ = happyReduce_54

action_125 (60) = happyShift action_155
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_45

action_127 (56) = happyShift action_154
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (61) = happyShift action_153
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_65

action_130 (43) = happyShift action_39
action_130 (45) = happyShift action_41
action_130 (46) = happyShift action_101
action_130 (47) = happyShift action_102
action_130 (49) = happyShift action_103
action_130 (51) = happyShift action_104
action_130 (55) = happyShift action_105
action_130 (59) = happyShift action_106
action_130 (19) = happyGoto action_94
action_130 (23) = happyGoto action_95
action_130 (25) = happyGoto action_96
action_130 (27) = happyGoto action_97
action_130 (28) = happyGoto action_152
action_130 (33) = happyGoto action_99
action_130 (35) = happyGoto action_100
action_130 _ = happyReduce_57

action_131 (39) = happyShift action_35
action_131 (40) = happyShift action_36
action_131 (41) = happyShift action_37
action_131 (42) = happyShift action_38
action_131 (43) = happyShift action_39
action_131 (44) = happyShift action_40
action_131 (45) = happyShift action_41
action_131 (46) = happyShift action_42
action_131 (47) = happyShift action_43
action_131 (48) = happyShift action_44
action_131 (49) = happyShift action_45
action_131 (50) = happyShift action_46
action_131 (55) = happyShift action_47
action_131 (59) = happyShift action_48
action_131 (29) = happyGoto action_151
action_131 (30) = happyGoto action_29
action_131 (31) = happyGoto action_30
action_131 (32) = happyGoto action_31
action_131 (33) = happyGoto action_32
action_131 (34) = happyGoto action_33
action_131 (35) = happyGoto action_34
action_131 _ = happyFail (happyExpListPerState 131)

action_132 _ = happyReduce_42

action_133 (43) = happyShift action_39
action_133 (45) = happyShift action_41
action_133 (46) = happyShift action_101
action_133 (47) = happyShift action_102
action_133 (49) = happyShift action_103
action_133 (51) = happyShift action_104
action_133 (55) = happyShift action_137
action_133 (59) = happyShift action_106
action_133 (19) = happyGoto action_132
action_133 (20) = happyGoto action_133
action_133 (21) = happyGoto action_150
action_133 (23) = happyGoto action_135
action_133 (24) = happyGoto action_136
action_133 (33) = happyGoto action_99
action_133 (35) = happyGoto action_100
action_133 _ = happyReduce_38

action_134 _ = happyReduce_53

action_135 _ = happyReduce_50

action_136 _ = happyReduce_35

action_137 (43) = happyShift action_39
action_137 (45) = happyShift action_41
action_137 (46) = happyShift action_149
action_137 (47) = happyShift action_102
action_137 (49) = happyShift action_103
action_137 (51) = happyShift action_104
action_137 (55) = happyShift action_105
action_137 (59) = happyShift action_106
action_137 (9) = happyGoto action_147
action_137 (19) = happyGoto action_148
action_137 (22) = happyGoto action_127
action_137 (23) = happyGoto action_95
action_137 (25) = happyGoto action_128
action_137 (33) = happyGoto action_99
action_137 (35) = happyGoto action_100
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (61) = happyShift action_146
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (58) = happyShift action_145
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (61) = happyShift action_144
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (39) = happyShift action_35
action_141 (43) = happyShift action_39
action_141 (44) = happyShift action_40
action_141 (45) = happyShift action_41
action_141 (46) = happyShift action_42
action_141 (47) = happyShift action_43
action_141 (48) = happyShift action_44
action_141 (49) = happyShift action_45
action_141 (55) = happyShift action_47
action_141 (59) = happyShift action_48
action_141 (32) = happyGoto action_143
action_141 (33) = happyGoto action_32
action_141 (34) = happyGoto action_33
action_141 (35) = happyGoto action_34
action_141 _ = happyFail (happyExpListPerState 141)

action_142 _ = happyReduce_6

action_143 (56) = happyShift action_169
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (39) = happyShift action_35
action_144 (40) = happyShift action_36
action_144 (41) = happyShift action_37
action_144 (42) = happyShift action_38
action_144 (43) = happyShift action_39
action_144 (44) = happyShift action_40
action_144 (45) = happyShift action_41
action_144 (46) = happyShift action_42
action_144 (47) = happyShift action_43
action_144 (48) = happyShift action_44
action_144 (49) = happyShift action_45
action_144 (50) = happyShift action_46
action_144 (55) = happyShift action_47
action_144 (59) = happyShift action_48
action_144 (29) = happyGoto action_168
action_144 (30) = happyGoto action_29
action_144 (31) = happyGoto action_30
action_144 (32) = happyGoto action_31
action_144 (33) = happyGoto action_32
action_144 (34) = happyGoto action_33
action_144 (35) = happyGoto action_34
action_144 _ = happyFail (happyExpListPerState 144)

action_145 _ = happyReduce_62

action_146 (39) = happyShift action_35
action_146 (40) = happyShift action_36
action_146 (41) = happyShift action_37
action_146 (42) = happyShift action_38
action_146 (43) = happyShift action_39
action_146 (44) = happyShift action_40
action_146 (45) = happyShift action_41
action_146 (46) = happyShift action_42
action_146 (47) = happyShift action_43
action_146 (48) = happyShift action_44
action_146 (49) = happyShift action_45
action_146 (50) = happyShift action_46
action_146 (55) = happyShift action_47
action_146 (59) = happyShift action_48
action_146 (29) = happyGoto action_167
action_146 (30) = happyGoto action_29
action_146 (31) = happyGoto action_30
action_146 (32) = happyGoto action_31
action_146 (33) = happyGoto action_32
action_146 (34) = happyGoto action_33
action_146 (35) = happyGoto action_34
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (52) = happyShift action_166
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (43) = happyShift action_39
action_148 (45) = happyShift action_41
action_148 (46) = happyShift action_101
action_148 (47) = happyShift action_102
action_148 (49) = happyShift action_103
action_148 (51) = happyShift action_104
action_148 (55) = happyShift action_137
action_148 (59) = happyShift action_106
action_148 (19) = happyGoto action_132
action_148 (20) = happyGoto action_133
action_148 (21) = happyGoto action_165
action_148 (23) = happyGoto action_135
action_148 (24) = happyGoto action_136
action_148 (33) = happyGoto action_99
action_148 (35) = happyGoto action_100
action_148 _ = happyReduce_42

action_149 (56) = happyShift action_164
action_149 (61) = happyReduce_43
action_149 _ = happyReduce_15

action_150 _ = happyReduce_39

action_151 _ = happyReduce_56

action_152 _ = happyReduce_59

action_153 (43) = happyShift action_39
action_153 (45) = happyShift action_41
action_153 (46) = happyShift action_101
action_153 (47) = happyShift action_102
action_153 (49) = happyShift action_103
action_153 (51) = happyShift action_104
action_153 (55) = happyShift action_105
action_153 (59) = happyShift action_106
action_153 (19) = happyGoto action_94
action_153 (22) = happyGoto action_162
action_153 (23) = happyGoto action_95
action_153 (25) = happyGoto action_163
action_153 (33) = happyGoto action_99
action_153 (35) = happyGoto action_100
action_153 _ = happyFail (happyExpListPerState 153)

action_154 _ = happyReduce_44

action_155 _ = happyReduce_46

action_156 (43) = happyShift action_39
action_156 (45) = happyShift action_41
action_156 (46) = happyShift action_101
action_156 (47) = happyShift action_102
action_156 (49) = happyShift action_103
action_156 (51) = happyShift action_104
action_156 (55) = happyShift action_105
action_156 (59) = happyShift action_106
action_156 (19) = happyGoto action_94
action_156 (23) = happyGoto action_95
action_156 (25) = happyGoto action_124
action_156 (26) = happyGoto action_161
action_156 (33) = happyGoto action_99
action_156 (35) = happyGoto action_100
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (56) = happyShift action_160
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_64

action_159 _ = happyReduce_75

action_160 _ = happyReduce_30

action_161 _ = happyReduce_55

action_162 _ = happyReduce_41

action_163 (61) = happyShift action_153
action_163 _ = happyReduce_40

action_164 _ = happyReduce_37

action_165 (56) = happyShift action_172
action_165 _ = happyReduce_53

action_166 (43) = happyShift action_39
action_166 (45) = happyShift action_41
action_166 (46) = happyShift action_101
action_166 (47) = happyShift action_102
action_166 (49) = happyShift action_103
action_166 (51) = happyShift action_104
action_166 (55) = happyShift action_171
action_166 (59) = happyShift action_106
action_166 (19) = happyGoto action_132
action_166 (23) = happyGoto action_135
action_166 (24) = happyGoto action_170
action_166 (33) = happyGoto action_99
action_166 (35) = happyGoto action_100
action_166 _ = happyFail (happyExpListPerState 166)

action_167 _ = happyReduce_61

action_168 _ = happyReduce_60

action_169 _ = happyReduce_71

action_170 (56) = happyShift action_173
action_170 _ = happyFail (happyExpListPerState 170)

action_171 (43) = happyShift action_39
action_171 (45) = happyShift action_41
action_171 (46) = happyShift action_101
action_171 (47) = happyShift action_102
action_171 (49) = happyShift action_103
action_171 (51) = happyShift action_104
action_171 (55) = happyShift action_105
action_171 (59) = happyShift action_106
action_171 (19) = happyGoto action_148
action_171 (22) = happyGoto action_127
action_171 (23) = happyGoto action_95
action_171 (25) = happyGoto action_128
action_171 (33) = happyGoto action_99
action_171 (35) = happyGoto action_100
action_171 _ = happyFail (happyExpListPerState 171)

action_172 _ = happyReduce_51

action_173 _ = happyReduce_36

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn4
		 (Source [happy_var_1]
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn4
		 (Source (happy_var_1 : statements happy_var_2)
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 6 6 happyReduction_5
happyReduction_5 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataDeclaration happy_var_2 happy_var_3 Nothing happy_var_5 []
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 8 6 happyReduction_6
happyReduction_6 (_ `HappyStk`
	(HappyAbsSyn8  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataDeclaration happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 5 6 happyReduction_7
happyReduction_7 ((HappyAbsSyn29  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Declaration happy_var_2 happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 5 6 happyReduction_8
happyReduction_8 ((HappyAbsSyn29  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Definition happy_var_2 happy_var_3 Nothing happy_var_5 []
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 7 6 happyReduction_9
happyReduction_9 ((HappyAbsSyn29  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Definition happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_2  7 happyReduction_10
happyReduction_10 (HappyAbsSyn12  happy_var_2)
	(HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn7
		 (Variant [] happy_var_1 happy_var_2 Nothing
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happyReduce 4 7 happyReduction_11
happyReduction_11 ((HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Variant [] happy_var_1 happy_var_2 (Just happy_var_4)
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_0  8 happyReduction_12
happyReduction_12  =  HappyAbsSyn8
		 ([]
	)

happyReduce_13 = happySpecReduce_1  8 happyReduction_13
happyReduction_13 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  8 happyReduction_14
happyReduction_14 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 : happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  9 happyReduction_15
happyReduction_15 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  10 happyReduction_16
happyReduction_16 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 :| []
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_2  10 happyReduction_17
happyReduction_17 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_17 _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  11 happyReduction_18
happyReduction_18 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1, Just happy_var_3, [])
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  12 happyReduction_19
happyReduction_19 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  12 happyReduction_20
happyReduction_20 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1 : happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_0  13 happyReduction_21
happyReduction_21  =  HappyAbsSyn12
		 ([]
	)

happyReduce_22 = happySpecReduce_3  13 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  14 happyReduction_23
happyReduction_23 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  14 happyReduction_24
happyReduction_24 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 : happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  15 happyReduction_25
happyReduction_25 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  15 happyReduction_26
happyReduction_26 _
	 =  HappyAbsSyn15
		 ("_"
	)

happyReduce_27 = happySpecReduce_1  16 happyReduction_27
happyReduction_27 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1 :| []
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  16 happyReduction_28
happyReduction_28 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  17 happyReduction_29
happyReduction_29 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1 :| [], Nothing, [])
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happyReduce 5 17 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 ((happy_var_2, Just happy_var_4, [])
	) `HappyStk` happyRest

happyReduce_31 = happySpecReduce_1  18 happyReduction_31
happyReduction_31 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1 :| []
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  18 happyReduction_32
happyReduction_32 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  19 happyReduction_33
happyReduction_33 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn19
		 (happy_var_1 :| []
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  19 happyReduction_34
happyReduction_34 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  20 happyReduction_35
happyReduction_35 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn20
		 (Right happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happyReduce 5 20 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn23  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (Left (P.Implicit happy_var_2 happy_var_4)
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_3  20 happyReduction_37
happyReduction_37 _
	(HappyTerminal (TokenLSym happy_var_2))
	_
	 =  HappyAbsSyn20
		 (Left (P.PunnedImplicit happy_var_2)
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_1  21 happyReduction_38
happyReduction_38 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1 :| []
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  21 happyReduction_39
happyReduction_39 (HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  22 happyReduction_40
happyReduction_40 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 ([happy_var_1, happy_var_3]
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  22 happyReduction_41
happyReduction_41 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 : happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  23 happyReduction_42
happyReduction_42 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn23
		 (P.Data happy_var_1 []
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  23 happyReduction_43
happyReduction_43 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn23
		 (P.Variable happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  23 happyReduction_44
happyReduction_44 _
	(HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (P.Tuple happy_var_2
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  23 happyReduction_45
happyReduction_45 _
	_
	 =  HappyAbsSyn23
		 (P.List []
	)

happyReduce_46 = happySpecReduce_3  23 happyReduction_46
happyReduction_46 _
	(HappyAbsSyn26  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (P.List (toList happy_var_2)
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  23 happyReduction_47
happyReduction_47 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn23
		 (P.Literal happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  23 happyReduction_48
happyReduction_48 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn23
		 (P.Literal happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  23 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn23
		 (Wildcard
	)

happyReduce_50 = happySpecReduce_1  24 happyReduction_50
happyReduction_50 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happyReduce 4 24 happyReduction_51
happyReduction_51 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn23
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_52 = happySpecReduce_1  25 happyReduction_52
happyReduction_52 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  25 happyReduction_53
happyReduction_53 (HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn23
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_53 _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  26 happyReduction_54
happyReduction_54 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :| []
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  26 happyReduction_55
happyReduction_55 (HappyAbsSyn26  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn26
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  27 happyReduction_56
happyReduction_56 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn27
		 ((happy_var_1, happy_var_3)
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_0  28 happyReduction_57
happyReduction_57  =  HappyAbsSyn28
		 ([]
	)

happyReduce_58 = happySpecReduce_1  28 happyReduction_58
happyReduction_58 (HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 ([happy_var_1]
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_3  28 happyReduction_59
happyReduction_59 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1 : happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happyReduce 6 29 happyReduction_60
happyReduction_60 ((HappyAbsSyn29  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_61 = happyReduce 6 29 happyReduction_61
happyReduction_61 ((HappyAbsSyn29  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (ForAll happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_62 = happyReduce 5 29 happyReduction_62
happyReduction_62 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_63 = happyReduce 4 29 happyReduction_63
happyReduction_63 ((HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_64 = happyReduce 5 29 happyReduction_64
happyReduction_64 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_65 = happyReduce 4 29 happyReduction_65
happyReduction_65 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_1  29 happyReduction_66
happyReduction_66 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  30 happyReduction_67
happyReduction_67 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  30 happyReduction_68
happyReduction_68 (HappyAbsSyn29  happy_var_3)
	(HappyTerminal (TokenInfixOp happy_var_2))
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (Infix happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_1  30 happyReduction_69
happyReduction_69 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_69 _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_2  31 happyReduction_70
happyReduction_70 (HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (Application happy_var_1 ((Nothing, happy_var_2) :| [])
	)
happyReduction_70 _ _  = notHappyAtAll 

happyReduce_71 = happyReduce 6 31 happyReduction_71
happyReduction_71 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (Application happy_var_1 ((Just happy_var_3, happy_var_5) :| [])
	) `HappyStk` happyRest

happyReduce_72 = happySpecReduce_1  31 happyReduction_72
happyReduction_72 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  32 happyReduction_73
happyReduction_73 _
	(HappyAbsSyn29  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (Parenthesized happy_var_2
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_2  32 happyReduction_74
happyReduction_74 _
	_
	 =  HappyAbsSyn29
		 (Literal UnitLiteral
	)

happyReduce_75 = happyReduce 5 32 happyReduction_75
happyReduction_75 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_76 = happySpecReduce_3  32 happyReduction_76
happyReduction_76 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (List happy_var_2
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  32 happyReduction_77
happyReduction_77 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn29
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  32 happyReduction_78
happyReduction_78 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn29
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  32 happyReduction_79
happyReduction_79 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn29
		 (Identifier happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  32 happyReduction_80
happyReduction_80 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn29
		 (Identifier happy_var_1
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  32 happyReduction_81
happyReduction_81 _
	 =  HappyAbsSyn29
		 (Type
	)

happyReduce_82 = happySpecReduce_1  32 happyReduction_82
happyReduction_82 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn29
		 (Literal happy_var_1
	)
happyReduction_82 _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  32 happyReduction_83
happyReduction_83 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn29
		 (Literal happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  32 happyReduction_84
happyReduction_84 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn29
		 (Literal happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  33 happyReduction_85
happyReduction_85 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn33
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  34 happyReduction_86
happyReduction_86 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn33
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  35 happyReduction_87
happyReduction_87 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn33
		 (StringLiteral happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 64 64 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenDatatype -> cont 36;
	TokenDeclare -> cont 37;
	TokenDefine -> cont 38;
	TokenType -> cont 39;
	TokenLet -> cont 40;
	TokenCase -> cont 41;
	TokenForAll -> cont 42;
	TokenInt happy_dollar_dollar -> cont 43;
	TokenFloat happy_dollar_dollar -> cont 44;
	TokenString happy_dollar_dollar -> cont 45;
	TokenLSym happy_dollar_dollar -> cont 46;
	TokenUSym happy_dollar_dollar -> cont 47;
	TokenLSymQ happy_dollar_dollar -> cont 48;
	TokenUSymQ happy_dollar_dollar -> cont 49;
	TokenBackslash -> cont 50;
	TokenUnderscore -> cont 51;
	TokenEq -> cont 52;
	TokenArrow -> cont 53;
	TokenInfixOp happy_dollar_dollar -> cont 54;
	TokenLParen -> cont 55;
	TokenRParen -> cont 56;
	TokenLBrace -> cont 57;
	TokenRBrace -> cont 58;
	TokenLBracket -> cont 59;
	TokenRBracket -> cont 60;
	TokenComma -> cont 61;
	TokenColon -> cont 62;
	TokenSemicolon -> cont 63;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 64 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Prelude.Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Prelude.Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (Prelude.>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (Prelude.return)
happyThen1 m k tks = (Prelude.>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (Prelude.return) a
happyError' :: () => ([(Token)], [Prelude.String]) -> HappyIdentity a
happyError' = HappyIdentity Prelude.. (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"

-- ' prevents syntax highlighting
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Prelude.Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x Prelude.< y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `Prelude.div` 16)) (bit `Prelude.mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Prelude.Int ->                    -- token number
         Prelude.Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k Prelude.- ((1) :: Prelude.Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Prelude.Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n Prelude.- ((1) :: Prelude.Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n Prelude.- ((1)::Prelude.Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = Prelude.error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `Prelude.seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
