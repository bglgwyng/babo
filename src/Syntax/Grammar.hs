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
happyExpList = Happy_Data_Array.listArray (0,496) ([0,0,28,0,0,49152,1,0,0,0,0,0,0,16384,0,0,0,512,0,0,0,32,0,0,0,0,0,0,448,0,0,0,0,0,0,0,16384,0,0,0,1024,0,0,0,64,0,0,0,528,0,0,32,0,0,0,0,2,0,0,8200,0,0,16352,68,0,0,17406,4,0,57344,17471,0,0,8192,0,0,0,0,512,0,0,0,16,0,0,2048,0,0,0,0,0,0,1024,0,0,0,17406,4,0,0,4096,0,0,64512,1091,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17440,1,0,57344,19519,0,0,65024,1091,0,0,0,1024,0,0,0,2,0,0,1024,0,0,0,0,0,0,512,0,0,0,17406,4,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,57344,17471,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,16384,0,0,0,0,128,0,0,0,16,0,0,2048,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1090,0,0,0,272,0,0,0,0,0,0,1056,0,0,16384,17495,0,0,0,8,0,0,16320,68,0,0,17404,4,0,0,0,0,0,65024,1219,0,0,1024,0,0,0,0,2,0,0,128,0,0,0,0,0,0,0,2,0,0,12288,0,0,57344,17471,0,0,29696,1093,0,0,0,0,0,0,0,16,0,0,256,0,0,0,16384,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,29696,1093,0,0,22336,196,0,0,1056,0,0,0,0,2,0,64512,1091,0,0,22336,68,0,0,0,0,0,0,0,0,0,65024,1091,0,0,16352,68,0,0,0,0,0,0,0,0,0,65024,1091,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,32,0,0,0,0,0,57344,17471,0,0,0,0,0,0,0,128,0,0,0,0,0,0,2048,0,0,0,4096,0,0,0,0,0,0,17780,4,0,57344,17471,0,0,29696,1093,0,0,0,0,0,0,17780,4,0,0,0,0,0,0,0,0,0,0,0,0,0,17780,4,0,0,0,1,0,64512,1091,0,0,0,0,0,0,32768,0,0,57344,17471,0,0,0,8,0,0,22336,68,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,17495,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,8,0,0,17780,4,0,0,0,0,0,0,0,0,0,0,8,0,0,17780,4,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Statement","Variant","Variants","NewName","NewNames","Argument","Arguments_","Arguments","CommaSeperated","NewName_","NewName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","Juxtaposition","IntegerLiteral","FloatLiteral","StringLiteral","Atom","BinaryExpression","datatype","declare","define","let","int","float","string","lsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 60
        bit_end = (st Prelude.+ 1) Prelude.* 60
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..59]
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

action_6 (60) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (35) = happyShift action_3
action_7 (36) = happyShift action_4
action_7 (37) = happyShift action_5
action_7 (4) = happyGoto action_8
action_7 (5) = happyGoto action_7
action_7 _ = happyReduce_1

action_8 _ = happyReduce_2

action_9 (51) = happyShift action_13
action_9 (12) = happyGoto action_15
action_9 _ = happyReduce_19

action_10 (51) = happyShift action_13
action_10 (12) = happyGoto action_14
action_10 _ = happyReduce_19

action_11 (51) = happyShift action_13
action_11 (12) = happyGoto action_12
action_11 _ = happyReduce_19

action_12 (53) = happyShift action_24
action_12 (58) = happyShift action_25
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (42) = happyShift action_23
action_13 (8) = happyGoto action_19
action_13 (9) = happyGoto action_20
action_13 (10) = happyGoto action_21
action_13 (11) = happyGoto action_22
action_13 _ = happyFail (happyExpListPerState 13)

action_14 (58) = happyShift action_18
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (48) = happyShift action_16
action_15 (58) = happyShift action_17
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
action_16 (51) = happyShift action_42
action_16 (55) = happyShift action_43
action_16 (28) = happyGoto action_53
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
action_17 (51) = happyShift action_42
action_17 (55) = happyShift action_43
action_17 (28) = happyGoto action_52
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
action_18 (51) = happyShift action_42
action_18 (55) = happyShift action_43
action_18 (28) = happyGoto action_51
action_18 (29) = happyGoto action_27
action_18 (30) = happyGoto action_28
action_18 (31) = happyGoto action_29
action_18 (32) = happyGoto action_30
action_18 (33) = happyGoto action_31
action_18 (34) = happyGoto action_32
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (42) = happyShift action_23
action_19 (8) = happyGoto action_19
action_19 (9) = happyGoto action_50
action_19 _ = happyReduce_14

action_20 (58) = happyShift action_49
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (57) = happyShift action_48
action_21 _ = happyReduce_17

action_22 (52) = happyShift action_47
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_13

action_24 (43) = happyShift action_46
action_24 (6) = happyGoto action_44
action_24 (7) = happyGoto action_45
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
action_25 (51) = happyShift action_42
action_25 (55) = happyShift action_43
action_25 (28) = happyGoto action_26
action_25 (29) = happyGoto action_27
action_25 (30) = happyGoto action_28
action_25 (31) = happyGoto action_29
action_25 (32) = happyGoto action_30
action_25 (33) = happyGoto action_31
action_25 (34) = happyGoto action_32
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (53) = happyShift action_76
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (39) = happyShift action_34
action_27 (40) = happyShift action_35
action_27 (41) = happyShift action_36
action_27 (42) = happyShift action_37
action_27 (43) = happyShift action_38
action_27 (44) = happyShift action_39
action_27 (45) = happyShift action_40
action_27 (46) = happyShift action_41
action_27 (51) = happyShift action_75
action_27 (55) = happyShift action_43
action_27 (30) = happyGoto action_28
action_27 (31) = happyGoto action_29
action_27 (32) = happyGoto action_30
action_27 (33) = happyGoto action_74
action_27 _ = happyReduce_82

action_28 _ = happyReduce_77

action_29 _ = happyReduce_78

action_30 _ = happyReduce_79

action_31 _ = happyReduce_62

action_32 (49) = happyShift action_72
action_32 (50) = happyShift action_73
action_32 _ = happyReduce_59

action_33 (42) = happyShift action_71
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_63

action_35 _ = happyReduce_64

action_36 _ = happyReduce_65

action_37 _ = happyReduce_73

action_38 _ = happyReduce_74

action_39 _ = happyReduce_75

action_40 _ = happyReduce_76

action_41 (42) = happyShift action_23
action_41 (47) = happyShift action_68
action_41 (51) = happyShift action_69
action_41 (53) = happyShift action_70
action_41 (8) = happyGoto action_64
action_41 (14) = happyGoto action_65
action_41 (16) = happyGoto action_66
action_41 (17) = happyGoto action_67
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (38) = happyShift action_33
action_42 (39) = happyShift action_34
action_42 (40) = happyShift action_35
action_42 (41) = happyShift action_36
action_42 (42) = happyShift action_37
action_42 (43) = happyShift action_38
action_42 (44) = happyShift action_39
action_42 (45) = happyShift action_40
action_42 (46) = happyShift action_41
action_42 (51) = happyShift action_42
action_42 (52) = happyShift action_63
action_42 (55) = happyShift action_43
action_42 (28) = happyGoto action_62
action_42 (29) = happyGoto action_27
action_42 (30) = happyGoto action_28
action_42 (31) = happyGoto action_29
action_42 (32) = happyGoto action_30
action_42 (33) = happyGoto action_31
action_42 (34) = happyGoto action_32
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
action_43 (51) = happyShift action_42
action_43 (55) = happyShift action_43
action_43 (13) = happyGoto action_60
action_43 (28) = happyGoto action_61
action_43 (29) = happyGoto action_27
action_43 (30) = happyGoto action_28
action_43 (31) = happyGoto action_29
action_43 (32) = happyGoto action_30
action_43 (33) = happyGoto action_31
action_43 (34) = happyGoto action_32
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (59) = happyShift action_59
action_44 _ = happyReduce_11

action_45 (54) = happyShift action_58
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (51) = happyShift action_13
action_46 (12) = happyGoto action_57
action_46 _ = happyReduce_19

action_47 _ = happyReduce_20

action_48 (42) = happyShift action_23
action_48 (8) = happyGoto action_19
action_48 (9) = happyGoto action_20
action_48 (10) = happyGoto action_21
action_48 (11) = happyGoto action_56
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (38) = happyShift action_33
action_49 (39) = happyShift action_34
action_49 (40) = happyShift action_35
action_49 (41) = happyShift action_36
action_49 (42) = happyShift action_37
action_49 (43) = happyShift action_38
action_49 (44) = happyShift action_39
action_49 (45) = happyShift action_40
action_49 (46) = happyShift action_41
action_49 (51) = happyShift action_42
action_49 (55) = happyShift action_43
action_49 (28) = happyGoto action_55
action_49 (29) = happyGoto action_27
action_49 (30) = happyGoto action_28
action_49 (31) = happyGoto action_29
action_49 (32) = happyGoto action_30
action_49 (33) = happyGoto action_31
action_49 (34) = happyGoto action_32
action_49 _ = happyFail (happyExpListPerState 49)

action_50 _ = happyReduce_15

action_51 _ = happyReduce_5

action_52 (48) = happyShift action_54
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_6

action_54 (38) = happyShift action_33
action_54 (39) = happyShift action_34
action_54 (40) = happyShift action_35
action_54 (41) = happyShift action_36
action_54 (42) = happyShift action_37
action_54 (43) = happyShift action_38
action_54 (44) = happyShift action_39
action_54 (45) = happyShift action_40
action_54 (46) = happyShift action_41
action_54 (51) = happyShift action_42
action_54 (55) = happyShift action_43
action_54 (28) = happyGoto action_108
action_54 (29) = happyGoto action_27
action_54 (30) = happyGoto action_28
action_54 (31) = happyGoto action_29
action_54 (32) = happyGoto action_30
action_54 (33) = happyGoto action_31
action_54 (34) = happyGoto action_32
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_16

action_56 _ = happyReduce_18

action_57 (58) = happyShift action_107
action_57 _ = happyReduce_8

action_58 _ = happyReduce_3

action_59 (43) = happyShift action_46
action_59 (6) = happyGoto action_44
action_59 (7) = happyGoto action_106
action_59 _ = happyReduce_10

action_60 (56) = happyShift action_105
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (57) = happyShift action_104
action_61 _ = happyReduce_21

action_62 (52) = happyShift action_102
action_62 (57) = happyShift action_103
action_62 _ = happyFail (happyExpListPerState 62)

action_63 _ = happyReduce_67

action_64 _ = happyReduce_23

action_65 _ = happyReduce_27

action_66 (42) = happyShift action_23
action_66 (47) = happyShift action_68
action_66 (51) = happyShift action_69
action_66 (8) = happyGoto action_64
action_66 (14) = happyGoto action_65
action_66 (16) = happyGoto action_66
action_66 (17) = happyGoto action_101
action_66 _ = happyReduce_29

action_67 (49) = happyShift action_99
action_67 (53) = happyShift action_100
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_24

action_69 (42) = happyShift action_23
action_69 (47) = happyShift action_68
action_69 (8) = happyGoto action_64
action_69 (14) = happyGoto action_97
action_69 (15) = happyGoto action_98
action_69 _ = happyFail (happyExpListPerState 69)

action_70 (39) = happyShift action_34
action_70 (41) = happyShift action_36
action_70 (42) = happyShift action_91
action_70 (43) = happyShift action_92
action_70 (45) = happyShift action_93
action_70 (47) = happyShift action_94
action_70 (51) = happyShift action_95
action_70 (55) = happyShift action_96
action_70 (18) = happyGoto action_83
action_70 (22) = happyGoto action_84
action_70 (24) = happyGoto action_85
action_70 (25) = happyGoto action_86
action_70 (26) = happyGoto action_87
action_70 (27) = happyGoto action_88
action_70 (30) = happyGoto action_89
action_70 (32) = happyGoto action_90
action_70 _ = happyReduce_55

action_71 (48) = happyShift action_82
action_71 _ = happyFail (happyExpListPerState 71)

action_72 (39) = happyShift action_34
action_72 (40) = happyShift action_35
action_72 (41) = happyShift action_36
action_72 (42) = happyShift action_37
action_72 (43) = happyShift action_38
action_72 (44) = happyShift action_39
action_72 (45) = happyShift action_40
action_72 (46) = happyShift action_41
action_72 (51) = happyShift action_42
action_72 (55) = happyShift action_43
action_72 (29) = happyGoto action_27
action_72 (30) = happyGoto action_28
action_72 (31) = happyGoto action_29
action_72 (32) = happyGoto action_30
action_72 (33) = happyGoto action_31
action_72 (34) = happyGoto action_81
action_72 _ = happyFail (happyExpListPerState 72)

action_73 (39) = happyShift action_34
action_73 (40) = happyShift action_35
action_73 (41) = happyShift action_36
action_73 (42) = happyShift action_37
action_73 (43) = happyShift action_38
action_73 (44) = happyShift action_39
action_73 (45) = happyShift action_40
action_73 (46) = happyShift action_41
action_73 (51) = happyShift action_42
action_73 (55) = happyShift action_43
action_73 (29) = happyGoto action_27
action_73 (30) = happyGoto action_28
action_73 (31) = happyGoto action_29
action_73 (32) = happyGoto action_30
action_73 (33) = happyGoto action_31
action_73 (34) = happyGoto action_80
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_60

action_75 (38) = happyShift action_33
action_75 (39) = happyShift action_34
action_75 (40) = happyShift action_35
action_75 (41) = happyShift action_36
action_75 (42) = happyShift action_79
action_75 (43) = happyShift action_38
action_75 (44) = happyShift action_39
action_75 (45) = happyShift action_40
action_75 (46) = happyShift action_41
action_75 (51) = happyShift action_42
action_75 (52) = happyShift action_63
action_75 (55) = happyShift action_43
action_75 (8) = happyGoto action_78
action_75 (28) = happyGoto action_62
action_75 (29) = happyGoto action_27
action_75 (30) = happyGoto action_28
action_75 (31) = happyGoto action_29
action_75 (32) = happyGoto action_30
action_75 (33) = happyGoto action_31
action_75 (34) = happyGoto action_32
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (43) = happyShift action_46
action_76 (6) = happyGoto action_44
action_76 (7) = happyGoto action_77
action_76 _ = happyReduce_10

action_77 (54) = happyShift action_132
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (48) = happyShift action_131
action_78 _ = happyFail (happyExpListPerState 78)

action_79 (48) = happyReduce_13
action_79 _ = happyReduce_73

action_80 (50) = happyShift action_73
action_80 _ = happyReduce_81

action_81 (49) = happyShift action_72
action_81 (50) = happyShift action_73
action_81 _ = happyReduce_80

action_82 (38) = happyShift action_33
action_82 (39) = happyShift action_34
action_82 (40) = happyShift action_35
action_82 (41) = happyShift action_36
action_82 (42) = happyShift action_37
action_82 (43) = happyShift action_38
action_82 (44) = happyShift action_39
action_82 (45) = happyShift action_40
action_82 (46) = happyShift action_41
action_82 (51) = happyShift action_42
action_82 (55) = happyShift action_43
action_82 (28) = happyGoto action_130
action_82 (29) = happyGoto action_27
action_82 (30) = happyGoto action_28
action_82 (31) = happyGoto action_29
action_82 (32) = happyGoto action_30
action_82 (33) = happyGoto action_31
action_82 (34) = happyGoto action_32
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (39) = happyShift action_34
action_83 (41) = happyShift action_36
action_83 (42) = happyShift action_91
action_83 (43) = happyShift action_92
action_83 (45) = happyShift action_93
action_83 (47) = happyShift action_94
action_83 (51) = happyShift action_129
action_83 (55) = happyShift action_96
action_83 (18) = happyGoto action_124
action_83 (19) = happyGoto action_125
action_83 (20) = happyGoto action_126
action_83 (22) = happyGoto action_127
action_83 (23) = happyGoto action_128
action_83 (30) = happyGoto action_89
action_83 (32) = happyGoto action_90
action_83 _ = happyReduce_40

action_84 _ = happyReduce_50

action_85 (57) = happyShift action_123
action_85 _ = happyReduce_52

action_86 (49) = happyShift action_122
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (59) = happyShift action_121
action_87 _ = happyReduce_56

action_88 (54) = happyShift action_120
action_88 _ = happyFail (happyExpListPerState 88)

action_89 _ = happyReduce_45

action_90 _ = happyReduce_46

action_91 _ = happyReduce_41

action_92 _ = happyReduce_31

action_93 _ = happyReduce_32

action_94 _ = happyReduce_47

action_95 (39) = happyShift action_34
action_95 (41) = happyShift action_36
action_95 (42) = happyShift action_91
action_95 (43) = happyShift action_92
action_95 (45) = happyShift action_93
action_95 (47) = happyShift action_94
action_95 (51) = happyShift action_95
action_95 (55) = happyShift action_96
action_95 (18) = happyGoto action_83
action_95 (21) = happyGoto action_118
action_95 (22) = happyGoto action_84
action_95 (24) = happyGoto action_119
action_95 (30) = happyGoto action_89
action_95 (32) = happyGoto action_90
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (39) = happyShift action_34
action_96 (41) = happyShift action_36
action_96 (42) = happyShift action_91
action_96 (43) = happyShift action_92
action_96 (45) = happyShift action_93
action_96 (47) = happyShift action_94
action_96 (51) = happyShift action_95
action_96 (55) = happyShift action_96
action_96 (56) = happyShift action_117
action_96 (18) = happyGoto action_83
action_96 (22) = happyGoto action_84
action_96 (24) = happyGoto action_85
action_96 (25) = happyGoto action_116
action_96 (30) = happyGoto action_89
action_96 (32) = happyGoto action_90
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (42) = happyShift action_23
action_97 (47) = happyShift action_68
action_97 (8) = happyGoto action_64
action_97 (14) = happyGoto action_97
action_97 (15) = happyGoto action_115
action_97 _ = happyReduce_25

action_98 (58) = happyShift action_114
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (39) = happyShift action_34
action_99 (40) = happyShift action_35
action_99 (41) = happyShift action_36
action_99 (42) = happyShift action_37
action_99 (43) = happyShift action_38
action_99 (44) = happyShift action_39
action_99 (45) = happyShift action_40
action_99 (46) = happyShift action_41
action_99 (51) = happyShift action_42
action_99 (55) = happyShift action_43
action_99 (30) = happyGoto action_28
action_99 (31) = happyGoto action_29
action_99 (32) = happyGoto action_30
action_99 (33) = happyGoto action_113
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (39) = happyShift action_34
action_100 (41) = happyShift action_36
action_100 (42) = happyShift action_91
action_100 (43) = happyShift action_92
action_100 (45) = happyShift action_93
action_100 (47) = happyShift action_94
action_100 (51) = happyShift action_95
action_100 (55) = happyShift action_96
action_100 (18) = happyGoto action_83
action_100 (22) = happyGoto action_84
action_100 (24) = happyGoto action_85
action_100 (25) = happyGoto action_86
action_100 (26) = happyGoto action_87
action_100 (27) = happyGoto action_112
action_100 (30) = happyGoto action_89
action_100 (32) = happyGoto action_90
action_100 _ = happyReduce_55

action_101 _ = happyReduce_30

action_102 _ = happyReduce_66

action_103 (38) = happyShift action_33
action_103 (39) = happyShift action_34
action_103 (40) = happyShift action_35
action_103 (41) = happyShift action_36
action_103 (42) = happyShift action_37
action_103 (43) = happyShift action_38
action_103 (44) = happyShift action_39
action_103 (45) = happyShift action_40
action_103 (46) = happyShift action_41
action_103 (51) = happyShift action_42
action_103 (55) = happyShift action_43
action_103 (13) = happyGoto action_111
action_103 (28) = happyGoto action_61
action_103 (29) = happyGoto action_27
action_103 (30) = happyGoto action_28
action_103 (31) = happyGoto action_29
action_103 (32) = happyGoto action_30
action_103 (33) = happyGoto action_31
action_103 (34) = happyGoto action_32
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (38) = happyShift action_33
action_104 (39) = happyShift action_34
action_104 (40) = happyShift action_35
action_104 (41) = happyShift action_36
action_104 (42) = happyShift action_37
action_104 (43) = happyShift action_38
action_104 (44) = happyShift action_39
action_104 (45) = happyShift action_40
action_104 (46) = happyShift action_41
action_104 (51) = happyShift action_42
action_104 (55) = happyShift action_43
action_104 (13) = happyGoto action_110
action_104 (28) = happyGoto action_61
action_104 (29) = happyGoto action_27
action_104 (30) = happyGoto action_28
action_104 (31) = happyGoto action_29
action_104 (32) = happyGoto action_30
action_104 (33) = happyGoto action_31
action_104 (34) = happyGoto action_32
action_104 _ = happyFail (happyExpListPerState 104)

action_105 _ = happyReduce_69

action_106 _ = happyReduce_12

action_107 (38) = happyShift action_33
action_107 (39) = happyShift action_34
action_107 (40) = happyShift action_35
action_107 (41) = happyShift action_36
action_107 (42) = happyShift action_37
action_107 (43) = happyShift action_38
action_107 (44) = happyShift action_39
action_107 (45) = happyShift action_40
action_107 (46) = happyShift action_41
action_107 (51) = happyShift action_42
action_107 (55) = happyShift action_43
action_107 (28) = happyGoto action_109
action_107 (29) = happyGoto action_27
action_107 (30) = happyGoto action_28
action_107 (31) = happyGoto action_29
action_107 (32) = happyGoto action_30
action_107 (33) = happyGoto action_31
action_107 (34) = happyGoto action_32
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_7

action_109 _ = happyReduce_9

action_110 _ = happyReduce_22

action_111 (52) = happyShift action_147
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (54) = happyShift action_146
action_112 _ = happyFail (happyExpListPerState 112)

action_113 _ = happyReduce_70

action_114 (38) = happyShift action_33
action_114 (39) = happyShift action_34
action_114 (40) = happyShift action_35
action_114 (41) = happyShift action_36
action_114 (42) = happyShift action_37
action_114 (43) = happyShift action_38
action_114 (44) = happyShift action_39
action_114 (45) = happyShift action_40
action_114 (46) = happyShift action_41
action_114 (51) = happyShift action_42
action_114 (55) = happyShift action_43
action_114 (28) = happyGoto action_145
action_114 (29) = happyGoto action_27
action_114 (30) = happyGoto action_28
action_114 (31) = happyGoto action_29
action_114 (32) = happyGoto action_30
action_114 (33) = happyGoto action_31
action_114 (34) = happyGoto action_32
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_26

action_116 (56) = happyShift action_144
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_43

action_118 (52) = happyShift action_143
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (57) = happyShift action_142
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_72

action_121 (39) = happyShift action_34
action_121 (41) = happyShift action_36
action_121 (42) = happyShift action_91
action_121 (43) = happyShift action_92
action_121 (45) = happyShift action_93
action_121 (47) = happyShift action_94
action_121 (51) = happyShift action_95
action_121 (55) = happyShift action_96
action_121 (18) = happyGoto action_83
action_121 (22) = happyGoto action_84
action_121 (24) = happyGoto action_85
action_121 (25) = happyGoto action_86
action_121 (26) = happyGoto action_87
action_121 (27) = happyGoto action_141
action_121 (30) = happyGoto action_89
action_121 (32) = happyGoto action_90
action_121 _ = happyReduce_55

action_122 (38) = happyShift action_33
action_122 (39) = happyShift action_34
action_122 (40) = happyShift action_35
action_122 (41) = happyShift action_36
action_122 (42) = happyShift action_37
action_122 (43) = happyShift action_38
action_122 (44) = happyShift action_39
action_122 (45) = happyShift action_40
action_122 (46) = happyShift action_41
action_122 (51) = happyShift action_42
action_122 (55) = happyShift action_43
action_122 (28) = happyGoto action_140
action_122 (29) = happyGoto action_27
action_122 (30) = happyGoto action_28
action_122 (31) = happyGoto action_29
action_122 (32) = happyGoto action_30
action_122 (33) = happyGoto action_31
action_122 (34) = happyGoto action_32
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (39) = happyShift action_34
action_123 (41) = happyShift action_36
action_123 (42) = happyShift action_91
action_123 (43) = happyShift action_92
action_123 (45) = happyShift action_93
action_123 (47) = happyShift action_94
action_123 (51) = happyShift action_95
action_123 (55) = happyShift action_96
action_123 (18) = happyGoto action_83
action_123 (22) = happyGoto action_84
action_123 (24) = happyGoto action_85
action_123 (25) = happyGoto action_139
action_123 (30) = happyGoto action_89
action_123 (32) = happyGoto action_90
action_123 _ = happyFail (happyExpListPerState 123)

action_124 _ = happyReduce_40

action_125 (39) = happyShift action_34
action_125 (41) = happyShift action_36
action_125 (42) = happyShift action_91
action_125 (43) = happyShift action_92
action_125 (45) = happyShift action_93
action_125 (47) = happyShift action_94
action_125 (51) = happyShift action_129
action_125 (55) = happyShift action_96
action_125 (18) = happyGoto action_124
action_125 (19) = happyGoto action_125
action_125 (20) = happyGoto action_138
action_125 (22) = happyGoto action_127
action_125 (23) = happyGoto action_128
action_125 (30) = happyGoto action_89
action_125 (32) = happyGoto action_90
action_125 _ = happyReduce_36

action_126 _ = happyReduce_51

action_127 _ = happyReduce_48

action_128 _ = happyReduce_33

action_129 (39) = happyShift action_34
action_129 (41) = happyShift action_36
action_129 (42) = happyShift action_137
action_129 (43) = happyShift action_92
action_129 (45) = happyShift action_93
action_129 (47) = happyShift action_94
action_129 (51) = happyShift action_95
action_129 (55) = happyShift action_96
action_129 (8) = happyGoto action_135
action_129 (18) = happyGoto action_136
action_129 (21) = happyGoto action_118
action_129 (22) = happyGoto action_84
action_129 (24) = happyGoto action_119
action_129 (30) = happyGoto action_89
action_129 (32) = happyGoto action_90
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (57) = happyShift action_134
action_130 _ = happyFail (happyExpListPerState 130)

action_131 (39) = happyShift action_34
action_131 (40) = happyShift action_35
action_131 (41) = happyShift action_36
action_131 (42) = happyShift action_37
action_131 (43) = happyShift action_38
action_131 (44) = happyShift action_39
action_131 (45) = happyShift action_40
action_131 (46) = happyShift action_41
action_131 (51) = happyShift action_42
action_131 (55) = happyShift action_43
action_131 (30) = happyGoto action_28
action_131 (31) = happyGoto action_29
action_131 (32) = happyGoto action_30
action_131 (33) = happyGoto action_133
action_131 _ = happyFail (happyExpListPerState 131)

action_132 _ = happyReduce_4

action_133 (52) = happyShift action_155
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (38) = happyShift action_33
action_134 (39) = happyShift action_34
action_134 (40) = happyShift action_35
action_134 (41) = happyShift action_36
action_134 (42) = happyShift action_37
action_134 (43) = happyShift action_38
action_134 (44) = happyShift action_39
action_134 (45) = happyShift action_40
action_134 (46) = happyShift action_41
action_134 (51) = happyShift action_42
action_134 (55) = happyShift action_43
action_134 (28) = happyGoto action_154
action_134 (29) = happyGoto action_27
action_134 (30) = happyGoto action_28
action_134 (31) = happyGoto action_29
action_134 (32) = happyGoto action_30
action_134 (33) = happyGoto action_31
action_134 (34) = happyGoto action_32
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (48) = happyShift action_153
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (39) = happyShift action_34
action_136 (41) = happyShift action_36
action_136 (42) = happyShift action_91
action_136 (43) = happyShift action_92
action_136 (45) = happyShift action_93
action_136 (47) = happyShift action_94
action_136 (51) = happyShift action_129
action_136 (55) = happyShift action_96
action_136 (18) = happyGoto action_124
action_136 (19) = happyGoto action_125
action_136 (20) = happyGoto action_152
action_136 (22) = happyGoto action_127
action_136 (23) = happyGoto action_128
action_136 (30) = happyGoto action_89
action_136 (32) = happyGoto action_90
action_136 _ = happyReduce_40

action_137 (52) = happyShift action_151
action_137 (57) = happyReduce_41
action_137 _ = happyReduce_13

action_138 _ = happyReduce_37

action_139 _ = happyReduce_53

action_140 _ = happyReduce_54

action_141 _ = happyReduce_57

action_142 (39) = happyShift action_34
action_142 (41) = happyShift action_36
action_142 (42) = happyShift action_91
action_142 (43) = happyShift action_92
action_142 (45) = happyShift action_93
action_142 (47) = happyShift action_94
action_142 (51) = happyShift action_95
action_142 (55) = happyShift action_96
action_142 (18) = happyGoto action_83
action_142 (21) = happyGoto action_149
action_142 (22) = happyGoto action_84
action_142 (24) = happyGoto action_150
action_142 (30) = happyGoto action_89
action_142 (32) = happyGoto action_90
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_42

action_144 _ = happyReduce_44

action_145 (52) = happyShift action_148
action_145 _ = happyFail (happyExpListPerState 145)

action_146 _ = happyReduce_71

action_147 _ = happyReduce_68

action_148 _ = happyReduce_28

action_149 _ = happyReduce_39

action_150 (57) = happyShift action_142
action_150 _ = happyReduce_38

action_151 _ = happyReduce_35

action_152 (52) = happyShift action_158
action_152 _ = happyReduce_51

action_153 (39) = happyShift action_34
action_153 (41) = happyShift action_36
action_153 (42) = happyShift action_91
action_153 (43) = happyShift action_92
action_153 (45) = happyShift action_93
action_153 (47) = happyShift action_94
action_153 (51) = happyShift action_157
action_153 (55) = happyShift action_96
action_153 (18) = happyGoto action_124
action_153 (22) = happyGoto action_127
action_153 (23) = happyGoto action_156
action_153 (30) = happyGoto action_89
action_153 (32) = happyGoto action_90
action_153 _ = happyFail (happyExpListPerState 153)

action_154 _ = happyReduce_58

action_155 _ = happyReduce_61

action_156 (52) = happyShift action_159
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (39) = happyShift action_34
action_157 (41) = happyShift action_36
action_157 (42) = happyShift action_91
action_157 (43) = happyShift action_92
action_157 (45) = happyShift action_93
action_157 (47) = happyShift action_94
action_157 (51) = happyShift action_95
action_157 (55) = happyShift action_96
action_157 (18) = happyGoto action_136
action_157 (21) = happyGoto action_118
action_157 (22) = happyGoto action_84
action_157 (24) = happyGoto action_119
action_157 (30) = happyGoto action_89
action_157 (32) = happyGoto action_90
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_49

action_159 _ = happyReduce_34

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

happyReduce_59 = happySpecReduce_1  28 happyReduction_59
happyReduction_59 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  29 happyReduction_60
happyReduction_60 (HappyAbsSyn28  happy_var_2)
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Application happy_var_1 ((Nothing, happy_var_2) :| [])
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happyReduce 6 29 happyReduction_61
happyReduction_61 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Application happy_var_1 ((Just happy_var_3, happy_var_5) :| [])
	) `HappyStk` happyRest

