{-# OPTIONS_GHC -w #-}
module Concrete.Grammar where

import Concrete.Tokens

import Data.List.NonEmpty (NonEmpty(..), toList, fromList)
import Concrete.Syntax
import Common
import qualified Concrete.Pattern as P
import Concrete.Pattern hiding (List, Literal, Tuple, Variable)
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
	| HappyAbsSyn25 ([P.Pattern])
	| HappyAbsSyn26 (Branch)
	| HappyAbsSyn27 ([Branch])
	| HappyAbsSyn28 (Expression)
	| HappyAbsSyn29 (Disk)
	| HappyAbsSyn30 (NonEmpty Disk)
	| HappyAbsSyn34 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,644) ([0,0,1008,0,0,0,32256,0,0,0,0,0,0,0,0,0,4,0,0,0,160,0,0,0,5120,0,0,0,65280,8766,0,0,57344,18399,4,0,0,64508,136,0,0,0,0,0,0,4032,0,0,0,0,0,0,0,0,0,0,0,0,0,1140,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,49152,36799,8,0,0,5120,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20756,0,0,0,0,0,0,0,57312,1223,0,0,64512,35067,0,0,0,0,0,0,0,0,4100,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,16384,0,0,0,0,1056,0,0,49152,1,0,0,0,0,16,0,0,32768,512,0,0,49088,2191,0,0,63488,4599,1,0,0,0,64,0,0,0,4096,0,0,0,4096,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,34976,0,0,0,0,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,17,0,0,0,8877,2,0,0,17664,0,0,0,0,16384,0,0,0,16384,0,0,0,16384,0,0,0,57312,1095,0,0,50176,35003,0,0,32768,6008,17,0,0,61200,546,0,0,57856,17501,0,0,16384,35772,8,0,0,29696,4,0,0,32768,14,0,0,0,464,0,0,0,14848,0,0,0,16384,7,0,0,0,1024,0,0,0,0,0,0,0,0,8192,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,64512,35067,0,0,0,5480,17,0,0,61424,547,0,0,0,0,0,0,0,32768,0,0,0,0,1024,0,0,0,128,0,0,0,0,64,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,23040,1093,0,0,16384,34987,1,0,0,0,128,0,0,61424,547,0,0,40960,17493,0,0,0,0,0,0,0,0,0,0,0,65280,8766,0,0,57344,18399,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32254,68,0,0,49088,2191,0,0,63488,4599,1,0,0,896,0,0,0,0,8192,0,0,0,0,2,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,65280,8766,0,0,0,0,1,0,0,0,2048,0,0,0,2048,0,0,0,8192,0,0,0,0,0,0,0,57344,0,0,0,63488,4599,1,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,4,0,0,0,0,0,0,65280,8766,0,0,0,0,8,0,0,0,0,0,0,0,512,0,0,0,0,8,0,0,0,0,0,0,46080,2186,0,0,63488,4599,1,0,0,10960,34,0,0,23040,1093,0,0,0,0,2,0,0,0,8,0,0,0,2048,0,0,0,0,0,0,49152,36799,8,0,0,63480,273,0,0,0,0,0,0,0,0,0,0,0,64508,136,0,0,0,0,0,0,61440,9199,2,0,0,32768,0,0,0,0,8192,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,35508,8,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,61440,9199,2,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,16384,0,0,0,0,8,0,0,0,0,8,0,0,0,0,0,0,65024,17533,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,26624,4373,0,0,0,8877,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Name","Statement","Variant","Variants","ArgumentName","ArgumentNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern","Patterns","Branch","Branches","Expression","Disk","Spine","BinaryExpression","Identifier","Atom","IntegerLiteral","FloatLiteral","StringLiteral","data","decl","def","check","eval","typeOf","type","let","case","forall","int","float","string","lsym","qlsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 69
        bit_end = (st Prelude.+ 1) Prelude.* 69
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..68]
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

action_3 (52) = happyShift action_39
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (50) = happyShift action_36
action_4 (52) = happyShift action_37
action_4 (5) = happyGoto action_38
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (50) = happyShift action_36
action_5 (52) = happyShift action_37
action_5 (5) = happyGoto action_35
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (43) = happyShift action_18
action_6 (44) = happyShift action_19
action_6 (45) = happyShift action_20
action_6 (46) = happyShift action_21
action_6 (47) = happyShift action_22
action_6 (48) = happyShift action_23
action_6 (49) = happyShift action_24
action_6 (50) = happyShift action_25
action_6 (52) = happyShift action_26
action_6 (53) = happyShift action_27
action_6 (54) = happyShift action_28
action_6 (55) = happyShift action_29
action_6 (56) = happyShift action_30
action_6 (60) = happyShift action_31
action_6 (64) = happyShift action_32
action_6 (28) = happyGoto action_34
action_6 (31) = happyGoto action_13
action_6 (33) = happyGoto action_14
action_6 (34) = happyGoto action_15
action_6 (35) = happyGoto action_16
action_6 (36) = happyGoto action_17
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (43) = happyShift action_18
action_7 (44) = happyShift action_19
action_7 (45) = happyShift action_20
action_7 (46) = happyShift action_21
action_7 (47) = happyShift action_22
action_7 (48) = happyShift action_23
action_7 (49) = happyShift action_24
action_7 (50) = happyShift action_25
action_7 (52) = happyShift action_26
action_7 (53) = happyShift action_27
action_7 (54) = happyShift action_28
action_7 (55) = happyShift action_29
action_7 (56) = happyShift action_30
action_7 (60) = happyShift action_31
action_7 (64) = happyShift action_32
action_7 (28) = happyGoto action_33
action_7 (31) = happyGoto action_13
action_7 (33) = happyGoto action_14
action_7 (34) = happyGoto action_15
action_7 (35) = happyGoto action_16
action_7 (36) = happyGoto action_17
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (43) = happyShift action_18
action_8 (44) = happyShift action_19
action_8 (45) = happyShift action_20
action_8 (46) = happyShift action_21
action_8 (47) = happyShift action_22
action_8 (48) = happyShift action_23
action_8 (49) = happyShift action_24
action_8 (50) = happyShift action_25
action_8 (52) = happyShift action_26
action_8 (53) = happyShift action_27
action_8 (54) = happyShift action_28
action_8 (55) = happyShift action_29
action_8 (56) = happyShift action_30
action_8 (60) = happyShift action_31
action_8 (64) = happyShift action_32
action_8 (28) = happyGoto action_12
action_8 (31) = happyGoto action_13
action_8 (33) = happyGoto action_14
action_8 (34) = happyGoto action_15
action_8 (35) = happyGoto action_16
action_8 (36) = happyGoto action_17
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (69) = happyAccept
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

action_13 (50) = happyShift action_64
action_13 (52) = happyShift action_65
action_13 (53) = happyShift action_66
action_13 (54) = happyShift action_67
action_13 (58) = happyShift action_68
action_13 _ = happyReduce_70

action_14 (60) = happyShift action_63
action_14 _ = happyReduce_81

action_15 _ = happyReduce_96

action_16 _ = happyReduce_97

action_17 _ = happyReduce_98

action_18 _ = happyReduce_95

action_19 (50) = happyShift action_62
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (43) = happyShift action_18
action_20 (44) = happyShift action_19
action_20 (45) = happyShift action_20
action_20 (46) = happyShift action_21
action_20 (47) = happyShift action_22
action_20 (48) = happyShift action_23
action_20 (49) = happyShift action_24
action_20 (50) = happyShift action_25
action_20 (52) = happyShift action_26
action_20 (53) = happyShift action_27
action_20 (54) = happyShift action_28
action_20 (55) = happyShift action_29
action_20 (56) = happyShift action_30
action_20 (60) = happyShift action_31
action_20 (64) = happyShift action_32
action_20 (14) = happyGoto action_61
action_20 (28) = happyGoto action_47
action_20 (31) = happyGoto action_13
action_20 (33) = happyGoto action_14
action_20 (34) = happyGoto action_15
action_20 (35) = happyGoto action_16
action_20 (36) = happyGoto action_17
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (50) = happyShift action_54
action_21 (52) = happyShift action_55
action_21 (56) = happyShift action_56
action_21 (15) = happyGoto action_50
action_21 (16) = happyGoto action_59
action_21 (17) = happyGoto action_60
action_21 _ = happyFail (happyExpListPerState 21)

action_22 _ = happyReduce_99

action_23 _ = happyReduce_100

action_24 _ = happyReduce_101

action_25 _ = happyReduce_91

action_26 _ = happyReduce_92

action_27 _ = happyReduce_93

action_28 _ = happyReduce_94

action_29 (50) = happyShift action_54
action_29 (52) = happyShift action_55
action_29 (56) = happyShift action_56
action_29 (60) = happyShift action_57
action_29 (62) = happyShift action_58
action_29 (15) = happyGoto action_50
action_29 (16) = happyGoto action_51
action_29 (18) = happyGoto action_52
action_29 (19) = happyGoto action_53
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_90

action_31 (43) = happyShift action_18
action_31 (44) = happyShift action_19
action_31 (45) = happyShift action_20
action_31 (46) = happyShift action_21
action_31 (47) = happyShift action_22
action_31 (48) = happyShift action_23
action_31 (49) = happyShift action_24
action_31 (50) = happyShift action_25
action_31 (52) = happyShift action_26
action_31 (53) = happyShift action_27
action_31 (54) = happyShift action_28
action_31 (55) = happyShift action_29
action_31 (56) = happyShift action_30
action_31 (60) = happyShift action_31
action_31 (61) = happyShift action_49
action_31 (64) = happyShift action_32
action_31 (28) = happyGoto action_48
action_31 (31) = happyGoto action_13
action_31 (33) = happyGoto action_14
action_31 (34) = happyGoto action_15
action_31 (35) = happyGoto action_16
action_31 (36) = happyGoto action_17
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (43) = happyShift action_18
action_32 (44) = happyShift action_19
action_32 (45) = happyShift action_20
action_32 (46) = happyShift action_21
action_32 (47) = happyShift action_22
action_32 (48) = happyShift action_23
action_32 (49) = happyShift action_24
action_32 (50) = happyShift action_25
action_32 (52) = happyShift action_26
action_32 (53) = happyShift action_27
action_32 (54) = happyShift action_28
action_32 (55) = happyShift action_29
action_32 (56) = happyShift action_30
action_32 (60) = happyShift action_31
action_32 (64) = happyShift action_32
action_32 (14) = happyGoto action_46
action_32 (28) = happyGoto action_47
action_32 (31) = happyGoto action_13
action_32 (33) = happyGoto action_14
action_32 (34) = happyGoto action_15
action_32 (35) = happyGoto action_16
action_32 (36) = happyGoto action_17
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_10

action_34 (57) = happyShift action_44
action_34 (67) = happyShift action_45
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (60) = happyShift action_41
action_35 (13) = happyGoto action_43
action_35 _ = happyReduce_27

action_36 _ = happyReduce_4

action_37 _ = happyReduce_3

action_38 (60) = happyShift action_41
action_38 (13) = happyGoto action_42
action_38 _ = happyReduce_27

action_39 (60) = happyShift action_41
action_39 (13) = happyGoto action_40
action_39 _ = happyReduce_27

action_40 (62) = happyShift action_117
action_40 (67) = happyShift action_118
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (50) = happyShift action_114
action_41 (51) = happyShift action_115
action_41 (52) = happyShift action_116
action_41 (9) = happyGoto action_110
action_41 (10) = happyGoto action_111
action_41 (11) = happyGoto action_112
action_41 (12) = happyGoto action_113
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (67) = happyShift action_109
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (57) = happyShift action_107
action_43 (67) = happyShift action_108
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (43) = happyShift action_18
action_44 (44) = happyShift action_19
action_44 (45) = happyShift action_20
action_44 (46) = happyShift action_21
action_44 (47) = happyShift action_22
action_44 (48) = happyShift action_23
action_44 (49) = happyShift action_24
action_44 (50) = happyShift action_25
action_44 (52) = happyShift action_26
action_44 (53) = happyShift action_27
action_44 (54) = happyShift action_28
action_44 (55) = happyShift action_29
action_44 (56) = happyShift action_30
action_44 (60) = happyShift action_31
action_44 (64) = happyShift action_32
action_44 (28) = happyGoto action_106
action_44 (31) = happyGoto action_13
action_44 (33) = happyGoto action_14
action_44 (34) = happyGoto action_15
action_44 (35) = happyGoto action_16
action_44 (36) = happyGoto action_17
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (43) = happyShift action_18
action_45 (44) = happyShift action_19
action_45 (45) = happyShift action_20
action_45 (46) = happyShift action_21
action_45 (47) = happyShift action_22
action_45 (48) = happyShift action_23
action_45 (49) = happyShift action_24
action_45 (50) = happyShift action_25
action_45 (52) = happyShift action_26
action_45 (53) = happyShift action_27
action_45 (54) = happyShift action_28
action_45 (55) = happyShift action_29
action_45 (56) = happyShift action_30
action_45 (60) = happyShift action_31
action_45 (64) = happyShift action_32
action_45 (28) = happyGoto action_105
action_45 (31) = happyGoto action_13
action_45 (33) = happyGoto action_14
action_45 (34) = happyGoto action_15
action_45 (35) = happyGoto action_16
action_45 (36) = happyGoto action_17
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (65) = happyShift action_104
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (66) = happyShift action_103
action_47 _ = happyReduce_29

action_48 (61) = happyShift action_101
action_48 (66) = happyShift action_102
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_87

action_50 _ = happyReduce_33

action_51 _ = happyReduce_37

action_52 (50) = happyShift action_54
action_52 (52) = happyShift action_55
action_52 (56) = happyShift action_56
action_52 (60) = happyShift action_57
action_52 (15) = happyGoto action_50
action_52 (16) = happyGoto action_51
action_52 (18) = happyGoto action_52
action_52 (19) = happyGoto action_100
action_52 _ = happyReduce_39

action_53 (58) = happyShift action_98
action_53 (62) = happyShift action_99
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_31

action_55 _ = happyReduce_32

action_56 _ = happyReduce_34

action_57 (50) = happyShift action_54
action_57 (52) = happyShift action_55
action_57 (56) = happyShift action_56
action_57 (15) = happyGoto action_50
action_57 (16) = happyGoto action_59
action_57 (17) = happyGoto action_97
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (47) = happyShift action_22
action_58 (49) = happyShift action_24
action_58 (50) = happyShift action_91
action_58 (52) = happyShift action_92
action_58 (54) = happyShift action_93
action_58 (56) = happyShift action_94
action_58 (60) = happyShift action_95
action_58 (64) = happyShift action_96
action_58 (20) = happyGoto action_84
action_58 (24) = happyGoto action_85
action_58 (25) = happyGoto action_86
action_58 (26) = happyGoto action_87
action_58 (27) = happyGoto action_88
action_58 (34) = happyGoto action_89
action_58 (36) = happyGoto action_90
action_58 _ = happyReduce_61

action_59 (50) = happyShift action_54
action_59 (52) = happyShift action_55
action_59 (56) = happyShift action_56
action_59 (15) = happyGoto action_50
action_59 (16) = happyGoto action_59
action_59 (17) = happyGoto action_83
action_59 _ = happyReduce_35

action_60 (67) = happyShift action_82
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (62) = happyShift action_81
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (57) = happyShift action_80
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (43) = happyShift action_18
action_63 (44) = happyShift action_19
action_63 (45) = happyShift action_20
action_63 (46) = happyShift action_21
action_63 (47) = happyShift action_22
action_63 (48) = happyShift action_23
action_63 (49) = happyShift action_24
action_63 (50) = happyShift action_78
action_63 (52) = happyShift action_79
action_63 (53) = happyShift action_27
action_63 (54) = happyShift action_28
action_63 (55) = happyShift action_29
action_63 (56) = happyShift action_30
action_63 (60) = happyShift action_31
action_63 (64) = happyShift action_32
action_63 (15) = happyGoto action_74
action_63 (28) = happyGoto action_75
action_63 (29) = happyGoto action_76
action_63 (30) = happyGoto action_77
action_63 (31) = happyGoto action_13
action_63 (33) = happyGoto action_14
action_63 (34) = happyGoto action_15
action_63 (35) = happyGoto action_16
action_63 (36) = happyGoto action_17
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (43) = happyShift action_18
action_64 (47) = happyShift action_22
action_64 (48) = happyShift action_23
action_64 (49) = happyShift action_24
action_64 (50) = happyShift action_25
action_64 (52) = happyShift action_26
action_64 (53) = happyShift action_27
action_64 (54) = happyShift action_28
action_64 (56) = happyShift action_30
action_64 (60) = happyShift action_31
action_64 (64) = happyShift action_32
action_64 (31) = happyGoto action_73
action_64 (33) = happyGoto action_14
action_64 (34) = happyGoto action_15
action_64 (35) = happyGoto action_16
action_64 (36) = happyGoto action_17
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (43) = happyShift action_18
action_65 (47) = happyShift action_22
action_65 (48) = happyShift action_23
action_65 (49) = happyShift action_24
action_65 (50) = happyShift action_25
action_65 (52) = happyShift action_26
action_65 (53) = happyShift action_27
action_65 (54) = happyShift action_28
action_65 (56) = happyShift action_30
action_65 (60) = happyShift action_31
action_65 (64) = happyShift action_32
action_65 (31) = happyGoto action_72
action_65 (33) = happyGoto action_14
action_65 (34) = happyGoto action_15
action_65 (35) = happyGoto action_16
action_65 (36) = happyGoto action_17
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (43) = happyShift action_18
action_66 (47) = happyShift action_22
action_66 (48) = happyShift action_23
action_66 (49) = happyShift action_24
action_66 (50) = happyShift action_25
action_66 (52) = happyShift action_26
action_66 (53) = happyShift action_27
action_66 (54) = happyShift action_28
action_66 (56) = happyShift action_30
action_66 (60) = happyShift action_31
action_66 (64) = happyShift action_32
action_66 (31) = happyGoto action_71
action_66 (33) = happyGoto action_14
action_66 (34) = happyGoto action_15
action_66 (35) = happyGoto action_16
action_66 (36) = happyGoto action_17
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (43) = happyShift action_18
action_67 (47) = happyShift action_22
action_67 (48) = happyShift action_23
action_67 (49) = happyShift action_24
action_67 (50) = happyShift action_25
action_67 (52) = happyShift action_26
action_67 (53) = happyShift action_27
action_67 (54) = happyShift action_28
action_67 (56) = happyShift action_30
action_67 (60) = happyShift action_31
action_67 (64) = happyShift action_32
action_67 (31) = happyGoto action_70
action_67 (33) = happyGoto action_14
action_67 (34) = happyGoto action_15
action_67 (35) = happyGoto action_16
action_67 (36) = happyGoto action_17
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (43) = happyShift action_18
action_68 (47) = happyShift action_22
action_68 (48) = happyShift action_23
action_68 (49) = happyShift action_24
action_68 (50) = happyShift action_25
action_68 (52) = happyShift action_26
action_68 (53) = happyShift action_27
action_68 (54) = happyShift action_28
action_68 (56) = happyShift action_30
action_68 (60) = happyShift action_31
action_68 (64) = happyShift action_32
action_68 (31) = happyGoto action_69
action_68 (33) = happyGoto action_14
action_68 (34) = happyGoto action_15
action_68 (35) = happyGoto action_16
action_68 (36) = happyGoto action_17
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (50) = happyShift action_64
action_69 (52) = happyShift action_65
action_69 (53) = happyShift action_66
action_69 (54) = happyShift action_67
action_69 (58) = happyShift action_68
action_69 _ = happyReduce_75

action_70 (50) = happyShift action_64
action_70 (52) = happyShift action_65
action_70 (53) = happyShift action_66
action_70 (54) = happyShift action_67
action_70 _ = happyReduce_79

action_71 (50) = happyShift action_64
action_71 (52) = happyShift action_65
action_71 (53) = happyShift action_66
action_71 (54) = happyShift action_67
action_71 _ = happyReduce_78

action_72 (50) = happyShift action_64
action_72 (52) = happyShift action_65
action_72 (53) = happyShift action_66
action_72 (54) = happyShift action_67
action_72 _ = happyReduce_77

action_73 (50) = happyShift action_64
action_73 (52) = happyShift action_65
action_73 (53) = happyShift action_66
action_73 (54) = happyShift action_67
action_73 _ = happyReduce_76

action_74 (57) = happyShift action_149
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_71

action_76 (66) = happyShift action_148
action_76 _ = happyReduce_73

action_77 (61) = happyShift action_147
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (57) = happyReduce_31
action_78 _ = happyReduce_91

action_79 (57) = happyReduce_32
action_79 _ = happyReduce_92

action_80 (43) = happyShift action_18
action_80 (44) = happyShift action_19
action_80 (45) = happyShift action_20
action_80 (46) = happyShift action_21
action_80 (47) = happyShift action_22
action_80 (48) = happyShift action_23
action_80 (49) = happyShift action_24
action_80 (50) = happyShift action_25
action_80 (52) = happyShift action_26
action_80 (53) = happyShift action_27
action_80 (54) = happyShift action_28
action_80 (55) = happyShift action_29
action_80 (56) = happyShift action_30
action_80 (60) = happyShift action_31
action_80 (64) = happyShift action_32
action_80 (28) = happyGoto action_146
action_80 (31) = happyGoto action_13
action_80 (33) = happyGoto action_14
action_80 (34) = happyGoto action_15
action_80 (35) = happyGoto action_16
action_80 (36) = happyGoto action_17
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (47) = happyShift action_22
action_81 (49) = happyShift action_24
action_81 (50) = happyShift action_91
action_81 (52) = happyShift action_92
action_81 (54) = happyShift action_93
action_81 (56) = happyShift action_94
action_81 (60) = happyShift action_95
action_81 (64) = happyShift action_96
action_81 (20) = happyGoto action_84
action_81 (24) = happyGoto action_85
action_81 (25) = happyGoto action_86
action_81 (26) = happyGoto action_87
action_81 (27) = happyGoto action_145
action_81 (34) = happyGoto action_89
action_81 (36) = happyGoto action_90
action_81 _ = happyReduce_61

action_82 (43) = happyShift action_18
action_82 (44) = happyShift action_19
action_82 (45) = happyShift action_20
action_82 (46) = happyShift action_21
action_82 (47) = happyShift action_22
action_82 (48) = happyShift action_23
action_82 (49) = happyShift action_24
action_82 (50) = happyShift action_25
action_82 (52) = happyShift action_26
action_82 (53) = happyShift action_27
action_82 (54) = happyShift action_28
action_82 (55) = happyShift action_29
action_82 (56) = happyShift action_30
action_82 (60) = happyShift action_31
action_82 (64) = happyShift action_32
action_82 (28) = happyGoto action_144
action_82 (31) = happyGoto action_13
action_82 (33) = happyGoto action_14
action_82 (34) = happyGoto action_15
action_82 (35) = happyGoto action_16
action_82 (36) = happyGoto action_17
action_82 _ = happyFail (happyExpListPerState 82)

action_83 _ = happyReduce_36

action_84 (60) = happyShift action_143
action_84 _ = happyReduce_49

action_85 (66) = happyShift action_142
action_85 _ = happyReduce_58

action_86 (58) = happyShift action_141
action_86 _ = happyFail (happyExpListPerState 86)

action_87 (68) = happyShift action_140
action_87 _ = happyReduce_62

action_88 (63) = happyShift action_139
action_88 _ = happyFail (happyExpListPerState 88)

action_89 _ = happyReduce_55

action_90 _ = happyReduce_56

action_91 _ = happyReduce_51

action_92 _ = happyReduce_41

action_93 _ = happyReduce_42

action_94 _ = happyReduce_57

action_95 (47) = happyShift action_22
action_95 (49) = happyShift action_24
action_95 (50) = happyShift action_91
action_95 (52) = happyShift action_92
action_95 (54) = happyShift action_93
action_95 (56) = happyShift action_94
action_95 (60) = happyShift action_95
action_95 (64) = happyShift action_96
action_95 (20) = happyGoto action_84
action_95 (23) = happyGoto action_137
action_95 (24) = happyGoto action_138
action_95 (34) = happyGoto action_89
action_95 (36) = happyGoto action_90
action_95 _ = happyFail (happyExpListPerState 95)

action_96 (47) = happyShift action_22
action_96 (49) = happyShift action_24
action_96 (50) = happyShift action_91
action_96 (52) = happyShift action_92
action_96 (54) = happyShift action_93
action_96 (56) = happyShift action_94
action_96 (60) = happyShift action_95
action_96 (64) = happyShift action_96
action_96 (65) = happyShift action_136
action_96 (20) = happyGoto action_84
action_96 (24) = happyGoto action_85
action_96 (25) = happyGoto action_135
action_96 (34) = happyGoto action_89
action_96 (36) = happyGoto action_90
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (67) = happyShift action_134
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (43) = happyShift action_18
action_98 (44) = happyShift action_19
action_98 (45) = happyShift action_20
action_98 (46) = happyShift action_21
action_98 (47) = happyShift action_22
action_98 (48) = happyShift action_23
action_98 (49) = happyShift action_24
action_98 (50) = happyShift action_25
action_98 (52) = happyShift action_26
action_98 (53) = happyShift action_27
action_98 (54) = happyShift action_28
action_98 (55) = happyShift action_29
action_98 (56) = happyShift action_30
action_98 (60) = happyShift action_31
action_98 (64) = happyShift action_32
action_98 (28) = happyGoto action_133
action_98 (31) = happyGoto action_13
action_98 (33) = happyGoto action_14
action_98 (34) = happyGoto action_15
action_98 (35) = happyGoto action_16
action_98 (36) = happyGoto action_17
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (47) = happyShift action_22
action_99 (49) = happyShift action_24
action_99 (50) = happyShift action_91
action_99 (52) = happyShift action_92
action_99 (54) = happyShift action_93
action_99 (56) = happyShift action_94
action_99 (60) = happyShift action_95
action_99 (64) = happyShift action_96
action_99 (20) = happyGoto action_84
action_99 (24) = happyGoto action_85
action_99 (25) = happyGoto action_86
action_99 (26) = happyGoto action_87
action_99 (27) = happyGoto action_132
action_99 (34) = happyGoto action_89
action_99 (36) = happyGoto action_90
action_99 _ = happyReduce_61

action_100 _ = happyReduce_40

action_101 _ = happyReduce_86

action_102 (43) = happyShift action_18
action_102 (44) = happyShift action_19
action_102 (45) = happyShift action_20
action_102 (46) = happyShift action_21
action_102 (47) = happyShift action_22
action_102 (48) = happyShift action_23
action_102 (49) = happyShift action_24
action_102 (50) = happyShift action_25
action_102 (52) = happyShift action_26
action_102 (53) = happyShift action_27
action_102 (54) = happyShift action_28
action_102 (55) = happyShift action_29
action_102 (56) = happyShift action_30
action_102 (60) = happyShift action_31
action_102 (64) = happyShift action_32
action_102 (14) = happyGoto action_131
action_102 (28) = happyGoto action_47
action_102 (31) = happyGoto action_13
action_102 (33) = happyGoto action_14
action_102 (34) = happyGoto action_15
action_102 (35) = happyGoto action_16
action_102 (36) = happyGoto action_17
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (43) = happyShift action_18
action_103 (44) = happyShift action_19
action_103 (45) = happyShift action_20
action_103 (46) = happyShift action_21
action_103 (47) = happyShift action_22
action_103 (48) = happyShift action_23
action_103 (49) = happyShift action_24
action_103 (50) = happyShift action_25
action_103 (52) = happyShift action_26
action_103 (53) = happyShift action_27
action_103 (54) = happyShift action_28
action_103 (55) = happyShift action_29
action_103 (56) = happyShift action_30
action_103 (60) = happyShift action_31
action_103 (64) = happyShift action_32
action_103 (14) = happyGoto action_130
action_103 (28) = happyGoto action_47
action_103 (31) = happyGoto action_13
action_103 (33) = happyGoto action_14
action_103 (34) = happyGoto action_15
action_103 (35) = happyGoto action_16
action_103 (36) = happyGoto action_17
action_103 _ = happyFail (happyExpListPerState 103)

action_104 _ = happyReduce_89

action_105 _ = happyReduce_13

action_106 _ = happyReduce_12

action_107 (43) = happyShift action_18
action_107 (44) = happyShift action_19
action_107 (45) = happyShift action_20
action_107 (46) = happyShift action_21
action_107 (47) = happyShift action_22
action_107 (48) = happyShift action_23
action_107 (49) = happyShift action_24
action_107 (50) = happyShift action_25
action_107 (52) = happyShift action_26
action_107 (53) = happyShift action_27
action_107 (54) = happyShift action_28
action_107 (55) = happyShift action_29
action_107 (56) = happyShift action_30
action_107 (60) = happyShift action_31
action_107 (64) = happyShift action_32
action_107 (28) = happyGoto action_129
action_107 (31) = happyGoto action_13
action_107 (33) = happyGoto action_14
action_107 (34) = happyGoto action_15
action_107 (35) = happyGoto action_16
action_107 (36) = happyGoto action_17
action_107 _ = happyFail (happyExpListPerState 107)

action_108 (43) = happyShift action_18
action_108 (44) = happyShift action_19
action_108 (45) = happyShift action_20
action_108 (46) = happyShift action_21
action_108 (47) = happyShift action_22
action_108 (48) = happyShift action_23
action_108 (49) = happyShift action_24
action_108 (50) = happyShift action_25
action_108 (52) = happyShift action_26
action_108 (53) = happyShift action_27
action_108 (54) = happyShift action_28
action_108 (55) = happyShift action_29
action_108 (56) = happyShift action_30
action_108 (60) = happyShift action_31
action_108 (64) = happyShift action_32
action_108 (28) = happyGoto action_128
action_108 (31) = happyGoto action_13
action_108 (33) = happyGoto action_14
action_108 (34) = happyGoto action_15
action_108 (35) = happyGoto action_16
action_108 (36) = happyGoto action_17
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (43) = happyShift action_18
action_109 (44) = happyShift action_19
action_109 (45) = happyShift action_20
action_109 (46) = happyShift action_21
action_109 (47) = happyShift action_22
action_109 (48) = happyShift action_23
action_109 (49) = happyShift action_24
action_109 (50) = happyShift action_25
action_109 (52) = happyShift action_26
action_109 (53) = happyShift action_27
action_109 (54) = happyShift action_28
action_109 (55) = happyShift action_29
action_109 (56) = happyShift action_30
action_109 (60) = happyShift action_31
action_109 (64) = happyShift action_32
action_109 (28) = happyGoto action_127
action_109 (31) = happyGoto action_13
action_109 (33) = happyGoto action_14
action_109 (34) = happyGoto action_15
action_109 (35) = happyGoto action_16
action_109 (36) = happyGoto action_17
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (50) = happyShift action_114
action_110 (51) = happyShift action_115
action_110 (52) = happyShift action_116
action_110 (9) = happyGoto action_110
action_110 (10) = happyGoto action_126
action_110 _ = happyReduce_22

action_111 (67) = happyShift action_125
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (66) = happyShift action_124
action_112 _ = happyReduce_25

action_113 (61) = happyShift action_123
action_113 _ = happyFail (happyExpListPerState 113)

action_114 _ = happyReduce_19

action_115 _ = happyReduce_20

action_116 _ = happyReduce_21

action_117 (52) = happyShift action_122
action_117 (7) = happyGoto action_120
action_117 (8) = happyGoto action_121
action_117 _ = happyReduce_16

action_118 (43) = happyShift action_18
action_118 (44) = happyShift action_19
action_118 (45) = happyShift action_20
action_118 (46) = happyShift action_21
action_118 (47) = happyShift action_22
action_118 (48) = happyShift action_23
action_118 (49) = happyShift action_24
action_118 (50) = happyShift action_25
action_118 (52) = happyShift action_26
action_118 (53) = happyShift action_27
action_118 (54) = happyShift action_28
action_118 (55) = happyShift action_29
action_118 (56) = happyShift action_30
action_118 (60) = happyShift action_31
action_118 (64) = happyShift action_32
action_118 (28) = happyGoto action_119
action_118 (31) = happyGoto action_13
action_118 (33) = happyGoto action_14
action_118 (34) = happyGoto action_15
action_118 (35) = happyGoto action_16
action_118 (36) = happyGoto action_17
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (62) = happyShift action_176
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (68) = happyShift action_175
action_120 _ = happyReduce_17

action_121 (63) = happyShift action_174
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (60) = happyShift action_41
action_122 (13) = happyGoto action_173
action_122 _ = happyReduce_27

action_123 _ = happyReduce_28

action_124 (50) = happyShift action_114
action_124 (51) = happyShift action_115
action_124 (52) = happyShift action_116
action_124 (9) = happyGoto action_110
action_124 (10) = happyGoto action_111
action_124 (11) = happyGoto action_112
action_124 (12) = happyGoto action_172
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (43) = happyShift action_18
action_125 (44) = happyShift action_19
action_125 (45) = happyShift action_20
action_125 (46) = happyShift action_21
action_125 (47) = happyShift action_22
action_125 (48) = happyShift action_23
action_125 (49) = happyShift action_24
action_125 (50) = happyShift action_25
action_125 (52) = happyShift action_26
action_125 (53) = happyShift action_27
action_125 (54) = happyShift action_28
action_125 (55) = happyShift action_29
action_125 (56) = happyShift action_30
action_125 (60) = happyShift action_31
action_125 (64) = happyShift action_32
action_125 (28) = happyGoto action_171
action_125 (31) = happyGoto action_13
action_125 (33) = happyGoto action_14
action_125 (34) = happyGoto action_15
action_125 (35) = happyGoto action_16
action_125 (36) = happyGoto action_17
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_23

action_127 _ = happyReduce_7

action_128 (57) = happyShift action_170
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_8

action_130 _ = happyReduce_30

action_131 (61) = happyShift action_169
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (63) = happyShift action_168
action_132 _ = happyFail (happyExpListPerState 132)

action_133 _ = happyReduce_67

action_134 (43) = happyShift action_18
action_134 (44) = happyShift action_19
action_134 (45) = happyShift action_20
action_134 (46) = happyShift action_21
action_134 (47) = happyShift action_22
action_134 (48) = happyShift action_23
action_134 (49) = happyShift action_24
action_134 (50) = happyShift action_25
action_134 (52) = happyShift action_26
action_134 (53) = happyShift action_27
action_134 (54) = happyShift action_28
action_134 (55) = happyShift action_29
action_134 (56) = happyShift action_30
action_134 (60) = happyShift action_31
action_134 (64) = happyShift action_32
action_134 (28) = happyGoto action_167
action_134 (31) = happyGoto action_13
action_134 (33) = happyGoto action_14
action_134 (34) = happyGoto action_15
action_134 (35) = happyGoto action_16
action_134 (36) = happyGoto action_17
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (65) = happyShift action_166
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_53

action_137 (61) = happyShift action_165
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (66) = happyShift action_164
action_138 _ = happyFail (happyExpListPerState 138)

action_139 _ = happyReduce_69

action_140 (47) = happyShift action_22
action_140 (49) = happyShift action_24
action_140 (50) = happyShift action_91
action_140 (52) = happyShift action_92
action_140 (54) = happyShift action_93
action_140 (56) = happyShift action_94
action_140 (60) = happyShift action_95
action_140 (64) = happyShift action_96
action_140 (20) = happyGoto action_84
action_140 (24) = happyGoto action_85
action_140 (25) = happyGoto action_86
action_140 (26) = happyGoto action_87
action_140 (27) = happyGoto action_163
action_140 (34) = happyGoto action_89
action_140 (36) = happyGoto action_90
action_140 _ = happyReduce_61

action_141 (43) = happyShift action_18
action_141 (44) = happyShift action_19
action_141 (45) = happyShift action_20
action_141 (46) = happyShift action_21
action_141 (47) = happyShift action_22
action_141 (48) = happyShift action_23
action_141 (49) = happyShift action_24
action_141 (50) = happyShift action_25
action_141 (52) = happyShift action_26
action_141 (53) = happyShift action_27
action_141 (54) = happyShift action_28
action_141 (55) = happyShift action_29
action_141 (56) = happyShift action_30
action_141 (60) = happyShift action_31
action_141 (64) = happyShift action_32
action_141 (28) = happyGoto action_162
action_141 (31) = happyGoto action_13
action_141 (33) = happyGoto action_14
action_141 (34) = happyGoto action_15
action_141 (35) = happyGoto action_16
action_141 (36) = happyGoto action_17
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (47) = happyShift action_22
action_142 (49) = happyShift action_24
action_142 (50) = happyShift action_91
action_142 (52) = happyShift action_92
action_142 (54) = happyShift action_93
action_142 (56) = happyShift action_94
action_142 (60) = happyShift action_95
action_142 (64) = happyShift action_96
action_142 (20) = happyGoto action_84
action_142 (24) = happyGoto action_85
action_142 (25) = happyGoto action_161
action_142 (34) = happyGoto action_89
action_142 (36) = happyGoto action_90
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (47) = happyShift action_22
action_143 (49) = happyShift action_24
action_143 (50) = happyShift action_159
action_143 (52) = happyShift action_160
action_143 (54) = happyShift action_93
action_143 (56) = happyShift action_94
action_143 (60) = happyShift action_95
action_143 (64) = happyShift action_96
action_143 (15) = happyGoto action_155
action_143 (20) = happyGoto action_84
action_143 (21) = happyGoto action_156
action_143 (22) = happyGoto action_157
action_143 (24) = happyGoto action_158
action_143 (34) = happyGoto action_89
action_143 (36) = happyGoto action_90
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (66) = happyShift action_154
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (63) = happyShift action_153
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (66) = happyShift action_152
action_146 _ = happyFail (happyExpListPerState 146)

action_147 _ = happyReduce_80

action_148 (43) = happyShift action_18
action_148 (44) = happyShift action_19
action_148 (45) = happyShift action_20
action_148 (46) = happyShift action_21
action_148 (47) = happyShift action_22
action_148 (48) = happyShift action_23
action_148 (49) = happyShift action_24
action_148 (50) = happyShift action_78
action_148 (52) = happyShift action_79
action_148 (53) = happyShift action_27
action_148 (54) = happyShift action_28
action_148 (55) = happyShift action_29
action_148 (56) = happyShift action_30
action_148 (60) = happyShift action_31
action_148 (64) = happyShift action_32
action_148 (15) = happyGoto action_74
action_148 (28) = happyGoto action_75
action_148 (29) = happyGoto action_76
action_148 (30) = happyGoto action_151
action_148 (31) = happyGoto action_13
action_148 (33) = happyGoto action_14
action_148 (34) = happyGoto action_15
action_148 (35) = happyGoto action_16
action_148 (36) = happyGoto action_17
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (43) = happyShift action_18
action_149 (44) = happyShift action_19
action_149 (45) = happyShift action_20
action_149 (46) = happyShift action_21
action_149 (47) = happyShift action_22
action_149 (48) = happyShift action_23
action_149 (49) = happyShift action_24
action_149 (50) = happyShift action_25
action_149 (52) = happyShift action_26
action_149 (53) = happyShift action_27
action_149 (54) = happyShift action_28
action_149 (55) = happyShift action_29
action_149 (56) = happyShift action_30
action_149 (60) = happyShift action_31
action_149 (64) = happyShift action_32
action_149 (28) = happyGoto action_150
action_149 (31) = happyGoto action_13
action_149 (33) = happyGoto action_14
action_149 (34) = happyGoto action_15
action_149 (35) = happyGoto action_16
action_149 (36) = happyGoto action_17
action_149 _ = happyFail (happyExpListPerState 149)

action_150 _ = happyReduce_72

action_151 _ = happyReduce_74

action_152 (43) = happyShift action_18
action_152 (44) = happyShift action_19
action_152 (45) = happyShift action_20
action_152 (46) = happyShift action_21
action_152 (47) = happyShift action_22
action_152 (48) = happyShift action_23
action_152 (49) = happyShift action_24
action_152 (50) = happyShift action_25
action_152 (52) = happyShift action_26
action_152 (53) = happyShift action_27
action_152 (54) = happyShift action_28
action_152 (55) = happyShift action_29
action_152 (56) = happyShift action_30
action_152 (60) = happyShift action_31
action_152 (64) = happyShift action_32
action_152 (28) = happyGoto action_188
action_152 (31) = happyGoto action_13
action_152 (33) = happyGoto action_14
action_152 (34) = happyGoto action_15
action_152 (35) = happyGoto action_16
action_152 (36) = happyGoto action_17
action_152 _ = happyFail (happyExpListPerState 152)

action_153 _ = happyReduce_66

action_154 (43) = happyShift action_18
action_154 (44) = happyShift action_19
action_154 (45) = happyShift action_20
action_154 (46) = happyShift action_21
action_154 (47) = happyShift action_22
action_154 (48) = happyShift action_23
action_154 (49) = happyShift action_24
action_154 (50) = happyShift action_25
action_154 (52) = happyShift action_26
action_154 (53) = happyShift action_27
action_154 (54) = happyShift action_28
action_154 (55) = happyShift action_29
action_154 (56) = happyShift action_30
action_154 (60) = happyShift action_31
action_154 (64) = happyShift action_32
action_154 (28) = happyGoto action_187
action_154 (31) = happyGoto action_13
action_154 (33) = happyGoto action_14
action_154 (34) = happyGoto action_15
action_154 (35) = happyGoto action_16
action_154 (36) = happyGoto action_17
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (57) = happyShift action_186
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (66) = happyShift action_185
action_156 _ = happyReduce_45

action_157 (61) = happyShift action_184
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_43

action_159 (61) = happyReduce_51
action_159 (66) = happyReduce_51
action_159 _ = happyReduce_31

action_160 (60) = happyReduce_41
action_160 (61) = happyReduce_41
action_160 (66) = happyReduce_41
action_160 _ = happyReduce_32

action_161 _ = happyReduce_59

action_162 _ = happyReduce_60

action_163 _ = happyReduce_63

action_164 (47) = happyShift action_22
action_164 (49) = happyShift action_24
action_164 (50) = happyShift action_91
action_164 (52) = happyShift action_92
action_164 (54) = happyShift action_93
action_164 (56) = happyShift action_94
action_164 (60) = happyShift action_95
action_164 (64) = happyShift action_96
action_164 (20) = happyGoto action_84
action_164 (23) = happyGoto action_182
action_164 (24) = happyGoto action_183
action_164 (34) = happyGoto action_89
action_164 (36) = happyGoto action_90
action_164 _ = happyFail (happyExpListPerState 164)

action_165 _ = happyReduce_52

action_166 _ = happyReduce_54

action_167 (61) = happyShift action_181
action_167 _ = happyFail (happyExpListPerState 167)

action_168 _ = happyReduce_68

action_169 _ = happyReduce_88

action_170 (43) = happyShift action_18
action_170 (44) = happyShift action_19
action_170 (45) = happyShift action_20
action_170 (46) = happyShift action_21
action_170 (47) = happyShift action_22
action_170 (48) = happyShift action_23
action_170 (49) = happyShift action_24
action_170 (50) = happyShift action_25
action_170 (52) = happyShift action_26
action_170 (53) = happyShift action_27
action_170 (54) = happyShift action_28
action_170 (55) = happyShift action_29
action_170 (56) = happyShift action_30
action_170 (60) = happyShift action_31
action_170 (64) = happyShift action_32
action_170 (28) = happyGoto action_180
action_170 (31) = happyGoto action_13
action_170 (33) = happyGoto action_14
action_170 (34) = happyGoto action_15
action_170 (35) = happyGoto action_16
action_170 (36) = happyGoto action_17
action_170 _ = happyFail (happyExpListPerState 170)

action_171 _ = happyReduce_24

action_172 _ = happyReduce_26

action_173 (67) = happyShift action_179
action_173 _ = happyReduce_14

action_174 _ = happyReduce_5

action_175 (52) = happyShift action_122
action_175 (7) = happyGoto action_120
action_175 (8) = happyGoto action_178
action_175 _ = happyReduce_16

action_176 (52) = happyShift action_122
action_176 (7) = happyGoto action_120
action_176 (8) = happyGoto action_177
action_176 _ = happyReduce_16

action_177 (63) = happyShift action_192
action_177 _ = happyFail (happyExpListPerState 177)

action_178 _ = happyReduce_18

action_179 (43) = happyShift action_18
action_179 (44) = happyShift action_19
action_179 (45) = happyShift action_20
action_179 (46) = happyShift action_21
action_179 (47) = happyShift action_22
action_179 (48) = happyShift action_23
action_179 (49) = happyShift action_24
action_179 (50) = happyShift action_25
action_179 (52) = happyShift action_26
action_179 (53) = happyShift action_27
action_179 (54) = happyShift action_28
action_179 (55) = happyShift action_29
action_179 (56) = happyShift action_30
action_179 (60) = happyShift action_31
action_179 (64) = happyShift action_32
action_179 (28) = happyGoto action_191
action_179 (31) = happyGoto action_13
action_179 (33) = happyGoto action_14
action_179 (34) = happyGoto action_15
action_179 (35) = happyGoto action_16
action_179 (36) = happyGoto action_17
action_179 _ = happyFail (happyExpListPerState 179)

action_180 _ = happyReduce_9

action_181 _ = happyReduce_38

action_182 _ = happyReduce_48

action_183 (66) = happyShift action_164
action_183 _ = happyReduce_47

action_184 _ = happyReduce_50

action_185 (47) = happyShift action_22
action_185 (49) = happyShift action_24
action_185 (50) = happyShift action_159
action_185 (52) = happyShift action_160
action_185 (54) = happyShift action_93
action_185 (56) = happyShift action_94
action_185 (60) = happyShift action_95
action_185 (64) = happyShift action_96
action_185 (15) = happyGoto action_155
action_185 (20) = happyGoto action_84
action_185 (21) = happyGoto action_156
action_185 (22) = happyGoto action_190
action_185 (24) = happyGoto action_158
action_185 (34) = happyGoto action_89
action_185 (36) = happyGoto action_90
action_185 _ = happyFail (happyExpListPerState 185)

action_186 (47) = happyShift action_22
action_186 (49) = happyShift action_24
action_186 (50) = happyShift action_91
action_186 (52) = happyShift action_92
action_186 (54) = happyShift action_93
action_186 (56) = happyShift action_94
action_186 (60) = happyShift action_95
action_186 (64) = happyShift action_96
action_186 (20) = happyGoto action_84
action_186 (24) = happyGoto action_189
action_186 (34) = happyGoto action_89
action_186 (36) = happyGoto action_90
action_186 _ = happyFail (happyExpListPerState 186)

action_187 _ = happyReduce_65

action_188 _ = happyReduce_64

action_189 _ = happyReduce_44

action_190 _ = happyReduce_46

action_191 _ = happyReduce_15

action_192 _ = happyReduce_6

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
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyTerminal (TokenUSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (DataDeclaration happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_7 = happyReduce 5 6 happyReduction_7
happyReduction_7 ((HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Declaration happy_var_2 happy_var_3 happy_var_5 []
	) `HappyStk` happyRest

happyReduce_8 = happyReduce 5 6 happyReduction_8
happyReduction_8 ((HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Definition happy_var_2 happy_var_3 Nothing happy_var_5 []
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 7 6 happyReduction_9
happyReduction_9 ((HappyAbsSyn28  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn12  happy_var_3) `HappyStk`
	(HappyAbsSyn5  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Definition happy_var_2 happy_var_3 (Just happy_var_5) happy_var_7 []
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_2  6 happyReduction_10
happyReduction_10 (HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (Eval happy_var_2
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  6 happyReduction_11
happyReduction_11 (HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (TypeOf happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happyReduce 4 6 happyReduction_12
happyReduction_12 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (CheckUnify happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_13 = happyReduce 4 6 happyReduction_13
happyReduction_13 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
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
happyReduction_15 ((HappyAbsSyn28  happy_var_4) `HappyStk`
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

happyReduce_21 = happySpecReduce_1  9 happyReduction_21
happyReduction_21 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  10 happyReduction_22
happyReduction_22 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 :| []
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  10 happyReduction_23
happyReduction_23 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_23 _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  11 happyReduction_24
happyReduction_24 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1, Just happy_var_3, [])
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  12 happyReduction_25
happyReduction_25 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  12 happyReduction_26
happyReduction_26 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1 : happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_0  13 happyReduction_27
happyReduction_27  =  HappyAbsSyn12
		 ([]
	)

happyReduce_28 = happySpecReduce_3  13 happyReduction_28
happyReduction_28 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  14 happyReduction_29
happyReduction_29 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  14 happyReduction_30
happyReduction_30 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 : happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  15 happyReduction_31
happyReduction_31 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  15 happyReduction_32
happyReduction_32 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  16 happyReduction_33
happyReduction_33 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  16 happyReduction_34
happyReduction_34 _
	 =  HappyAbsSyn15
		 ("_"
	)

happyReduce_35 = happySpecReduce_1  17 happyReduction_35
happyReduction_35 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| []
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_2  17 happyReduction_36
happyReduction_36 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  18 happyReduction_37
happyReduction_37 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1 :| [], Nothing, [])
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happyReduce 5 18 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 ((happy_var_2, Just happy_var_4, [])
	) `HappyStk` happyRest

happyReduce_39 = happySpecReduce_1  19 happyReduction_39
happyReduction_39 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 :| []
	)
happyReduction_39 _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  19 happyReduction_40
happyReduction_40 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  20 happyReduction_41
happyReduction_41 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  20 happyReduction_42
happyReduction_42 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  21 happyReduction_43
happyReduction_43 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn21
		 (Right happy_var_1
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  21 happyReduction_44
happyReduction_44 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn21
		 (Left (P.Implicit happy_var_1 happy_var_3)
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  22 happyReduction_45
happyReduction_45 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| []
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  22 happyReduction_46
happyReduction_46 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  23 happyReduction_47
happyReduction_47 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 ([happy_var_1, happy_var_3]
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  23 happyReduction_48
happyReduction_48 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1 : happy_var_3
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  24 happyReduction_49
happyReduction_49 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Data happy_var_1 []
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happyReduce 4 24 happyReduction_50
happyReduction_50 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (P.Data happy_var_1 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_51 = happySpecReduce_1  24 happyReduction_51
happyReduction_51 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn24
		 (P.Variable happy_var_1
	)
happyReduction_51 _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_3  24 happyReduction_52
happyReduction_52 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.Tuple happy_var_2
	)
happyReduction_52 _ _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  24 happyReduction_53
happyReduction_53 _
	_
	 =  HappyAbsSyn24
		 (P.List []
	)

happyReduce_54 = happySpecReduce_3  24 happyReduction_54
happyReduction_54 _
	(HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.List happy_var_2
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  24 happyReduction_55
happyReduction_55 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  24 happyReduction_56
happyReduction_56 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_1  24 happyReduction_57
happyReduction_57 _
	 =  HappyAbsSyn24
		 (Wildcard
	)

happyReduce_58 = happySpecReduce_1  25 happyReduction_58
happyReduction_58 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn25
		 ([happy_var_1]
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_3  25 happyReduction_59
happyReduction_59 (HappyAbsSyn25  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_1 : happy_var_3
	)
happyReduction_59 _ _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  26 happyReduction_60
happyReduction_60 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn26
		 ((happy_var_1, happy_var_3)
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_0  27 happyReduction_61
happyReduction_61  =  HappyAbsSyn27
		 ([]
	)

happyReduce_62 = happySpecReduce_1  27 happyReduction_62
happyReduction_62 (HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  27 happyReduction_63
happyReduction_63 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happyReduce 6 28 happyReduction_64
happyReduction_64 ((HappyAbsSyn28  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_65 = happyReduce 6 28 happyReduction_65
happyReduction_65 ((HappyAbsSyn28  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (ForAll happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_66 = happyReduce 5 28 happyReduction_66
happyReduction_66 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_67 = happyReduce 4 28 happyReduction_67
happyReduction_67 ((HappyAbsSyn28  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_68 = happyReduce 5 28 happyReduction_68
happyReduction_68 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 4 28 happyReduction_69
happyReduction_69 (_ `HappyStk`
	(HappyAbsSyn27  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_70 = happySpecReduce_1  28 happyReduction_70
happyReduction_70 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_70 _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  29 happyReduction_71
happyReduction_71 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 ((Nothing, happy_var_1)
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  29 happyReduction_72
happyReduction_72 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn29
		 ((Just happy_var_1, happy_var_3)
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_1  30 happyReduction_73
happyReduction_73 (HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1 :| []
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  30 happyReduction_74
happyReduction_74 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  31 happyReduction_75
happyReduction_75 (HappyAbsSyn28  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  31 happyReduction_76
happyReduction_76 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (TokenLSym happy_var_2))
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Infix happy_var_1 (QName [] happy_var_2) happy_var_3
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  31 happyReduction_77
happyReduction_77 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (TokenUSym happy_var_2))
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Infix happy_var_1 (QName [] happy_var_2) happy_var_3
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  31 happyReduction_78
happyReduction_78 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (TokenLSymQ happy_var_2))
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Infix happy_var_1 (uncurry QName happy_var_2) happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_3  31 happyReduction_79
happyReduction_79 (HappyAbsSyn28  happy_var_3)
	(HappyTerminal (TokenUSymQ happy_var_2))
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (Infix happy_var_1 (uncurry QName happy_var_2) happy_var_3
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happyReduce 4 31 happyReduction_80
happyReduction_80 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Application happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_81 = happySpecReduce_1  31 happyReduction_81
happyReduction_81 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (happy_var_1
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_1  32 happyReduction_82
happyReduction_82 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_82 _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  32 happyReduction_83
happyReduction_83 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  32 happyReduction_84
happyReduction_84 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  32 happyReduction_85
happyReduction_85 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  33 happyReduction_86
happyReduction_86 _
	(HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (Parenthesized happy_var_2
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_2  33 happyReduction_87
happyReduction_87 _
	_
	 =  HappyAbsSyn28
		 (Literal UnitLiteral
	)

happyReduce_88 = happyReduce 5 33 happyReduction_88
happyReduction_88 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn28
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_89 = happySpecReduce_3  33 happyReduction_89
happyReduction_89 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (List happy_var_2
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_1  33 happyReduction_90
happyReduction_90 _
	 =  HappyAbsSyn28
		 (Meta
	)

happyReduce_91 = happySpecReduce_1  33 happyReduction_91
happyReduction_91 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_91 _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  33 happyReduction_92
happyReduction_92 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_92 _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_1  33 happyReduction_93
happyReduction_93 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_1  33 happyReduction_94
happyReduction_94 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn28
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  33 happyReduction_95
happyReduction_95 _
	 =  HappyAbsSyn28
		 (Type
	)

happyReduce_96 = happySpecReduce_1  33 happyReduction_96
happyReduction_96 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  33 happyReduction_97
happyReduction_97 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  33 happyReduction_98
happyReduction_98 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn28
		 (Literal happy_var_1
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  34 happyReduction_99
happyReduction_99 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn34
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  35 happyReduction_100
happyReduction_100 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn34
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  36 happyReduction_101
happyReduction_101 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn34
		 (StringLiteral happy_var_1
	)
happyReduction_101 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 69 69 notHappyAtAll (HappyState action) sts stk []

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
	TokenInfixOp happy_dollar_dollar -> cont 59;
	TokenLParen -> cont 60;
	TokenRParen -> cont 61;
	TokenLBrace -> cont 62;
	TokenRBrace -> cont 63;
	TokenLBracket -> cont 64;
	TokenRBracket -> cont 65;
	TokenComma -> cont 66;
	TokenColon -> cont 67;
	TokenSemicolon -> cont 68;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 69 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

happyThen :: () => Either String a -> (a -> Either String b) -> Either String b
happyThen = (thenE)
happyReturn :: () => a -> Either String a
happyReturn = (returnE)
happyThen1 m k tks = (thenE) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Either String a
happyReturn1 = \a tks -> (returnE) a
happyError' :: () => ([(Token)], [Prelude.String]) -> Either String a
happyError' = (\(tokens, _) -> parseError tokens)
parse tks = happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError tokens = Left "Parse error"

thenE = (>>=)
returnE = pure


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
