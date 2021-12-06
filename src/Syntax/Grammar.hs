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

data HappyAbsSyn t9
	= HappyTerminal (Token)
	| HappyErrorToken Prelude.Int
	| HappyAbsSyn4 (Source)
	| HappyAbsSyn5 (TopLevelStatement)
	| HappyAbsSyn6 (Variant)
	| HappyAbsSyn7 ([Variant])
	| HappyAbsSyn8 (String)
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 (Argument)
	| HappyAbsSyn11 ([Argument])
	| HappyAbsSyn13 ([Expression])
	| HappyAbsSyn14 (LocalName)
	| HappyAbsSyn15 (NonEmpty LocalName)
	| HappyAbsSyn16 (LambdaArgument)
	| HappyAbsSyn17 (NonEmpty LambdaArgument)
	| HappyAbsSyn18 (NonEmpty String)
	| HappyAbsSyn19 (P.Pattern)
	| HappyAbsSyn20 (NonEmpty P.Pattern)
	| HappyAbsSyn21 ([Pattern])
	| HappyAbsSyn26 (Case)
	| HappyAbsSyn27 ([Case])
	| HappyAbsSyn28 (Expression)
	| HappyAbsSyn32 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,560) ([0,0,28,0,0,0,7,0,0,0,0,0,0,0,32,0,0,0,12,0,0,0,3,0,0,0,0,0,0,112,0,0,0,0,0,0,0,0,4,0,0,0,1,0,0,16384,0,0,0,4096,0,0,0,1024,0,0,0,33792,0,0,4096,0,0,0,0,2048,0,0,0,512,0,0,4096,128,0,0,1024,32,0,57344,5247,1,0,63488,17695,0,0,65024,4423,0,0,65408,1105,0,0,32736,276,0,0,8184,69,0,0,64,0,0,0,0,32,0,0,0,4,0,0,2048,0,0,0,0,0,0,8192,0,0,0,32736,276,0,0,0,16,0,0,40960,0,0,32768,16638,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8448,20,0,0,2112,0,0,32768,53759,4,0,57344,5247,1,0,0,0,4,0,0,2048,0,0,0,64,0,0,0,0,0,0,256,0,0,0,18430,17,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,1,0,0,0,0,0,0,18430,17,0,32768,20991,4,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,2048,0,0,0,0,128,0,0,0,64,0,0,32768,16,0,0,0,0,0,0,0,0,0,16384,8,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,2112,1,0,0,2048,1,0,0,132,0,0,40960,17451,0,0,0,16,0,0,0,0,0,0,32736,308,0,0,4072,68,0,0,1018,17,0,0,32,0,0,0,32768,0,0,0,512,0,0,0,160,0,0,0,4,0,0,0,0,0,0,8184,69,0,0,2792,17,0,0,0,0,0,0,0,4,0,0,128,0,0,0,0,1,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,59392,4362,0,0,47616,3138,0,0,0,2048,0,0,4072,68,0,0,2792,17,0,0,0,0,0,57344,5247,1,0,0,0,0,0,0,0,0,0,65408,1105,0,0,32736,276,0,0,0,0,0,0,0,0,0,32768,20991,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,256,0,0,0,8,0,0,0,0,0,57344,5247,1,0,0,32768,0,0,0,0,0,0,0,128,0,0,0,1024,0,0,0,0,0,0,2792,17,0,32768,20991,4,0,32768,4270,1,0,0,0,0,0,59392,4362,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2792,17,0,0,0,16,0,40960,4159,1,0,0,0,0,0,0,512,0,0,65408,1105,0,0,0,1,0,0,11168,68,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,47616,1090,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,57344,5247,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,32768,0,0,32768,4270,1,0,0,0,0,0,0,0,0,0,0,128,0,0,44672,272,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Statement","Variant","Variants","LocalName","LocalNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","BinaryExpression","Juxtaposition","Atom","IntegerLiteral","FloatLiteral","StringLiteral","datatype","declare","define","type","let","int","float","string","lsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","forall","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 62
        bit_end = (st Prelude.+ 1) Prelude.* 62
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..61]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (35) = happyShift action_3
action_0 (36) = happyShift action_4
action_0 (37) = happyShift action_5
action_0 (4) = happyGoto action_6
action_0 (5) = happyGoto action_7
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (35) = happyShift action_3
action_1 (36) = happyShift action_4
action_1 (37) = happyShift action_5
action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyFail (happyExpListPerState 2)

action_3 (44) = happyShift action_13
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (43) = happyShift action_11
action_4 (44) = happyShift action_12
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (43) = happyShift action_9
action_5 (44) = happyShift action_10
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (62) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (35) = happyShift action_3
action_7 (36) = happyShift action_4
action_7 (37) = happyShift action_5
action_7 (4) = happyGoto action_8
action_7 (5) = happyGoto action_7
action_7 _ = happyReduce_1

action_8 _ = happyReduce_2

action_9 (53) = happyShift action_15
action_9 (12) = happyGoto action_19
action_9 _ = happyReduce_22

action_10 (53) = happyShift action_15
action_10 (12) = happyGoto action_18
action_10 _ = happyReduce_22

action_11 (53) = happyShift action_15
action_11 (12) = happyGoto action_17
action_11 _ = happyReduce_22

action_12 (53) = happyShift action_15
action_12 (12) = happyGoto action_16
action_12 _ = happyReduce_22

action_13 (53) = happyShift action_15
action_13 (12) = happyGoto action_14
action_13 _ = happyReduce_22

action_14 (55) = happyShift action_31
action_14 (60) = happyShift action_32
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (43) = happyShift action_30
action_15 (8) = happyGoto action_26
action_15 (9) = happyGoto action_27
action_15 (10) = happyGoto action_28
action_15 (11) = happyGoto action_29
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (60) = happyShift action_25
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (60) = happyShift action_24
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (49) = happyShift action_22
action_18 (60) = happyShift action_23
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (49) = happyShift action_20
action_19 (60) = happyShift action_21
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (38) = happyShift action_40
action_20 (39) = happyShift action_41
action_20 (40) = happyShift action_42
action_20 (41) = happyShift action_43
action_20 (42) = happyShift action_44
action_20 (43) = happyShift action_45
action_20 (44) = happyShift action_46
action_20 (45) = happyShift action_47
action_20 (46) = happyShift action_48
action_20 (47) = happyShift action_49
action_20 (51) = happyShift action_50
action_20 (53) = happyShift action_51
action_20 (57) = happyShift action_52
action_20 (28) = happyGoto action_65
action_20 (29) = happyGoto action_34
action_20 (30) = happyGoto action_35
action_20 (31) = happyGoto action_36
action_20 (32) = happyGoto action_37
action_20 (33) = happyGoto action_38
action_20 (34) = happyGoto action_39
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (38) = happyShift action_40
action_21 (39) = happyShift action_41
action_21 (40) = happyShift action_42
action_21 (41) = happyShift action_43
action_21 (42) = happyShift action_44
action_21 (43) = happyShift action_45
action_21 (44) = happyShift action_46
action_21 (45) = happyShift action_47
action_21 (46) = happyShift action_48
action_21 (47) = happyShift action_49
action_21 (51) = happyShift action_50
action_21 (53) = happyShift action_51
action_21 (57) = happyShift action_52
action_21 (28) = happyGoto action_64
action_21 (29) = happyGoto action_34
action_21 (30) = happyGoto action_35
action_21 (31) = happyGoto action_36
action_21 (32) = happyGoto action_37
action_21 (33) = happyGoto action_38
action_21 (34) = happyGoto action_39
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (38) = happyShift action_40
action_22 (39) = happyShift action_41
action_22 (40) = happyShift action_42
action_22 (41) = happyShift action_43
action_22 (42) = happyShift action_44
action_22 (43) = happyShift action_45
action_22 (44) = happyShift action_46
action_22 (45) = happyShift action_47
action_22 (46) = happyShift action_48
action_22 (47) = happyShift action_49
action_22 (51) = happyShift action_50
action_22 (53) = happyShift action_51
action_22 (57) = happyShift action_52
action_22 (28) = happyGoto action_63
action_22 (29) = happyGoto action_34
action_22 (30) = happyGoto action_35
action_22 (31) = happyGoto action_36
action_22 (32) = happyGoto action_37
action_22 (33) = happyGoto action_38
action_22 (34) = happyGoto action_39
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (38) = happyShift action_40
action_23 (39) = happyShift action_41
action_23 (40) = happyShift action_42
action_23 (41) = happyShift action_43
action_23 (42) = happyShift action_44
action_23 (43) = happyShift action_45
action_23 (44) = happyShift action_46
action_23 (45) = happyShift action_47
action_23 (46) = happyShift action_48
action_23 (47) = happyShift action_49
action_23 (51) = happyShift action_50
action_23 (53) = happyShift action_51
action_23 (57) = happyShift action_52
action_23 (28) = happyGoto action_62
action_23 (29) = happyGoto action_34
action_23 (30) = happyGoto action_35
action_23 (31) = happyGoto action_36
action_23 (32) = happyGoto action_37
action_23 (33) = happyGoto action_38
action_23 (34) = happyGoto action_39
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (38) = happyShift action_40
action_24 (39) = happyShift action_41
action_24 (40) = happyShift action_42
action_24 (41) = happyShift action_43
action_24 (42) = happyShift action_44
action_24 (43) = happyShift action_45
action_24 (44) = happyShift action_46
action_24 (45) = happyShift action_47
action_24 (46) = happyShift action_48
action_24 (47) = happyShift action_49
action_24 (51) = happyShift action_50
action_24 (53) = happyShift action_51
action_24 (57) = happyShift action_52
action_24 (28) = happyGoto action_61
action_24 (29) = happyGoto action_34
action_24 (30) = happyGoto action_35
action_24 (31) = happyGoto action_36
action_24 (32) = happyGoto action_37
action_24 (33) = happyGoto action_38
action_24 (34) = happyGoto action_39
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (38) = happyShift action_40
action_25 (39) = happyShift action_41
action_25 (40) = happyShift action_42
action_25 (41) = happyShift action_43
action_25 (42) = happyShift action_44
action_25 (43) = happyShift action_45
action_25 (44) = happyShift action_46
action_25 (45) = happyShift action_47
action_25 (46) = happyShift action_48
action_25 (47) = happyShift action_49
action_25 (51) = happyShift action_50
action_25 (53) = happyShift action_51
action_25 (57) = happyShift action_52
action_25 (28) = happyGoto action_60
action_25 (29) = happyGoto action_34
action_25 (30) = happyGoto action_35
action_25 (31) = happyGoto action_36
action_25 (32) = happyGoto action_37
action_25 (33) = happyGoto action_38
action_25 (34) = happyGoto action_39
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (43) = happyShift action_30
action_26 (8) = happyGoto action_26
action_26 (9) = happyGoto action_59
action_26 _ = happyReduce_17

action_27 (60) = happyShift action_58
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (59) = happyShift action_57
action_28 _ = happyReduce_20

action_29 (54) = happyShift action_56
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_16

action_31 (44) = happyShift action_55
action_31 (6) = happyGoto action_53
action_31 (7) = happyGoto action_54
action_31 _ = happyReduce_13

action_32 (38) = happyShift action_40
action_32 (39) = happyShift action_41
action_32 (40) = happyShift action_42
action_32 (41) = happyShift action_43
action_32 (42) = happyShift action_44
action_32 (43) = happyShift action_45
action_32 (44) = happyShift action_46
action_32 (45) = happyShift action_47
action_32 (46) = happyShift action_48
action_32 (47) = happyShift action_49
action_32 (51) = happyShift action_50
action_32 (53) = happyShift action_51
action_32 (57) = happyShift action_52
action_32 (28) = happyGoto action_33
action_32 (29) = happyGoto action_34
action_32 (30) = happyGoto action_35
action_32 (31) = happyGoto action_36
action_32 (32) = happyGoto action_37
action_32 (33) = happyGoto action_38
action_32 (34) = happyGoto action_39
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (55) = happyShift action_91
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (50) = happyShift action_89
action_34 (52) = happyShift action_90
action_34 _ = happyReduce_66

action_35 (38) = happyShift action_40
action_35 (40) = happyShift action_42
action_35 (41) = happyShift action_43
action_35 (42) = happyShift action_44
action_35 (43) = happyShift action_45
action_35 (44) = happyShift action_46
action_35 (45) = happyShift action_47
action_35 (46) = happyShift action_48
action_35 (53) = happyShift action_88
action_35 (57) = happyShift action_52
action_35 (31) = happyGoto action_87
action_35 (32) = happyGoto action_37
action_35 (33) = happyGoto action_38
action_35 (34) = happyGoto action_39
action_35 _ = happyReduce_69

action_36 _ = happyReduce_72

action_37 _ = happyReduce_82

action_38 _ = happyReduce_83

action_39 _ = happyReduce_84

action_40 _ = happyReduce_81

action_41 (43) = happyShift action_86
action_41 _ = happyFail (happyExpListPerState 41)

action_42 _ = happyReduce_85

action_43 _ = happyReduce_86

action_44 _ = happyReduce_87

action_45 _ = happyReduce_77

action_46 _ = happyReduce_78

action_47 _ = happyReduce_79

action_48 _ = happyReduce_80

action_49 (43) = happyShift action_30
action_49 (48) = happyShift action_80
action_49 (53) = happyShift action_84
action_49 (55) = happyShift action_85
action_49 (8) = happyGoto action_77
action_49 (14) = happyGoto action_81
action_49 (16) = happyGoto action_82
action_49 (17) = happyGoto action_83
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (43) = happyShift action_30
action_50 (48) = happyShift action_80
action_50 (8) = happyGoto action_77
action_50 (14) = happyGoto action_78
action_50 (15) = happyGoto action_79
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (38) = happyShift action_40
action_51 (39) = happyShift action_41
action_51 (40) = happyShift action_42
action_51 (41) = happyShift action_43
action_51 (42) = happyShift action_44
action_51 (43) = happyShift action_45
action_51 (44) = happyShift action_46
action_51 (45) = happyShift action_47
action_51 (46) = happyShift action_48
action_51 (47) = happyShift action_49
action_51 (51) = happyShift action_50
action_51 (53) = happyShift action_51
action_51 (54) = happyShift action_76
action_51 (57) = happyShift action_52
action_51 (28) = happyGoto action_75
action_51 (29) = happyGoto action_34
action_51 (30) = happyGoto action_35
action_51 (31) = happyGoto action_36
action_51 (32) = happyGoto action_37
action_51 (33) = happyGoto action_38
action_51 (34) = happyGoto action_39
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (38) = happyShift action_40
action_52 (39) = happyShift action_41
action_52 (40) = happyShift action_42
action_52 (41) = happyShift action_43
action_52 (42) = happyShift action_44
action_52 (43) = happyShift action_45
action_52 (44) = happyShift action_46
action_52 (45) = happyShift action_47
action_52 (46) = happyShift action_48
action_52 (47) = happyShift action_49
action_52 (51) = happyShift action_50
action_52 (53) = happyShift action_51
action_52 (57) = happyShift action_52
action_52 (13) = happyGoto action_73
action_52 (28) = happyGoto action_74
action_52 (29) = happyGoto action_34
action_52 (30) = happyGoto action_35
action_52 (31) = happyGoto action_36
action_52 (32) = happyGoto action_37
action_52 (33) = happyGoto action_38
action_52 (34) = happyGoto action_39
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (61) = happyShift action_72
action_53 _ = happyReduce_14

action_54 (56) = happyShift action_71
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (53) = happyShift action_15
action_55 (12) = happyGoto action_70
action_55 _ = happyReduce_22

action_56 _ = happyReduce_23

action_57 (43) = happyShift action_30
action_57 (8) = happyGoto action_26
action_57 (9) = happyGoto action_27
action_57 (10) = happyGoto action_28
action_57 (11) = happyGoto action_69
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (38) = happyShift action_40
action_58 (39) = happyShift action_41
action_58 (40) = happyShift action_42
action_58 (41) = happyShift action_43
action_58 (42) = happyShift action_44
action_58 (43) = happyShift action_45
action_58 (44) = happyShift action_46
action_58 (45) = happyShift action_47
action_58 (46) = happyShift action_48
action_58 (47) = happyShift action_49
action_58 (51) = happyShift action_50
action_58 (53) = happyShift action_51
action_58 (57) = happyShift action_52
action_58 (28) = happyGoto action_68
action_58 (29) = happyGoto action_34
action_58 (30) = happyGoto action_35
action_58 (31) = happyGoto action_36
action_58 (32) = happyGoto action_37
action_58 (33) = happyGoto action_38
action_58 (34) = happyGoto action_39
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_18

action_60 _ = happyReduce_6

action_61 _ = happyReduce_5

action_62 (49) = happyShift action_67
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_8

action_64 (49) = happyShift action_66
action_64 _ = happyFail (happyExpListPerState 64)

action_65 _ = happyReduce_7

action_66 (38) = happyShift action_40
action_66 (39) = happyShift action_41
action_66 (40) = happyShift action_42
action_66 (41) = happyShift action_43
action_66 (42) = happyShift action_44
action_66 (43) = happyShift action_45
action_66 (44) = happyShift action_46
action_66 (45) = happyShift action_47
action_66 (46) = happyShift action_48
action_66 (47) = happyShift action_49
action_66 (51) = happyShift action_50
action_66 (53) = happyShift action_51
action_66 (57) = happyShift action_52
action_66 (28) = happyGoto action_125
action_66 (29) = happyGoto action_34
action_66 (30) = happyGoto action_35
action_66 (31) = happyGoto action_36
action_66 (32) = happyGoto action_37
action_66 (33) = happyGoto action_38
action_66 (34) = happyGoto action_39
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (38) = happyShift action_40
action_67 (39) = happyShift action_41
action_67 (40) = happyShift action_42
action_67 (41) = happyShift action_43
action_67 (42) = happyShift action_44
action_67 (43) = happyShift action_45
action_67 (44) = happyShift action_46
action_67 (45) = happyShift action_47
action_67 (46) = happyShift action_48
action_67 (47) = happyShift action_49
action_67 (51) = happyShift action_50
action_67 (53) = happyShift action_51
action_67 (57) = happyShift action_52
action_67 (28) = happyGoto action_124
action_67 (29) = happyGoto action_34
action_67 (30) = happyGoto action_35
action_67 (31) = happyGoto action_36
action_67 (32) = happyGoto action_37
action_67 (33) = happyGoto action_38
action_67 (34) = happyGoto action_39
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_19

action_69 _ = happyReduce_21

action_70 (60) = happyShift action_123
action_70 _ = happyReduce_11

action_71 _ = happyReduce_3

action_72 (44) = happyShift action_55
action_72 (6) = happyGoto action_53
action_72 (7) = happyGoto action_122
action_72 _ = happyReduce_13

action_73 (58) = happyShift action_121
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (59) = happyShift action_120
action_74 _ = happyReduce_24

action_75 (54) = happyShift action_118
action_75 (59) = happyShift action_119
action_75 _ = happyFail (happyExpListPerState 75)

action_76 _ = happyReduce_74

action_77 _ = happyReduce_26

action_78 (43) = happyShift action_30
action_78 (48) = happyShift action_80
action_78 (8) = happyGoto action_77
action_78 (14) = happyGoto action_78
action_78 (15) = happyGoto action_117
action_78 _ = happyReduce_28

action_79 (60) = happyShift action_116
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_27

action_81 _ = happyReduce_30

action_82 (43) = happyShift action_30
action_82 (48) = happyShift action_80
action_82 (53) = happyShift action_84
action_82 (8) = happyGoto action_77
action_82 (14) = happyGoto action_81
action_82 (16) = happyGoto action_82
action_82 (17) = happyGoto action_115
action_82 _ = happyReduce_32

action_83 (50) = happyShift action_113
action_83 (55) = happyShift action_114
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (43) = happyShift action_30
action_84 (48) = happyShift action_80
action_84 (8) = happyGoto action_77
action_84 (14) = happyGoto action_78
action_84 (15) = happyGoto action_112
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (40) = happyShift action_42
action_85 (42) = happyShift action_44
action_85 (43) = happyShift action_106
action_85 (44) = happyShift action_107
action_85 (46) = happyShift action_108
action_85 (48) = happyShift action_109
action_85 (53) = happyShift action_110
action_85 (57) = happyShift action_111
action_85 (18) = happyGoto action_98
action_85 (22) = happyGoto action_99
action_85 (24) = happyGoto action_100
action_85 (25) = happyGoto action_101
action_85 (26) = happyGoto action_102
action_85 (27) = happyGoto action_103
action_85 (32) = happyGoto action_104
action_85 (34) = happyGoto action_105
action_85 _ = happyReduce_58

action_86 (49) = happyShift action_97
action_86 _ = happyFail (happyExpListPerState 86)

action_87 _ = happyReduce_70

action_88 (38) = happyShift action_40
action_88 (39) = happyShift action_41
action_88 (40) = happyShift action_42
action_88 (41) = happyShift action_43
action_88 (42) = happyShift action_44
action_88 (43) = happyShift action_96
action_88 (44) = happyShift action_46
action_88 (45) = happyShift action_47
action_88 (46) = happyShift action_48
action_88 (47) = happyShift action_49
action_88 (51) = happyShift action_50
action_88 (53) = happyShift action_51
action_88 (54) = happyShift action_76
action_88 (57) = happyShift action_52
action_88 (8) = happyGoto action_95
action_88 (28) = happyGoto action_75
action_88 (29) = happyGoto action_34
action_88 (30) = happyGoto action_35
action_88 (31) = happyGoto action_36
action_88 (32) = happyGoto action_37
action_88 (33) = happyGoto action_38
action_88 (34) = happyGoto action_39
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (38) = happyShift action_40
action_89 (40) = happyShift action_42
action_89 (41) = happyShift action_43
action_89 (42) = happyShift action_44
action_89 (43) = happyShift action_45
action_89 (44) = happyShift action_46
action_89 (45) = happyShift action_47
action_89 (46) = happyShift action_48
action_89 (53) = happyShift action_51
action_89 (57) = happyShift action_52
action_89 (29) = happyGoto action_94
action_89 (30) = happyGoto action_35
action_89 (31) = happyGoto action_36
action_89 (32) = happyGoto action_37
action_89 (33) = happyGoto action_38
action_89 (34) = happyGoto action_39
action_89 _ = happyFail (happyExpListPerState 89)

action_90 (38) = happyShift action_40
action_90 (40) = happyShift action_42
action_90 (41) = happyShift action_43
action_90 (42) = happyShift action_44
action_90 (43) = happyShift action_45
action_90 (44) = happyShift action_46
action_90 (45) = happyShift action_47
action_90 (46) = happyShift action_48
action_90 (53) = happyShift action_51
action_90 (57) = happyShift action_52
action_90 (29) = happyGoto action_93
action_90 (30) = happyGoto action_35
action_90 (31) = happyGoto action_36
action_90 (32) = happyGoto action_37
action_90 (33) = happyGoto action_38
action_90 (34) = happyGoto action_39
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (44) = happyShift action_55
action_91 (6) = happyGoto action_53
action_91 (7) = happyGoto action_92
action_91 _ = happyReduce_13

action_92 (56) = happyShift action_149
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (52) = happyShift action_90
action_93 _ = happyReduce_68

action_94 (50) = happyShift action_89
action_94 (52) = happyShift action_90
action_94 _ = happyReduce_67

action_95 (49) = happyShift action_148
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (49) = happyReduce_16
action_96 _ = happyReduce_77

action_97 (38) = happyShift action_40
action_97 (39) = happyShift action_41
action_97 (40) = happyShift action_42
action_97 (41) = happyShift action_43
action_97 (42) = happyShift action_44
action_97 (43) = happyShift action_45
action_97 (44) = happyShift action_46
action_97 (45) = happyShift action_47
action_97 (46) = happyShift action_48
action_97 (47) = happyShift action_49
action_97 (51) = happyShift action_50
action_97 (53) = happyShift action_51
action_97 (57) = happyShift action_52
action_97 (28) = happyGoto action_147
action_97 (29) = happyGoto action_34
action_97 (30) = happyGoto action_35
action_97 (31) = happyGoto action_36
action_97 (32) = happyGoto action_37
action_97 (33) = happyGoto action_38
action_97 (34) = happyGoto action_39
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (40) = happyShift action_42
action_98 (42) = happyShift action_44
action_98 (43) = happyShift action_106
action_98 (44) = happyShift action_107
action_98 (46) = happyShift action_108
action_98 (48) = happyShift action_109
action_98 (53) = happyShift action_146
action_98 (57) = happyShift action_111
action_98 (18) = happyGoto action_141
action_98 (19) = happyGoto action_142
action_98 (20) = happyGoto action_143
action_98 (22) = happyGoto action_144
action_98 (23) = happyGoto action_145
action_98 (32) = happyGoto action_104
action_98 (34) = happyGoto action_105
action_98 _ = happyReduce_43

action_99 _ = happyReduce_53

action_100 (59) = happyShift action_140
action_100 _ = happyReduce_55

action_101 (50) = happyShift action_139
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (61) = happyShift action_138
action_102 _ = happyReduce_59

action_103 (56) = happyShift action_137
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_48

action_105 _ = happyReduce_49

action_106 _ = happyReduce_44

action_107 _ = happyReduce_34

action_108 _ = happyReduce_35

action_109 _ = happyReduce_50

action_110 (40) = happyShift action_42
action_110 (42) = happyShift action_44
action_110 (43) = happyShift action_106
action_110 (44) = happyShift action_107
action_110 (46) = happyShift action_108
action_110 (48) = happyShift action_109
action_110 (53) = happyShift action_110
action_110 (57) = happyShift action_111
action_110 (18) = happyGoto action_98
action_110 (21) = happyGoto action_135
action_110 (22) = happyGoto action_99
action_110 (24) = happyGoto action_136
action_110 (32) = happyGoto action_104
action_110 (34) = happyGoto action_105
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (40) = happyShift action_42
action_111 (42) = happyShift action_44
action_111 (43) = happyShift action_106
action_111 (44) = happyShift action_107
action_111 (46) = happyShift action_108
action_111 (48) = happyShift action_109
action_111 (53) = happyShift action_110
action_111 (57) = happyShift action_111
action_111 (58) = happyShift action_134
action_111 (18) = happyGoto action_98
action_111 (22) = happyGoto action_99
action_111 (24) = happyGoto action_100
action_111 (25) = happyGoto action_133
action_111 (32) = happyGoto action_104
action_111 (34) = happyGoto action_105
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (60) = happyShift action_132
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (38) = happyShift action_40
action_113 (40) = happyShift action_42
action_113 (41) = happyShift action_43
action_113 (42) = happyShift action_44
action_113 (43) = happyShift action_45
action_113 (44) = happyShift action_46
action_113 (45) = happyShift action_47
action_113 (46) = happyShift action_48
action_113 (53) = happyShift action_51
action_113 (57) = happyShift action_52
action_113 (31) = happyGoto action_131
action_113 (32) = happyGoto action_37
action_113 (33) = happyGoto action_38
action_113 (34) = happyGoto action_39
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (40) = happyShift action_42
action_114 (42) = happyShift action_44
action_114 (43) = happyShift action_106
action_114 (44) = happyShift action_107
action_114 (46) = happyShift action_108
action_114 (48) = happyShift action_109
action_114 (53) = happyShift action_110
action_114 (57) = happyShift action_111
action_114 (18) = happyGoto action_98
action_114 (22) = happyGoto action_99
action_114 (24) = happyGoto action_100
action_114 (25) = happyGoto action_101
action_114 (26) = happyGoto action_102
action_114 (27) = happyGoto action_130
action_114 (32) = happyGoto action_104
action_114 (34) = happyGoto action_105
action_114 _ = happyReduce_58

action_115 _ = happyReduce_33

action_116 (38) = happyShift action_40
action_116 (39) = happyShift action_41
action_116 (40) = happyShift action_42
action_116 (41) = happyShift action_43
action_116 (42) = happyShift action_44
action_116 (43) = happyShift action_45
action_116 (44) = happyShift action_46
action_116 (45) = happyShift action_47
action_116 (46) = happyShift action_48
action_116 (47) = happyShift action_49
action_116 (51) = happyShift action_50
action_116 (53) = happyShift action_51
action_116 (57) = happyShift action_52
action_116 (28) = happyGoto action_129
action_116 (29) = happyGoto action_34
action_116 (30) = happyGoto action_35
action_116 (31) = happyGoto action_36
action_116 (32) = happyGoto action_37
action_116 (33) = happyGoto action_38
action_116 (34) = happyGoto action_39
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_29

action_118 _ = happyReduce_73

action_119 (38) = happyShift action_40
action_119 (39) = happyShift action_41
action_119 (40) = happyShift action_42
action_119 (41) = happyShift action_43
action_119 (42) = happyShift action_44
action_119 (43) = happyShift action_45
action_119 (44) = happyShift action_46
action_119 (45) = happyShift action_47
action_119 (46) = happyShift action_48
action_119 (47) = happyShift action_49
action_119 (51) = happyShift action_50
action_119 (53) = happyShift action_51
action_119 (57) = happyShift action_52
action_119 (13) = happyGoto action_128
action_119 (28) = happyGoto action_74
action_119 (29) = happyGoto action_34
action_119 (30) = happyGoto action_35
action_119 (31) = happyGoto action_36
action_119 (32) = happyGoto action_37
action_119 (33) = happyGoto action_38
action_119 (34) = happyGoto action_39
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (38) = happyShift action_40
action_120 (39) = happyShift action_41
action_120 (40) = happyShift action_42
action_120 (41) = happyShift action_43
action_120 (42) = happyShift action_44
action_120 (43) = happyShift action_45
action_120 (44) = happyShift action_46
action_120 (45) = happyShift action_47
action_120 (46) = happyShift action_48
action_120 (47) = happyShift action_49
action_120 (51) = happyShift action_50
action_120 (53) = happyShift action_51
action_120 (57) = happyShift action_52
action_120 (13) = happyGoto action_127
action_120 (28) = happyGoto action_74
action_120 (29) = happyGoto action_34
action_120 (30) = happyGoto action_35
action_120 (31) = happyGoto action_36
action_120 (32) = happyGoto action_37
action_120 (33) = happyGoto action_38
action_120 (34) = happyGoto action_39
action_120 _ = happyFail (happyExpListPerState 120)

action_121 _ = happyReduce_76

action_122 _ = happyReduce_15

action_123 (38) = happyShift action_40
action_123 (39) = happyShift action_41
action_123 (40) = happyShift action_42
action_123 (41) = happyShift action_43
action_123 (42) = happyShift action_44
action_123 (43) = happyShift action_45
action_123 (44) = happyShift action_46
action_123 (45) = happyShift action_47
action_123 (46) = happyShift action_48
action_123 (47) = happyShift action_49
action_123 (51) = happyShift action_50
action_123 (53) = happyShift action_51
action_123 (57) = happyShift action_52
action_123 (28) = happyGoto action_126
action_123 (29) = happyGoto action_34
action_123 (30) = happyGoto action_35
action_123 (31) = happyGoto action_36
action_123 (32) = happyGoto action_37
action_123 (33) = happyGoto action_38
action_123 (34) = happyGoto action_39
action_123 _ = happyFail (happyExpListPerState 123)

action_124 _ = happyReduce_10

action_125 _ = happyReduce_9

action_126 _ = happyReduce_12

action_127 _ = happyReduce_25

action_128 (54) = happyShift action_165
action_128 _ = happyFail (happyExpListPerState 128)

action_129 (59) = happyShift action_164
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (56) = happyShift action_163
action_130 _ = happyFail (happyExpListPerState 130)

action_131 _ = happyReduce_63

action_132 (38) = happyShift action_40
action_132 (39) = happyShift action_41
action_132 (40) = happyShift action_42
action_132 (41) = happyShift action_43
action_132 (42) = happyShift action_44
action_132 (43) = happyShift action_45
action_132 (44) = happyShift action_46
action_132 (45) = happyShift action_47
action_132 (46) = happyShift action_48
action_132 (47) = happyShift action_49
action_132 (51) = happyShift action_50
action_132 (53) = happyShift action_51
action_132 (57) = happyShift action_52
action_132 (28) = happyGoto action_162
action_132 (29) = happyGoto action_34
action_132 (30) = happyGoto action_35
action_132 (31) = happyGoto action_36
action_132 (32) = happyGoto action_37
action_132 (33) = happyGoto action_38
action_132 (34) = happyGoto action_39
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (58) = happyShift action_161
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_46

action_135 (54) = happyShift action_160
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (59) = happyShift action_159
action_136 _ = happyFail (happyExpListPerState 136)

action_137 _ = happyReduce_65

action_138 (40) = happyShift action_42
action_138 (42) = happyShift action_44
action_138 (43) = happyShift action_106
action_138 (44) = happyShift action_107
action_138 (46) = happyShift action_108
action_138 (48) = happyShift action_109
action_138 (53) = happyShift action_110
action_138 (57) = happyShift action_111
action_138 (18) = happyGoto action_98
action_138 (22) = happyGoto action_99
action_138 (24) = happyGoto action_100
action_138 (25) = happyGoto action_101
action_138 (26) = happyGoto action_102
action_138 (27) = happyGoto action_158
action_138 (32) = happyGoto action_104
action_138 (34) = happyGoto action_105
action_138 _ = happyReduce_58

action_139 (38) = happyShift action_40
action_139 (39) = happyShift action_41
action_139 (40) = happyShift action_42
action_139 (41) = happyShift action_43
action_139 (42) = happyShift action_44
action_139 (43) = happyShift action_45
action_139 (44) = happyShift action_46
action_139 (45) = happyShift action_47
action_139 (46) = happyShift action_48
action_139 (47) = happyShift action_49
action_139 (51) = happyShift action_50
action_139 (53) = happyShift action_51
action_139 (57) = happyShift action_52
action_139 (28) = happyGoto action_157
action_139 (29) = happyGoto action_34
action_139 (30) = happyGoto action_35
action_139 (31) = happyGoto action_36
action_139 (32) = happyGoto action_37
action_139 (33) = happyGoto action_38
action_139 (34) = happyGoto action_39
action_139 _ = happyFail (happyExpListPerState 139)

action_140 (40) = happyShift action_42
action_140 (42) = happyShift action_44
action_140 (43) = happyShift action_106
action_140 (44) = happyShift action_107
action_140 (46) = happyShift action_108
action_140 (48) = happyShift action_109
action_140 (53) = happyShift action_110
action_140 (57) = happyShift action_111
action_140 (18) = happyGoto action_98
action_140 (22) = happyGoto action_99
action_140 (24) = happyGoto action_100
action_140 (25) = happyGoto action_156
action_140 (32) = happyGoto action_104
action_140 (34) = happyGoto action_105
action_140 _ = happyFail (happyExpListPerState 140)

action_141 _ = happyReduce_43

action_142 (40) = happyShift action_42
action_142 (42) = happyShift action_44
action_142 (43) = happyShift action_106
action_142 (44) = happyShift action_107
action_142 (46) = happyShift action_108
action_142 (48) = happyShift action_109
action_142 (53) = happyShift action_146
action_142 (57) = happyShift action_111
action_142 (18) = happyGoto action_141
action_142 (19) = happyGoto action_142
action_142 (20) = happyGoto action_155
action_142 (22) = happyGoto action_144
action_142 (23) = happyGoto action_145
action_142 (32) = happyGoto action_104
action_142 (34) = happyGoto action_105
action_142 _ = happyReduce_39

action_143 _ = happyReduce_54

action_144 _ = happyReduce_51

action_145 _ = happyReduce_36

action_146 (40) = happyShift action_42
action_146 (42) = happyShift action_44
action_146 (43) = happyShift action_154
action_146 (44) = happyShift action_107
action_146 (46) = happyShift action_108
action_146 (48) = happyShift action_109
action_146 (53) = happyShift action_110
action_146 (57) = happyShift action_111
action_146 (8) = happyGoto action_152
action_146 (18) = happyGoto action_153
action_146 (21) = happyGoto action_135
action_146 (22) = happyGoto action_99
action_146 (24) = happyGoto action_136
action_146 (32) = happyGoto action_104
action_146 (34) = happyGoto action_105
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (59) = happyShift action_151
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (38) = happyShift action_40
action_148 (40) = happyShift action_42
action_148 (41) = happyShift action_43
action_148 (42) = happyShift action_44
action_148 (43) = happyShift action_45
action_148 (44) = happyShift action_46
action_148 (45) = happyShift action_47
action_148 (46) = happyShift action_48
action_148 (53) = happyShift action_51
action_148 (57) = happyShift action_52
action_148 (31) = happyGoto action_150
action_148 (32) = happyGoto action_37
action_148 (33) = happyGoto action_38
action_148 (34) = happyGoto action_39
action_148 _ = happyFail (happyExpListPerState 148)

action_149 _ = happyReduce_4

action_150 (54) = happyShift action_174
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (38) = happyShift action_40
action_151 (39) = happyShift action_41
action_151 (40) = happyShift action_42
action_151 (41) = happyShift action_43
action_151 (42) = happyShift action_44
action_151 (43) = happyShift action_45
action_151 (44) = happyShift action_46
action_151 (45) = happyShift action_47
action_151 (46) = happyShift action_48
action_151 (47) = happyShift action_49
action_151 (51) = happyShift action_50
action_151 (53) = happyShift action_51
action_151 (57) = happyShift action_52
action_151 (28) = happyGoto action_173
action_151 (29) = happyGoto action_34
action_151 (30) = happyGoto action_35
action_151 (31) = happyGoto action_36
action_151 (32) = happyGoto action_37
action_151 (33) = happyGoto action_38
action_151 (34) = happyGoto action_39
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (49) = happyShift action_172
action_152 _ = happyFail (happyExpListPerState 152)

action_153 (40) = happyShift action_42
action_153 (42) = happyShift action_44
action_153 (43) = happyShift action_106
action_153 (44) = happyShift action_107
action_153 (46) = happyShift action_108
action_153 (48) = happyShift action_109
action_153 (53) = happyShift action_146
action_153 (57) = happyShift action_111
action_153 (18) = happyGoto action_141
action_153 (19) = happyGoto action_142
action_153 (20) = happyGoto action_171
action_153 (22) = happyGoto action_144
action_153 (23) = happyGoto action_145
action_153 (32) = happyGoto action_104
action_153 (34) = happyGoto action_105
action_153 _ = happyReduce_43

action_154 (54) = happyShift action_170
action_154 (59) = happyReduce_44
action_154 _ = happyReduce_16

action_155 _ = happyReduce_40

action_156 _ = happyReduce_56

action_157 _ = happyReduce_57

action_158 _ = happyReduce_60

action_159 (40) = happyShift action_42
action_159 (42) = happyShift action_44
action_159 (43) = happyShift action_106
action_159 (44) = happyShift action_107
action_159 (46) = happyShift action_108
action_159 (48) = happyShift action_109
action_159 (53) = happyShift action_110
action_159 (57) = happyShift action_111
action_159 (18) = happyGoto action_98
action_159 (21) = happyGoto action_168
action_159 (22) = happyGoto action_99
action_159 (24) = happyGoto action_169
action_159 (32) = happyGoto action_104
action_159 (34) = happyGoto action_105
action_159 _ = happyFail (happyExpListPerState 159)

action_160 _ = happyReduce_45

action_161 _ = happyReduce_47

action_162 (54) = happyShift action_167
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_64

action_164 (38) = happyShift action_40
action_164 (39) = happyShift action_41
action_164 (40) = happyShift action_42
action_164 (41) = happyShift action_43
action_164 (42) = happyShift action_44
action_164 (43) = happyShift action_45
action_164 (44) = happyShift action_46
action_164 (45) = happyShift action_47
action_164 (46) = happyShift action_48
action_164 (47) = happyShift action_49
action_164 (51) = happyShift action_50
action_164 (53) = happyShift action_51
action_164 (57) = happyShift action_52
action_164 (28) = happyGoto action_166
action_164 (29) = happyGoto action_34
action_164 (30) = happyGoto action_35
action_164 (31) = happyGoto action_36
action_164 (32) = happyGoto action_37
action_164 (33) = happyGoto action_38
action_164 (34) = happyGoto action_39
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_75

action_166 _ = happyReduce_62

action_167 _ = happyReduce_31

action_168 _ = happyReduce_42

action_169 (59) = happyShift action_159
action_169 _ = happyReduce_41

action_170 _ = happyReduce_38

action_171 (54) = happyShift action_177
action_171 _ = happyReduce_54

action_172 (40) = happyShift action_42
action_172 (42) = happyShift action_44
action_172 (43) = happyShift action_106
action_172 (44) = happyShift action_107
action_172 (46) = happyShift action_108
action_172 (48) = happyShift action_109
action_172 (53) = happyShift action_176
action_172 (57) = happyShift action_111
action_172 (18) = happyGoto action_141
action_172 (22) = happyGoto action_144
action_172 (23) = happyGoto action_175
action_172 (32) = happyGoto action_104
action_172 (34) = happyGoto action_105
action_172 _ = happyFail (happyExpListPerState 172)

action_173 _ = happyReduce_61

action_174 _ = happyReduce_71

action_175 (54) = happyShift action_178
action_175 _ = happyFail (happyExpListPerState 175)

action_176 (40) = happyShift action_42
action_176 (42) = happyShift action_44
action_176 (43) = happyShift action_106
action_176 (44) = happyShift action_107
action_176 (46) = happyShift action_108
action_176 (48) = happyShift action_109
action_176 (53) = happyShift action_110
action_176 (57) = happyShift action_111
action_176 (18) = happyGoto action_153
action_176 (21) = happyGoto action_135
action_176 (22) = happyGoto action_99
action_176 (24) = happyGoto action_136
action_176 (32) = happyGoto action_104
action_176 (34) = happyGoto action_105
action_176 _ = happyFail (happyExpListPerState 176)

action_177 _ = happyReduce_52

action_178 _ = happyReduce_37

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Source [happy_var_1]
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (Source (happy_var_1 : statements happy_var_2)
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 6 5 happyReduction_3
happyReduction_3 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (DataDeclaration happy_var_2 happy_var_3 Nothing happy_var_5 []
	) `HappyStk` happyRest

happyReduce_4 = happyReduce 8 5 happyReduction_4
happyReduction_4 (_ `HappyStk`
	(HappyAbsSyn7  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (DataDeclaration happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_5 = happyReduce 5 5 happyReduction_5
happyReduction_5 ((HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Declaration happy_var_2 happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 5 5 happyReduction_6
happyReduction_6 ((HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Declaration happy_var_2 happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 5 5 happyReduction_7
happyReduction_7 ((HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Definition happy_var_2 happy_var_3 Nothing happy_var_5 []
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 5 5 happyReduction_8
happyReduction_8 ((HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Definition happy_var_2 happy_var_3 Nothing happy_var_5 []
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 7 5 happyReduction_9
happyReduction_9 ((HappyAbsSyn28  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Definition happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_10 = happyReduce 7 5 happyReduction_10
happyReduction_10 ((HappyAbsSyn28  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Definition happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_11 = happySpecReduce_2  6 happyReduction_11
happyReduction_11 (HappyAbsSyn11  happy_var_2)
	(HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn6
		 (([], happy_var_1, happy_var_2, Nothing)
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happyReduce 4 6 happyReduction_12
happyReduction_12 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (([], happy_var_1, happy_var_2, Just happy_var_4)
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_0  7 happyReduction_13
happyReduction_13  =  HappyAbsSyn7
		 ([]
	)

happyReduce_14 = happySpecReduce_1  7 happyReduction_14
happyReduction_14 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn7
		 ([happy_var_1]
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  7 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1 : happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  8 happyReduction_16
happyReduction_16 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  9 happyReduction_17
happyReduction_17 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 :| []
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  9 happyReduction_18
happyReduction_18 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  10 happyReduction_19
happyReduction_19 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 ((happy_var_1, happy_var_3, [])
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  11 happyReduction_20
happyReduction_20 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  11 happyReduction_21
happyReduction_21 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 : happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_0  12 happyReduction_22
happyReduction_22  =  HappyAbsSyn11
		 ([]
	)

happyReduce_23 = happySpecReduce_3  12 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (happy_var_2
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  13 happyReduction_24
happyReduction_24 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  13 happyReduction_25
happyReduction_25 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1 : happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  14 happyReduction_26
happyReduction_26 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  14 happyReduction_27
happyReduction_27 _
	 =  HappyAbsSyn14
		 ("_"
	)

happyReduce_28 = happySpecReduce_1  15 happyReduction_28
happyReduction_28 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1 :| []
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  15 happyReduction_29
happyReduction_29 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  16 happyReduction_30
happyReduction_30 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn16
		 ((happy_var_1 :| [], Nothing)
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happyReduce 5 16 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 ((happy_var_2, Just happy_var_4)
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_1  17 happyReduction_32
happyReduction_32 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| []
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  17 happyReduction_33
happyReduction_33 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  18 happyReduction_34
happyReduction_34 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn18
		 (happy_var_1 :| []
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  18 happyReduction_35
happyReduction_35 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  19 happyReduction_36
happyReduction_36 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happyReduce 5 19 happyReduction_37
happyReduction_37 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (Implicit happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_3  19 happyReduction_38
happyReduction_38 _
	(HappyTerminal (TokenLSym happy_var_2))
	_
	 =  HappyAbsSyn19
		 (PunnedImplicit happy_var_2
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_1  20 happyReduction_39
happyReduction_39 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| []
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  20 happyReduction_40
happyReduction_40 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  21 happyReduction_41
happyReduction_41 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 ([happy_var_1, happy_var_3]
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  21 happyReduction_42
happyReduction_42 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1 : happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  22 happyReduction_43
happyReduction_43 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Data happy_var_1 []
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  22 happyReduction_44
happyReduction_44 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn19
		 (P.Variable happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  22 happyReduction_45
happyReduction_45 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (P.Tuple happy_var_2
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  22 happyReduction_46
happyReduction_46 _
	_
	 =  HappyAbsSyn19
		 (P.List []
	)

happyReduce_47 = happySpecReduce_3  22 happyReduction_47
happyReduction_47 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (P.List (toList happy_var_2)
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  22 happyReduction_48
happyReduction_48 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Literal happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  22 happyReduction_49
happyReduction_49 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Literal happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  22 happyReduction_50
happyReduction_50 _
	 =  HappyAbsSyn19
		 (Wildcard
	)

happyReduce_51 = happySpecReduce_1  23 happyReduction_51
happyReduction_51 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happyReduce 4 23 happyReduction_52
happyReduction_52 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_53 = happySpecReduce_1  24 happyReduction_53
happyReduction_53 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_2  24 happyReduction_54
happyReduction_54 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_54 _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  25 happyReduction_55
happyReduction_55 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| []
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  25 happyReduction_56
happyReduction_56 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  26 happyReduction_57
happyReduction_57 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn26
		 ((happy_var_1, happy_var_3)
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_0  27 happyReduction_58
happyReduction_58  =  HappyAbsSyn27
		 ([]
	)

happyReduce_59 = happySpecReduce_1  27 happyReduction_59
happyReduction_59 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  27 happyReduction_60
happyReduction_60 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happyReduce 6 28 happyReduction_61
happyReduction_61 ((HappyAbsSyn28  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_62 = happyReduce 6 28 happyReduction_62
happyReduction_62 ((HappyAbsSyn28  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (ForAll happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_63 = happyReduce 4 28 happyReduction_63
happyReduction_63 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_64 = happyReduce 5 28 happyReduction_64
happyReduction_64 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_65 = happyReduce 4 28 happyReduction_65
happyReduction_65 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_66 = happySpecReduce_1  28 happyReduction_66
happyReduction_66 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  29 happyReduction_67
happyReduction_67 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  29 happyReduction_68
happyReduction_68 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (TokenInfixOp happy_var_2))
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Infix happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_1  29 happyReduction_69
happyReduction_69 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_69 _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_2  30 happyReduction_70
happyReduction_70 (HappyAbsSyn28  happy_var_2)
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Application happy_var_1 ((Nothing, happy_var_2) :| [])
	)
happyReduction_70 _ _  = notHappyAtAll 

happyReduce_71 = happyReduce 6 30 happyReduction_71
happyReduction_71 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Application happy_var_1 ((Just happy_var_3, happy_var_5) :| [])
	) `HappyStk` happyRest

happyReduce_72 = happySpecReduce_1  30 happyReduction_72
happyReduction_72 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  31 happyReduction_73
happyReduction_73 _
	(HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (Parenthesized happy_var_2
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_2  31 happyReduction_74
happyReduction_74 _
	_
	 =  HappyAbsSyn28
		 (Literal UnitLiteral
	)

happyReduce_75 = happyReduce 5 31 happyReduction_75
happyReduction_75 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_76 = happySpecReduce_3  31 happyReduction_76
happyReduction_76 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (List happy_var_2
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  31 happyReduction_77
happyReduction_77 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  31 happyReduction_78
happyReduction_78 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  31 happyReduction_79
happyReduction_79 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  31 happyReduction_80
happyReduction_80 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier happy_var_1
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  31 happyReduction_81
happyReduction_81 _
	 =  HappyAbsSyn28
		 (Type
	)

happyReduce_82 = happySpecReduce_1  31 happyReduction_82
happyReduction_82 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_82 _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  31 happyReduction_83
happyReduction_83 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  31 happyReduction_84
happyReduction_84 (HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  32 happyReduction_85
happyReduction_85 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn32
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  33 happyReduction_86
happyReduction_86 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn32
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  34 happyReduction_87
happyReduction_87 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn32
		 (StringLiteral happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 62 62 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenDatatype -> cont 35;
	TokenDeclare -> cont 36;
	TokenDefine -> cont 37;
	TokenType -> cont 38;
	TokenLet -> cont 39;
	TokenInt happy_dollar_dollar -> cont 40;
	TokenFloat happy_dollar_dollar -> cont 41;
	TokenString happy_dollar_dollar -> cont 42;
	TokenLSym happy_dollar_dollar -> cont 43;
	TokenUSym happy_dollar_dollar -> cont 44;
	TokenLSymQ happy_dollar_dollar -> cont 45;
	TokenUSymQ happy_dollar_dollar -> cont 46;
	TokenBackslash -> cont 47;
	TokenUnderscore -> cont 48;
	TokenEq -> cont 49;
	TokenArrow -> cont 50;
	TokenForAll -> cont 51;
	TokenInfixOp happy_dollar_dollar -> cont 52;
	TokenLParen -> cont 53;
	TokenRParen -> cont 54;
	TokenLBrace -> cont 55;
	TokenRBrace -> cont 56;
	TokenLBracket -> cont 57;
	TokenRBracket -> cont 58;
	TokenComma -> cont 59;
	TokenColon -> cont 60;
	TokenSemicolon -> cont 61;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 62 tk tks = happyError' (tks, explist)
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