happyReduce_62 = happySpecReduce_1  29 happyReduction_62
happyReduction_62 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_1  30 happyReduction_63
happyReduction_63 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn30
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_63 _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_1  31 happyReduction_64
happyReduction_64 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn30
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_64 _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_1  32 happyReduction_65
happyReduction_65 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn30
		 (StringLiteral happy_var_1
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  33 happyReduction_66
happyReduction_66 _
	(HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (Parenthesized happy_var_2
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_2  33 happyReduction_67
happyReduction_67 _
	_
	 =  HappyAbsSyn28
		 (Literal UnitLiteral
	)

happyReduce_68 = happyReduce 5 33 happyReduction_68
happyReduction_68 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_69 = happySpecReduce_3  33 happyReduction_69
happyReduction_69 _
	(HappyAbsSyn13  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (List happy_var_2
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happyReduce 4 33 happyReduction_70
happyReduction_70 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 5 33 happyReduction_71
happyReduction_71 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_72 = happyReduce 4 33 happyReduction_72
happyReduction_72 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_73 = happySpecReduce_1  33 happyReduction_73
happyReduction_73 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  33 happyReduction_74
happyReduction_74 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  33 happyReduction_75
happyReduction_75 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  33 happyReduction_76
happyReduction_76 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier happy_var_1
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  33 happyReduction_77
happyReduction_77 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  33 happyReduction_78
happyReduction_78 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  33 happyReduction_79
happyReduction_79 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_3  34 happyReduction_80
happyReduction_80 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_3  34 happyReduction_81
happyReduction_81 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (TokenInfixOp happy_var_2))
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Infix happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_81 _ _ _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_1  34 happyReduction_82
happyReduction_82 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_82 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 60 60 notHappyAtAll (HappyState action) sts stk []

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
	TokenInfixOp happy_dollar_dollar -> cont 50;
	TokenLParen -> cont 51;
	TokenRParen -> cont 52;
	TokenLBrace -> cont 53;
	TokenRBrace -> cont 54;
	TokenLBracket -> cont 55;
	TokenRBracket -> cont 56;
	TokenComma -> cont 57;
	TokenColon -> cont 58;
	TokenSemicolon -> cont 59;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 60 tk tks = happyError' (tks, explist)
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
