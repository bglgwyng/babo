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
	| HappyAbsSyn14 (NewName)
	| HappyAbsSyn15 (NonEmpty NewName)
	| HappyAbsSyn16 (LambdaArgument)
	| HappyAbsSyn17 (NonEmpty LambdaArgument)
	| HappyAbsSyn18 (NonEmpty String)
	| HappyAbsSyn19 (P.Pattern)
	| HappyAbsSyn20 (NonEmpty P.Pattern)
	| HappyAbsSyn21 ([Pattern])
	| HappyAbsSyn26 (Case)
	| HappyAbsSyn27 ([Case])
	| HappyAbsSyn28 (Expression)
	| HappyAbsSyn30 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,448) ([0,0,14,0,0,14336,0,0,0,0,0,0,0,64,0,0,32768,0,0,0,512,0,0,0,0,0,0,896,0,0,0,0,0,0,0,1024,0,0,0,16,0,0,16384,0,0,0,33792,0,0,512,0,0,0,0,8,0,0,8200,0,0,4080,17,0,49152,17471,0,0,65280,272,0,0,32,0,0,0,32768,0,0,0,256,0,0,8192,0,0,0,0,0,0,256,0,0,49152,17471,0,0,0,64,0,0,17400,4,0,0,0,0,0,0,0,0,0,0,0,0,0,48,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8192,324,0,0,4080,19,0,49152,17471,0,0,0,4096,0,0,0,2,0,0,256,0,0,0,0,0,0,8,0,0,64512,1091,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,61440,4367,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,4,0,0,0,512,0,0,0,16,0,0,16896,0,0,0,0,0,0,0,0,0,0,0,0,0,4224,1,0,0,4352,0,0,0,0,0,0,1056,0,0,40960,4373,0,0,32768,0,0,0,4350,1,0,63488,1091,0,0,0,0,0,49152,19519,0,0,4096,0,0,0,0,2,0,0,32,0,0,0,0,0,0,2048,0,0,0,48,0,0,4080,17,0,32768,17494,0,0,0,0,0,0,0,16,0,0,64,0,0,0,1024,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,40960,4373,0,0,22144,196,0,0,264,0,0,0,8192,0,0,4064,17,0,32768,17494,0,0,0,0,0,0,0,0,0,61440,4367,0,0,16320,68,0,0,0,0,0,0,0,0,0,4080,17,0,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,32,0,0,0,0,0,64512,1091,0,0,0,0,0,0,32768,0,0,0,0,0,0,32768,0,0,0,16384,0,0,0,0,0,0,4442,1,0,64512,1091,0,0,5536,17,0,0,0,0,0,23040,273,0,0,0,0,0,0,0,0,0,0,0,0,0,4442,1,0,0,4096,0,0,4064,17,0,0,0,0,0,0,32,0,0,17404,4,0,0,32,0,0,22144,68,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17768,4,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,8,0,0,4442,1,0,0,0,0,0,0,0,0,0,2048,0,0,23040,273,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Statement","Variant","Variants","NewName","NewNames","Argument","Arguments_","Arguments","CommaSeperated","NewName_","NewName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","Juxtaposition","IntegerLiteral","FloatLiteral","Atom","BinaryExpression","datatype","declare","define","let","int","float","lsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 58
        bit_end = (st Prelude.+ 1) Prelude.* 58
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..57]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (34) = happyShift action_3
action_0 (35) = happyShift action_4
action_0 (36) = happyShift action_5
action_0 (4) = happyGoto action_6
action_0 (5) = happyGoto action_7
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (34) = happyShift action_3
action_1 (35) = happyShift action_4
action_1 (36) = happyShift action_5
action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyFail (happyExpListPerState 2)

action_3 (41) = happyShift action_11
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (40) = happyShift action_10
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (40) = happyShift action_9
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (58) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (34) = happyShift action_3
action_7 (35) = happyShift action_4
action_7 (36) = happyShift action_5
action_7 (4) = happyGoto action_8
action_7 (5) = happyGoto action_7
action_7 _ = happyReduce_1

action_8 _ = happyReduce_2

action_9 (49) = happyShift action_13
action_9 (12) = happyGoto action_15
action_9 _ = happyReduce_19

action_10 (49) = happyShift action_13
action_10 (12) = happyGoto action_14
action_10 _ = happyReduce_19

action_11 (49) = happyShift action_13
action_11 (12) = happyGoto action_12
action_11 _ = happyReduce_19

action_12 (51) = happyShift action_24
action_12 (56) = happyShift action_25
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (40) = happyShift action_23
action_13 (8) = happyGoto action_19
action_13 (9) = happyGoto action_20
action_13 (10) = happyGoto action_21
action_13 (11) = happyGoto action_22
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (56) = happyShift action_18
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (46) = happyShift action_16
action_15 (56) = happyShift action_17
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (37) = happyShift action_32
action_16 (38) = happyShift action_33
action_16 (39) = happyShift action_34
action_16 (40) = happyShift action_35
action_16 (41) = happyShift action_36
action_16 (42) = happyShift action_37
action_16 (43) = happyShift action_38
action_16 (44) = happyShift action_39
action_16 (49) = happyShift action_40
action_16 (53) = happyShift action_41
action_16 (28) = happyGoto action_51
action_16 (29) = happyGoto action_27
action_16 (30) = happyGoto action_28
action_16 (31) = happyGoto action_29
action_16 (32) = happyGoto action_30
action_16 (33) = happyGoto action_31
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (37) = happyShift action_32
action_17 (38) = happyShift action_33
action_17 (39) = happyShift action_34
action_17 (40) = happyShift action_35
action_17 (41) = happyShift action_36
action_17 (42) = happyShift action_37
action_17 (43) = happyShift action_38
action_17 (44) = happyShift action_39
action_17 (49) = happyShift action_40
action_17 (53) = happyShift action_41
action_17 (28) = happyGoto action_50
action_17 (29) = happyGoto action_27
action_17 (30) = happyGoto action_28
action_17 (31) = happyGoto action_29
action_17 (32) = happyGoto action_30
action_17 (33) = happyGoto action_31
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (37) = happyShift action_32
action_18 (38) = happyShift action_33
action_18 (39) = happyShift action_34
action_18 (40) = happyShift action_35
action_18 (41) = happyShift action_36
action_18 (42) = happyShift action_37
action_18 (43) = happyShift action_38
action_18 (44) = happyShift action_39
action_18 (49) = happyShift action_40
action_18 (53) = happyShift action_41
action_18 (28) = happyGoto action_49
action_18 (29) = happyGoto action_27
action_18 (30) = happyGoto action_28
action_18 (31) = happyGoto action_29
action_18 (32) = happyGoto action_30
action_18 (33) = happyGoto action_31
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (40) = happyShift action_23
action_19 (8) = happyGoto action_19
action_19 (9) = happyGoto action_48
action_19 _ = happyReduce_14

action_20 (56) = happyShift action_47
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (55) = happyShift action_46
action_21 _ = happyReduce_17

action_22 (50) = happyShift action_45
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_13

action_24 (41) = happyShift action_44
action_24 (6) = happyGoto action_42
action_24 (7) = happyGoto action_43
action_24 _ = happyReduce_10

action_25 (37) = happyShift action_32
action_25 (38) = happyShift action_33
action_25 (39) = happyShift action_34
action_25 (40) = happyShift action_35
action_25 (41) = happyShift action_36
action_25 (42) = happyShift action_37
action_25 (43) = happyShift action_38
action_25 (44) = happyShift action_39
action_25 (49) = happyShift action_40
action_25 (53) = happyShift action_41
action_25 (28) = happyGoto action_26
action_25 (29) = happyGoto action_27
action_25 (30) = happyGoto action_28
action_25 (31) = happyGoto action_29
action_25 (32) = happyGoto action_30
action_25 (33) = happyGoto action_31
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (51) = happyShift action_74
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (38) = happyShift action_33
action_27 (39) = happyShift action_34
action_27 (40) = happyShift action_35
action_27 (41) = happyShift action_36
action_27 (42) = happyShift action_37
action_27 (43) = happyShift action_38
action_27 (44) = happyShift action_39
action_27 (49) = happyShift action_73
action_27 (53) = happyShift action_41
action_27 (30) = happyGoto action_28
action_27 (31) = happyGoto action_29
action_27 (32) = happyGoto action_72
action_27 _ = happyReduce_79

action_28 _ = happyReduce_71

action_29 _ = happyReduce_72

action_30 _ = happyReduce_61

action_31 (47) = happyShift action_70
action_31 (48) = happyShift action_71
action_31 _ = happyReduce_58

action_32 (40) = happyShift action_69
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_62

action_34 _ = happyReduce_63

action_35 _ = happyReduce_73

action_36 _ = happyReduce_74

action_37 _ = happyReduce_75

action_38 _ = happyReduce_76

action_39 (40) = happyShift action_23
action_39 (45) = happyShift action_66
action_39 (49) = happyShift action_67
action_39 (51) = happyShift action_68
action_39 (8) = happyGoto action_62
action_39 (14) = happyGoto action_63
action_39 (16) = happyGoto action_64
action_39 (17) = happyGoto action_65
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (37) = happyShift action_32
action_40 (38) = happyShift action_33
action_40 (39) = happyShift action_34
action_40 (40) = happyShift action_35
action_40 (41) = happyShift action_36
action_40 (42) = happyShift action_37
action_40 (43) = happyShift action_38
action_40 (44) = happyShift action_39
action_40 (49) = happyShift action_40
action_40 (50) = happyShift action_61
action_40 (53) = happyShift action_41
action_40 (28) = happyGoto action_60
action_40 (29) = happyGoto action_27
action_40 (30) = happyGoto action_28
action_40 (31) = happyGoto action_29
action_40 (32) = happyGoto action_30
action_40 (33) = happyGoto action_31
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (37) = happyShift action_32
action_41 (38) = happyShift action_33
action_41 (39) = happyShift action_34
action_41 (40) = happyShift action_35
action_41 (41) = happyShift action_36
action_41 (42) = happyShift action_37
action_41 (43) = happyShift action_38
action_41 (44) = happyShift action_39
action_41 (49) = happyShift action_40
action_41 (53) = happyShift action_41
action_41 (13) = happyGoto action_58
action_41 (28) = happyGoto action_59
action_41 (29) = happyGoto action_27
action_41 (30) = happyGoto action_28
action_41 (31) = happyGoto action_29
action_41 (32) = happyGoto action_30
action_41 (33) = happyGoto action_31
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (57) = happyShift action_57
action_42 _ = happyReduce_11

action_43 (52) = happyShift action_56
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (49) = happyShift action_13
action_44 (12) = happyGoto action_55
action_44 _ = happyReduce_19

action_45 _ = happyReduce_20

action_46 (40) = happyShift action_23
action_46 (8) = happyGoto action_19
action_46 (9) = happyGoto action_20
action_46 (10) = happyGoto action_21
action_46 (11) = happyGoto action_54
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (37) = happyShift action_32
action_47 (38) = happyShift action_33
action_47 (39) = happyShift action_34
action_47 (40) = happyShift action_35
action_47 (41) = happyShift action_36
action_47 (42) = happyShift action_37
action_47 (43) = happyShift action_38
action_47 (44) = happyShift action_39
action_47 (49) = happyShift action_40
action_47 (53) = happyShift action_41
action_47 (28) = happyGoto action_53
action_47 (29) = happyGoto action_27
action_47 (30) = happyGoto action_28
action_47 (31) = happyGoto action_29
action_47 (32) = happyGoto action_30
action_47 (33) = happyGoto action_31
action_47 _ = happyFail (happyExpListPerState 47)

action_48 _ = happyReduce_15

action_49 _ = happyReduce_5

action_50 (46) = happyShift action_52
action_50 _ = happyFail (happyExpListPerState 50)

action_51 _ = happyReduce_6

action_52 (37) = happyShift action_32
action_52 (38) = happyShift action_33
action_52 (39) = happyShift action_34
action_52 (40) = happyShift action_35
action_52 (41) = happyShift action_36
action_52 (42) = happyShift action_37
action_52 (43) = happyShift action_38
action_52 (44) = happyShift action_39
action_52 (49) = happyShift action_40
action_52 (53) = happyShift action_41
action_52 (28) = happyGoto action_105
action_52 (29) = happyGoto action_27
action_52 (30) = happyGoto action_28
action_52 (31) = happyGoto action_29
action_52 (32) = happyGoto action_30
action_52 (33) = happyGoto action_31
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_16

action_54 _ = happyReduce_18

action_55 (56) = happyShift action_104
action_55 _ = happyReduce_8

action_56 _ = happyReduce_3

action_57 (41) = happyShift action_44
action_57 (6) = happyGoto action_42
action_57 (7) = happyGoto action_103
action_57 _ = happyReduce_10

action_58 (54) = happyShift action_102
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (55) = happyShift action_101
action_59 _ = happyReduce_21

action_60 (50) = happyShift action_99
action_60 (55) = happyShift action_100
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_65

action_62 _ = happyReduce_23

action_63 _ = happyReduce_27

action_64 (40) = happyShift action_23
action_64 (45) = happyShift action_66
action_64 (49) = happyShift action_67
action_64 (8) = happyGoto action_62
action_64 (14) = happyGoto action_63
action_64 (16) = happyGoto action_64
action_64 (17) = happyGoto action_98
action_64 _ = happyReduce_29

action_65 (47) = happyShift action_96
action_65 (51) = happyShift action_97
action_65 _ = happyFail (happyExpListPerState 65)

action_66 _ = happyReduce_24

action_67 (40) = happyShift action_23
action_67 (45) = happyShift action_66
action_67 (8) = happyGoto action_62
action_67 (14) = happyGoto action_94
action_67 (15) = happyGoto action_95
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (38) = happyShift action_33
action_68 (40) = happyShift action_88
action_68 (41) = happyShift action_89
action_68 (43) = happyShift action_90
action_68 (45) = happyShift action_91
action_68 (49) = happyShift action_92
action_68 (53) = happyShift action_93
action_68 (18) = happyGoto action_81
action_68 (22) = happyGoto action_82
action_68 (24) = happyGoto action_83
action_68 (25) = happyGoto action_84
action_68 (26) = happyGoto action_85
action_68 (27) = happyGoto action_86
action_68 (30) = happyGoto action_87
action_68 _ = happyReduce_54

action_69 (46) = happyShift action_80
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (38) = happyShift action_33
action_70 (39) = happyShift action_34
action_70 (40) = happyShift action_35
action_70 (41) = happyShift action_36
action_70 (42) = happyShift action_37
action_70 (43) = happyShift action_38
action_70 (44) = happyShift action_39
action_70 (49) = happyShift action_40
action_70 (53) = happyShift action_41
action_70 (29) = happyGoto action_27
action_70 (30) = happyGoto action_28
action_70 (31) = happyGoto action_29
action_70 (32) = happyGoto action_30
action_70 (33) = happyGoto action_79
action_70 _ = happyFail (happyExpListPerState 70)

action_71 (38) = happyShift action_33
action_71 (39) = happyShift action_34
action_71 (40) = happyShift action_35
action_71 (41) = happyShift action_36
action_71 (42) = happyShift action_37
action_71 (43) = happyShift action_38
action_71 (44) = happyShift action_39
action_71 (49) = happyShift action_40
action_71 (53) = happyShift action_41
action_71 (29) = happyGoto action_27
action_71 (30) = happyGoto action_28
action_71 (31) = happyGoto action_29
action_71 (32) = happyGoto action_30
action_71 (33) = happyGoto action_78
action_71 _ = happyFail (happyExpListPerState 71)

action_72 _ = happyReduce_59

action_73 (37) = happyShift action_32
action_73 (38) = happyShift action_33
action_73 (39) = happyShift action_34
action_73 (40) = happyShift action_77
action_73 (41) = happyShift action_36
action_73 (42) = happyShift action_37
action_73 (43) = happyShift action_38
action_73 (44) = happyShift action_39
action_73 (49) = happyShift action_40
action_73 (50) = happyShift action_61
action_73 (53) = happyShift action_41
action_73 (8) = happyGoto action_76
action_73 (28) = happyGoto action_60
action_73 (29) = happyGoto action_27
action_73 (30) = happyGoto action_28
action_73 (31) = happyGoto action_29
action_73 (32) = happyGoto action_30
action_73 (33) = happyGoto action_31
action_73 _ = happyFail (happyExpListPerState 73)

action_74 (41) = happyShift action_44
action_74 (6) = happyGoto action_42
action_74 (7) = happyGoto action_75
action_74 _ = happyReduce_10

action_75 (52) = happyShift action_129
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (46) = happyShift action_128
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (46) = happyReduce_13
action_77 _ = happyReduce_73

action_78 (48) = happyShift action_71
action_78 _ = happyReduce_78

action_79 (47) = happyShift action_70
action_79 (48) = happyShift action_71
action_79 _ = happyReduce_77

action_80 (37) = happyShift action_32
action_80 (38) = happyShift action_33
action_80 (39) = happyShift action_34
action_80 (40) = happyShift action_35
action_80 (41) = happyShift action_36
action_80 (42) = happyShift action_37
action_80 (43) = happyShift action_38
action_80 (44) = happyShift action_39
action_80 (49) = happyShift action_40
action_80 (53) = happyShift action_41
action_80 (28) = happyGoto action_127
action_80 (29) = happyGoto action_27
action_80 (30) = happyGoto action_28
action_80 (31) = happyGoto action_29
action_80 (32) = happyGoto action_30
action_80 (33) = happyGoto action_31
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (38) = happyShift action_33
action_81 (40) = happyShift action_88
action_81 (41) = happyShift action_89
action_81 (43) = happyShift action_90
action_81 (45) = happyShift action_91
action_81 (49) = happyShift action_126
action_81 (53) = happyShift action_93
action_81 (18) = happyGoto action_121
action_81 (19) = happyGoto action_122
action_81 (20) = happyGoto action_123
action_81 (22) = happyGoto action_124
action_81 (23) = happyGoto action_125
action_81 (30) = happyGoto action_87
action_81 _ = happyReduce_40

action_82 _ = happyReduce_49

action_83 (55) = happyShift action_120
action_83 _ = happyReduce_51

action_84 (47) = happyShift action_119
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (57) = happyShift action_118
action_85 _ = happyReduce_55

action_86 (52) = happyShift action_117
action_86 _ = happyFail (happyExpListPerState 86)

action_87 _ = happyReduce_45

action_88 _ = happyReduce_41

action_89 _ = happyReduce_31

action_90 _ = happyReduce_32

action_91 _ = happyReduce_46

action_92 (38) = happyShift action_33
action_92 (40) = happyShift action_88
action_92 (41) = happyShift action_89
action_92 (43) = happyShift action_90
action_92 (45) = happyShift action_91
action_92 (49) = happyShift action_92
action_92 (53) = happyShift action_93
action_92 (18) = happyGoto action_81
action_92 (21) = happyGoto action_115
action_92 (22) = happyGoto action_82
action_92 (24) = happyGoto action_116
action_92 (30) = happyGoto action_87
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (38) = happyShift action_33
action_93 (40) = happyShift action_88
action_93 (41) = happyShift action_89
action_93 (43) = happyShift action_90
action_93 (45) = happyShift action_91
action_93 (49) = happyShift action_92
action_93 (53) = happyShift action_93
action_93 (54) = happyShift action_114
action_93 (18) = happyGoto action_81
action_93 (22) = happyGoto action_82
action_93 (24) = happyGoto action_83
action_93 (25) = happyGoto action_113
action_93 (30) = happyGoto action_87
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (40) = happyShift action_23
action_94 (45) = happyShift action_66
action_94 (8) = happyGoto action_62
action_94 (14) = happyGoto action_94
action_94 (15) = happyGoto action_112
action_94 _ = happyReduce_25

action_95 (56) = happyShift action_111
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (38) = happyShift action_33
action_96 (39) = happyShift action_34
action_96 (40) = happyShift action_35
action_96 (41) = happyShift action_36
action_96 (42) = happyShift action_37
action_96 (43) = happyShift action_38
action_96 (44) = happyShift action_39
action_96 (49) = happyShift action_40
action_96 (53) = happyShift action_41
action_96 (30) = happyGoto action_28
action_96 (31) = happyGoto action_29
action_96 (32) = happyGoto action_110
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (38) = happyShift action_33
action_97 (40) = happyShift action_88
action_97 (41) = happyShift action_89
action_97 (43) = happyShift action_90
action_97 (45) = happyShift action_91
action_97 (49) = happyShift action_92
action_97 (53) = happyShift action_93
action_97 (18) = happyGoto action_81
action_97 (22) = happyGoto action_82
action_97 (24) = happyGoto action_83
action_97 (25) = happyGoto action_84
action_97 (26) = happyGoto action_85
action_97 (27) = happyGoto action_109
action_97 (30) = happyGoto action_87
action_97 _ = happyReduce_54

action_98 _ = happyReduce_30

action_99 _ = happyReduce_64

action_100 (37) = happyShift action_32
action_100 (38) = happyShift action_33
action_100 (39) = happyShift action_34
action_100 (40) = happyShift action_35
action_100 (41) = happyShift action_36
action_100 (42) = happyShift action_37
action_100 (43) = happyShift action_38
action_100 (44) = happyShift action_39
action_100 (49) = happyShift action_40
action_100 (53) = happyShift action_41
action_100 (13) = happyGoto action_108
action_100 (28) = happyGoto action_59
action_100 (29) = happyGoto action_27
action_100 (30) = happyGoto action_28
action_100 (31) = happyGoto action_29
action_100 (32) = happyGoto action_30
action_100 (33) = happyGoto action_31
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (37) = happyShift action_32
action_101 (38) = happyShift action_33
action_101 (39) = happyShift action_34
action_101 (40) = happyShift action_35
action_101 (41) = happyShift action_36
action_101 (42) = happyShift action_37
action_101 (43) = happyShift action_38
action_101 (44) = happyShift action_39
action_101 (49) = happyShift action_40
action_101 (53) = happyShift action_41
action_101 (13) = happyGoto action_107
action_101 (28) = happyGoto action_59
action_101 (29) = happyGoto action_27
action_101 (30) = happyGoto action_28
action_101 (31) = happyGoto action_29
action_101 (32) = happyGoto action_30
action_101 (33) = happyGoto action_31
action_101 _ = happyFail (happyExpListPerState 101)

action_102 _ = happyReduce_67

action_103 _ = happyReduce_12

action_104 (37) = happyShift action_32
action_104 (38) = happyShift action_33
action_104 (39) = happyShift action_34
action_104 (40) = happyShift action_35
action_104 (41) = happyShift action_36
action_104 (42) = happyShift action_37
action_104 (43) = happyShift action_38
action_104 (44) = happyShift action_39
action_104 (49) = happyShift action_40
action_104 (53) = happyShift action_41
action_104 (28) = happyGoto action_106
action_104 (29) = happyGoto action_27
action_104 (30) = happyGoto action_28
action_104 (31) = happyGoto action_29
action_104 (32) = happyGoto action_30
action_104 (33) = happyGoto action_31
action_104 _ = happyFail (happyExpListPerState 104)

action_105 _ = happyReduce_7

action_106 _ = happyReduce_9

action_107 _ = happyReduce_22

action_108 (50) = happyShift action_144
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (52) = happyShift action_143
action_109 _ = happyFail (happyExpListPerState 109)

action_110 _ = happyReduce_68

action_111 (37) = happyShift action_32
action_111 (38) = happyShift action_33
action_111 (39) = happyShift action_34
action_111 (40) = happyShift action_35
action_111 (41) = happyShift action_36
action_111 (42) = happyShift action_37
action_111 (43) = happyShift action_38
action_111 (44) = happyShift action_39
action_111 (49) = happyShift action_40
action_111 (53) = happyShift action_41
action_111 (28) = happyGoto action_142
action_111 (29) = happyGoto action_27
action_111 (30) = happyGoto action_28
action_111 (31) = happyGoto action_29
action_111 (32) = happyGoto action_30
action_111 (33) = happyGoto action_31
action_111 _ = happyFail (happyExpListPerState 111)

action_112 _ = happyReduce_26

action_113 (54) = happyShift action_141
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_43

action_115 (50) = happyShift action_140
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (55) = happyShift action_139
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_70

action_118 (38) = happyShift action_33
action_118 (40) = happyShift action_88
action_118 (41) = happyShift action_89
action_118 (43) = happyShift action_90
action_118 (45) = happyShift action_91
action_118 (49) = happyShift action_92
action_118 (53) = happyShift action_93
action_118 (18) = happyGoto action_81
action_118 (22) = happyGoto action_82
action_118 (24) = happyGoto action_83
action_118 (25) = happyGoto action_84
action_118 (26) = happyGoto action_85
action_118 (27) = happyGoto action_138
action_118 (30) = happyGoto action_87
action_118 _ = happyReduce_54

action_119 (37) = happyShift action_32
action_119 (38) = happyShift action_33
action_119 (39) = happyShift action_34
action_119 (40) = happyShift action_35
action_119 (41) = happyShift action_36
action_119 (42) = happyShift action_37
action_119 (43) = happyShift action_38
action_119 (44) = happyShift action_39
action_119 (49) = happyShift action_40
action_119 (53) = happyShift action_41
action_119 (28) = happyGoto action_137
action_119 (29) = happyGoto action_27
action_119 (30) = happyGoto action_28
action_119 (31) = happyGoto action_29
action_119 (32) = happyGoto action_30
action_119 (33) = happyGoto action_31
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (38) = happyShift action_33
action_120 (40) = happyShift action_88
action_120 (41) = happyShift action_89
action_120 (43) = happyShift action_90
action_120 (45) = happyShift action_91
action_120 (49) = happyShift action_92
action_120 (53) = happyShift action_93
action_120 (18) = happyGoto action_81
action_120 (22) = happyGoto action_82
action_120 (24) = happyGoto action_83
action_120 (25) = happyGoto action_136
action_120 (30) = happyGoto action_87
action_120 _ = happyFail (happyExpListPerState 120)

action_121 _ = happyReduce_40

action_122 (38) = happyShift action_33
action_122 (40) = happyShift action_88
action_122 (41) = happyShift action_89
action_122 (43) = happyShift action_90
action_122 (45) = happyShift action_91
action_122 (49) = happyShift action_126
action_122 (53) = happyShift action_93
action_122 (18) = happyGoto action_121
action_122 (19) = happyGoto action_122
action_122 (20) = happyGoto action_135
action_122 (22) = happyGoto action_124
action_122 (23) = happyGoto action_125
action_122 (30) = happyGoto action_87
action_122 _ = happyReduce_36

action_123 _ = happyReduce_50

action_124 _ = happyReduce_47

action_125 _ = happyReduce_33

action_126 (38) = happyShift action_33
action_126 (40) = happyShift action_134
action_126 (41) = happyShift action_89
action_126 (43) = happyShift action_90
action_126 (45) = happyShift action_91
action_126 (49) = happyShift action_92
action_126 (53) = happyShift action_93
action_126 (8) = happyGoto action_132
action_126 (18) = happyGoto action_133
action_126 (21) = happyGoto action_115
action_126 (22) = happyGoto action_82
action_126 (24) = happyGoto action_116
action_126 (30) = happyGoto action_87
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (55) = happyShift action_131
action_127 _ = happyFail (happyExpListPerState 127)

action_128 (38) = happyShift action_33
action_128 (39) = happyShift action_34
action_128 (40) = happyShift action_35
action_128 (41) = happyShift action_36
action_128 (42) = happyShift action_37
action_128 (43) = happyShift action_38
action_128 (44) = happyShift action_39
action_128 (49) = happyShift action_40
action_128 (53) = happyShift action_41
action_128 (30) = happyGoto action_28
action_128 (31) = happyGoto action_29
action_128 (32) = happyGoto action_130
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_4

action_130 (50) = happyShift action_152
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (37) = happyShift action_32
action_131 (38) = happyShift action_33
action_131 (39) = happyShift action_34
action_131 (40) = happyShift action_35
action_131 (41) = happyShift action_36
action_131 (42) = happyShift action_37
action_131 (43) = happyShift action_38
action_131 (44) = happyShift action_39
action_131 (49) = happyShift action_40
action_131 (53) = happyShift action_41
action_131 (28) = happyGoto action_151
action_131 (29) = happyGoto action_27
action_131 (30) = happyGoto action_28
action_131 (31) = happyGoto action_29
action_131 (32) = happyGoto action_30
action_131 (33) = happyGoto action_31
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (46) = happyShift action_150
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (38) = happyShift action_33
action_133 (40) = happyShift action_88
action_133 (41) = happyShift action_89
action_133 (43) = happyShift action_90
action_133 (45) = happyShift action_91
action_133 (49) = happyShift action_126
action_133 (53) = happyShift action_93
action_133 (18) = happyGoto action_121
action_133 (19) = happyGoto action_122
action_133 (20) = happyGoto action_149
action_133 (22) = happyGoto action_124
action_133 (23) = happyGoto action_125
action_133 (30) = happyGoto action_87
action_133 _ = happyReduce_40

action_134 (50) = happyShift action_148
action_134 (55) = happyReduce_41
action_134 _ = happyReduce_13

action_135 _ = happyReduce_37

action_136 _ = happyReduce_52

action_137 _ = happyReduce_53

action_138 _ = happyReduce_56

action_139 (38) = happyShift action_33
action_139 (40) = happyShift action_88
action_139 (41) = happyShift action_89
action_139 (43) = happyShift action_90
action_139 (45) = happyShift action_91
action_139 (49) = happyShift action_92
action_139 (53) = happyShift action_93
action_139 (18) = happyGoto action_81
action_139 (21) = happyGoto action_146
action_139 (22) = happyGoto action_82
action_139 (24) = happyGoto action_147
action_139 (30) = happyGoto action_87
action_139 _ = happyFail (happyExpListPerState 139)

action_140 _ = happyReduce_42

action_141 _ = happyReduce_44

action_142 (50) = happyShift action_145
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_69

action_144 _ = happyReduce_66

action_145 _ = happyReduce_28

action_146 _ = happyReduce_39

action_147 (55) = happyShift action_139
action_147 _ = happyReduce_38

action_148 _ = happyReduce_35

action_149 (50) = happyShift action_155
action_149 _ = happyReduce_50

action_150 (38) = happyShift action_33
action_150 (40) = happyShift action_88
action_150 (41) = happyShift action_89
action_150 (43) = happyShift action_90
action_150 (45) = happyShift action_91
action_150 (49) = happyShift action_154
action_150 (53) = happyShift action_93
action_150 (18) = happyGoto action_121
action_150 (22) = happyGoto action_124
action_150 (23) = happyGoto action_153
action_150 (30) = happyGoto action_87
action_150 _ = happyFail (happyExpListPerState 150)

action_151 _ = happyReduce_57

action_152 _ = happyReduce_60

action_153 (50) = happyShift action_156
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (38) = happyShift action_33
action_154 (40) = happyShift action_88
action_154 (41) = happyShift action_89
action_154 (43) = happyShift action_90
action_154 (45) = happyShift action_91
action_154 (49) = happyShift action_92
action_154 (53) = happyShift action_93
action_154 (18) = happyGoto action_133
action_154 (21) = happyGoto action_115
action_154 (22) = happyGoto action_82
action_154 (24) = happyGoto action_116
action_154 (30) = happyGoto action_87
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_48

action_156 _ = happyReduce_34

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
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (Definition happy_var_2 happy_var_3 Nothing happy_var_5 []
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 7 5 happyReduction_7
happyReduction_7 ((HappyAbsSyn28  happy_var_7) `HappyStk`
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

happyReduce_8 = happySpecReduce_2  6 happyReduction_8
happyReduction_8 (HappyAbsSyn11  happy_var_2)
	(HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn6
		 (([], happy_var_1, happy_var_2, Nothing)
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happyReduce 4 6 happyReduction_9
happyReduction_9 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (([], happy_var_1, happy_var_2, Just happy_var_4)
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_0  7 happyReduction_10
happyReduction_10  =  HappyAbsSyn7
		 ([]
	)

happyReduce_11 = happySpecReduce_1  7 happyReduction_11
happyReduction_11 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn7
		 ([happy_var_1]
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1 : happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  8 happyReduction_13
happyReduction_13 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn8
		 (happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  9 happyReduction_14
happyReduction_14 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 :| []
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_2  9 happyReduction_15
happyReduction_15 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  10 happyReduction_16
happyReduction_16 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 ((happy_var_1, happy_var_3, [])
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  11 happyReduction_17
happyReduction_17 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  11 happyReduction_18
happyReduction_18 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 : happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_0  12 happyReduction_19
happyReduction_19  =  HappyAbsSyn11
		 ([]
	)

happyReduce_20 = happySpecReduce_3  12 happyReduction_20
happyReduction_20 _
	(HappyAbsSyn11  happy_var_2)
	_
	 =  HappyAbsSyn11
		 (happy_var_2
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  13 happyReduction_21
happyReduction_21 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  13 happyReduction_22
happyReduction_22 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1 : happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  14 happyReduction_23
happyReduction_23 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  14 happyReduction_24
happyReduction_24 _
	 =  HappyAbsSyn14
		 ("_"
	)

happyReduce_25 = happySpecReduce_1  15 happyReduction_25
happyReduction_25 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1 :| []
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_2  15 happyReduction_26
happyReduction_26 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_26 _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  16 happyReduction_27
happyReduction_27 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn16
		 ((happy_var_1 :| [], Nothing)
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happyReduce 5 16 happyReduction_28
happyReduction_28 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 ((happy_var_2, Just happy_var_4)
	) `HappyStk` happyRest

happyReduce_29 = happySpecReduce_1  17 happyReduction_29
happyReduction_29 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| []
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  17 happyReduction_30
happyReduction_30 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  18 happyReduction_31
happyReduction_31 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn18
		 (happy_var_1 :| []
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  18 happyReduction_32
happyReduction_32 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn18
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  19 happyReduction_33
happyReduction_33 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happyReduce 5 19 happyReduction_34
happyReduction_34 (_ `HappyStk`
	(HappyAbsSyn19  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (Implicit happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_35 = happySpecReduce_3  19 happyReduction_35
happyReduction_35 _
	(HappyTerminal (TokenLSym happy_var_2))
	_
	 =  HappyAbsSyn19
		 (PunnedImplicit happy_var_2
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  20 happyReduction_36
happyReduction_36 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| []
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_2  20 happyReduction_37
happyReduction_37 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  21 happyReduction_38
happyReduction_38 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 ([happy_var_1, happy_var_3]
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  21 happyReduction_39
happyReduction_39 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1 : happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  22 happyReduction_40
happyReduction_40 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Data happy_var_1 []
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  22 happyReduction_41
happyReduction_41 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn19
		 (P.Variable happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  22 happyReduction_42
happyReduction_42 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (P.Tuple happy_var_2
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  22 happyReduction_43
happyReduction_43 _
	_
	 =  HappyAbsSyn19
		 (P.List []
	)

happyReduce_44 = happySpecReduce_3  22 happyReduction_44
happyReduction_44 _
	(HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (P.List (toList happy_var_2)
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  22 happyReduction_45
happyReduction_45 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Literal happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  22 happyReduction_46
happyReduction_46 _
	 =  HappyAbsSyn19
		 (Wildcard
	)

happyReduce_47 = happySpecReduce_1  23 happyReduction_47
happyReduction_47 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happyReduce 4 23 happyReduction_48
happyReduction_48 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_49 = happySpecReduce_1  24 happyReduction_49
happyReduction_49 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_2  24 happyReduction_50
happyReduction_50 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  25 happyReduction_51
happyReduction_51 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| []
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  25 happyReduction_52
happyReduction_52 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  26 happyReduction_53
happyReduction_53 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn26
		 ((happy_var_1, happy_var_3)
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_0  27 happyReduction_54
happyReduction_54  =  HappyAbsSyn27
		 ([]
	)

happyReduce_55 = happySpecReduce_1  27 happyReduction_55
happyReduction_55 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  27 happyReduction_56
happyReduction_56 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happyReduce 6 28 happyReduction_57
happyReduction_57 ((HappyAbsSyn28  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_58 = happySpecReduce_1  28 happyReduction_58
happyReduction_58 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_2  29 happyReduction_59
happyReduction_59 (HappyAbsSyn28  happy_var_2)
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Application happy_var_1 ((Nothing, happy_var_2) :| [])
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happyReduce 6 29 happyReduction_60
happyReduction_60 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Application happy_var_1 ((Just happy_var_3, happy_var_5) :| [])
	) `HappyStk` happyRest

happyReduce_61 = happySpecReduce_1  29 happyReduction_61
happyReduction_61 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  30 happyReduction_62
happyReduction_62 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn30
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  31 happyReduction_63
happyReduction_63 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn30
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  32 happyReduction_64
happyReduction_64 _
	(HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (Parenthesized happy_var_2
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_2  32 happyReduction_65
happyReduction_65 _
	_
	 =  HappyAbsSyn28
		 (Literal UnitLiteral
	)

happyReduce_66 = happyReduce 5 32 happyReduction_66
happyReduction_66 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_67 = happySpecReduce_3  32 happyReduction_67
happyReduction_67 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (List happy_var_2
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happyReduce 4 32 happyReduction_68
happyReduction_68 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 5 32 happyReduction_69
happyReduction_69 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 4 32 happyReduction_70
happyReduction_70 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_71 = happySpecReduce_1  32 happyReduction_71
happyReduction_71 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  32 happyReduction_72
happyReduction_72 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  32 happyReduction_73
happyReduction_73 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  32 happyReduction_74
happyReduction_74 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  32 happyReduction_75
happyReduction_75 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  32 happyReduction_76
happyReduction_76 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier happy_var_1
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  33 happyReduction_77
happyReduction_77 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  33 happyReduction_78
happyReduction_78 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (TokenInfixOp happy_var_2))
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Infix happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  33 happyReduction_79
happyReduction_79 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 58 58 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenDatatype -> cont 34;
	TokenDeclare -> cont 35;
	TokenDefine -> cont 36;
	TokenLet -> cont 37;
	TokenInt happy_dollar_dollar -> cont 38;
	TokenFloat happy_dollar_dollar -> cont 39;
	TokenLSym happy_dollar_dollar -> cont 40;
	TokenUSym happy_dollar_dollar -> cont 41;
	TokenLSymQ happy_dollar_dollar -> cont 42;
	TokenUSymQ happy_dollar_dollar -> cont 43;
	TokenBackslash -> cont 44;
	TokenUnderscore -> cont 45;
	TokenEq -> cont 46;
	TokenArrow -> cont 47;
	TokenInfixOp happy_dollar_dollar -> cont 48;
	TokenLParen -> cont 49;
	TokenRParen -> cont 50;
	TokenLBrace -> cont 51;
	TokenRBrace -> cont 52;
	TokenLBracket -> cont 53;
	TokenRBracket -> cont 54;
	TokenComma -> cont 55;
	TokenColon -> cont 56;
	TokenSemicolon -> cont 57;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 58 tk tks = happyError' (tks, explist)
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
