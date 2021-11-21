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
	| HappyAbsSyn30 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,490) ([0,0,28,0,0,32768,3,0,0,0,0,0,0,0,2,0,0,8192,0,0,0,1024,0,0,0,0,0,0,57344,0,0,0,0,0,0,0,0,256,0,0,0,32,0,0,0,4,0,0,0,66,0,0,4,0,0,0,0,1,0,0,8196,0,0,16352,138,0,0,18428,17,0,32768,10495,2,0,0,1,0,0,0,16384,0,0,0,1024,0,0,0,4,0,0,0,0,0,0,4,0,0,64512,4423,0,0,0,128,0,0,4064,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,1288,0,0,2048,1,0,0,8176,77,0,0,41982,8,0,0,0,16,0,0,4096,0,0,0,64,0,0,0,0,0,0,64,0,0,32768,10495,2,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,20991,4,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,64,0,0,0,0,2,0,0,32768,0,0,0,4224,0,0,0,0,0,0,0,0,0,0,264,0,0,0,0,2,0,0,0,0,0,0,0,0,0,4224,2,0,0,2048,1,0,0,66,0,0,59392,4362,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,8192,0,0,0,0,64,0,0,4096,0,0,0,4096,0,0,0,640,0,0,65024,2211,0,0,44672,272,0,0,0,0,0,0,0,16,0,0,256,0,0,0,0,1,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2792,17,0,0,8541,6,0,0,0,2,0,64512,1,0,0,44672,272,0,0,0,0,0,0,20991,4,0,0,0,0,0,0,0,0,0,65408,552,0,0,8176,69,0,0,0,0,0,0,0,0,0,63488,8847,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,1,0,0,1024,0,0,0,0,0,0,36856,34,0,0,0,8,0,0,0,0,0,0,512,0,0,0,2048,0,0,0,0,0,0,34164,8,0,49152,5247,1,0,53248,8725,0,0,0,0,0,0,22336,136,0,0,0,0,0,0,0,0,0,0,0,0,0,29696,2181,0,0,0,1024,0,0,2032,0,0,0,0,0,0,0,4096,0,0,64512,4423,0,0,0,2,0,0,11168,68,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2792,17,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,36856,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,8192,0,0,53248,8725,0,0,0,0,0,0,0,0,0,0,0,2,0,0,8541,2,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Statement","Variant","Variants","LocalName","LocalNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","Juxtaposition","IntegerLiteral","FloatLiteral","StringLiteral","Atom","BinaryExpression","datatype","declare","define","let","int","float","string","lsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","forall","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 61
        bit_end = (st Prelude.+ 1) Prelude.* 61
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..60]
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

action_3 (43) = happyShift action_11
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (42) = happyShift action_10
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (42) = happyShift action_9
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (61) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (35) = happyShift action_3
action_7 (36) = happyShift action_4
action_7 (37) = happyShift action_5
action_7 (4) = happyGoto action_8
action_7 (5) = happyGoto action_7
action_7 _ = happyReduce_1

action_8 _ = happyReduce_2

action_9 (52) = happyShift action_13
action_9 (12) = happyGoto action_15
action_9 _ = happyReduce_19

action_10 (52) = happyShift action_13
action_10 (12) = happyGoto action_14
action_10 _ = happyReduce_19

action_11 (52) = happyShift action_13
action_11 (12) = happyGoto action_12
action_11 _ = happyReduce_19

action_12 (54) = happyShift action_24
action_12 (59) = happyShift action_25
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (42) = happyShift action_23
action_13 (8) = happyGoto action_19
action_13 (9) = happyGoto action_20
action_13 (10) = happyGoto action_21
action_13 (11) = happyGoto action_22
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (59) = happyShift action_18
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (48) = happyShift action_16
action_15 (59) = happyShift action_17
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (38) = happyShift action_33
action_16 (39) = happyShift action_34
action_16 (40) = happyShift action_35
action_16 (41) = happyShift action_36
action_16 (42) = happyShift action_37
action_16 (43) = happyShift action_38
action_16 (44) = happyShift action_39
action_16 (45) = happyShift action_40
action_16 (46) = happyShift action_41
action_16 (50) = happyShift action_42
action_16 (52) = happyShift action_43
action_16 (56) = happyShift action_44
action_16 (28) = happyGoto action_54
action_16 (29) = happyGoto action_27
action_16 (30) = happyGoto action_28
action_16 (31) = happyGoto action_29
action_16 (32) = happyGoto action_30
action_16 (33) = happyGoto action_31
action_16 (34) = happyGoto action_32
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (38) = happyShift action_33
action_17 (39) = happyShift action_34
action_17 (40) = happyShift action_35
action_17 (41) = happyShift action_36
action_17 (42) = happyShift action_37
action_17 (43) = happyShift action_38
action_17 (44) = happyShift action_39
action_17 (45) = happyShift action_40
action_17 (46) = happyShift action_41
action_17 (50) = happyShift action_42
action_17 (52) = happyShift action_43
action_17 (56) = happyShift action_44
action_17 (28) = happyGoto action_53
action_17 (29) = happyGoto action_27
action_17 (30) = happyGoto action_28
action_17 (31) = happyGoto action_29
action_17 (32) = happyGoto action_30
action_17 (33) = happyGoto action_31
action_17 (34) = happyGoto action_32
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (38) = happyShift action_33
action_18 (39) = happyShift action_34
action_18 (40) = happyShift action_35
action_18 (41) = happyShift action_36
action_18 (42) = happyShift action_37
action_18 (43) = happyShift action_38
action_18 (44) = happyShift action_39
action_18 (45) = happyShift action_40
action_18 (46) = happyShift action_41
action_18 (50) = happyShift action_42
action_18 (52) = happyShift action_43
action_18 (56) = happyShift action_44
action_18 (28) = happyGoto action_52
action_18 (29) = happyGoto action_27
action_18 (30) = happyGoto action_28
action_18 (31) = happyGoto action_29
action_18 (32) = happyGoto action_30
action_18 (33) = happyGoto action_31
action_18 (34) = happyGoto action_32
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (42) = happyShift action_23
action_19 (8) = happyGoto action_19
action_19 (9) = happyGoto action_51
action_19 _ = happyReduce_14

action_20 (59) = happyShift action_50
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (58) = happyShift action_49
action_21 _ = happyReduce_17

action_22 (53) = happyShift action_48
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_13

action_24 (43) = happyShift action_47
action_24 (6) = happyGoto action_45
action_24 (7) = happyGoto action_46
action_24 _ = happyReduce_10

action_25 (38) = happyShift action_33
action_25 (39) = happyShift action_34
action_25 (40) = happyShift action_35
action_25 (41) = happyShift action_36
action_25 (42) = happyShift action_37
action_25 (43) = happyShift action_38
action_25 (44) = happyShift action_39
action_25 (45) = happyShift action_40
action_25 (46) = happyShift action_41
action_25 (50) = happyShift action_42
action_25 (52) = happyShift action_43
action_25 (56) = happyShift action_44
action_25 (28) = happyGoto action_26
action_25 (29) = happyGoto action_27
action_25 (30) = happyGoto action_28
action_25 (31) = happyGoto action_29
action_25 (32) = happyGoto action_30
action_25 (33) = happyGoto action_31
action_25 (34) = happyGoto action_32
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (54) = happyShift action_79
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (39) = happyShift action_34
action_27 (40) = happyShift action_35
action_27 (41) = happyShift action_36
action_27 (42) = happyShift action_37
action_27 (43) = happyShift action_38
action_27 (44) = happyShift action_39
action_27 (45) = happyShift action_40
action_27 (52) = happyShift action_78
action_27 (30) = happyGoto action_28
action_27 (31) = happyGoto action_29
action_27 (32) = happyGoto action_30
action_27 (33) = happyGoto action_77
action_27 _ = happyReduce_64

action_28 _ = happyReduce_79

action_29 _ = happyReduce_80

action_30 _ = happyReduce_81

action_31 _ = happyReduce_71

action_32 (49) = happyShift action_75
action_32 (51) = happyShift action_76
action_32 _ = happyReduce_63

action_33 (42) = happyShift action_74
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_72

action_35 _ = happyReduce_73

action_36 _ = happyReduce_74

action_37 _ = happyReduce_75

action_38 _ = happyReduce_76

action_39 _ = happyReduce_77

action_40 _ = happyReduce_78

action_41 (42) = happyShift action_23
action_41 (47) = happyShift action_68
action_41 (52) = happyShift action_72
action_41 (54) = happyShift action_73
action_41 (8) = happyGoto action_65
action_41 (14) = happyGoto action_69
action_41 (16) = happyGoto action_70
action_41 (17) = happyGoto action_71
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (42) = happyShift action_23
action_42 (47) = happyShift action_68
action_42 (8) = happyGoto action_65
action_42 (14) = happyGoto action_66
action_42 (15) = happyGoto action_67
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (38) = happyShift action_33
action_43 (39) = happyShift action_34
action_43 (40) = happyShift action_35
action_43 (41) = happyShift action_36
action_43 (42) = happyShift action_37
action_43 (43) = happyShift action_38
action_43 (44) = happyShift action_39
action_43 (45) = happyShift action_40
action_43 (46) = happyShift action_41
action_43 (50) = happyShift action_42
action_43 (52) = happyShift action_43
action_43 (53) = happyShift action_64
action_43 (56) = happyShift action_44
action_43 (28) = happyGoto action_63
action_43 (29) = happyGoto action_27
action_43 (30) = happyGoto action_28
action_43 (31) = happyGoto action_29
action_43 (32) = happyGoto action_30
action_43 (33) = happyGoto action_31
action_43 (34) = happyGoto action_32
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (38) = happyShift action_33
action_44 (39) = happyShift action_34
action_44 (40) = happyShift action_35
action_44 (41) = happyShift action_36
action_44 (42) = happyShift action_37
action_44 (43) = happyShift action_38
action_44 (44) = happyShift action_39
action_44 (45) = happyShift action_40
action_44 (46) = happyShift action_41
action_44 (50) = happyShift action_42
action_44 (52) = happyShift action_43
action_44 (56) = happyShift action_44
action_44 (13) = happyGoto action_61
action_44 (28) = happyGoto action_62
action_44 (29) = happyGoto action_27
action_44 (30) = happyGoto action_28
action_44 (31) = happyGoto action_29
action_44 (32) = happyGoto action_30
action_44 (33) = happyGoto action_31
action_44 (34) = happyGoto action_32
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (60) = happyShift action_60
action_45 _ = happyReduce_11

action_46 (55) = happyShift action_59
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (52) = happyShift action_13
action_47 (12) = happyGoto action_58
action_47 _ = happyReduce_19

action_48 _ = happyReduce_20

action_49 (42) = happyShift action_23
action_49 (8) = happyGoto action_19
action_49 (9) = happyGoto action_20
action_49 (10) = happyGoto action_21
action_49 (11) = happyGoto action_57
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (38) = happyShift action_33
action_50 (39) = happyShift action_34
action_50 (40) = happyShift action_35
action_50 (41) = happyShift action_36
action_50 (42) = happyShift action_37
action_50 (43) = happyShift action_38
action_50 (44) = happyShift action_39
action_50 (45) = happyShift action_40
action_50 (46) = happyShift action_41
action_50 (50) = happyShift action_42
action_50 (52) = happyShift action_43
action_50 (56) = happyShift action_44
action_50 (28) = happyGoto action_56
action_50 (29) = happyGoto action_27
action_50 (30) = happyGoto action_28
action_50 (31) = happyGoto action_29
action_50 (32) = happyGoto action_30
action_50 (33) = happyGoto action_31
action_50 (34) = happyGoto action_32
action_50 _ = happyFail (happyExpListPerState 50)

action_51 _ = happyReduce_15

action_52 _ = happyReduce_5

action_53 (48) = happyShift action_55
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_6

action_55 (38) = happyShift action_33
action_55 (39) = happyShift action_34
action_55 (40) = happyShift action_35
action_55 (41) = happyShift action_36
action_55 (42) = happyShift action_37
action_55 (43) = happyShift action_38
action_55 (44) = happyShift action_39
action_55 (45) = happyShift action_40
action_55 (46) = happyShift action_41
action_55 (50) = happyShift action_42
action_55 (52) = happyShift action_43
action_55 (56) = happyShift action_44
action_55 (28) = happyGoto action_111
action_55 (29) = happyGoto action_27
action_55 (30) = happyGoto action_28
action_55 (31) = happyGoto action_29
action_55 (32) = happyGoto action_30
action_55 (33) = happyGoto action_31
action_55 (34) = happyGoto action_32
action_55 _ = happyFail (happyExpListPerState 55)

action_56 _ = happyReduce_16

action_57 _ = happyReduce_18

action_58 (59) = happyShift action_110
action_58 _ = happyReduce_8

action_59 _ = happyReduce_3

action_60 (43) = happyShift action_47
action_60 (6) = happyGoto action_45
action_60 (7) = happyGoto action_109
action_60 _ = happyReduce_10

action_61 (57) = happyShift action_108
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (58) = happyShift action_107
action_62 _ = happyReduce_21

action_63 (53) = happyShift action_105
action_63 (58) = happyShift action_106
action_63 _ = happyFail (happyExpListPerState 63)

action_64 _ = happyReduce_68

action_65 _ = happyReduce_23

action_66 (42) = happyShift action_23
action_66 (47) = happyShift action_68
action_66 (8) = happyGoto action_65
action_66 (14) = happyGoto action_66
action_66 (15) = happyGoto action_104
action_66 _ = happyReduce_25

action_67 (59) = happyShift action_103
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_24

action_69 _ = happyReduce_27

action_70 (42) = happyShift action_23
action_70 (47) = happyShift action_68
action_70 (52) = happyShift action_72
action_70 (8) = happyGoto action_65
action_70 (14) = happyGoto action_69
action_70 (16) = happyGoto action_70
action_70 (17) = happyGoto action_102
action_70 _ = happyReduce_29

action_71 (49) = happyShift action_100
action_71 (54) = happyShift action_101
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (42) = happyShift action_23
action_72 (47) = happyShift action_68
action_72 (8) = happyGoto action_65
action_72 (14) = happyGoto action_66
action_72 (15) = happyGoto action_99
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (39) = happyShift action_34
action_73 (41) = happyShift action_36
action_73 (42) = happyShift action_93
action_73 (43) = happyShift action_94
action_73 (45) = happyShift action_95
action_73 (47) = happyShift action_96
action_73 (52) = happyShift action_97
action_73 (56) = happyShift action_98
action_73 (18) = happyGoto action_85
action_73 (22) = happyGoto action_86
action_73 (24) = happyGoto action_87
action_73 (25) = happyGoto action_88
action_73 (26) = happyGoto action_89
action_73 (27) = happyGoto action_90
action_73 (30) = happyGoto action_91
action_73 (32) = happyGoto action_92
action_73 _ = happyReduce_55

action_74 (48) = happyShift action_84
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (34) = happyGoto action_83
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (34) = happyGoto action_82
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_65

action_78 (42) = happyShift action_23
action_78 (8) = happyGoto action_81
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (43) = happyShift action_47
action_79 (6) = happyGoto action_45
action_79 (7) = happyGoto action_80
action_79 _ = happyReduce_10

action_80 (55) = happyShift action_135
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (48) = happyShift action_134
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (51) = happyShift action_76
action_82 _ = happyReduce_83

action_83 (49) = happyShift action_75
action_83 (51) = happyShift action_76
action_83 _ = happyReduce_82

action_84 (38) = happyShift action_33
action_84 (39) = happyShift action_34
action_84 (40) = happyShift action_35
action_84 (41) = happyShift action_36
action_84 (42) = happyShift action_37
action_84 (43) = happyShift action_38
action_84 (44) = happyShift action_39
action_84 (45) = happyShift action_40
action_84 (46) = happyShift action_41
action_84 (50) = happyShift action_42
action_84 (52) = happyShift action_43
action_84 (56) = happyShift action_44
action_84 (28) = happyGoto action_133
action_84 (29) = happyGoto action_27
action_84 (30) = happyGoto action_28
action_84 (31) = happyGoto action_29
action_84 (32) = happyGoto action_30
action_84 (33) = happyGoto action_31
action_84 (34) = happyGoto action_32
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (39) = happyShift action_34
action_85 (41) = happyShift action_36
action_85 (42) = happyShift action_93
action_85 (43) = happyShift action_94
action_85 (45) = happyShift action_95
action_85 (47) = happyShift action_96
action_85 (52) = happyShift action_132
action_85 (56) = happyShift action_98
action_85 (18) = happyGoto action_127
action_85 (19) = happyGoto action_128
action_85 (20) = happyGoto action_129
action_85 (22) = happyGoto action_130
action_85 (23) = happyGoto action_131
action_85 (30) = happyGoto action_91
action_85 (32) = happyGoto action_92
action_85 _ = happyReduce_40

action_86 _ = happyReduce_50

action_87 (58) = happyShift action_126
action_87 _ = happyReduce_52

action_88 (49) = happyShift action_125
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (60) = happyShift action_124
action_89 _ = happyReduce_56

action_90 (55) = happyShift action_123
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_45

action_92 _ = happyReduce_46

action_93 _ = happyReduce_41

action_94 _ = happyReduce_31

action_95 _ = happyReduce_32

action_96 _ = happyReduce_47

action_97 (39) = happyShift action_34
action_97 (41) = happyShift action_36
action_97 (42) = happyShift action_93
action_97 (43) = happyShift action_94
action_97 (45) = happyShift action_95
action_97 (47) = happyShift action_96
action_97 (52) = happyShift action_97
action_97 (56) = happyShift action_98
action_97 (18) = happyGoto action_85
action_97 (21) = happyGoto action_121
action_97 (22) = happyGoto action_86
action_97 (24) = happyGoto action_122
action_97 (30) = happyGoto action_91
action_97 (32) = happyGoto action_92
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (39) = happyShift action_34
action_98 (41) = happyShift action_36
action_98 (42) = happyShift action_93
action_98 (43) = happyShift action_94
action_98 (45) = happyShift action_95
action_98 (47) = happyShift action_96
action_98 (52) = happyShift action_97
action_98 (56) = happyShift action_98
action_98 (57) = happyShift action_120
action_98 (18) = happyGoto action_85
action_98 (22) = happyGoto action_86
action_98 (24) = happyGoto action_87
action_98 (25) = happyGoto action_119
action_98 (30) = happyGoto action_91
action_98 (32) = happyGoto action_92
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (59) = happyShift action_118
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (39) = happyShift action_34
action_100 (40) = happyShift action_35
action_100 (41) = happyShift action_36
action_100 (42) = happyShift action_37
action_100 (43) = happyShift action_38
action_100 (44) = happyShift action_39
action_100 (45) = happyShift action_40
action_100 (30) = happyGoto action_28
action_100 (31) = happyGoto action_29
action_100 (32) = happyGoto action_30
action_100 (33) = happyGoto action_117
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (39) = happyShift action_34
action_101 (41) = happyShift action_36
action_101 (42) = happyShift action_93
action_101 (43) = happyShift action_94
action_101 (45) = happyShift action_95
action_101 (47) = happyShift action_96
action_101 (52) = happyShift action_97
action_101 (56) = happyShift action_98
action_101 (18) = happyGoto action_85
action_101 (22) = happyGoto action_86
action_101 (24) = happyGoto action_87
action_101 (25) = happyGoto action_88
action_101 (26) = happyGoto action_89
action_101 (27) = happyGoto action_116
action_101 (30) = happyGoto action_91
action_101 (32) = happyGoto action_92
action_101 _ = happyReduce_55

action_102 _ = happyReduce_30

action_103 (38) = happyShift action_33
action_103 (39) = happyShift action_34
action_103 (40) = happyShift action_35
action_103 (41) = happyShift action_36
action_103 (42) = happyShift action_37
action_103 (43) = happyShift action_38
action_103 (44) = happyShift action_39
action_103 (45) = happyShift action_40
action_103 (46) = happyShift action_41
action_103 (50) = happyShift action_42
action_103 (52) = happyShift action_43
action_103 (56) = happyShift action_44
action_103 (28) = happyGoto action_115
action_103 (29) = happyGoto action_27
action_103 (30) = happyGoto action_28
action_103 (31) = happyGoto action_29
action_103 (32) = happyGoto action_30
action_103 (33) = happyGoto action_31
action_103 (34) = happyGoto action_32
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_26

action_105 _ = happyReduce_67

action_106 (38) = happyShift action_33
action_106 (39) = happyShift action_34
action_106 (40) = happyShift action_35
action_106 (41) = happyShift action_36
action_106 (42) = happyShift action_37
action_106 (43) = happyShift action_38
action_106 (44) = happyShift action_39
action_106 (45) = happyShift action_40
action_106 (46) = happyShift action_41
action_106 (50) = happyShift action_42
action_106 (52) = happyShift action_43
action_106 (56) = happyShift action_44
action_106 (13) = happyGoto action_114
action_106 (28) = happyGoto action_62
action_106 (29) = happyGoto action_27
action_106 (30) = happyGoto action_28
action_106 (31) = happyGoto action_29
action_106 (32) = happyGoto action_30
action_106 (33) = happyGoto action_31
action_106 (34) = happyGoto action_32
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (38) = happyShift action_33
action_107 (39) = happyShift action_34
action_107 (40) = happyShift action_35
action_107 (41) = happyShift action_36
action_107 (42) = happyShift action_37
action_107 (43) = happyShift action_38
action_107 (44) = happyShift action_39
action_107 (45) = happyShift action_40
action_107 (46) = happyShift action_41
action_107 (50) = happyShift action_42
action_107 (52) = happyShift action_43
action_107 (56) = happyShift action_44
action_107 (13) = happyGoto action_113
action_107 (28) = happyGoto action_62
action_107 (29) = happyGoto action_27
action_107 (30) = happyGoto action_28
action_107 (31) = happyGoto action_29
action_107 (32) = happyGoto action_30
action_107 (33) = happyGoto action_31
action_107 (34) = happyGoto action_32
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_70

action_109 _ = happyReduce_12

action_110 (38) = happyShift action_33
action_110 (39) = happyShift action_34
action_110 (40) = happyShift action_35
action_110 (41) = happyShift action_36
action_110 (42) = happyShift action_37
action_110 (43) = happyShift action_38
action_110 (44) = happyShift action_39
action_110 (45) = happyShift action_40
action_110 (46) = happyShift action_41
action_110 (50) = happyShift action_42
action_110 (52) = happyShift action_43
action_110 (56) = happyShift action_44
action_110 (28) = happyGoto action_112
action_110 (29) = happyGoto action_27
action_110 (30) = happyGoto action_28
action_110 (31) = happyGoto action_29
action_110 (32) = happyGoto action_30
action_110 (33) = happyGoto action_31
action_110 (34) = happyGoto action_32
action_110 _ = happyFail (happyExpListPerState 110)

action_111 _ = happyReduce_7

action_112 _ = happyReduce_9

action_113 _ = happyReduce_22

action_114 (53) = happyShift action_151
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (58) = happyShift action_150
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (55) = happyShift action_149
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_60

action_118 (38) = happyShift action_33
action_118 (39) = happyShift action_34
action_118 (40) = happyShift action_35
action_118 (41) = happyShift action_36
action_118 (42) = happyShift action_37
action_118 (43) = happyShift action_38
action_118 (44) = happyShift action_39
action_118 (45) = happyShift action_40
action_118 (46) = happyShift action_41
action_118 (50) = happyShift action_42
action_118 (52) = happyShift action_43
action_118 (56) = happyShift action_44
action_118 (28) = happyGoto action_148
action_118 (29) = happyGoto action_27
action_118 (30) = happyGoto action_28
action_118 (31) = happyGoto action_29
action_118 (32) = happyGoto action_30
action_118 (33) = happyGoto action_31
action_118 (34) = happyGoto action_32
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (57) = happyShift action_147
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_43

action_121 (53) = happyShift action_146
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (58) = happyShift action_145
action_122 _ = happyFail (happyExpListPerState 122)

action_123 _ = happyReduce_62

action_124 (39) = happyShift action_34
action_124 (41) = happyShift action_36
action_124 (42) = happyShift action_93
action_124 (43) = happyShift action_94
action_124 (45) = happyShift action_95
action_124 (47) = happyShift action_96
action_124 (52) = happyShift action_97
action_124 (56) = happyShift action_98
action_124 (18) = happyGoto action_85
action_124 (22) = happyGoto action_86
action_124 (24) = happyGoto action_87
action_124 (25) = happyGoto action_88
action_124 (26) = happyGoto action_89
action_124 (27) = happyGoto action_144
action_124 (30) = happyGoto action_91
action_124 (32) = happyGoto action_92
action_124 _ = happyReduce_55

action_125 (38) = happyShift action_33
action_125 (39) = happyShift action_34
action_125 (40) = happyShift action_35
action_125 (41) = happyShift action_36
action_125 (42) = happyShift action_37
action_125 (43) = happyShift action_38
action_125 (44) = happyShift action_39
action_125 (45) = happyShift action_40
action_125 (46) = happyShift action_41
action_125 (50) = happyShift action_42
action_125 (52) = happyShift action_43
action_125 (56) = happyShift action_44
action_125 (28) = happyGoto action_143
action_125 (29) = happyGoto action_27
action_125 (30) = happyGoto action_28
action_125 (31) = happyGoto action_29
action_125 (32) = happyGoto action_30
action_125 (33) = happyGoto action_31
action_125 (34) = happyGoto action_32
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (39) = happyShift action_34
action_126 (41) = happyShift action_36
action_126 (42) = happyShift action_93
action_126 (43) = happyShift action_94
action_126 (45) = happyShift action_95
action_126 (47) = happyShift action_96
action_126 (52) = happyShift action_97
action_126 (56) = happyShift action_98
action_126 (18) = happyGoto action_85
action_126 (22) = happyGoto action_86
action_126 (24) = happyGoto action_87
action_126 (25) = happyGoto action_142
action_126 (30) = happyGoto action_91
action_126 (32) = happyGoto action_92
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_40

action_128 (39) = happyShift action_34
action_128 (41) = happyShift action_36
action_128 (42) = happyShift action_93
action_128 (43) = happyShift action_94
action_128 (45) = happyShift action_95
action_128 (47) = happyShift action_96
action_128 (52) = happyShift action_132
action_128 (56) = happyShift action_98
action_128 (18) = happyGoto action_127
action_128 (19) = happyGoto action_128
action_128 (20) = happyGoto action_141
action_128 (22) = happyGoto action_130
action_128 (23) = happyGoto action_131
action_128 (30) = happyGoto action_91
action_128 (32) = happyGoto action_92
action_128 _ = happyReduce_36

action_129 _ = happyReduce_51

action_130 _ = happyReduce_48

action_131 _ = happyReduce_33

action_132 (39) = happyShift action_34
action_132 (41) = happyShift action_36
action_132 (42) = happyShift action_140
action_132 (43) = happyShift action_94
action_132 (45) = happyShift action_95
action_132 (47) = happyShift action_96
action_132 (52) = happyShift action_97
action_132 (56) = happyShift action_98
action_132 (8) = happyGoto action_138
action_132 (18) = happyGoto action_139
action_132 (21) = happyGoto action_121
action_132 (22) = happyGoto action_86
action_132 (24) = happyGoto action_122
action_132 (30) = happyGoto action_91
action_132 (32) = happyGoto action_92
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (58) = happyShift action_137
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (39) = happyShift action_34
action_134 (40) = happyShift action_35
action_134 (41) = happyShift action_36
action_134 (42) = happyShift action_37
action_134 (43) = happyShift action_38
action_134 (44) = happyShift action_39
action_134 (45) = happyShift action_40
action_134 (30) = happyGoto action_28
action_134 (31) = happyGoto action_29
action_134 (32) = happyGoto action_30
action_134 (33) = happyGoto action_136
action_134 _ = happyFail (happyExpListPerState 134)

action_135 _ = happyReduce_4

action_136 (53) = happyShift action_160
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (38) = happyShift action_33
action_137 (39) = happyShift action_34
action_137 (40) = happyShift action_35
action_137 (41) = happyShift action_36
action_137 (42) = happyShift action_37
action_137 (43) = happyShift action_38
action_137 (44) = happyShift action_39
action_137 (45) = happyShift action_40
action_137 (46) = happyShift action_41
action_137 (50) = happyShift action_42
action_137 (52) = happyShift action_43
action_137 (56) = happyShift action_44
action_137 (28) = happyGoto action_159
action_137 (29) = happyGoto action_27
action_137 (30) = happyGoto action_28
action_137 (31) = happyGoto action_29
action_137 (32) = happyGoto action_30
action_137 (33) = happyGoto action_31
action_137 (34) = happyGoto action_32
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (48) = happyShift action_158
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (39) = happyShift action_34
action_139 (41) = happyShift action_36
action_139 (42) = happyShift action_93
action_139 (43) = happyShift action_94
action_139 (45) = happyShift action_95
action_139 (47) = happyShift action_96
action_139 (52) = happyShift action_132
action_139 (56) = happyShift action_98
action_139 (18) = happyGoto action_127
action_139 (19) = happyGoto action_128
action_139 (20) = happyGoto action_157
action_139 (22) = happyGoto action_130
action_139 (23) = happyGoto action_131
action_139 (30) = happyGoto action_91
action_139 (32) = happyGoto action_92
action_139 _ = happyReduce_40

action_140 (53) = happyShift action_156
action_140 (58) = happyReduce_41
action_140 _ = happyReduce_13

action_141 _ = happyReduce_37

action_142 _ = happyReduce_53

action_143 _ = happyReduce_54

action_144 _ = happyReduce_57

action_145 (39) = happyShift action_34
action_145 (41) = happyShift action_36
action_145 (42) = happyShift action_93
action_145 (43) = happyShift action_94
action_145 (45) = happyShift action_95
action_145 (47) = happyShift action_96
action_145 (52) = happyShift action_97
action_145 (56) = happyShift action_98
action_145 (18) = happyGoto action_85
action_145 (21) = happyGoto action_154
action_145 (22) = happyGoto action_86
action_145 (24) = happyGoto action_155
action_145 (30) = happyGoto action_91
action_145 (32) = happyGoto action_92
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_42

action_147 _ = happyReduce_44

action_148 (53) = happyShift action_153
action_148 _ = happyFail (happyExpListPerState 148)

action_149 _ = happyReduce_61

action_150 (38) = happyShift action_33
action_150 (39) = happyShift action_34
action_150 (40) = happyShift action_35
action_150 (41) = happyShift action_36
action_150 (42) = happyShift action_37
action_150 (43) = happyShift action_38
action_150 (44) = happyShift action_39
action_150 (45) = happyShift action_40
action_150 (46) = happyShift action_41
action_150 (50) = happyShift action_42
action_150 (52) = happyShift action_43
action_150 (56) = happyShift action_44
action_150 (28) = happyGoto action_152
action_150 (29) = happyGoto action_27
action_150 (30) = happyGoto action_28
action_150 (31) = happyGoto action_29
action_150 (32) = happyGoto action_30
action_150 (33) = happyGoto action_31
action_150 (34) = happyGoto action_32
action_150 _ = happyFail (happyExpListPerState 150)

action_151 _ = happyReduce_69

action_152 _ = happyReduce_59

action_153 _ = happyReduce_28

action_154 _ = happyReduce_39

action_155 (58) = happyShift action_145
action_155 _ = happyReduce_38

action_156 _ = happyReduce_35

action_157 (53) = happyShift action_163
action_157 _ = happyReduce_51

action_158 (39) = happyShift action_34
action_158 (41) = happyShift action_36
action_158 (42) = happyShift action_93
action_158 (43) = happyShift action_94
action_158 (45) = happyShift action_95
action_158 (47) = happyShift action_96
action_158 (52) = happyShift action_162
action_158 (56) = happyShift action_98
action_158 (18) = happyGoto action_127
action_158 (22) = happyGoto action_130
action_158 (23) = happyGoto action_161
action_158 (30) = happyGoto action_91
action_158 (32) = happyGoto action_92
action_158 _ = happyFail (happyExpListPerState 158)

action_159 _ = happyReduce_58

action_160 _ = happyReduce_66

action_161 (53) = happyShift action_164
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (39) = happyShift action_34
action_162 (41) = happyShift action_36
action_162 (42) = happyShift action_93
action_162 (43) = happyShift action_94
action_162 (45) = happyShift action_95
action_162 (47) = happyShift action_96
action_162 (52) = happyShift action_97
action_162 (56) = happyShift action_98
action_162 (18) = happyGoto action_139
action_162 (21) = happyGoto action_121
action_162 (22) = happyGoto action_86
action_162 (24) = happyGoto action_122
action_162 (30) = happyGoto action_91
action_162 (32) = happyGoto action_92
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_49

action_164 _ = happyReduce_34

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
happyReduction_46 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Literal happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  22 happyReduction_47
happyReduction_47 _
	 =  HappyAbsSyn19
		 (Wildcard
	)

happyReduce_48 = happySpecReduce_1  23 happyReduction_48
happyReduction_48 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happyReduce 4 23 happyReduction_49
happyReduction_49 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_3) `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_50 = happySpecReduce_1  24 happyReduction_50
happyReduction_50 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  24 happyReduction_51
happyReduction_51 (HappyAbsSyn20  happy_var_2)
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn19
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  25 happyReduction_52
happyReduction_52 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| []
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_3  25 happyReduction_53
happyReduction_53 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_3  26 happyReduction_54
happyReduction_54 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn26
		 ((happy_var_1, happy_var_3)
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_0  27 happyReduction_55
happyReduction_55  =  HappyAbsSyn27
		 ([]
	)

happyReduce_56 = happySpecReduce_1  27 happyReduction_56
happyReduction_56 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  27 happyReduction_57
happyReduction_57 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happyReduce 6 28 happyReduction_58
happyReduction_58 ((HappyAbsSyn28  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_59 = happyReduce 6 28 happyReduction_59
happyReduction_59 ((HappyAbsSyn28  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (ForAll happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_60 = happyReduce 4 28 happyReduction_60
happyReduction_60 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_61 = happyReduce 5 28 happyReduction_61
happyReduction_61 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_62 = happyReduce 4 28 happyReduction_62
happyReduction_62 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_63 = happySpecReduce_1  28 happyReduction_63
happyReduction_63 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  28 happyReduction_64
happyReduction_64 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_2  29 happyReduction_65
happyReduction_65 (HappyAbsSyn28  happy_var_2)
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Application happy_var_1 ((Nothing, happy_var_2) :| [])
	)
happyReduction_65 _ _  = notHappyAtAll 

happyReduce_66 = happyReduce 6 29 happyReduction_66
happyReduction_66 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Application happy_var_1 ((Just happy_var_3, happy_var_5) :| [])
	) `HappyStk` happyRest

happyReduce_67 = happySpecReduce_3  29 happyReduction_67
happyReduction_67 _
	(HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (Parenthesized happy_var_2
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_2  29 happyReduction_68
happyReduction_68 _
	_
	 =  HappyAbsSyn28
		 (Literal UnitLiteral
	)

happyReduce_69 = happyReduce 5 29 happyReduction_69
happyReduction_69 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_70 = happySpecReduce_3  29 happyReduction_70
happyReduction_70 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (List happy_var_2
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  29 happyReduction_71
happyReduction_71 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_1  30 happyReduction_72
happyReduction_72 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn30
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_72 _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  31 happyReduction_73
happyReduction_73 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn30
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  32 happyReduction_74
happyReduction_74 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn30
		 (StringLiteral happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  33 happyReduction_75
happyReduction_75 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  33 happyReduction_76
happyReduction_76 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  33 happyReduction_77
happyReduction_77 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier happy_var_1
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  33 happyReduction_78
happyReduction_78 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier happy_var_1
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  33 happyReduction_79
happyReduction_79 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  33 happyReduction_80
happyReduction_80 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  33 happyReduction_81
happyReduction_81 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  34 happyReduction_82
happyReduction_82 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_3  34 happyReduction_83
happyReduction_83 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (TokenInfixOp happy_var_2))
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Infix happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 61 61 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenDatatype -> cont 35;
	TokenDeclare -> cont 36;
	TokenDefine -> cont 37;
	TokenLet -> cont 38;
	TokenInt happy_dollar_dollar -> cont 39;
	TokenFloat happy_dollar_dollar -> cont 40;
	TokenString happy_dollar_dollar -> cont 41;
	TokenLSym happy_dollar_dollar -> cont 42;
	TokenUSym happy_dollar_dollar -> cont 43;
	TokenLSymQ happy_dollar_dollar -> cont 44;
	TokenUSymQ happy_dollar_dollar -> cont 45;
	TokenBackslash -> cont 46;
	TokenUnderscore -> cont 47;
	TokenEq -> cont 48;
	TokenArrow -> cont 49;
	TokenForAll -> cont 50;
	TokenInfixOp happy_dollar_dollar -> cont 51;
	TokenLParen -> cont 52;
	TokenRParen -> cont 53;
	TokenLBrace -> cont 54;
	TokenRBrace -> cont 55;
	TokenLBracket -> cont 56;
	TokenRBracket -> cont 57;
	TokenComma -> cont 58;
	TokenColon -> cont 59;
	TokenSemicolon -> cont 60;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 61 tk tks = happyError' (tks, explist)
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
