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
	| HappyAbsSyn17 (NonEmpty LocalName)
	| HappyAbsSyn19 (NonEmpty Argument)
	| HappyAbsSyn20 (QName)
	| HappyAbsSyn21 (Either P.Implicit P.Pattern)
	| HappyAbsSyn22 (NonEmpty (Either P.Implicit P.Pattern))
	| HappyAbsSyn23 ([Pattern])
	| HappyAbsSyn24 (P.Pattern)
	| HappyAbsSyn27 ([P.Pattern])
	| HappyAbsSyn28 (Case)
	| HappyAbsSyn29 ([Case])
	| HappyAbsSyn30 (Expression)
	| HappyAbsSyn34 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,607) ([0,0,1008,0,0,0,64512,0,0,0,0,0,0,0,0,0,32,0,0,0,2560,0,0,0,32768,2,0,0,49152,18367,17,0,0,61424,1105,0,0,64512,5243,1,0,0,0,0,0,0,63,0,0,0,0,0,0,0,0,0,0,0,0,0,640,0,0,16384,17340,17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,65280,17694,0,0,0,2080,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2080,5,0,0,0,0,0,0,64512,13435,1,0,0,7935,69,0,0,0,0,0,0,0,1024,32,0,0,0,16,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,4096,0,0,0,0,528,0,0,24576,0,0,0,0,0,32,0,0,0,2049,0,0,65280,17694,0,0,49152,18367,17,0,0,0,2048,0,0,0,0,4,0,0,0,264,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,1056,0,0,0,8192,4,0,0,0,0,0,0,0,0,0,0,0,8320,0,0,0,46080,4362,0,0,0,520,0,0,0,0,2048,0,0,0,4096,0,0,0,4096,0,0,0,0,0,0,0,64512,13435,1,0,0,3825,69,0,0,48192,4419,0,0,0,8192,0,0,0,0,10,0,0,0,64,0,0,0,0,0,0,0,61424,1105,0,0,16384,4267,1,0,0,7935,69,0,0,0,0,0,0,0,17069,4,0,0,0,0,0,0,0,0,1,0,0,8192,0,0,0,0,16384,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,44288,1090,0,0,16384,4267,3,0,0,0,512,0,0,48192,4419,0,0,0,17069,4,0,0,0,0,0,0,0,0,0,0,49152,18367,17,0,0,61424,1105,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,20975,4,0,0,31740,276,0,0,65280,17694,0,0,0,96,0,0,0,0,8192,0,0,0,0,4,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,65280,17694,0,0,0,0,4,0,0,0,16384,0,0,0,32768,0,0,0,0,4,0,0,0,0,0,0,0,24,0,0,0,31740,276,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,2,0,0,0,0,0,0,65280,17694,0,0,0,0,32,0,0,0,0,0,0,0,8192,0,0,0,0,256,0,0,0,0,0,0,0,17069,4,0,0,31740,276,0,0,53248,17450,0,0,0,0,0,0,0,44288,1090,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17069,4,0,0,0,1024,0,0,0,8192,0,0,0,0,64,0,0,61424,1105,0,0,0,8192,0,0,0,7935,69,0,0,0,0,0,0,61440,20975,4,0,0,0,1,0,0,53248,17450,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17069,4,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,7935,69,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,128,0,0,0,8192,0,0,0,0,32768,0,0,0,0,0,0,0,49088,4423,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,8192,0,0,0,10960,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,2740,17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Name","Statement","Variant","Variants","ArgumentName","ArgumentNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","BinaryExpression","Juxtaposition","Atom","IntegerLiteral","FloatLiteral","StringLiteral","data","decl","def","check","eval","typeOf","type","let","case","forall","int","float","string","lsym","qlsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","'?'","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 70
        bit_end = (st Prelude.+ 1) Prelude.* 70
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..69]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (37) = happyShift action_3
action_0 (38) = happyShift action_4
action_0 (39) = happyShift action_5
action_0 (40) = happyShift action_6
action_0 (41) = happyShift action_7
action_0 (42) = happyShift action_8
action_0 (4) = happyGoto action_9
action_0 (6) = happyGoto action_10
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (37) = happyShift action_3
action_1 (38) = happyShift action_4
action_1 (39) = happyShift action_5
action_1 (40) = happyShift action_6
action_1 (41) = happyShift action_7
action_1 (42) = happyShift action_8
action_1 (6) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyFail (happyExpListPerState 2)

action_3 (52) = happyShift action_40
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (50) = happyShift action_37
action_4 (52) = happyShift action_38
action_4 (5) = happyGoto action_39
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (50) = happyShift action_37
action_5 (52) = happyShift action_38
action_5 (5) = happyGoto action_36
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (43) = happyShift action_19
action_6 (44) = happyShift action_20
action_6 (45) = happyShift action_21
action_6 (46) = happyShift action_22
action_6 (47) = happyShift action_23
action_6 (48) = happyShift action_24
action_6 (49) = happyShift action_25
action_6 (50) = happyShift action_26
action_6 (52) = happyShift action_27
action_6 (53) = happyShift action_28
action_6 (54) = happyShift action_29
action_6 (55) = happyShift action_30
action_6 (59) = happyShift action_31
action_6 (61) = happyShift action_32
action_6 (65) = happyShift action_33
action_6 (30) = happyGoto action_35
action_6 (31) = happyGoto action_13
action_6 (32) = happyGoto action_14
action_6 (33) = happyGoto action_15
action_6 (34) = happyGoto action_16
action_6 (35) = happyGoto action_17
action_6 (36) = happyGoto action_18
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (43) = happyShift action_19
action_7 (44) = happyShift action_20
action_7 (45) = happyShift action_21
action_7 (46) = happyShift action_22
action_7 (47) = happyShift action_23
action_7 (48) = happyShift action_24
action_7 (49) = happyShift action_25
action_7 (50) = happyShift action_26
action_7 (52) = happyShift action_27
action_7 (53) = happyShift action_28
action_7 (54) = happyShift action_29
action_7 (55) = happyShift action_30
action_7 (59) = happyShift action_31
action_7 (61) = happyShift action_32
action_7 (65) = happyShift action_33
action_7 (30) = happyGoto action_34
action_7 (31) = happyGoto action_13
action_7 (32) = happyGoto action_14
action_7 (33) = happyGoto action_15
action_7 (34) = happyGoto action_16
action_7 (35) = happyGoto action_17
action_7 (36) = happyGoto action_18
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (43) = happyShift action_19
action_8 (44) = happyShift action_20
action_8 (45) = happyShift action_21
action_8 (46) = happyShift action_22
action_8 (47) = happyShift action_23
action_8 (48) = happyShift action_24
action_8 (49) = happyShift action_25
action_8 (50) = happyShift action_26
action_8 (52) = happyShift action_27
action_8 (53) = happyShift action_28
action_8 (54) = happyShift action_29
action_8 (55) = happyShift action_30
action_8 (59) = happyShift action_31
action_8 (61) = happyShift action_32
action_8 (65) = happyShift action_33
action_8 (30) = happyGoto action_12
action_8 (31) = happyGoto action_13
action_8 (32) = happyGoto action_14
action_8 (33) = happyGoto action_15
action_8 (34) = happyGoto action_16
action_8 (35) = happyGoto action_17
action_8 (36) = happyGoto action_18
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (70) = happyAccept
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (37) = happyShift action_3
action_10 (38) = happyShift action_4
action_10 (39) = happyShift action_5
action_10 (40) = happyShift action_6
action_10 (41) = happyShift action_7
action_10 (42) = happyShift action_8
action_10 (4) = happyGoto action_11
action_10 (6) = happyGoto action_10
action_10 _ = happyReduce_1

action_11 _ = happyReduce_2

action_12 _ = happyReduce_11

action_13 (58) = happyShift action_65
action_13 (60) = happyShift action_66
action_13 _ = happyReduce_72

action_14 (43) = happyShift action_19
action_14 (47) = happyShift action_23
action_14 (48) = happyShift action_24
action_14 (49) = happyShift action_25
action_14 (50) = happyShift action_26
action_14 (52) = happyShift action_27
action_14 (53) = happyShift action_28
action_14 (54) = happyShift action_29
action_14 (59) = happyShift action_31
action_14 (61) = happyShift action_64
action_14 (65) = happyShift action_33
action_14 (33) = happyGoto action_63
action_14 (34) = happyGoto action_16
action_14 (35) = happyGoto action_17
action_14 (36) = happyGoto action_18
action_14 _ = happyReduce_75

action_15 _ = happyReduce_78

action_16 _ = happyReduce_89

action_17 _ = happyReduce_90

action_18 _ = happyReduce_91

action_19 _ = happyReduce_88

action_20 (50) = happyShift action_62
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (43) = happyShift action_19
action_21 (44) = happyShift action_20
action_21 (45) = happyShift action_21
action_21 (46) = happyShift action_22
action_21 (47) = happyShift action_23
action_21 (48) = happyShift action_24
action_21 (49) = happyShift action_25
action_21 (50) = happyShift action_26
action_21 (52) = happyShift action_27
action_21 (53) = happyShift action_28
action_21 (54) = happyShift action_29
action_21 (55) = happyShift action_30
action_21 (59) = happyShift action_31
action_21 (61) = happyShift action_32
action_21 (65) = happyShift action_33
action_21 (14) = happyGoto action_61
action_21 (30) = happyGoto action_48
action_21 (31) = happyGoto action_13
action_21 (32) = happyGoto action_14
action_21 (33) = happyGoto action_15
action_21 (34) = happyGoto action_16
action_21 (35) = happyGoto action_17
action_21 (36) = happyGoto action_18
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (50) = happyShift action_55
action_22 (56) = happyShift action_56
action_22 (15) = happyGoto action_51
action_22 (16) = happyGoto action_59
action_22 (17) = happyGoto action_60
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_92

action_24 _ = happyReduce_93

action_25 _ = happyReduce_94

action_26 _ = happyReduce_84

action_27 _ = happyReduce_85

action_28 _ = happyReduce_86

action_29 _ = happyReduce_87

action_30 (50) = happyShift action_55
action_30 (56) = happyShift action_56
action_30 (61) = happyShift action_57
action_30 (63) = happyShift action_58
action_30 (15) = happyGoto action_51
action_30 (16) = happyGoto action_52
action_30 (18) = happyGoto action_53
action_30 (19) = happyGoto action_54
action_30 _ = happyFail (happyExpListPerState 30)

action_31 _ = happyReduce_83

action_32 (43) = happyShift action_19
action_32 (44) = happyShift action_20
action_32 (45) = happyShift action_21
action_32 (46) = happyShift action_22
action_32 (47) = happyShift action_23
action_32 (48) = happyShift action_24
action_32 (49) = happyShift action_25
action_32 (50) = happyShift action_26
action_32 (52) = happyShift action_27
action_32 (53) = happyShift action_28
action_32 (54) = happyShift action_29
action_32 (55) = happyShift action_30
action_32 (59) = happyShift action_31
action_32 (61) = happyShift action_32
action_32 (62) = happyShift action_50
action_32 (65) = happyShift action_33
action_32 (30) = happyGoto action_49
action_32 (31) = happyGoto action_13
action_32 (32) = happyGoto action_14
action_32 (33) = happyGoto action_15
action_32 (34) = happyGoto action_16
action_32 (35) = happyGoto action_17
action_32 (36) = happyGoto action_18
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (43) = happyShift action_19
action_33 (44) = happyShift action_20
action_33 (45) = happyShift action_21
action_33 (46) = happyShift action_22
action_33 (47) = happyShift action_23
action_33 (48) = happyShift action_24
action_33 (49) = happyShift action_25
action_33 (50) = happyShift action_26
action_33 (52) = happyShift action_27
action_33 (53) = happyShift action_28
action_33 (54) = happyShift action_29
action_33 (55) = happyShift action_30
action_33 (59) = happyShift action_31
action_33 (61) = happyShift action_32
action_33 (65) = happyShift action_33
action_33 (14) = happyGoto action_47
action_33 (30) = happyGoto action_48
action_33 (31) = happyGoto action_13
action_33 (32) = happyGoto action_14
action_33 (33) = happyGoto action_15
action_33 (34) = happyGoto action_16
action_33 (35) = happyGoto action_17
action_33 (36) = happyGoto action_18
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_10

action_35 (57) = happyShift action_45
action_35 (68) = happyShift action_46
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (61) = happyShift action_42
action_36 (13) = happyGoto action_44
action_36 _ = happyReduce_26

action_37 _ = happyReduce_4

action_38 _ = happyReduce_3

action_39 (61) = happyShift action_42
action_39 (13) = happyGoto action_43
action_39 _ = happyReduce_26

action_40 (61) = happyShift action_42
action_40 (13) = happyGoto action_41
action_40 _ = happyReduce_26

action_41 (63) = happyShift action_108
action_41 (68) = happyShift action_109
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (50) = happyShift action_106
action_42 (51) = happyShift action_107
action_42 (9) = happyGoto action_102
action_42 (10) = happyGoto action_103
action_42 (11) = happyGoto action_104
action_42 (12) = happyGoto action_105
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (68) = happyShift action_101
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (57) = happyShift action_99
action_44 (68) = happyShift action_100
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (43) = happyShift action_19
action_45 (44) = happyShift action_20
action_45 (45) = happyShift action_21
action_45 (46) = happyShift action_22
action_45 (47) = happyShift action_23
action_45 (48) = happyShift action_24
action_45 (49) = happyShift action_25
action_45 (50) = happyShift action_26
action_45 (52) = happyShift action_27
action_45 (53) = happyShift action_28
action_45 (54) = happyShift action_29
action_45 (55) = happyShift action_30
action_45 (59) = happyShift action_31
action_45 (61) = happyShift action_32
action_45 (65) = happyShift action_33
action_45 (30) = happyGoto action_98
action_45 (31) = happyGoto action_13
action_45 (32) = happyGoto action_14
action_45 (33) = happyGoto action_15
action_45 (34) = happyGoto action_16
action_45 (35) = happyGoto action_17
action_45 (36) = happyGoto action_18
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (43) = happyShift action_19
action_46 (44) = happyShift action_20
action_46 (45) = happyShift action_21
action_46 (46) = happyShift action_22
action_46 (47) = happyShift action_23
action_46 (48) = happyShift action_24
action_46 (49) = happyShift action_25
action_46 (50) = happyShift action_26
action_46 (52) = happyShift action_27
action_46 (53) = happyShift action_28
action_46 (54) = happyShift action_29
action_46 (55) = happyShift action_30
action_46 (59) = happyShift action_31
action_46 (61) = happyShift action_32
action_46 (65) = happyShift action_33
action_46 (30) = happyGoto action_97
action_46 (31) = happyGoto action_13
action_46 (32) = happyGoto action_14
action_46 (33) = happyGoto action_15
action_46 (34) = happyGoto action_16
action_46 (35) = happyGoto action_17
action_46 (36) = happyGoto action_18
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (66) = happyShift action_96
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (67) = happyShift action_95
action_48 _ = happyReduce_28

action_49 (62) = happyShift action_93
action_49 (67) = happyShift action_94
action_49 _ = happyFail (happyExpListPerState 49)

action_50 _ = happyReduce_80

action_51 _ = happyReduce_31

action_52 _ = happyReduce_35

action_53 (50) = happyShift action_55
action_53 (56) = happyShift action_56
action_53 (61) = happyShift action_57
action_53 (15) = happyGoto action_51
action_53 (16) = happyGoto action_52
action_53 (18) = happyGoto action_53
action_53 (19) = happyGoto action_92
action_53 _ = happyReduce_37

action_54 (58) = happyShift action_90
action_54 (63) = happyShift action_91
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_30

action_56 _ = happyReduce_32

action_57 (50) = happyShift action_55
action_57 (56) = happyShift action_56
action_57 (15) = happyGoto action_51
action_57 (16) = happyGoto action_59
action_57 (17) = happyGoto action_89
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (47) = happyShift action_23
action_58 (49) = happyShift action_25
action_58 (50) = happyShift action_83
action_58 (52) = happyShift action_84
action_58 (54) = happyShift action_85
action_58 (56) = happyShift action_86
action_58 (61) = happyShift action_87
action_58 (65) = happyShift action_88
action_58 (20) = happyGoto action_75
action_58 (24) = happyGoto action_76
action_58 (26) = happyGoto action_77
action_58 (27) = happyGoto action_78
action_58 (28) = happyGoto action_79
action_58 (29) = happyGoto action_80
action_58 (34) = happyGoto action_81
action_58 (36) = happyGoto action_82
action_58 _ = happyReduce_63

action_59 (50) = happyShift action_55
action_59 (56) = happyShift action_56
action_59 (15) = happyGoto action_51
action_59 (16) = happyGoto action_59
action_59 (17) = happyGoto action_74
action_59 _ = happyReduce_33

action_60 (68) = happyShift action_73
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (63) = happyShift action_72
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (57) = happyShift action_71
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_76

action_64 (43) = happyShift action_19
action_64 (44) = happyShift action_20
action_64 (45) = happyShift action_21
action_64 (46) = happyShift action_22
action_64 (47) = happyShift action_23
action_64 (48) = happyShift action_24
action_64 (49) = happyShift action_25
action_64 (50) = happyShift action_70
action_64 (52) = happyShift action_27
action_64 (53) = happyShift action_28
action_64 (54) = happyShift action_29
action_64 (55) = happyShift action_30
action_64 (59) = happyShift action_31
action_64 (61) = happyShift action_32
action_64 (62) = happyShift action_50
action_64 (65) = happyShift action_33
action_64 (15) = happyGoto action_69
action_64 (30) = happyGoto action_49
action_64 (31) = happyGoto action_13
action_64 (32) = happyGoto action_14
action_64 (33) = happyGoto action_15
action_64 (34) = happyGoto action_16
action_64 (35) = happyGoto action_17
action_64 (36) = happyGoto action_18
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (43) = happyShift action_19
action_65 (47) = happyShift action_23
action_65 (48) = happyShift action_24
action_65 (49) = happyShift action_25
action_65 (50) = happyShift action_26
action_65 (52) = happyShift action_27
action_65 (53) = happyShift action_28
action_65 (54) = happyShift action_29
action_65 (59) = happyShift action_31
action_65 (61) = happyShift action_32
action_65 (65) = happyShift action_33
action_65 (31) = happyGoto action_68
action_65 (32) = happyGoto action_14
action_65 (33) = happyGoto action_15
action_65 (34) = happyGoto action_16
action_65 (35) = happyGoto action_17
action_65 (36) = happyGoto action_18
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (43) = happyShift action_19
action_66 (47) = happyShift action_23
action_66 (48) = happyShift action_24
action_66 (49) = happyShift action_25
action_66 (50) = happyShift action_26
action_66 (52) = happyShift action_27
action_66 (53) = happyShift action_28
action_66 (54) = happyShift action_29
action_66 (59) = happyShift action_31
action_66 (61) = happyShift action_32
action_66 (65) = happyShift action_33
action_66 (31) = happyGoto action_67
action_66 (32) = happyGoto action_14
action_66 (33) = happyGoto action_15
action_66 (34) = happyGoto action_16
action_66 (35) = happyGoto action_17
action_66 (36) = happyGoto action_18
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (60) = happyShift action_66
action_67 _ = happyReduce_74

action_68 (58) = happyShift action_65
action_68 (60) = happyShift action_66
action_68 _ = happyReduce_73

action_69 (57) = happyShift action_143
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (57) = happyReduce_30
action_70 _ = happyReduce_84

action_71 (43) = happyShift action_19
action_71 (44) = happyShift action_20
action_71 (45) = happyShift action_21
action_71 (46) = happyShift action_22
action_71 (47) = happyShift action_23
action_71 (48) = happyShift action_24
action_71 (49) = happyShift action_25
action_71 (50) = happyShift action_26
action_71 (52) = happyShift action_27
action_71 (53) = happyShift action_28
action_71 (54) = happyShift action_29
action_71 (55) = happyShift action_30
action_71 (59) = happyShift action_31
action_71 (61) = happyShift action_32
action_71 (65) = happyShift action_33
action_71 (30) = happyGoto action_142
action_71 (31) = happyGoto action_13
action_71 (32) = happyGoto action_14
action_71 (33) = happyGoto action_15
action_71 (34) = happyGoto action_16
action_71 (35) = happyGoto action_17
action_71 (36) = happyGoto action_18
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (47) = happyShift action_23
action_72 (49) = happyShift action_25
action_72 (50) = happyShift action_83
action_72 (52) = happyShift action_84
action_72 (54) = happyShift action_85
action_72 (56) = happyShift action_86
action_72 (61) = happyShift action_87
action_72 (65) = happyShift action_88
action_72 (20) = happyGoto action_75
action_72 (24) = happyGoto action_76
action_72 (26) = happyGoto action_77
action_72 (27) = happyGoto action_78
action_72 (28) = happyGoto action_79
action_72 (29) = happyGoto action_141
action_72 (34) = happyGoto action_81
action_72 (36) = happyGoto action_82
action_72 _ = happyReduce_63

action_73 (43) = happyShift action_19
action_73 (44) = happyShift action_20
action_73 (45) = happyShift action_21
action_73 (46) = happyShift action_22
action_73 (47) = happyShift action_23
action_73 (48) = happyShift action_24
action_73 (49) = happyShift action_25
action_73 (50) = happyShift action_26
action_73 (52) = happyShift action_27
action_73 (53) = happyShift action_28
action_73 (54) = happyShift action_29
action_73 (55) = happyShift action_30
action_73 (59) = happyShift action_31
action_73 (61) = happyShift action_32
action_73 (65) = happyShift action_33
action_73 (30) = happyGoto action_140
action_73 (31) = happyGoto action_13
action_73 (32) = happyGoto action_14
action_73 (33) = happyGoto action_15
action_73 (34) = happyGoto action_16
action_73 (35) = happyGoto action_17
action_73 (36) = happyGoto action_18
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_34

action_75 (47) = happyShift action_23
action_75 (49) = happyShift action_25
action_75 (50) = happyShift action_83
action_75 (52) = happyShift action_84
action_75 (54) = happyShift action_85
action_75 (56) = happyShift action_86
action_75 (61) = happyShift action_139
action_75 (65) = happyShift action_88
action_75 (20) = happyGoto action_134
action_75 (21) = happyGoto action_135
action_75 (22) = happyGoto action_136
action_75 (24) = happyGoto action_137
action_75 (25) = happyGoto action_138
action_75 (34) = happyGoto action_81
action_75 (36) = happyGoto action_82
action_75 _ = happyReduce_48

action_76 _ = happyReduce_58

action_77 (67) = happyShift action_133
action_77 _ = happyReduce_60

action_78 (58) = happyShift action_132
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (69) = happyShift action_131
action_79 _ = happyReduce_64

action_80 (64) = happyShift action_130
action_80 _ = happyFail (happyExpListPerState 80)

action_81 _ = happyReduce_53

action_82 _ = happyReduce_54

action_83 _ = happyReduce_49

action_84 _ = happyReduce_39

action_85 _ = happyReduce_40

action_86 _ = happyReduce_55

action_87 (47) = happyShift action_23
action_87 (49) = happyShift action_25
action_87 (50) = happyShift action_83
action_87 (52) = happyShift action_84
action_87 (54) = happyShift action_85
action_87 (56) = happyShift action_86
action_87 (61) = happyShift action_87
action_87 (65) = happyShift action_88
action_87 (20) = happyGoto action_75
action_87 (23) = happyGoto action_128
action_87 (24) = happyGoto action_76
action_87 (26) = happyGoto action_129
action_87 (34) = happyGoto action_81
action_87 (36) = happyGoto action_82
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (47) = happyShift action_23
action_88 (49) = happyShift action_25
action_88 (50) = happyShift action_83
action_88 (52) = happyShift action_84
action_88 (54) = happyShift action_85
action_88 (56) = happyShift action_86
action_88 (61) = happyShift action_87
action_88 (65) = happyShift action_88
action_88 (66) = happyShift action_127
action_88 (20) = happyGoto action_75
action_88 (24) = happyGoto action_76
action_88 (26) = happyGoto action_77
action_88 (27) = happyGoto action_126
action_88 (34) = happyGoto action_81
action_88 (36) = happyGoto action_82
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (68) = happyShift action_125
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (43) = happyShift action_19
action_90 (47) = happyShift action_23
action_90 (48) = happyShift action_24
action_90 (49) = happyShift action_25
action_90 (50) = happyShift action_26
action_90 (52) = happyShift action_27
action_90 (53) = happyShift action_28
action_90 (54) = happyShift action_29
action_90 (59) = happyShift action_31
action_90 (61) = happyShift action_32
action_90 (65) = happyShift action_33
action_90 (33) = happyGoto action_124
action_90 (34) = happyGoto action_16
action_90 (35) = happyGoto action_17
action_90 (36) = happyGoto action_18
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (47) = happyShift action_23
action_91 (49) = happyShift action_25
action_91 (50) = happyShift action_83
action_91 (52) = happyShift action_84
action_91 (54) = happyShift action_85
action_91 (56) = happyShift action_86
action_91 (61) = happyShift action_87
action_91 (65) = happyShift action_88
action_91 (20) = happyGoto action_75
action_91 (24) = happyGoto action_76
action_91 (26) = happyGoto action_77
action_91 (27) = happyGoto action_78
action_91 (28) = happyGoto action_79
action_91 (29) = happyGoto action_123
action_91 (34) = happyGoto action_81
action_91 (36) = happyGoto action_82
action_91 _ = happyReduce_63

action_92 _ = happyReduce_38

action_93 _ = happyReduce_79

action_94 (43) = happyShift action_19
action_94 (44) = happyShift action_20
action_94 (45) = happyShift action_21
action_94 (46) = happyShift action_22
action_94 (47) = happyShift action_23
action_94 (48) = happyShift action_24
action_94 (49) = happyShift action_25
action_94 (50) = happyShift action_26
action_94 (52) = happyShift action_27
action_94 (53) = happyShift action_28
action_94 (54) = happyShift action_29
action_94 (55) = happyShift action_30
action_94 (59) = happyShift action_31
action_94 (61) = happyShift action_32
action_94 (65) = happyShift action_33
action_94 (14) = happyGoto action_122
action_94 (30) = happyGoto action_48
action_94 (31) = happyGoto action_13
action_94 (32) = happyGoto action_14
action_94 (33) = happyGoto action_15
action_94 (34) = happyGoto action_16
action_94 (35) = happyGoto action_17
action_94 (36) = happyGoto action_18
action_94 _ = happyFail (happyExpListPerState 94)

action_95 (43) = happyShift action_19
action_95 (44) = happyShift action_20
action_95 (45) = happyShift action_21
action_95 (46) = happyShift action_22
action_95 (47) = happyShift action_23
action_95 (48) = happyShift action_24
action_95 (49) = happyShift action_25
action_95 (50) = happyShift action_26
action_95 (52) = happyShift action_27
action_95 (53) = happyShift action_28
action_95 (54) = happyShift action_29
action_95 (55) = happyShift action_30
action_95 (59) = happyShift action_31
action_95 (61) = happyShift action_32
action_95 (65) = happyShift action_33
action_95 (14) = happyGoto action_121
action_95 (30) = happyGoto action_48
action_95 (31) = happyGoto action_13
action_95 (32) = happyGoto action_14
action_95 (33) = happyGoto action_15
action_95 (34) = happyGoto action_16
action_95 (35) = happyGoto action_17
action_95 (36) = happyGoto action_18
action_95 _ = happyFail (happyExpListPerState 95)

action_96 _ = happyReduce_82

action_97 _ = happyReduce_13

action_98 _ = happyReduce_12

action_99 (43) = happyShift action_19
action_99 (44) = happyShift action_20
action_99 (45) = happyShift action_21
action_99 (46) = happyShift action_22
action_99 (47) = happyShift action_23
action_99 (48) = happyShift action_24
action_99 (49) = happyShift action_25
action_99 (50) = happyShift action_26
action_99 (52) = happyShift action_27
action_99 (53) = happyShift action_28
action_99 (54) = happyShift action_29
action_99 (55) = happyShift action_30
action_99 (59) = happyShift action_31
action_99 (61) = happyShift action_32
action_99 (65) = happyShift action_33
action_99 (30) = happyGoto action_120
action_99 (31) = happyGoto action_13
action_99 (32) = happyGoto action_14
action_99 (33) = happyGoto action_15
action_99 (34) = happyGoto action_16
action_99 (35) = happyGoto action_17
action_99 (36) = happyGoto action_18
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (43) = happyShift action_19
action_100 (44) = happyShift action_20
action_100 (45) = happyShift action_21
action_100 (46) = happyShift action_22
action_100 (47) = happyShift action_23
action_100 (48) = happyShift action_24
action_100 (49) = happyShift action_25
action_100 (50) = happyShift action_26
action_100 (52) = happyShift action_27
action_100 (53) = happyShift action_28
action_100 (54) = happyShift action_29
action_100 (55) = happyShift action_30
action_100 (59) = happyShift action_31
action_100 (61) = happyShift action_32
action_100 (65) = happyShift action_33
action_100 (30) = happyGoto action_119
action_100 (31) = happyGoto action_13
action_100 (32) = happyGoto action_14
action_100 (33) = happyGoto action_15
action_100 (34) = happyGoto action_16
action_100 (35) = happyGoto action_17
action_100 (36) = happyGoto action_18
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (43) = happyShift action_19
action_101 (44) = happyShift action_20
action_101 (45) = happyShift action_21
action_101 (46) = happyShift action_22
action_101 (47) = happyShift action_23
action_101 (48) = happyShift action_24
action_101 (49) = happyShift action_25
action_101 (50) = happyShift action_26
action_101 (52) = happyShift action_27
action_101 (53) = happyShift action_28
action_101 (54) = happyShift action_29
action_101 (55) = happyShift action_30
action_101 (59) = happyShift action_31
action_101 (61) = happyShift action_32
action_101 (65) = happyShift action_33
action_101 (30) = happyGoto action_118
action_101 (31) = happyGoto action_13
action_101 (32) = happyGoto action_14
action_101 (33) = happyGoto action_15
action_101 (34) = happyGoto action_16
action_101 (35) = happyGoto action_17
action_101 (36) = happyGoto action_18
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (50) = happyShift action_106
action_102 (51) = happyShift action_107
action_102 (9) = happyGoto action_102
action_102 (10) = happyGoto action_117
action_102 _ = happyReduce_21

action_103 (68) = happyShift action_116
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (67) = happyShift action_115
action_104 _ = happyReduce_24

action_105 (62) = happyShift action_114
action_105 _ = happyFail (happyExpListPerState 105)

action_106 _ = happyReduce_19

action_107 _ = happyReduce_20

action_108 (52) = happyShift action_113
action_108 (7) = happyGoto action_111
action_108 (8) = happyGoto action_112
action_108 _ = happyReduce_16

action_109 (43) = happyShift action_19
action_109 (44) = happyShift action_20
action_109 (45) = happyShift action_21
action_109 (46) = happyShift action_22
action_109 (47) = happyShift action_23
action_109 (48) = happyShift action_24
action_109 (49) = happyShift action_25
action_109 (50) = happyShift action_26
action_109 (52) = happyShift action_27
action_109 (53) = happyShift action_28
action_109 (54) = happyShift action_29
action_109 (55) = happyShift action_30
action_109 (59) = happyShift action_31
action_109 (61) = happyShift action_32
action_109 (65) = happyShift action_33
action_109 (30) = happyGoto action_110
action_109 (31) = happyGoto action_13
action_109 (32) = happyGoto action_14
action_109 (33) = happyGoto action_15
action_109 (34) = happyGoto action_16
action_109 (35) = happyGoto action_17
action_109 (36) = happyGoto action_18
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (63) = happyShift action_167
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (69) = happyShift action_166
action_111 _ = happyReduce_17

action_112 (64) = happyShift action_165
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (61) = happyShift action_42
action_113 (13) = happyGoto action_164
action_113 _ = happyReduce_26

action_114 _ = happyReduce_27

action_115 (50) = happyShift action_106
action_115 (51) = happyShift action_107
action_115 (9) = happyGoto action_102
action_115 (10) = happyGoto action_103
action_115 (11) = happyGoto action_104
action_115 (12) = happyGoto action_163
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (43) = happyShift action_19
action_116 (44) = happyShift action_20
action_116 (45) = happyShift action_21
action_116 (46) = happyShift action_22
action_116 (47) = happyShift action_23
action_116 (48) = happyShift action_24
action_116 (49) = happyShift action_25
action_116 (50) = happyShift action_26
action_116 (52) = happyShift action_27
action_116 (53) = happyShift action_28
action_116 (54) = happyShift action_29
action_116 (55) = happyShift action_30
action_116 (59) = happyShift action_31
action_116 (61) = happyShift action_32
action_116 (65) = happyShift action_33
action_116 (30) = happyGoto action_162
action_116 (31) = happyGoto action_13
action_116 (32) = happyGoto action_14
action_116 (33) = happyGoto action_15
action_116 (34) = happyGoto action_16
action_116 (35) = happyGoto action_17
action_116 (36) = happyGoto action_18
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_22

action_118 _ = happyReduce_7

action_119 (57) = happyShift action_161
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_8

action_121 _ = happyReduce_29

action_122 (62) = happyShift action_160
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (64) = happyShift action_159
action_123 _ = happyFail (happyExpListPerState 123)

action_124 _ = happyReduce_69

action_125 (43) = happyShift action_19
action_125 (44) = happyShift action_20
action_125 (45) = happyShift action_21
action_125 (46) = happyShift action_22
action_125 (47) = happyShift action_23
action_125 (48) = happyShift action_24
action_125 (49) = happyShift action_25
action_125 (50) = happyShift action_26
action_125 (52) = happyShift action_27
action_125 (53) = happyShift action_28
action_125 (54) = happyShift action_29
action_125 (55) = happyShift action_30
action_125 (59) = happyShift action_31
action_125 (61) = happyShift action_32
action_125 (65) = happyShift action_33
action_125 (30) = happyGoto action_158
action_125 (31) = happyGoto action_13
action_125 (32) = happyGoto action_14
action_125 (33) = happyGoto action_15
action_125 (34) = happyGoto action_16
action_125 (35) = happyGoto action_17
action_125 (36) = happyGoto action_18
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (66) = happyShift action_157
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_51

action_128 (62) = happyShift action_156
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (67) = happyShift action_155
action_129 _ = happyFail (happyExpListPerState 129)

action_130 _ = happyReduce_71

action_131 (47) = happyShift action_23
action_131 (49) = happyShift action_25
action_131 (50) = happyShift action_83
action_131 (52) = happyShift action_84
action_131 (54) = happyShift action_85
action_131 (56) = happyShift action_86
action_131 (61) = happyShift action_87
action_131 (65) = happyShift action_88
action_131 (20) = happyGoto action_75
action_131 (24) = happyGoto action_76
action_131 (26) = happyGoto action_77
action_131 (27) = happyGoto action_78
action_131 (28) = happyGoto action_79
action_131 (29) = happyGoto action_154
action_131 (34) = happyGoto action_81
action_131 (36) = happyGoto action_82
action_131 _ = happyReduce_63

action_132 (43) = happyShift action_19
action_132 (44) = happyShift action_20
action_132 (45) = happyShift action_21
action_132 (46) = happyShift action_22
action_132 (47) = happyShift action_23
action_132 (48) = happyShift action_24
action_132 (49) = happyShift action_25
action_132 (50) = happyShift action_26
action_132 (52) = happyShift action_27
action_132 (53) = happyShift action_28
action_132 (54) = happyShift action_29
action_132 (55) = happyShift action_30
action_132 (59) = happyShift action_31
action_132 (61) = happyShift action_32
action_132 (65) = happyShift action_33
action_132 (30) = happyGoto action_153
action_132 (31) = happyGoto action_13
action_132 (32) = happyGoto action_14
action_132 (33) = happyGoto action_15
action_132 (34) = happyGoto action_16
action_132 (35) = happyGoto action_17
action_132 (36) = happyGoto action_18
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (47) = happyShift action_23
action_133 (49) = happyShift action_25
action_133 (50) = happyShift action_83
action_133 (52) = happyShift action_84
action_133 (54) = happyShift action_85
action_133 (56) = happyShift action_86
action_133 (61) = happyShift action_87
action_133 (65) = happyShift action_88
action_133 (20) = happyGoto action_75
action_133 (24) = happyGoto action_76
action_133 (26) = happyGoto action_77
action_133 (27) = happyGoto action_152
action_133 (34) = happyGoto action_81
action_133 (36) = happyGoto action_82
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_48

action_135 (47) = happyShift action_23
action_135 (49) = happyShift action_25
action_135 (50) = happyShift action_83
action_135 (52) = happyShift action_84
action_135 (54) = happyShift action_85
action_135 (56) = happyShift action_86
action_135 (61) = happyShift action_139
action_135 (65) = happyShift action_88
action_135 (20) = happyGoto action_134
action_135 (21) = happyGoto action_135
action_135 (22) = happyGoto action_151
action_135 (24) = happyGoto action_137
action_135 (25) = happyGoto action_138
action_135 (34) = happyGoto action_81
action_135 (36) = happyGoto action_82
action_135 _ = happyReduce_44

action_136 _ = happyReduce_59

action_137 _ = happyReduce_56

action_138 _ = happyReduce_41

action_139 (47) = happyShift action_23
action_139 (49) = happyShift action_25
action_139 (50) = happyShift action_150
action_139 (52) = happyShift action_84
action_139 (54) = happyShift action_85
action_139 (56) = happyShift action_86
action_139 (61) = happyShift action_87
action_139 (65) = happyShift action_88
action_139 (15) = happyGoto action_148
action_139 (20) = happyGoto action_149
action_139 (23) = happyGoto action_128
action_139 (24) = happyGoto action_76
action_139 (26) = happyGoto action_129
action_139 (34) = happyGoto action_81
action_139 (36) = happyGoto action_82
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (67) = happyShift action_147
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (64) = happyShift action_146
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (67) = happyShift action_145
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (43) = happyShift action_19
action_143 (44) = happyShift action_20
action_143 (45) = happyShift action_21
action_143 (46) = happyShift action_22
action_143 (47) = happyShift action_23
action_143 (48) = happyShift action_24
action_143 (49) = happyShift action_25
action_143 (50) = happyShift action_26
action_143 (52) = happyShift action_27
action_143 (53) = happyShift action_28
action_143 (54) = happyShift action_29
action_143 (55) = happyShift action_30
action_143 (59) = happyShift action_31
action_143 (61) = happyShift action_32
action_143 (65) = happyShift action_33
action_143 (30) = happyGoto action_144
action_143 (31) = happyGoto action_13
action_143 (32) = happyGoto action_14
action_143 (33) = happyGoto action_15
action_143 (34) = happyGoto action_16
action_143 (35) = happyGoto action_17
action_143 (36) = happyGoto action_18
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (62) = happyShift action_180
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (43) = happyShift action_19
action_145 (44) = happyShift action_20
action_145 (45) = happyShift action_21
action_145 (46) = happyShift action_22
action_145 (47) = happyShift action_23
action_145 (48) = happyShift action_24
action_145 (49) = happyShift action_25
action_145 (50) = happyShift action_26
action_145 (52) = happyShift action_27
action_145 (53) = happyShift action_28
action_145 (54) = happyShift action_29
action_145 (55) = happyShift action_30
action_145 (59) = happyShift action_31
action_145 (61) = happyShift action_32
action_145 (65) = happyShift action_33
action_145 (30) = happyGoto action_179
action_145 (31) = happyGoto action_13
action_145 (32) = happyGoto action_14
action_145 (33) = happyGoto action_15
action_145 (34) = happyGoto action_16
action_145 (35) = happyGoto action_17
action_145 (36) = happyGoto action_18
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_68

action_147 (43) = happyShift action_19
action_147 (44) = happyShift action_20
action_147 (45) = happyShift action_21
action_147 (46) = happyShift action_22
action_147 (47) = happyShift action_23
action_147 (48) = happyShift action_24
action_147 (49) = happyShift action_25
action_147 (50) = happyShift action_26
action_147 (52) = happyShift action_27
action_147 (53) = happyShift action_28
action_147 (54) = happyShift action_29
action_147 (55) = happyShift action_30
action_147 (59) = happyShift action_31
action_147 (61) = happyShift action_32
action_147 (65) = happyShift action_33
action_147 (30) = happyGoto action_178
action_147 (31) = happyGoto action_13
action_147 (32) = happyGoto action_14
action_147 (33) = happyGoto action_15
action_147 (34) = happyGoto action_16
action_147 (35) = happyGoto action_17
action_147 (36) = happyGoto action_18
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (57) = happyShift action_177
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (47) = happyShift action_23
action_149 (49) = happyShift action_25
action_149 (50) = happyShift action_83
action_149 (52) = happyShift action_84
action_149 (54) = happyShift action_85
action_149 (56) = happyShift action_86
action_149 (61) = happyShift action_139
action_149 (65) = happyShift action_88
action_149 (20) = happyGoto action_134
action_149 (21) = happyGoto action_135
action_149 (22) = happyGoto action_176
action_149 (24) = happyGoto action_137
action_149 (25) = happyGoto action_138
action_149 (34) = happyGoto action_81
action_149 (36) = happyGoto action_82
action_149 _ = happyReduce_48

action_150 (62) = happyShift action_175
action_150 (67) = happyReduce_49
action_150 _ = happyReduce_30

action_151 _ = happyReduce_45

action_152 _ = happyReduce_61

action_153 _ = happyReduce_62

action_154 _ = happyReduce_65

action_155 (47) = happyShift action_23
action_155 (49) = happyShift action_25
action_155 (50) = happyShift action_83
action_155 (52) = happyShift action_84
action_155 (54) = happyShift action_85
action_155 (56) = happyShift action_86
action_155 (61) = happyShift action_87
action_155 (65) = happyShift action_88
action_155 (20) = happyGoto action_75
action_155 (23) = happyGoto action_173
action_155 (24) = happyGoto action_76
action_155 (26) = happyGoto action_174
action_155 (34) = happyGoto action_81
action_155 (36) = happyGoto action_82
action_155 _ = happyFail (happyExpListPerState 155)

action_156 _ = happyReduce_50

action_157 _ = happyReduce_52

action_158 (62) = happyShift action_172
action_158 _ = happyFail (happyExpListPerState 158)

action_159 _ = happyReduce_70

action_160 _ = happyReduce_81

action_161 (43) = happyShift action_19
action_161 (44) = happyShift action_20
action_161 (45) = happyShift action_21
action_161 (46) = happyShift action_22
action_161 (47) = happyShift action_23
action_161 (48) = happyShift action_24
action_161 (49) = happyShift action_25
action_161 (50) = happyShift action_26
action_161 (52) = happyShift action_27
action_161 (53) = happyShift action_28
action_161 (54) = happyShift action_29
action_161 (55) = happyShift action_30
action_161 (59) = happyShift action_31
action_161 (61) = happyShift action_32
action_161 (65) = happyShift action_33
action_161 (30) = happyGoto action_171
action_161 (31) = happyGoto action_13
action_161 (32) = happyGoto action_14
action_161 (33) = happyGoto action_15
action_161 (34) = happyGoto action_16
action_161 (35) = happyGoto action_17
action_161 (36) = happyGoto action_18
action_161 _ = happyFail (happyExpListPerState 161)

action_162 _ = happyReduce_23

action_163 _ = happyReduce_25

action_164 (68) = happyShift action_170
action_164 _ = happyReduce_14

action_165 _ = happyReduce_5

action_166 (52) = happyShift action_113
action_166 (7) = happyGoto action_111
action_166 (8) = happyGoto action_169
action_166 _ = happyReduce_16

action_167 (52) = happyShift action_113
action_167 (7) = happyGoto action_111
action_167 (8) = happyGoto action_168
action_167 _ = happyReduce_16

action_168 (64) = happyShift action_185
action_168 _ = happyFail (happyExpListPerState 168)

action_169 _ = happyReduce_18

action_170 (43) = happyShift action_19
action_170 (44) = happyShift action_20
action_170 (45) = happyShift action_21
action_170 (46) = happyShift action_22
action_170 (47) = happyShift action_23
action_170 (48) = happyShift action_24
action_170 (49) = happyShift action_25
action_170 (50) = happyShift action_26
action_170 (52) = happyShift action_27
action_170 (53) = happyShift action_28
action_170 (54) = happyShift action_29
action_170 (55) = happyShift action_30
action_170 (59) = happyShift action_31
action_170 (61) = happyShift action_32
action_170 (65) = happyShift action_33
action_170 (30) = happyGoto action_184
action_170 (31) = happyGoto action_13
action_170 (32) = happyGoto action_14
action_170 (33) = happyGoto action_15
action_170 (34) = happyGoto action_16
action_170 (35) = happyGoto action_17
action_170 (36) = happyGoto action_18
action_170 _ = happyFail (happyExpListPerState 170)

action_171 _ = happyReduce_9

action_172 _ = happyReduce_36

action_173 _ = happyReduce_47

action_174 (67) = happyShift action_155
action_174 _ = happyReduce_46

action_175 _ = happyReduce_43

action_176 (62) = happyShift action_183
action_176 _ = happyReduce_59

action_177 (47) = happyShift action_23
action_177 (49) = happyShift action_25
action_177 (50) = happyShift action_83
action_177 (52) = happyShift action_84
action_177 (54) = happyShift action_85
action_177 (56) = happyShift action_86
action_177 (61) = happyShift action_182
action_177 (65) = happyShift action_88
action_177 (20) = happyGoto action_134
action_177 (24) = happyGoto action_137
action_177 (25) = happyGoto action_181
action_177 (34) = happyGoto action_81
action_177 (36) = happyGoto action_82
action_177 _ = happyFail (happyExpListPerState 177)

action_178 _ = happyReduce_67

action_179 _ = happyReduce_66

action_180 _ = happyReduce_77

action_181 (62) = happyShift action_186
action_181 _ = happyFail (happyExpListPerState 181)

action_182 (47) = happyShift action_23
action_182 (49) = happyShift action_25
action_182 (50) = happyShift action_83
action_182 (52) = happyShift action_84
action_182 (54) = happyShift action_85
action_182 (56) = happyShift action_86
action_182 (61) = happyShift action_87
action_182 (65) = happyShift action_88
action_182 (20) = happyGoto action_149
action_182 (23) = happyGoto action_128
action_182 (24) = happyGoto action_76
action_182 (26) = happyGoto action_129
action_182 (34) = happyGoto action_81
action_182 (36) = happyGoto action_82
action_182 _ = happyFail (happyExpListPerState 182)

action_183 _ = happyReduce_57

action_184 _ = happyReduce_15

action_185 _ = happyReduce_6

action_186 _ = happyReduce_42

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
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataDeclaration happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 5 6 happyReduction_7
happyReduction_7 ((HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Declaration happy_var_2 happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 5 6 happyReduction_8
happyReduction_8 ((HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Definition happy_var_2 happy_var_3 Nothing happy_var_5 []
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 7 6 happyReduction_9
happyReduction_9 ((HappyAbsSyn30  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Definition happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_2  6 happyReduction_10
happyReduction_10 (HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Eval happy_var_2
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  6 happyReduction_11
happyReduction_11 (HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (TypeOf happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happyReduce 4 6 happyReduction_12
happyReduction_12 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (CheckUnify happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 4 6 happyReduction_13
happyReduction_13 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (CheckTypeOf happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_14 = happySpecReduce_2  7 happyReduction_14
happyReduction_14 (HappyAbsSyn12  happy_var_2)
	(HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn7
		 (Variant [] happy_var_1 happy_var_2 Nothing
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happyReduce 4 7 happyReduction_15
happyReduction_15 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_2) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (Variant [] happy_var_1 happy_var_2 (Just happy_var_4)
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_0  8 happyReduction_16
happyReduction_16  =  HappyAbsSyn8
		 ([]
	)

happyReduce_17 = happySpecReduce_1  8 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  8 happyReduction_18
happyReduction_18 (HappyAbsSyn8  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_1 : happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  9 happyReduction_19
happyReduction_19 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  9 happyReduction_20
happyReduction_20 (HappyTerminal (TokenQLSym happy_var_1))
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  10 happyReduction_21
happyReduction_21 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 :| []
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_2  10 happyReduction_22
happyReduction_22 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_22 _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  11 happyReduction_23
happyReduction_23 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1, Just happy_var_3, [])
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  12 happyReduction_24
happyReduction_24 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  12 happyReduction_25
happyReduction_25 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1 : happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_0  13 happyReduction_26
happyReduction_26  =  HappyAbsSyn12
		 ([]
	)

happyReduce_27 = happySpecReduce_3  13 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  14 happyReduction_28
happyReduction_28 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  14 happyReduction_29
happyReduction_29 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 : happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  15 happyReduction_30
happyReduction_30 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  16 happyReduction_31
happyReduction_31 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  16 happyReduction_32
happyReduction_32 _
	 =  HappyAbsSyn15
		 ("_"
	)

happyReduce_33 = happySpecReduce_1  17 happyReduction_33
happyReduction_33 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| []
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_2  17 happyReduction_34
happyReduction_34 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_34 _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  18 happyReduction_35
happyReduction_35 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1 :| [], Nothing, [])
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happyReduce 5 18 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 ((happy_var_2, Just happy_var_4, [])
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_1  19 happyReduction_37
happyReduction_37 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 :| []
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  19 happyReduction_38
happyReduction_38 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  20 happyReduction_39
happyReduction_39 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  20 happyReduction_40
happyReduction_40 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  21 happyReduction_41
happyReduction_41 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn21
		 (Right happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happyReduce 5 21 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (Left (P.Implicit happy_var_2 happy_var_4)
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_3  21 happyReduction_43
happyReduction_43 _
	(HappyTerminal (TokenLSym happy_var_2))
	_
	 =  HappyAbsSyn21
		 (Left (P.PunnedImplicit happy_var_2)
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  22 happyReduction_44
happyReduction_44 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| []
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  22 happyReduction_45
happyReduction_45 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  23 happyReduction_46
happyReduction_46 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 ([happy_var_1, happy_var_3]
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  23 happyReduction_47
happyReduction_47 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1 : happy_var_3
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  24 happyReduction_48
happyReduction_48 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Data happy_var_1 []
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  24 happyReduction_49
happyReduction_49 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn24
		 (P.Variable happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_3  24 happyReduction_50
happyReduction_50 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.Tuple happy_var_2
	)
happyReduction_50 _ _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  24 happyReduction_51
happyReduction_51 _
	_
	 =  HappyAbsSyn24
		 (P.List []
	)

happyReduce_52 = happySpecReduce_3  24 happyReduction_52
happyReduction_52 _
	(HappyAbsSyn27  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.List happy_var_2
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_1  24 happyReduction_53
happyReduction_53 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  24 happyReduction_54
happyReduction_54 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  24 happyReduction_55
happyReduction_55 _
	 =  HappyAbsSyn24
		 (Wildcard
	)

happyReduce_56 = happySpecReduce_1  25 happyReduction_56
happyReduction_56 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happyReduce 4 25 happyReduction_57
happyReduction_57 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_58 = happySpecReduce_1  26 happyReduction_58
happyReduction_58 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_2  26 happyReduction_59
happyReduction_59 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_1  27 happyReduction_60
happyReduction_60 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  27 happyReduction_61
happyReduction_61 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  28 happyReduction_62
happyReduction_62 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 ((happy_var_1, happy_var_3)
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_0  29 happyReduction_63
happyReduction_63  =  HappyAbsSyn29
		 ([]
	)

happyReduce_64 = happySpecReduce_1  29 happyReduction_64
happyReduction_64 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 ([happy_var_1]
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  29 happyReduction_65
happyReduction_65 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1 : happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happyReduce 6 30 happyReduction_66
happyReduction_66 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_67 = happyReduce 6 30 happyReduction_67
happyReduction_67 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (ForAll happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_68 = happyReduce 5 30 happyReduction_68
happyReduction_68 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 4 30 happyReduction_69
happyReduction_69 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 5 30 happyReduction_70
happyReduction_70 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 4 30 happyReduction_71
happyReduction_71 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_72 = happySpecReduce_1  30 happyReduction_72
happyReduction_72 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  31 happyReduction_73
happyReduction_73 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  31 happyReduction_74
happyReduction_74 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenInfixOp happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (uncurry QName happy_var_2) happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  31 happyReduction_75
happyReduction_75 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_2  32 happyReduction_76
happyReduction_76 (HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Application happy_var_1 ((Nothing, happy_var_2) :| [])
	)
happyReduction_76 _ _  = notHappyAtAll 

happyReduce_77 = happyReduce 6 32 happyReduction_77
happyReduction_77 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Application happy_var_1 ((Just happy_var_3, happy_var_5) :| [])
	) `HappyStk` happyRest

happyReduce_78 = happySpecReduce_1  32 happyReduction_78
happyReduction_78 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_3  33 happyReduction_79
happyReduction_79 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (Parenthesized happy_var_2
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_2  33 happyReduction_80
happyReduction_80 _
	_
	 =  HappyAbsSyn30
		 (Literal UnitLiteral
	)

happyReduce_81 = happyReduce 5 33 happyReduction_81
happyReduction_81 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_82 = happySpecReduce_3  33 happyReduction_82
happyReduction_82 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (List happy_var_2
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  33 happyReduction_83
happyReduction_83 _
	 =  HappyAbsSyn30
		 (Meta
	)

happyReduce_84 = happySpecReduce_1  33 happyReduction_84
happyReduction_84 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  33 happyReduction_85
happyReduction_85 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  33 happyReduction_86
happyReduction_86 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  33 happyReduction_87
happyReduction_87 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  33 happyReduction_88
happyReduction_88 _
	 =  HappyAbsSyn30
		 (Type
	)

happyReduce_89 = happySpecReduce_1  33 happyReduction_89
happyReduction_89 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_89 _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_1  33 happyReduction_90
happyReduction_90 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_90 _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_1  33 happyReduction_91
happyReduction_91 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_91 _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  34 happyReduction_92
happyReduction_92 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn34
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_92 _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_1  35 happyReduction_93
happyReduction_93 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn34
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_1  36 happyReduction_94
happyReduction_94 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn34
		 (StringLiteral happy_var_1
	)
happyReduction_94 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 70 70 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenDatatype -> cont 37;
	TokenDeclare -> cont 38;
	TokenDefine -> cont 39;
	TokenCheck -> cont 40;
	TokenEval -> cont 41;
	TokenTypeOf -> cont 42;
	TokenType -> cont 43;
	TokenLet -> cont 44;
	TokenCase -> cont 45;
	TokenForAll -> cont 46;
	TokenInt happy_dollar_dollar -> cont 47;
	TokenFloat happy_dollar_dollar -> cont 48;
	TokenString happy_dollar_dollar -> cont 49;
	TokenLSym happy_dollar_dollar -> cont 50;
	TokenQLSym happy_dollar_dollar -> cont 51;
	TokenUSym happy_dollar_dollar -> cont 52;
	TokenLSymQ happy_dollar_dollar -> cont 53;
	TokenUSymQ happy_dollar_dollar -> cont 54;
	TokenBackslash -> cont 55;
	TokenUnderscore -> cont 56;
	TokenEq -> cont 57;
	TokenArrow -> cont 58;
	TokenQuestionMark -> cont 59;
	TokenInfixOp happy_dollar_dollar -> cont 60;
	TokenLParen -> cont 61;
	TokenRParen -> cont 62;
	TokenLBrace -> cont 63;
	TokenRBrace -> cont 64;
	TokenLBracket -> cont 65;
	TokenRBracket -> cont 66;
	TokenComma -> cont 67;
	TokenColon -> cont 68;
	TokenSemicolon -> cont 69;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 70 tk tks = happyError' (tks, explist)
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
