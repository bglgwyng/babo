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
	| HappyAbsSyn17 (LambdaArgument)
	| HappyAbsSyn18 (NonEmpty LambdaArgument)
	| HappyAbsSyn19 (NonEmpty String)
	| HappyAbsSyn20 (P.Pattern)
	| HappyAbsSyn21 (NonEmpty P.Pattern)
	| HappyAbsSyn22 ([Pattern])
	| HappyAbsSyn27 (Case)
	| HappyAbsSyn28 ([Case])
	| HappyAbsSyn29 (Expression)
	| HappyAbsSyn33 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,531) ([0,0,56,0,0,0,28,0,0,0,0,0,0,0,512,0,0,0,384,0,0,0,192,0,0,0,0,0,0,28672,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,256,0,0,0,16896,0,0,4096,0,0,0,0,4096,0,0,0,2049,0,0,16368,138,0,0,8184,69,0,0,36860,34,0,0,64,0,0,0,0,64,0,0,0,16,0,0,16384,0,0,0,0,0,0,0,4,0,0,63488,17695,0,0,0,2048,0,0,0,160,0,0,64768,2177,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,2576,0,0,16384,8,0,0,65280,2467,0,0,65408,1105,0,0,0,8192,0,0,0,128,0,0,0,8,0,0,0,0,0,0,128,0,0,0,18430,17,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,61440,35391,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,8192,0,0,0,0,1024,0,0,0,1024,0,0,0,528,0,0,0,0,0,0,0,0,0,0,2112,0,0,0,0,64,0,0,0,0,0,0,0,0,0,0,4228,0,0,0,8448,0,0,0,33,0,0,53248,8725,0,0,0,16,0,0,0,0,0,0,65408,1233,0,0,32576,544,0,0,16288,272,0,0,1024,0,0,0,0,32,0,0,0,1,0,0,40960,0,0,0,2048,0,0,0,0,0,0,49152,10495,2,0,32768,4270,1,0,0,0,0,0,0,0,1,0,0,64,0,0,0,0,1,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2792,17,0,0,34164,24,0,0,0,32,0,16384,8319,2,0,32768,4270,1,0,0,0,0,0,63488,17695,0,0,0,0,0,0,0,0,0,0,65280,2211,0,0,65408,1105,0,0,0,0,0,0,0,0,0,0,16368,138,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,16,0,0,0,1,0,0,0,0,0,61440,35391,0,0,0,32768,0,0,0,0,0,0,0,512,0,0,0,8192,0,0,0,0,0,0,23808,545,0,0,32736,276,0,0,22336,136,0,0,0,0,0,0,5584,34,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8541,2,0,0,0,4,0,53248,34847,0,0,0,0,0,0,0,1024,0,0,65024,4423,0,0,0,8,0,0,47616,1090,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2792,17,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,61440,35391,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,32,0,0,22336,136,0,0,0,0,0,0,0,0,0,0,0,2,0,0,34164,8,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Name","Statement","Variant","Variants","LocalName","LocalNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","BinaryExpression","Juxtaposition","Atom","IntegerLiteral","FloatLiteral","StringLiteral","datatype","declare","define","type","let","int","float","string","lsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","forall","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 63
        bit_end = (st Prelude.+ 1) Prelude.* 63
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..62]
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

action_3 (45) = happyShift action_13
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (44) = happyShift action_10
action_4 (45) = happyShift action_11
action_4 (5) = happyGoto action_12
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (44) = happyShift action_10
action_5 (45) = happyShift action_11
action_5 (5) = happyGoto action_9
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (63) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (36) = happyShift action_3
action_7 (37) = happyShift action_4
action_7 (38) = happyShift action_5
action_7 (4) = happyGoto action_8
action_7 (6) = happyGoto action_7
action_7 _ = happyReduce_1

action_8 _ = happyReduce_2

action_9 (54) = happyShift action_15
action_9 (13) = happyGoto action_17
action_9 _ = happyReduce_21

action_10 _ = happyReduce_4

action_11 _ = happyReduce_3

action_12 (54) = happyShift action_15
action_12 (13) = happyGoto action_16
action_12 _ = happyReduce_21

action_13 (54) = happyShift action_15
action_13 (13) = happyGoto action_14
action_13 _ = happyReduce_21

action_14 (56) = happyShift action_26
action_14 (61) = happyShift action_27
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (44) = happyShift action_25
action_15 (9) = happyGoto action_21
action_15 (10) = happyGoto action_22
action_15 (11) = happyGoto action_23
action_15 (12) = happyGoto action_24
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (61) = happyShift action_20
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (50) = happyShift action_18
action_17 (61) = happyShift action_19
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
action_18 (52) = happyShift action_45
action_18 (54) = happyShift action_46
action_18 (58) = happyShift action_47
action_18 (29) = happyGoto action_57
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
action_19 (52) = happyShift action_45
action_19 (54) = happyShift action_46
action_19 (58) = happyShift action_47
action_19 (29) = happyGoto action_56
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
action_20 (52) = happyShift action_45
action_20 (54) = happyShift action_46
action_20 (58) = happyShift action_47
action_20 (29) = happyGoto action_55
action_20 (30) = happyGoto action_29
action_20 (31) = happyGoto action_30
action_20 (32) = happyGoto action_31
action_20 (33) = happyGoto action_32
action_20 (34) = happyGoto action_33
action_20 (35) = happyGoto action_34
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (44) = happyShift action_25
action_21 (9) = happyGoto action_21
action_21 (10) = happyGoto action_54
action_21 _ = happyReduce_16

action_22 (61) = happyShift action_53
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (60) = happyShift action_52
action_23 _ = happyReduce_19

action_24 (55) = happyShift action_51
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_15

action_26 (45) = happyShift action_50
action_26 (7) = happyGoto action_48
action_26 (8) = happyGoto action_49
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
action_27 (52) = happyShift action_45
action_27 (54) = happyShift action_46
action_27 (58) = happyShift action_47
action_27 (29) = happyGoto action_28
action_27 (30) = happyGoto action_29
action_27 (31) = happyGoto action_30
action_27 (32) = happyGoto action_31
action_27 (33) = happyGoto action_32
action_27 (34) = happyGoto action_33
action_27 (35) = happyGoto action_34
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (56) = happyShift action_82
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (51) = happyShift action_80
action_29 (53) = happyShift action_81
action_29 _ = happyReduce_65

action_30 (39) = happyShift action_35
action_30 (41) = happyShift action_37
action_30 (42) = happyShift action_38
action_30 (43) = happyShift action_39
action_30 (44) = happyShift action_40
action_30 (45) = happyShift action_41
action_30 (46) = happyShift action_42
action_30 (47) = happyShift action_43
action_30 (54) = happyShift action_79
action_30 (58) = happyShift action_47
action_30 (32) = happyGoto action_78
action_30 (33) = happyGoto action_32
action_30 (34) = happyGoto action_33
action_30 (35) = happyGoto action_34
action_30 _ = happyReduce_68

action_31 _ = happyReduce_71

action_32 _ = happyReduce_81

action_33 _ = happyReduce_82

action_34 _ = happyReduce_83

action_35 _ = happyReduce_80

action_36 (44) = happyShift action_77
action_36 _ = happyFail (happyExpListPerState 36)

action_37 _ = happyReduce_84

action_38 _ = happyReduce_85

action_39 _ = happyReduce_86

action_40 _ = happyReduce_76

action_41 _ = happyReduce_77

action_42 _ = happyReduce_78

action_43 _ = happyReduce_79

action_44 (44) = happyShift action_25
action_44 (49) = happyShift action_71
action_44 (54) = happyShift action_75
action_44 (56) = happyShift action_76
action_44 (9) = happyGoto action_68
action_44 (15) = happyGoto action_72
action_44 (17) = happyGoto action_73
action_44 (18) = happyGoto action_74
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (44) = happyShift action_25
action_45 (49) = happyShift action_71
action_45 (9) = happyGoto action_68
action_45 (15) = happyGoto action_69
action_45 (16) = happyGoto action_70
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (39) = happyShift action_35
action_46 (40) = happyShift action_36
action_46 (41) = happyShift action_37
action_46 (42) = happyShift action_38
action_46 (43) = happyShift action_39
action_46 (44) = happyShift action_40
action_46 (45) = happyShift action_41
action_46 (46) = happyShift action_42
action_46 (47) = happyShift action_43
action_46 (48) = happyShift action_44
action_46 (52) = happyShift action_45
action_46 (54) = happyShift action_46
action_46 (55) = happyShift action_67
action_46 (58) = happyShift action_47
action_46 (29) = happyGoto action_66
action_46 (30) = happyGoto action_29
action_46 (31) = happyGoto action_30
action_46 (32) = happyGoto action_31
action_46 (33) = happyGoto action_32
action_46 (34) = happyGoto action_33
action_46 (35) = happyGoto action_34
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
action_47 (52) = happyShift action_45
action_47 (54) = happyShift action_46
action_47 (58) = happyShift action_47
action_47 (14) = happyGoto action_64
action_47 (29) = happyGoto action_65
action_47 (30) = happyGoto action_29
action_47 (31) = happyGoto action_30
action_47 (32) = happyGoto action_31
action_47 (33) = happyGoto action_32
action_47 (34) = happyGoto action_33
action_47 (35) = happyGoto action_34
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (62) = happyShift action_63
action_48 _ = happyReduce_13

action_49 (57) = happyShift action_62
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (54) = happyShift action_15
action_50 (13) = happyGoto action_61
action_50 _ = happyReduce_21

action_51 _ = happyReduce_22

action_52 (44) = happyShift action_25
action_52 (9) = happyGoto action_21
action_52 (10) = happyGoto action_22
action_52 (11) = happyGoto action_23
action_52 (12) = happyGoto action_60
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (39) = happyShift action_35
action_53 (40) = happyShift action_36
action_53 (41) = happyShift action_37
action_53 (42) = happyShift action_38
action_53 (43) = happyShift action_39
action_53 (44) = happyShift action_40
action_53 (45) = happyShift action_41
action_53 (46) = happyShift action_42
action_53 (47) = happyShift action_43
action_53 (48) = happyShift action_44
action_53 (52) = happyShift action_45
action_53 (54) = happyShift action_46
action_53 (58) = happyShift action_47
action_53 (29) = happyGoto action_59
action_53 (30) = happyGoto action_29
action_53 (31) = happyGoto action_30
action_53 (32) = happyGoto action_31
action_53 (33) = happyGoto action_32
action_53 (34) = happyGoto action_33
action_53 (35) = happyGoto action_34
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_17

action_55 _ = happyReduce_7

action_56 (50) = happyShift action_58
action_56 _ = happyFail (happyExpListPerState 56)

action_57 _ = happyReduce_8

action_58 (39) = happyShift action_35
action_58 (40) = happyShift action_36
action_58 (41) = happyShift action_37
action_58 (42) = happyShift action_38
action_58 (43) = happyShift action_39
action_58 (44) = happyShift action_40
action_58 (45) = happyShift action_41
action_58 (46) = happyShift action_42
action_58 (47) = happyShift action_43
action_58 (48) = happyShift action_44
action_58 (52) = happyShift action_45
action_58 (54) = happyShift action_46
action_58 (58) = happyShift action_47
action_58 (29) = happyGoto action_115
action_58 (30) = happyGoto action_29
action_58 (31) = happyGoto action_30
action_58 (32) = happyGoto action_31
action_58 (33) = happyGoto action_32
action_58 (34) = happyGoto action_33
action_58 (35) = happyGoto action_34
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_18

action_60 _ = happyReduce_20

action_61 (61) = happyShift action_114
action_61 _ = happyReduce_10

action_62 _ = happyReduce_5

action_63 (45) = happyShift action_50
action_63 (7) = happyGoto action_48
action_63 (8) = happyGoto action_113
action_63 _ = happyReduce_12

action_64 (59) = happyShift action_112
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (60) = happyShift action_111
action_65 _ = happyReduce_23

action_66 (55) = happyShift action_109
action_66 (60) = happyShift action_110
action_66 _ = happyFail (happyExpListPerState 66)

action_67 _ = happyReduce_73

action_68 _ = happyReduce_25

action_69 (44) = happyShift action_25
action_69 (49) = happyShift action_71
action_69 (9) = happyGoto action_68
action_69 (15) = happyGoto action_69
action_69 (16) = happyGoto action_108
action_69 _ = happyReduce_27

action_70 (61) = happyShift action_107
action_70 _ = happyFail (happyExpListPerState 70)

action_71 _ = happyReduce_26

action_72 _ = happyReduce_29

action_73 (44) = happyShift action_25
action_73 (49) = happyShift action_71
action_73 (54) = happyShift action_75
action_73 (9) = happyGoto action_68
action_73 (15) = happyGoto action_72
action_73 (17) = happyGoto action_73
action_73 (18) = happyGoto action_106
action_73 _ = happyReduce_31

action_74 (51) = happyShift action_104
action_74 (56) = happyShift action_105
action_74 _ = happyFail (happyExpListPerState 74)

action_75 (44) = happyShift action_25
action_75 (49) = happyShift action_71
action_75 (9) = happyGoto action_68
action_75 (15) = happyGoto action_69
action_75 (16) = happyGoto action_103
action_75 _ = happyFail (happyExpListPerState 75)

action_76 (41) = happyShift action_37
action_76 (43) = happyShift action_39
action_76 (44) = happyShift action_97
action_76 (45) = happyShift action_98
action_76 (47) = happyShift action_99
action_76 (49) = happyShift action_100
action_76 (54) = happyShift action_101
action_76 (58) = happyShift action_102
action_76 (19) = happyGoto action_89
action_76 (23) = happyGoto action_90
action_76 (25) = happyGoto action_91
action_76 (26) = happyGoto action_92
action_76 (27) = happyGoto action_93
action_76 (28) = happyGoto action_94
action_76 (33) = happyGoto action_95
action_76 (35) = happyGoto action_96
action_76 _ = happyReduce_57

action_77 (50) = happyShift action_88
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_69

action_79 (39) = happyShift action_35
action_79 (40) = happyShift action_36
action_79 (41) = happyShift action_37
action_79 (42) = happyShift action_38
action_79 (43) = happyShift action_39
action_79 (44) = happyShift action_87
action_79 (45) = happyShift action_41
action_79 (46) = happyShift action_42
action_79 (47) = happyShift action_43
action_79 (48) = happyShift action_44
action_79 (52) = happyShift action_45
action_79 (54) = happyShift action_46
action_79 (55) = happyShift action_67
action_79 (58) = happyShift action_47
action_79 (9) = happyGoto action_86
action_79 (29) = happyGoto action_66
action_79 (30) = happyGoto action_29
action_79 (31) = happyGoto action_30
action_79 (32) = happyGoto action_31
action_79 (33) = happyGoto action_32
action_79 (34) = happyGoto action_33
action_79 (35) = happyGoto action_34
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (39) = happyShift action_35
action_80 (41) = happyShift action_37
action_80 (42) = happyShift action_38
action_80 (43) = happyShift action_39
action_80 (44) = happyShift action_40
action_80 (45) = happyShift action_41
action_80 (46) = happyShift action_42
action_80 (47) = happyShift action_43
action_80 (54) = happyShift action_46
action_80 (58) = happyShift action_47
action_80 (30) = happyGoto action_85
action_80 (31) = happyGoto action_30
action_80 (32) = happyGoto action_31
action_80 (33) = happyGoto action_32
action_80 (34) = happyGoto action_33
action_80 (35) = happyGoto action_34
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (39) = happyShift action_35
action_81 (41) = happyShift action_37
action_81 (42) = happyShift action_38
action_81 (43) = happyShift action_39
action_81 (44) = happyShift action_40
action_81 (45) = happyShift action_41
action_81 (46) = happyShift action_42
action_81 (47) = happyShift action_43
action_81 (54) = happyShift action_46
action_81 (58) = happyShift action_47
action_81 (30) = happyGoto action_84
action_81 (31) = happyGoto action_30
action_81 (32) = happyGoto action_31
action_81 (33) = happyGoto action_32
action_81 (34) = happyGoto action_33
action_81 (35) = happyGoto action_34
action_81 _ = happyFail (happyExpListPerState 81)

action_82 (45) = happyShift action_50
action_82 (7) = happyGoto action_48
action_82 (8) = happyGoto action_83
action_82 _ = happyReduce_12

action_83 (57) = happyShift action_139
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (53) = happyShift action_81
action_84 _ = happyReduce_67

action_85 (51) = happyShift action_80
action_85 (53) = happyShift action_81
action_85 _ = happyReduce_66

action_86 (50) = happyShift action_138
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (50) = happyReduce_15
action_87 _ = happyReduce_76

action_88 (39) = happyShift action_35
action_88 (40) = happyShift action_36
action_88 (41) = happyShift action_37
action_88 (42) = happyShift action_38
action_88 (43) = happyShift action_39
action_88 (44) = happyShift action_40
action_88 (45) = happyShift action_41
action_88 (46) = happyShift action_42
action_88 (47) = happyShift action_43
action_88 (48) = happyShift action_44
action_88 (52) = happyShift action_45
action_88 (54) = happyShift action_46
action_88 (58) = happyShift action_47
action_88 (29) = happyGoto action_137
action_88 (30) = happyGoto action_29
action_88 (31) = happyGoto action_30
action_88 (32) = happyGoto action_31
action_88 (33) = happyGoto action_32
action_88 (34) = happyGoto action_33
action_88 (35) = happyGoto action_34
action_88 _ = happyFail (happyExpListPerState 88)

action_89 (41) = happyShift action_37
action_89 (43) = happyShift action_39
action_89 (44) = happyShift action_97
action_89 (45) = happyShift action_98
action_89 (47) = happyShift action_99
action_89 (49) = happyShift action_100
action_89 (54) = happyShift action_136
action_89 (58) = happyShift action_102
action_89 (19) = happyGoto action_131
action_89 (20) = happyGoto action_132
action_89 (21) = happyGoto action_133
action_89 (23) = happyGoto action_134
action_89 (24) = happyGoto action_135
action_89 (33) = happyGoto action_95
action_89 (35) = happyGoto action_96
action_89 _ = happyReduce_42

action_90 _ = happyReduce_52

action_91 (60) = happyShift action_130
action_91 _ = happyReduce_54

action_92 (51) = happyShift action_129
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (62) = happyShift action_128
action_93 _ = happyReduce_58

action_94 (57) = happyShift action_127
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_47

action_96 _ = happyReduce_48

action_97 _ = happyReduce_43

action_98 _ = happyReduce_33

action_99 _ = happyReduce_34

action_100 _ = happyReduce_49

action_101 (41) = happyShift action_37
action_101 (43) = happyShift action_39
action_101 (44) = happyShift action_97
action_101 (45) = happyShift action_98
action_101 (47) = happyShift action_99
action_101 (49) = happyShift action_100
action_101 (54) = happyShift action_101
action_101 (58) = happyShift action_102
action_101 (19) = happyGoto action_89
action_101 (22) = happyGoto action_125
action_101 (23) = happyGoto action_90
action_101 (25) = happyGoto action_126
action_101 (33) = happyGoto action_95
action_101 (35) = happyGoto action_96
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (41) = happyShift action_37
action_102 (43) = happyShift action_39
action_102 (44) = happyShift action_97
action_102 (45) = happyShift action_98
action_102 (47) = happyShift action_99
action_102 (49) = happyShift action_100
action_102 (54) = happyShift action_101
action_102 (58) = happyShift action_102
action_102 (59) = happyShift action_124
action_102 (19) = happyGoto action_89
action_102 (23) = happyGoto action_90
action_102 (25) = happyGoto action_91
action_102 (26) = happyGoto action_123
action_102 (33) = happyGoto action_95
action_102 (35) = happyGoto action_96
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (61) = happyShift action_122
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (39) = happyShift action_35
action_104 (41) = happyShift action_37
action_104 (42) = happyShift action_38
action_104 (43) = happyShift action_39
action_104 (44) = happyShift action_40
action_104 (45) = happyShift action_41
action_104 (46) = happyShift action_42
action_104 (47) = happyShift action_43
action_104 (54) = happyShift action_46
action_104 (58) = happyShift action_47
action_104 (32) = happyGoto action_121
action_104 (33) = happyGoto action_32
action_104 (34) = happyGoto action_33
action_104 (35) = happyGoto action_34
action_104 _ = happyFail (happyExpListPerState 104)

action_105 (41) = happyShift action_37
action_105 (43) = happyShift action_39
action_105 (44) = happyShift action_97
action_105 (45) = happyShift action_98
action_105 (47) = happyShift action_99
action_105 (49) = happyShift action_100
action_105 (54) = happyShift action_101
action_105 (58) = happyShift action_102
action_105 (19) = happyGoto action_89
action_105 (23) = happyGoto action_90
action_105 (25) = happyGoto action_91
action_105 (26) = happyGoto action_92
action_105 (27) = happyGoto action_93
action_105 (28) = happyGoto action_120
action_105 (33) = happyGoto action_95
action_105 (35) = happyGoto action_96
action_105 _ = happyReduce_57

action_106 _ = happyReduce_32

action_107 (39) = happyShift action_35
action_107 (40) = happyShift action_36
action_107 (41) = happyShift action_37
action_107 (42) = happyShift action_38
action_107 (43) = happyShift action_39
action_107 (44) = happyShift action_40
action_107 (45) = happyShift action_41
action_107 (46) = happyShift action_42
action_107 (47) = happyShift action_43
action_107 (48) = happyShift action_44
action_107 (52) = happyShift action_45
action_107 (54) = happyShift action_46
action_107 (58) = happyShift action_47
action_107 (29) = happyGoto action_119
action_107 (30) = happyGoto action_29
action_107 (31) = happyGoto action_30
action_107 (32) = happyGoto action_31
action_107 (33) = happyGoto action_32
action_107 (34) = happyGoto action_33
action_107 (35) = happyGoto action_34
action_107 _ = happyFail (happyExpListPerState 107)

action_108 _ = happyReduce_28

action_109 _ = happyReduce_72

action_110 (39) = happyShift action_35
action_110 (40) = happyShift action_36
action_110 (41) = happyShift action_37
action_110 (42) = happyShift action_38
action_110 (43) = happyShift action_39
action_110 (44) = happyShift action_40
action_110 (45) = happyShift action_41
action_110 (46) = happyShift action_42
action_110 (47) = happyShift action_43
action_110 (48) = happyShift action_44
action_110 (52) = happyShift action_45
action_110 (54) = happyShift action_46
action_110 (58) = happyShift action_47
action_110 (14) = happyGoto action_118
action_110 (29) = happyGoto action_65
action_110 (30) = happyGoto action_29
action_110 (31) = happyGoto action_30
action_110 (32) = happyGoto action_31
action_110 (33) = happyGoto action_32
action_110 (34) = happyGoto action_33
action_110 (35) = happyGoto action_34
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (39) = happyShift action_35
action_111 (40) = happyShift action_36
action_111 (41) = happyShift action_37
action_111 (42) = happyShift action_38
action_111 (43) = happyShift action_39
action_111 (44) = happyShift action_40
action_111 (45) = happyShift action_41
action_111 (46) = happyShift action_42
action_111 (47) = happyShift action_43
action_111 (48) = happyShift action_44
action_111 (52) = happyShift action_45
action_111 (54) = happyShift action_46
action_111 (58) = happyShift action_47
action_111 (14) = happyGoto action_117
action_111 (29) = happyGoto action_65
action_111 (30) = happyGoto action_29
action_111 (31) = happyGoto action_30
action_111 (32) = happyGoto action_31
action_111 (33) = happyGoto action_32
action_111 (34) = happyGoto action_33
action_111 (35) = happyGoto action_34
action_111 _ = happyFail (happyExpListPerState 111)

action_112 _ = happyReduce_75

action_113 _ = happyReduce_14

action_114 (39) = happyShift action_35
action_114 (40) = happyShift action_36
action_114 (41) = happyShift action_37
action_114 (42) = happyShift action_38
action_114 (43) = happyShift action_39
action_114 (44) = happyShift action_40
action_114 (45) = happyShift action_41
action_114 (46) = happyShift action_42
action_114 (47) = happyShift action_43
action_114 (48) = happyShift action_44
action_114 (52) = happyShift action_45
action_114 (54) = happyShift action_46
action_114 (58) = happyShift action_47
action_114 (29) = happyGoto action_116
action_114 (30) = happyGoto action_29
action_114 (31) = happyGoto action_30
action_114 (32) = happyGoto action_31
action_114 (33) = happyGoto action_32
action_114 (34) = happyGoto action_33
action_114 (35) = happyGoto action_34
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_9

action_116 _ = happyReduce_11

action_117 _ = happyReduce_24

action_118 (55) = happyShift action_155
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (60) = happyShift action_154
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (57) = happyShift action_153
action_120 _ = happyFail (happyExpListPerState 120)

action_121 _ = happyReduce_62

action_122 (39) = happyShift action_35
action_122 (40) = happyShift action_36
action_122 (41) = happyShift action_37
action_122 (42) = happyShift action_38
action_122 (43) = happyShift action_39
action_122 (44) = happyShift action_40
action_122 (45) = happyShift action_41
action_122 (46) = happyShift action_42
action_122 (47) = happyShift action_43
action_122 (48) = happyShift action_44
action_122 (52) = happyShift action_45
action_122 (54) = happyShift action_46
action_122 (58) = happyShift action_47
action_122 (29) = happyGoto action_152
action_122 (30) = happyGoto action_29
action_122 (31) = happyGoto action_30
action_122 (32) = happyGoto action_31
action_122 (33) = happyGoto action_32
action_122 (34) = happyGoto action_33
action_122 (35) = happyGoto action_34
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (59) = happyShift action_151
action_123 _ = happyFail (happyExpListPerState 123)

action_124 _ = happyReduce_45

action_125 (55) = happyShift action_150
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (60) = happyShift action_149
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_64

action_128 (41) = happyShift action_37
action_128 (43) = happyShift action_39
action_128 (44) = happyShift action_97
action_128 (45) = happyShift action_98
action_128 (47) = happyShift action_99
action_128 (49) = happyShift action_100
action_128 (54) = happyShift action_101
action_128 (58) = happyShift action_102
action_128 (19) = happyGoto action_89
action_128 (23) = happyGoto action_90
action_128 (25) = happyGoto action_91
action_128 (26) = happyGoto action_92
action_128 (27) = happyGoto action_93
action_128 (28) = happyGoto action_148
action_128 (33) = happyGoto action_95
action_128 (35) = happyGoto action_96
action_128 _ = happyReduce_57

action_129 (39) = happyShift action_35
action_129 (40) = happyShift action_36
action_129 (41) = happyShift action_37
action_129 (42) = happyShift action_38
action_129 (43) = happyShift action_39
action_129 (44) = happyShift action_40
action_129 (45) = happyShift action_41
action_129 (46) = happyShift action_42
action_129 (47) = happyShift action_43
action_129 (48) = happyShift action_44
action_129 (52) = happyShift action_45
action_129 (54) = happyShift action_46
action_129 (58) = happyShift action_47
action_129 (29) = happyGoto action_147
action_129 (30) = happyGoto action_29
action_129 (31) = happyGoto action_30
action_129 (32) = happyGoto action_31
action_129 (33) = happyGoto action_32
action_129 (34) = happyGoto action_33
action_129 (35) = happyGoto action_34
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (41) = happyShift action_37
action_130 (43) = happyShift action_39
action_130 (44) = happyShift action_97
action_130 (45) = happyShift action_98
action_130 (47) = happyShift action_99
action_130 (49) = happyShift action_100
action_130 (54) = happyShift action_101
action_130 (58) = happyShift action_102
action_130 (19) = happyGoto action_89
action_130 (23) = happyGoto action_90
action_130 (25) = happyGoto action_91
action_130 (26) = happyGoto action_146
action_130 (33) = happyGoto action_95
action_130 (35) = happyGoto action_96
action_130 _ = happyFail (happyExpListPerState 130)

action_131 _ = happyReduce_42

action_132 (41) = happyShift action_37
action_132 (43) = happyShift action_39
action_132 (44) = happyShift action_97
action_132 (45) = happyShift action_98
action_132 (47) = happyShift action_99
action_132 (49) = happyShift action_100
action_132 (54) = happyShift action_136
action_132 (58) = happyShift action_102
action_132 (19) = happyGoto action_131
action_132 (20) = happyGoto action_132
action_132 (21) = happyGoto action_145
action_132 (23) = happyGoto action_134
action_132 (24) = happyGoto action_135
action_132 (33) = happyGoto action_95
action_132 (35) = happyGoto action_96
action_132 _ = happyReduce_38

action_133 _ = happyReduce_53

action_134 _ = happyReduce_50

action_135 _ = happyReduce_35

action_136 (41) = happyShift action_37
action_136 (43) = happyShift action_39
action_136 (44) = happyShift action_144
action_136 (45) = happyShift action_98
action_136 (47) = happyShift action_99
action_136 (49) = happyShift action_100
action_136 (54) = happyShift action_101
action_136 (58) = happyShift action_102
action_136 (9) = happyGoto action_142
action_136 (19) = happyGoto action_143
action_136 (22) = happyGoto action_125
action_136 (23) = happyGoto action_90
action_136 (25) = happyGoto action_126
action_136 (33) = happyGoto action_95
action_136 (35) = happyGoto action_96
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (60) = happyShift action_141
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (39) = happyShift action_35
action_138 (41) = happyShift action_37
action_138 (42) = happyShift action_38
action_138 (43) = happyShift action_39
action_138 (44) = happyShift action_40
action_138 (45) = happyShift action_41
action_138 (46) = happyShift action_42
action_138 (47) = happyShift action_43
action_138 (54) = happyShift action_46
action_138 (58) = happyShift action_47
action_138 (32) = happyGoto action_140
action_138 (33) = happyGoto action_32
action_138 (34) = happyGoto action_33
action_138 (35) = happyGoto action_34
action_138 _ = happyFail (happyExpListPerState 138)

action_139 _ = happyReduce_6

action_140 (55) = happyShift action_164
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (39) = happyShift action_35
action_141 (40) = happyShift action_36
action_141 (41) = happyShift action_37
action_141 (42) = happyShift action_38
action_141 (43) = happyShift action_39
action_141 (44) = happyShift action_40
action_141 (45) = happyShift action_41
action_141 (46) = happyShift action_42
action_141 (47) = happyShift action_43
action_141 (48) = happyShift action_44
action_141 (52) = happyShift action_45
action_141 (54) = happyShift action_46
action_141 (58) = happyShift action_47
action_141 (29) = happyGoto action_163
action_141 (30) = happyGoto action_29
action_141 (31) = happyGoto action_30
action_141 (32) = happyGoto action_31
action_141 (33) = happyGoto action_32
action_141 (34) = happyGoto action_33
action_141 (35) = happyGoto action_34
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (50) = happyShift action_162
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (41) = happyShift action_37
action_143 (43) = happyShift action_39
action_143 (44) = happyShift action_97
action_143 (45) = happyShift action_98
action_143 (47) = happyShift action_99
action_143 (49) = happyShift action_100
action_143 (54) = happyShift action_136
action_143 (58) = happyShift action_102
action_143 (19) = happyGoto action_131
action_143 (20) = happyGoto action_132
action_143 (21) = happyGoto action_161
action_143 (23) = happyGoto action_134
action_143 (24) = happyGoto action_135
action_143 (33) = happyGoto action_95
action_143 (35) = happyGoto action_96
action_143 _ = happyReduce_42

action_144 (55) = happyShift action_160
action_144 (60) = happyReduce_43
action_144 _ = happyReduce_15

action_145 _ = happyReduce_39

action_146 _ = happyReduce_55

action_147 _ = happyReduce_56

action_148 _ = happyReduce_59

action_149 (41) = happyShift action_37
action_149 (43) = happyShift action_39
action_149 (44) = happyShift action_97
action_149 (45) = happyShift action_98
action_149 (47) = happyShift action_99
action_149 (49) = happyShift action_100
action_149 (54) = happyShift action_101
action_149 (58) = happyShift action_102
action_149 (19) = happyGoto action_89
action_149 (22) = happyGoto action_158
action_149 (23) = happyGoto action_90
action_149 (25) = happyGoto action_159
action_149 (33) = happyGoto action_95
action_149 (35) = happyGoto action_96
action_149 _ = happyFail (happyExpListPerState 149)

action_150 _ = happyReduce_44

action_151 _ = happyReduce_46

action_152 (55) = happyShift action_157
action_152 _ = happyFail (happyExpListPerState 152)

action_153 _ = happyReduce_63

action_154 (39) = happyShift action_35
action_154 (40) = happyShift action_36
action_154 (41) = happyShift action_37
action_154 (42) = happyShift action_38
action_154 (43) = happyShift action_39
action_154 (44) = happyShift action_40
action_154 (45) = happyShift action_41
action_154 (46) = happyShift action_42
action_154 (47) = happyShift action_43
action_154 (48) = happyShift action_44
action_154 (52) = happyShift action_45
action_154 (54) = happyShift action_46
action_154 (58) = happyShift action_47
action_154 (29) = happyGoto action_156
action_154 (30) = happyGoto action_29
action_154 (31) = happyGoto action_30
action_154 (32) = happyGoto action_31
action_154 (33) = happyGoto action_32
action_154 (34) = happyGoto action_33
action_154 (35) = happyGoto action_34
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_74

action_156 _ = happyReduce_61

action_157 _ = happyReduce_30

action_158 _ = happyReduce_41

action_159 (60) = happyShift action_149
action_159 _ = happyReduce_40

action_160 _ = happyReduce_37

action_161 (55) = happyShift action_167
action_161 _ = happyReduce_53

action_162 (41) = happyShift action_37
action_162 (43) = happyShift action_39
action_162 (44) = happyShift action_97
action_162 (45) = happyShift action_98
action_162 (47) = happyShift action_99
action_162 (49) = happyShift action_100
action_162 (54) = happyShift action_166
action_162 (58) = happyShift action_102
action_162 (19) = happyGoto action_131
action_162 (23) = happyGoto action_134
action_162 (24) = happyGoto action_165
action_162 (33) = happyGoto action_95
action_162 (35) = happyGoto action_96
action_162 _ = happyFail (happyExpListPerState 162)

action_163 _ = happyReduce_60

action_164 _ = happyReduce_70

action_165 (55) = happyShift action_168
action_165 _ = happyFail (happyExpListPerState 165)

action_166 (41) = happyShift action_37
action_166 (43) = happyShift action_39
action_166 (44) = happyShift action_97
action_166 (45) = happyShift action_98
action_166 (47) = happyShift action_99
action_166 (49) = happyShift action_100
action_166 (54) = happyShift action_101
action_166 (58) = happyShift action_102
action_166 (19) = happyGoto action_143
action_166 (22) = happyGoto action_125
action_166 (23) = happyGoto action_90
action_166 (25) = happyGoto action_126
action_166 (33) = happyGoto action_95
action_166 (35) = happyGoto action_96
action_166 _ = happyFail (happyExpListPerState 166)

action_167 _ = happyReduce_51

action_168 _ = happyReduce_36

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
		 ((happy_var_1, happy_var_3, [])
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
	 =  HappyAbsSyn17
		 ((happy_var_1 :| [], Nothing)
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happyReduce 5 17 happyReduction_30
happyReduction_30 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn16  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn17
		 ((happy_var_2, Just happy_var_4)
	) `HappyStk` happyRest

happyReduce_31 = happySpecReduce_1  18 happyReduction_31
happyReduction_31 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_1 :| []
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  18 happyReduction_32
happyReduction_32 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
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
happyReduction_35 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happyReduce 5 20 happyReduction_36
happyReduction_36 (_ `HappyStk`
	(HappyAbsSyn20  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (Implicit happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_37 = happySpecReduce_3  20 happyReduction_37
happyReduction_37 _
	(HappyTerminal (TokenLSym happy_var_2))
	_
	 =  HappyAbsSyn20
		 (PunnedImplicit happy_var_2
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
happyReduction_40 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn22
		 ([happy_var_1, happy_var_3]
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  22 happyReduction_41
happyReduction_41 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 : happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  23 happyReduction_42
happyReduction_42 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (P.Data happy_var_1 []
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  23 happyReduction_43
happyReduction_43 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn20
		 (P.Variable happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  23 happyReduction_44
happyReduction_44 _
	(HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (P.Tuple happy_var_2
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  23 happyReduction_45
happyReduction_45 _
	_
	 =  HappyAbsSyn20
		 (P.List []
	)

happyReduce_46 = happySpecReduce_3  23 happyReduction_46
happyReduction_46 _
	(HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (P.List (toList happy_var_2)
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  23 happyReduction_47
happyReduction_47 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn20
		 (P.Literal happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  23 happyReduction_48
happyReduction_48 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn20
		 (P.Literal happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  23 happyReduction_49
happyReduction_49 _
	 =  HappyAbsSyn20
		 (Wildcard
	)

happyReduce_50 = happySpecReduce_1  24 happyReduction_50
happyReduction_50 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happyReduce 4 24 happyReduction_51
happyReduction_51 (_ `HappyStk`
	(HappyAbsSyn21  happy_var_3) `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn20
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_52 = happySpecReduce_1  25 happyReduction_52
happyReduction_52 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  25 happyReduction_53
happyReduction_53 (HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_53 _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  26 happyReduction_54
happyReduction_54 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1 :| []
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  26 happyReduction_55
happyReduction_55 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  27 happyReduction_56
happyReduction_56 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn21  happy_var_1)
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

happyReduce_62 = happyReduce 4 29 happyReduction_62
happyReduction_62 ((HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_63 = happyReduce 5 29 happyReduction_63
happyReduction_63 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn18  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_64 = happyReduce 4 29 happyReduction_64
happyReduction_64 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_65 = happySpecReduce_1  29 happyReduction_65
happyReduction_65 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  30 happyReduction_66
happyReduction_66 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  30 happyReduction_67
happyReduction_67 (HappyAbsSyn29  happy_var_3)
	(HappyTerminal (TokenInfixOp happy_var_2))
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (Infix happy_var_1 happy_var_2 happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_1  30 happyReduction_68
happyReduction_68 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_2  31 happyReduction_69
happyReduction_69 (HappyAbsSyn29  happy_var_2)
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (Application happy_var_1 ((Nothing, happy_var_2) :| [])
	)
happyReduction_69 _ _  = notHappyAtAll 

happyReduce_70 = happyReduce 6 31 happyReduction_70
happyReduction_70 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn5  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (Application happy_var_1 ((Just happy_var_3, happy_var_5) :| [])
	) `HappyStk` happyRest

happyReduce_71 = happySpecReduce_1  31 happyReduction_71
happyReduction_71 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  32 happyReduction_72
happyReduction_72 _
	(HappyAbsSyn29  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (Parenthesized happy_var_2
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_2  32 happyReduction_73
happyReduction_73 _
	_
	 =  HappyAbsSyn29
		 (Literal UnitLiteral
	)

happyReduce_74 = happyReduce 5 32 happyReduction_74
happyReduction_74 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn29  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn29
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_75 = happySpecReduce_3  32 happyReduction_75
happyReduction_75 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn29
		 (List happy_var_2
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  32 happyReduction_76
happyReduction_76 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn29
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  32 happyReduction_77
happyReduction_77 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn29
		 (Identifier (happy_var_1 :| [])
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_1  32 happyReduction_78
happyReduction_78 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn29
		 (Identifier happy_var_1
	)
happyReduction_78 _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  32 happyReduction_79
happyReduction_79 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn29
		 (Identifier happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  32 happyReduction_80
happyReduction_80 _
	 =  HappyAbsSyn29
		 (Type
	)

happyReduce_81 = happySpecReduce_1  32 happyReduction_81
happyReduction_81 (HappyAbsSyn33  happy_var_1)
	 =  HappyAbsSyn29
		 (Literal happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

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

happyReduce_84 = happySpecReduce_1  33 happyReduction_84
happyReduction_84 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn33
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  34 happyReduction_85
happyReduction_85 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn33
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  35 happyReduction_86
happyReduction_86 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn33
		 (StringLiteral happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 63 63 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenDatatype -> cont 36;
	TokenDeclare -> cont 37;
	TokenDefine -> cont 38;
	TokenType -> cont 39;
	TokenLet -> cont 40;
	TokenInt happy_dollar_dollar -> cont 41;
	TokenFloat happy_dollar_dollar -> cont 42;
	TokenString happy_dollar_dollar -> cont 43;
	TokenLSym happy_dollar_dollar -> cont 44;
	TokenUSym happy_dollar_dollar -> cont 45;
	TokenLSymQ happy_dollar_dollar -> cont 46;
	TokenUSymQ happy_dollar_dollar -> cont 47;
	TokenBackslash -> cont 48;
	TokenUnderscore -> cont 49;
	TokenEq -> cont 50;
	TokenArrow -> cont 51;
	TokenForAll -> cont 52;
	TokenInfixOp happy_dollar_dollar -> cont 53;
	TokenLParen -> cont 54;
	TokenRParen -> cont 55;
	TokenLBrace -> cont 56;
	TokenRBrace -> cont 57;
	TokenLBracket -> cont 58;
	TokenRBracket -> cont 59;
	TokenComma -> cont 60;
	TokenColon -> cont 61;
	TokenSemicolon -> cont 62;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 63 tk tks = happyError' (tks, explist)
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
