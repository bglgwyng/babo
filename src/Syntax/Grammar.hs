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
	| HappyAbsSyn28 (Branch)
	| HappyAbsSyn29 ([Branch])
	| HappyAbsSyn30 (Expression)
	| HappyAbsSyn31 (Disk)
	| HappyAbsSyn32 (NonEmpty Disk)
	| HappyAbsSyn36 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,766) ([0,0,4032,0,0,0,57344,7,0,0,0,0,0,0,0,0,1024,0,0,0,32768,2,0,0,0,320,0,0,0,49088,2191,0,0,57344,18399,4,0,0,61424,547,0,0,0,0,0,0,61440,3,0,0,0,0,0,0,0,0,0,0,0,0,16384,71,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,65280,8766,0,0,0,4416,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,1297,0,0,0,0,0,0,0,57312,1223,0,0,61440,9199,2,0,0,0,0,0,0,0,256,4,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,16384,0,0,0,0,4224,0,0,0,28,0,0,0,0,1024,0,0,0,128,2,0,0,16127,34,0,0,32640,4383,0,0,0,0,16,0,0,0,4096,0,0,0,16384,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,546,0,0,0,16384,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,276,0,0,0,43840,136,0,0,0,69,0,0,0,0,256,0,0,0,1024,0,0,0,4096,0,0,0,57312,1095,0,0,4096,8943,2,0,0,30600,273,0,0,50176,35003,0,0,0,24034,68,0,0,61696,8750,0,0,0,18240,0,0,0,40960,3,0,0,0,464,0,0,0,59392,0,0,0,0,116,0,0,0,0,1,0,0,0,0,0,0,0,0,128,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,61440,9199,2,0,0,22144,273,0,0,64512,35067,0,0,0,0,0,0,0,53248,8746,0,0,0,0,0,0,0,0,8192,0,0,0,4096,0,0,0,0,8192,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8877,2,0,0,22144,785,0,0,0,0,4,0,0,32254,68,0,0,53248,8746,0,0,0,0,0,0,0,0,0,0,0,57344,18399,4,0,0,61424,547,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16127,34,0,0,32640,4383,0,0,49152,36799,8,0,0,28672,0,0,0,0,0,16,0,0,0,1024,0,0,0,4096,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,57344,18399,4,0,0,0,128,0,0,0,0,16,0,0,0,64,0,0,0,1024,0,0,0,0,0,0,0,49152,1,0,0,49152,36799,8,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,8,0,0,0,0,0,0,57344,18399,4,0,0,0,1024,0,0,0,0,0,0,0,0,16,0,0,0,0,1,0,0,0,0,0,0,26624,4373,0,0,49152,36799,8,0,0,23040,1093,0,0,0,0,0,0,0,22144,273,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5480,17,0,0,0,8192,0,0,0,0,2,0,0,0,2048,0,0,0,0,0,0,0,64508,136,0,0,65024,17533,0,0,0,0,0,0,0,0,0,0,0,49152,36799,8,0,0,0,0,0,0,61440,9199,2,0,0,0,2,0,0,16384,34987,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,4438,1,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,57312,1095,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,2,0,0,0,256,0,0,0,0,1024,0,0,0,0,0,0,0,61424,547,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,1,0,0,23040,1093,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,21920,68,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Name","Statement","Variant","Variants","ArgumentName","ArgumentNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Branch","Branches","Expression","Disk","Spine","BinaryExpression","Identifier","Atom","IntegerLiteral","FloatLiteral","StringLiteral","data","decl","def","check","eval","typeOf","type","let","case","forall","int","float","string","lsym","qlsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 71
        bit_end = (st Prelude.+ 1) Prelude.* 71
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..70]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (39) = happyShift action_3
action_0 (40) = happyShift action_4
action_0 (41) = happyShift action_5
action_0 (42) = happyShift action_6
action_0 (43) = happyShift action_7
action_0 (44) = happyShift action_8
action_0 (4) = happyGoto action_9
action_0 (6) = happyGoto action_10
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (39) = happyShift action_3
action_1 (40) = happyShift action_4
action_1 (41) = happyShift action_5
action_1 (42) = happyShift action_6
action_1 (43) = happyShift action_7
action_1 (44) = happyShift action_8
action_1 (6) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyFail (happyExpListPerState 2)

action_3 (54) = happyShift action_39
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (52) = happyShift action_36
action_4 (54) = happyShift action_37
action_4 (5) = happyGoto action_38
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (52) = happyShift action_36
action_5 (54) = happyShift action_37
action_5 (5) = happyGoto action_35
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (45) = happyShift action_18
action_6 (46) = happyShift action_19
action_6 (47) = happyShift action_20
action_6 (48) = happyShift action_21
action_6 (49) = happyShift action_22
action_6 (50) = happyShift action_23
action_6 (51) = happyShift action_24
action_6 (52) = happyShift action_25
action_6 (54) = happyShift action_26
action_6 (55) = happyShift action_27
action_6 (56) = happyShift action_28
action_6 (57) = happyShift action_29
action_6 (58) = happyShift action_30
action_6 (62) = happyShift action_31
action_6 (66) = happyShift action_32
action_6 (30) = happyGoto action_34
action_6 (33) = happyGoto action_13
action_6 (35) = happyGoto action_14
action_6 (36) = happyGoto action_15
action_6 (37) = happyGoto action_16
action_6 (38) = happyGoto action_17
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (45) = happyShift action_18
action_7 (46) = happyShift action_19
action_7 (47) = happyShift action_20
action_7 (48) = happyShift action_21
action_7 (49) = happyShift action_22
action_7 (50) = happyShift action_23
action_7 (51) = happyShift action_24
action_7 (52) = happyShift action_25
action_7 (54) = happyShift action_26
action_7 (55) = happyShift action_27
action_7 (56) = happyShift action_28
action_7 (57) = happyShift action_29
action_7 (58) = happyShift action_30
action_7 (62) = happyShift action_31
action_7 (66) = happyShift action_32
action_7 (30) = happyGoto action_33
action_7 (33) = happyGoto action_13
action_7 (35) = happyGoto action_14
action_7 (36) = happyGoto action_15
action_7 (37) = happyGoto action_16
action_7 (38) = happyGoto action_17
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (45) = happyShift action_18
action_8 (46) = happyShift action_19
action_8 (47) = happyShift action_20
action_8 (48) = happyShift action_21
action_8 (49) = happyShift action_22
action_8 (50) = happyShift action_23
action_8 (51) = happyShift action_24
action_8 (52) = happyShift action_25
action_8 (54) = happyShift action_26
action_8 (55) = happyShift action_27
action_8 (56) = happyShift action_28
action_8 (57) = happyShift action_29
action_8 (58) = happyShift action_30
action_8 (62) = happyShift action_31
action_8 (66) = happyShift action_32
action_8 (30) = happyGoto action_12
action_8 (33) = happyGoto action_13
action_8 (35) = happyGoto action_14
action_8 (36) = happyGoto action_15
action_8 (37) = happyGoto action_16
action_8 (38) = happyGoto action_17
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (71) = happyAccept
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (39) = happyShift action_3
action_10 (40) = happyShift action_4
action_10 (41) = happyShift action_5
action_10 (42) = happyShift action_6
action_10 (43) = happyShift action_7
action_10 (44) = happyShift action_8
action_10 (4) = happyGoto action_11
action_10 (6) = happyGoto action_10
action_10 _ = happyReduce_1

action_11 _ = happyReduce_2

action_12 _ = happyReduce_11

action_13 (52) = happyShift action_64
action_13 (54) = happyShift action_65
action_13 (55) = happyShift action_66
action_13 (56) = happyShift action_67
action_13 (60) = happyShift action_68
action_13 _ = happyReduce_74

action_14 (62) = happyShift action_63
action_14 _ = happyReduce_85

action_15 _ = happyReduce_100

action_16 _ = happyReduce_101

action_17 _ = happyReduce_102

action_18 _ = happyReduce_99

action_19 (52) = happyShift action_62
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (45) = happyShift action_18
action_20 (46) = happyShift action_19
action_20 (47) = happyShift action_20
action_20 (48) = happyShift action_21
action_20 (49) = happyShift action_22
action_20 (50) = happyShift action_23
action_20 (51) = happyShift action_24
action_20 (52) = happyShift action_25
action_20 (54) = happyShift action_26
action_20 (55) = happyShift action_27
action_20 (56) = happyShift action_28
action_20 (57) = happyShift action_29
action_20 (58) = happyShift action_30
action_20 (62) = happyShift action_31
action_20 (66) = happyShift action_32
action_20 (14) = happyGoto action_61
action_20 (30) = happyGoto action_47
action_20 (33) = happyGoto action_13
action_20 (35) = happyGoto action_14
action_20 (36) = happyGoto action_15
action_20 (37) = happyGoto action_16
action_20 (38) = happyGoto action_17
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (52) = happyShift action_54
action_21 (54) = happyShift action_55
action_21 (58) = happyShift action_56
action_21 (15) = happyGoto action_50
action_21 (16) = happyGoto action_59
action_21 (17) = happyGoto action_60
action_21 _ = happyFail (happyExpListPerState 21)

action_22 _ = happyReduce_103

action_23 _ = happyReduce_104

action_24 _ = happyReduce_105

action_25 _ = happyReduce_95

action_26 _ = happyReduce_96

action_27 _ = happyReduce_97

action_28 _ = happyReduce_98

action_29 (52) = happyShift action_54
action_29 (54) = happyShift action_55
action_29 (58) = happyShift action_56
action_29 (62) = happyShift action_57
action_29 (64) = happyShift action_58
action_29 (15) = happyGoto action_50
action_29 (16) = happyGoto action_51
action_29 (18) = happyGoto action_52
action_29 (19) = happyGoto action_53
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_94

action_31 (45) = happyShift action_18
action_31 (46) = happyShift action_19
action_31 (47) = happyShift action_20
action_31 (48) = happyShift action_21
action_31 (49) = happyShift action_22
action_31 (50) = happyShift action_23
action_31 (51) = happyShift action_24
action_31 (52) = happyShift action_25
action_31 (54) = happyShift action_26
action_31 (55) = happyShift action_27
action_31 (56) = happyShift action_28
action_31 (57) = happyShift action_29
action_31 (58) = happyShift action_30
action_31 (62) = happyShift action_31
action_31 (63) = happyShift action_49
action_31 (66) = happyShift action_32
action_31 (30) = happyGoto action_48
action_31 (33) = happyGoto action_13
action_31 (35) = happyGoto action_14
action_31 (36) = happyGoto action_15
action_31 (37) = happyGoto action_16
action_31 (38) = happyGoto action_17
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (45) = happyShift action_18
action_32 (46) = happyShift action_19
action_32 (47) = happyShift action_20
action_32 (48) = happyShift action_21
action_32 (49) = happyShift action_22
action_32 (50) = happyShift action_23
action_32 (51) = happyShift action_24
action_32 (52) = happyShift action_25
action_32 (54) = happyShift action_26
action_32 (55) = happyShift action_27
action_32 (56) = happyShift action_28
action_32 (57) = happyShift action_29
action_32 (58) = happyShift action_30
action_32 (62) = happyShift action_31
action_32 (66) = happyShift action_32
action_32 (14) = happyGoto action_46
action_32 (30) = happyGoto action_47
action_32 (33) = happyGoto action_13
action_32 (35) = happyGoto action_14
action_32 (36) = happyGoto action_15
action_32 (37) = happyGoto action_16
action_32 (38) = happyGoto action_17
action_32 _ = happyFail (happyExpListPerState 32)

action_33 _ = happyReduce_10

action_34 (59) = happyShift action_44
action_34 (69) = happyShift action_45
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (62) = happyShift action_41
action_35 (13) = happyGoto action_43
action_35 _ = happyReduce_27

action_36 _ = happyReduce_4

action_37 _ = happyReduce_3

action_38 (62) = happyShift action_41
action_38 (13) = happyGoto action_42
action_38 _ = happyReduce_27

action_39 (62) = happyShift action_41
action_39 (13) = happyGoto action_40
action_39 _ = happyReduce_27

action_40 (64) = happyShift action_118
action_40 (69) = happyShift action_119
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (52) = happyShift action_115
action_41 (53) = happyShift action_116
action_41 (54) = happyShift action_117
action_41 (9) = happyGoto action_111
action_41 (10) = happyGoto action_112
action_41 (11) = happyGoto action_113
action_41 (12) = happyGoto action_114
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (69) = happyShift action_110
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (59) = happyShift action_108
action_43 (69) = happyShift action_109
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (45) = happyShift action_18
action_44 (46) = happyShift action_19
action_44 (47) = happyShift action_20
action_44 (48) = happyShift action_21
action_44 (49) = happyShift action_22
action_44 (50) = happyShift action_23
action_44 (51) = happyShift action_24
action_44 (52) = happyShift action_25
action_44 (54) = happyShift action_26
action_44 (55) = happyShift action_27
action_44 (56) = happyShift action_28
action_44 (57) = happyShift action_29
action_44 (58) = happyShift action_30
action_44 (62) = happyShift action_31
action_44 (66) = happyShift action_32
action_44 (30) = happyGoto action_107
action_44 (33) = happyGoto action_13
action_44 (35) = happyGoto action_14
action_44 (36) = happyGoto action_15
action_44 (37) = happyGoto action_16
action_44 (38) = happyGoto action_17
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (45) = happyShift action_18
action_45 (46) = happyShift action_19
action_45 (47) = happyShift action_20
action_45 (48) = happyShift action_21
action_45 (49) = happyShift action_22
action_45 (50) = happyShift action_23
action_45 (51) = happyShift action_24
action_45 (52) = happyShift action_25
action_45 (54) = happyShift action_26
action_45 (55) = happyShift action_27
action_45 (56) = happyShift action_28
action_45 (57) = happyShift action_29
action_45 (58) = happyShift action_30
action_45 (62) = happyShift action_31
action_45 (66) = happyShift action_32
action_45 (30) = happyGoto action_106
action_45 (33) = happyGoto action_13
action_45 (35) = happyGoto action_14
action_45 (36) = happyGoto action_15
action_45 (37) = happyGoto action_16
action_45 (38) = happyGoto action_17
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (67) = happyShift action_105
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (68) = happyShift action_104
action_47 _ = happyReduce_29

action_48 (63) = happyShift action_102
action_48 (68) = happyShift action_103
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_91

action_50 _ = happyReduce_33

action_51 _ = happyReduce_37

action_52 (52) = happyShift action_54
action_52 (54) = happyShift action_55
action_52 (58) = happyShift action_56
action_52 (62) = happyShift action_57
action_52 (15) = happyGoto action_50
action_52 (16) = happyGoto action_51
action_52 (18) = happyGoto action_52
action_52 (19) = happyGoto action_101
action_52 _ = happyReduce_39

action_53 (60) = happyShift action_99
action_53 (64) = happyShift action_100
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_31

action_55 _ = happyReduce_32

action_56 _ = happyReduce_34

action_57 (52) = happyShift action_54
action_57 (54) = happyShift action_55
action_57 (58) = happyShift action_56
action_57 (15) = happyGoto action_50
action_57 (16) = happyGoto action_59
action_57 (17) = happyGoto action_98
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (49) = happyShift action_22
action_58 (51) = happyShift action_24
action_58 (52) = happyShift action_92
action_58 (54) = happyShift action_93
action_58 (56) = happyShift action_94
action_58 (58) = happyShift action_95
action_58 (62) = happyShift action_96
action_58 (66) = happyShift action_97
action_58 (20) = happyGoto action_84
action_58 (24) = happyGoto action_85
action_58 (26) = happyGoto action_86
action_58 (27) = happyGoto action_87
action_58 (28) = happyGoto action_88
action_58 (29) = happyGoto action_89
action_58 (36) = happyGoto action_90
action_58 (38) = happyGoto action_91
action_58 _ = happyReduce_65

action_59 (52) = happyShift action_54
action_59 (54) = happyShift action_55
action_59 (58) = happyShift action_56
action_59 (15) = happyGoto action_50
action_59 (16) = happyGoto action_59
action_59 (17) = happyGoto action_83
action_59 _ = happyReduce_35

action_60 (69) = happyShift action_82
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (64) = happyShift action_81
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (59) = happyShift action_80
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (45) = happyShift action_18
action_63 (46) = happyShift action_19
action_63 (47) = happyShift action_20
action_63 (48) = happyShift action_21
action_63 (49) = happyShift action_22
action_63 (50) = happyShift action_23
action_63 (51) = happyShift action_24
action_63 (52) = happyShift action_78
action_63 (54) = happyShift action_79
action_63 (55) = happyShift action_27
action_63 (56) = happyShift action_28
action_63 (57) = happyShift action_29
action_63 (58) = happyShift action_30
action_63 (62) = happyShift action_31
action_63 (66) = happyShift action_32
action_63 (15) = happyGoto action_74
action_63 (30) = happyGoto action_75
action_63 (31) = happyGoto action_76
action_63 (32) = happyGoto action_77
action_63 (33) = happyGoto action_13
action_63 (35) = happyGoto action_14
action_63 (36) = happyGoto action_15
action_63 (37) = happyGoto action_16
action_63 (38) = happyGoto action_17
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (45) = happyShift action_18
action_64 (49) = happyShift action_22
action_64 (50) = happyShift action_23
action_64 (51) = happyShift action_24
action_64 (52) = happyShift action_25
action_64 (54) = happyShift action_26
action_64 (55) = happyShift action_27
action_64 (56) = happyShift action_28
action_64 (58) = happyShift action_30
action_64 (62) = happyShift action_31
action_64 (66) = happyShift action_32
action_64 (33) = happyGoto action_73
action_64 (35) = happyGoto action_14
action_64 (36) = happyGoto action_15
action_64 (37) = happyGoto action_16
action_64 (38) = happyGoto action_17
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (45) = happyShift action_18
action_65 (49) = happyShift action_22
action_65 (50) = happyShift action_23
action_65 (51) = happyShift action_24
action_65 (52) = happyShift action_25
action_65 (54) = happyShift action_26
action_65 (55) = happyShift action_27
action_65 (56) = happyShift action_28
action_65 (58) = happyShift action_30
action_65 (62) = happyShift action_31
action_65 (66) = happyShift action_32
action_65 (33) = happyGoto action_72
action_65 (35) = happyGoto action_14
action_65 (36) = happyGoto action_15
action_65 (37) = happyGoto action_16
action_65 (38) = happyGoto action_17
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (45) = happyShift action_18
action_66 (49) = happyShift action_22
action_66 (50) = happyShift action_23
action_66 (51) = happyShift action_24
action_66 (52) = happyShift action_25
action_66 (54) = happyShift action_26
action_66 (55) = happyShift action_27
action_66 (56) = happyShift action_28
action_66 (58) = happyShift action_30
action_66 (62) = happyShift action_31
action_66 (66) = happyShift action_32
action_66 (33) = happyGoto action_71
action_66 (35) = happyGoto action_14
action_66 (36) = happyGoto action_15
action_66 (37) = happyGoto action_16
action_66 (38) = happyGoto action_17
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (45) = happyShift action_18
action_67 (49) = happyShift action_22
action_67 (50) = happyShift action_23
action_67 (51) = happyShift action_24
action_67 (52) = happyShift action_25
action_67 (54) = happyShift action_26
action_67 (55) = happyShift action_27
action_67 (56) = happyShift action_28
action_67 (58) = happyShift action_30
action_67 (62) = happyShift action_31
action_67 (66) = happyShift action_32
action_67 (33) = happyGoto action_70
action_67 (35) = happyGoto action_14
action_67 (36) = happyGoto action_15
action_67 (37) = happyGoto action_16
action_67 (38) = happyGoto action_17
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (45) = happyShift action_18
action_68 (49) = happyShift action_22
action_68 (50) = happyShift action_23
action_68 (51) = happyShift action_24
action_68 (52) = happyShift action_25
action_68 (54) = happyShift action_26
action_68 (55) = happyShift action_27
action_68 (56) = happyShift action_28
action_68 (58) = happyShift action_30
action_68 (62) = happyShift action_31
action_68 (66) = happyShift action_32
action_68 (33) = happyGoto action_69
action_68 (35) = happyGoto action_14
action_68 (36) = happyGoto action_15
action_68 (37) = happyGoto action_16
action_68 (38) = happyGoto action_17
action_68 _ = happyFail (happyExpListPerState 68)

action_69 (52) = happyShift action_64
action_69 (54) = happyShift action_65
action_69 (55) = happyShift action_66
action_69 (56) = happyShift action_67
action_69 (60) = happyShift action_68
action_69 _ = happyReduce_79

action_70 (52) = happyShift action_64
action_70 (54) = happyShift action_65
action_70 (55) = happyShift action_66
action_70 (56) = happyShift action_67
action_70 _ = happyReduce_83

action_71 (52) = happyShift action_64
action_71 (54) = happyShift action_65
action_71 (55) = happyShift action_66
action_71 (56) = happyShift action_67
action_71 _ = happyReduce_82

action_72 (52) = happyShift action_64
action_72 (54) = happyShift action_65
action_72 (55) = happyShift action_66
action_72 (56) = happyShift action_67
action_72 _ = happyReduce_81

action_73 (52) = happyShift action_64
action_73 (54) = happyShift action_65
action_73 (55) = happyShift action_66
action_73 (56) = happyShift action_67
action_73 _ = happyReduce_80

action_74 (59) = happyShift action_155
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_75

action_76 (68) = happyShift action_154
action_76 _ = happyReduce_77

action_77 (63) = happyShift action_153
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (59) = happyReduce_31
action_78 _ = happyReduce_95

action_79 (59) = happyReduce_32
action_79 _ = happyReduce_96

action_80 (45) = happyShift action_18
action_80 (46) = happyShift action_19
action_80 (47) = happyShift action_20
action_80 (48) = happyShift action_21
action_80 (49) = happyShift action_22
action_80 (50) = happyShift action_23
action_80 (51) = happyShift action_24
action_80 (52) = happyShift action_25
action_80 (54) = happyShift action_26
action_80 (55) = happyShift action_27
action_80 (56) = happyShift action_28
action_80 (57) = happyShift action_29
action_80 (58) = happyShift action_30
action_80 (62) = happyShift action_31
action_80 (66) = happyShift action_32
action_80 (30) = happyGoto action_152
action_80 (33) = happyGoto action_13
action_80 (35) = happyGoto action_14
action_80 (36) = happyGoto action_15
action_80 (37) = happyGoto action_16
action_80 (38) = happyGoto action_17
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (49) = happyShift action_22
action_81 (51) = happyShift action_24
action_81 (52) = happyShift action_92
action_81 (54) = happyShift action_93
action_81 (56) = happyShift action_94
action_81 (58) = happyShift action_95
action_81 (62) = happyShift action_96
action_81 (66) = happyShift action_97
action_81 (20) = happyGoto action_84
action_81 (24) = happyGoto action_85
action_81 (26) = happyGoto action_86
action_81 (27) = happyGoto action_87
action_81 (28) = happyGoto action_88
action_81 (29) = happyGoto action_151
action_81 (36) = happyGoto action_90
action_81 (38) = happyGoto action_91
action_81 _ = happyReduce_65

action_82 (45) = happyShift action_18
action_82 (46) = happyShift action_19
action_82 (47) = happyShift action_20
action_82 (48) = happyShift action_21
action_82 (49) = happyShift action_22
action_82 (50) = happyShift action_23
action_82 (51) = happyShift action_24
action_82 (52) = happyShift action_25
action_82 (54) = happyShift action_26
action_82 (55) = happyShift action_27
action_82 (56) = happyShift action_28
action_82 (57) = happyShift action_29
action_82 (58) = happyShift action_30
action_82 (62) = happyShift action_31
action_82 (66) = happyShift action_32
action_82 (30) = happyGoto action_150
action_82 (33) = happyGoto action_13
action_82 (35) = happyGoto action_14
action_82 (36) = happyGoto action_15
action_82 (37) = happyGoto action_16
action_82 (38) = happyGoto action_17
action_82 _ = happyFail (happyExpListPerState 82)

action_83 _ = happyReduce_36

action_84 (49) = happyShift action_22
action_84 (51) = happyShift action_24
action_84 (52) = happyShift action_92
action_84 (54) = happyShift action_93
action_84 (56) = happyShift action_94
action_84 (58) = happyShift action_95
action_84 (62) = happyShift action_149
action_84 (66) = happyShift action_97
action_84 (20) = happyGoto action_144
action_84 (21) = happyGoto action_145
action_84 (22) = happyGoto action_146
action_84 (24) = happyGoto action_147
action_84 (25) = happyGoto action_148
action_84 (36) = happyGoto action_90
action_84 (38) = happyGoto action_91
action_84 _ = happyReduce_50

action_85 _ = happyReduce_60

action_86 (68) = happyShift action_143
action_86 _ = happyReduce_62

action_87 (60) = happyShift action_142
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (70) = happyShift action_141
action_88 _ = happyReduce_66

action_89 (65) = happyShift action_140
action_89 _ = happyFail (happyExpListPerState 89)

action_90 _ = happyReduce_55

action_91 _ = happyReduce_56

action_92 _ = happyReduce_51

action_93 _ = happyReduce_41

action_94 _ = happyReduce_42

action_95 _ = happyReduce_57

action_96 (49) = happyShift action_22
action_96 (51) = happyShift action_24
action_96 (52) = happyShift action_92
action_96 (54) = happyShift action_93
action_96 (56) = happyShift action_94
action_96 (58) = happyShift action_95
action_96 (62) = happyShift action_96
action_96 (66) = happyShift action_97
action_96 (20) = happyGoto action_84
action_96 (23) = happyGoto action_138
action_96 (24) = happyGoto action_85
action_96 (26) = happyGoto action_139
action_96 (36) = happyGoto action_90
action_96 (38) = happyGoto action_91
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (49) = happyShift action_22
action_97 (51) = happyShift action_24
action_97 (52) = happyShift action_92
action_97 (54) = happyShift action_93
action_97 (56) = happyShift action_94
action_97 (58) = happyShift action_95
action_97 (62) = happyShift action_96
action_97 (66) = happyShift action_97
action_97 (67) = happyShift action_137
action_97 (20) = happyGoto action_84
action_97 (24) = happyGoto action_85
action_97 (26) = happyGoto action_86
action_97 (27) = happyGoto action_136
action_97 (36) = happyGoto action_90
action_97 (38) = happyGoto action_91
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (69) = happyShift action_135
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (45) = happyShift action_18
action_99 (46) = happyShift action_19
action_99 (47) = happyShift action_20
action_99 (48) = happyShift action_21
action_99 (49) = happyShift action_22
action_99 (50) = happyShift action_23
action_99 (51) = happyShift action_24
action_99 (52) = happyShift action_25
action_99 (54) = happyShift action_26
action_99 (55) = happyShift action_27
action_99 (56) = happyShift action_28
action_99 (57) = happyShift action_29
action_99 (58) = happyShift action_30
action_99 (62) = happyShift action_31
action_99 (66) = happyShift action_32
action_99 (30) = happyGoto action_134
action_99 (33) = happyGoto action_13
action_99 (35) = happyGoto action_14
action_99 (36) = happyGoto action_15
action_99 (37) = happyGoto action_16
action_99 (38) = happyGoto action_17
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (49) = happyShift action_22
action_100 (51) = happyShift action_24
action_100 (52) = happyShift action_92
action_100 (54) = happyShift action_93
action_100 (56) = happyShift action_94
action_100 (58) = happyShift action_95
action_100 (62) = happyShift action_96
action_100 (66) = happyShift action_97
action_100 (20) = happyGoto action_84
action_100 (24) = happyGoto action_85
action_100 (26) = happyGoto action_86
action_100 (27) = happyGoto action_87
action_100 (28) = happyGoto action_88
action_100 (29) = happyGoto action_133
action_100 (36) = happyGoto action_90
action_100 (38) = happyGoto action_91
action_100 _ = happyReduce_65

action_101 _ = happyReduce_40

action_102 _ = happyReduce_90

action_103 (45) = happyShift action_18
action_103 (46) = happyShift action_19
action_103 (47) = happyShift action_20
action_103 (48) = happyShift action_21
action_103 (49) = happyShift action_22
action_103 (50) = happyShift action_23
action_103 (51) = happyShift action_24
action_103 (52) = happyShift action_25
action_103 (54) = happyShift action_26
action_103 (55) = happyShift action_27
action_103 (56) = happyShift action_28
action_103 (57) = happyShift action_29
action_103 (58) = happyShift action_30
action_103 (62) = happyShift action_31
action_103 (66) = happyShift action_32
action_103 (14) = happyGoto action_132
action_103 (30) = happyGoto action_47
action_103 (33) = happyGoto action_13
action_103 (35) = happyGoto action_14
action_103 (36) = happyGoto action_15
action_103 (37) = happyGoto action_16
action_103 (38) = happyGoto action_17
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (45) = happyShift action_18
action_104 (46) = happyShift action_19
action_104 (47) = happyShift action_20
action_104 (48) = happyShift action_21
action_104 (49) = happyShift action_22
action_104 (50) = happyShift action_23
action_104 (51) = happyShift action_24
action_104 (52) = happyShift action_25
action_104 (54) = happyShift action_26
action_104 (55) = happyShift action_27
action_104 (56) = happyShift action_28
action_104 (57) = happyShift action_29
action_104 (58) = happyShift action_30
action_104 (62) = happyShift action_31
action_104 (66) = happyShift action_32
action_104 (14) = happyGoto action_131
action_104 (30) = happyGoto action_47
action_104 (33) = happyGoto action_13
action_104 (35) = happyGoto action_14
action_104 (36) = happyGoto action_15
action_104 (37) = happyGoto action_16
action_104 (38) = happyGoto action_17
action_104 _ = happyFail (happyExpListPerState 104)

action_105 _ = happyReduce_93

action_106 _ = happyReduce_13

action_107 _ = happyReduce_12

action_108 (45) = happyShift action_18
action_108 (46) = happyShift action_19
action_108 (47) = happyShift action_20
action_108 (48) = happyShift action_21
action_108 (49) = happyShift action_22
action_108 (50) = happyShift action_23
action_108 (51) = happyShift action_24
action_108 (52) = happyShift action_25
action_108 (54) = happyShift action_26
action_108 (55) = happyShift action_27
action_108 (56) = happyShift action_28
action_108 (57) = happyShift action_29
action_108 (58) = happyShift action_30
action_108 (62) = happyShift action_31
action_108 (66) = happyShift action_32
action_108 (30) = happyGoto action_130
action_108 (33) = happyGoto action_13
action_108 (35) = happyGoto action_14
action_108 (36) = happyGoto action_15
action_108 (37) = happyGoto action_16
action_108 (38) = happyGoto action_17
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (45) = happyShift action_18
action_109 (46) = happyShift action_19
action_109 (47) = happyShift action_20
action_109 (48) = happyShift action_21
action_109 (49) = happyShift action_22
action_109 (50) = happyShift action_23
action_109 (51) = happyShift action_24
action_109 (52) = happyShift action_25
action_109 (54) = happyShift action_26
action_109 (55) = happyShift action_27
action_109 (56) = happyShift action_28
action_109 (57) = happyShift action_29
action_109 (58) = happyShift action_30
action_109 (62) = happyShift action_31
action_109 (66) = happyShift action_32
action_109 (30) = happyGoto action_129
action_109 (33) = happyGoto action_13
action_109 (35) = happyGoto action_14
action_109 (36) = happyGoto action_15
action_109 (37) = happyGoto action_16
action_109 (38) = happyGoto action_17
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (45) = happyShift action_18
action_110 (46) = happyShift action_19
action_110 (47) = happyShift action_20
action_110 (48) = happyShift action_21
action_110 (49) = happyShift action_22
action_110 (50) = happyShift action_23
action_110 (51) = happyShift action_24
action_110 (52) = happyShift action_25
action_110 (54) = happyShift action_26
action_110 (55) = happyShift action_27
action_110 (56) = happyShift action_28
action_110 (57) = happyShift action_29
action_110 (58) = happyShift action_30
action_110 (62) = happyShift action_31
action_110 (66) = happyShift action_32
action_110 (30) = happyGoto action_128
action_110 (33) = happyGoto action_13
action_110 (35) = happyGoto action_14
action_110 (36) = happyGoto action_15
action_110 (37) = happyGoto action_16
action_110 (38) = happyGoto action_17
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (52) = happyShift action_115
action_111 (53) = happyShift action_116
action_111 (54) = happyShift action_117
action_111 (9) = happyGoto action_111
action_111 (10) = happyGoto action_127
action_111 _ = happyReduce_22

action_112 (69) = happyShift action_126
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (68) = happyShift action_125
action_113 _ = happyReduce_25

action_114 (63) = happyShift action_124
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_19

action_116 _ = happyReduce_20

action_117 _ = happyReduce_21

action_118 (54) = happyShift action_123
action_118 (7) = happyGoto action_121
action_118 (8) = happyGoto action_122
action_118 _ = happyReduce_16

action_119 (45) = happyShift action_18
action_119 (46) = happyShift action_19
action_119 (47) = happyShift action_20
action_119 (48) = happyShift action_21
action_119 (49) = happyShift action_22
action_119 (50) = happyShift action_23
action_119 (51) = happyShift action_24
action_119 (52) = happyShift action_25
action_119 (54) = happyShift action_26
action_119 (55) = happyShift action_27
action_119 (56) = happyShift action_28
action_119 (57) = happyShift action_29
action_119 (58) = happyShift action_30
action_119 (62) = happyShift action_31
action_119 (66) = happyShift action_32
action_119 (30) = happyGoto action_120
action_119 (33) = happyGoto action_13
action_119 (35) = happyGoto action_14
action_119 (36) = happyGoto action_15
action_119 (37) = happyGoto action_16
action_119 (38) = happyGoto action_17
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (64) = happyShift action_181
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (70) = happyShift action_180
action_121 _ = happyReduce_17

action_122 (65) = happyShift action_179
action_122 _ = happyFail (happyExpListPerState 122)

action_123 (62) = happyShift action_41
action_123 (13) = happyGoto action_178
action_123 _ = happyReduce_27

action_124 _ = happyReduce_28

action_125 (52) = happyShift action_115
action_125 (53) = happyShift action_116
action_125 (54) = happyShift action_117
action_125 (9) = happyGoto action_111
action_125 (10) = happyGoto action_112
action_125 (11) = happyGoto action_113
action_125 (12) = happyGoto action_177
action_125 _ = happyFail (happyExpListPerState 125)

action_126 (45) = happyShift action_18
action_126 (46) = happyShift action_19
action_126 (47) = happyShift action_20
action_126 (48) = happyShift action_21
action_126 (49) = happyShift action_22
action_126 (50) = happyShift action_23
action_126 (51) = happyShift action_24
action_126 (52) = happyShift action_25
action_126 (54) = happyShift action_26
action_126 (55) = happyShift action_27
action_126 (56) = happyShift action_28
action_126 (57) = happyShift action_29
action_126 (58) = happyShift action_30
action_126 (62) = happyShift action_31
action_126 (66) = happyShift action_32
action_126 (30) = happyGoto action_176
action_126 (33) = happyGoto action_13
action_126 (35) = happyGoto action_14
action_126 (36) = happyGoto action_15
action_126 (37) = happyGoto action_16
action_126 (38) = happyGoto action_17
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_23

action_128 _ = happyReduce_7

action_129 (59) = happyShift action_175
action_129 _ = happyFail (happyExpListPerState 129)

action_130 _ = happyReduce_8

action_131 _ = happyReduce_30

action_132 (63) = happyShift action_174
action_132 _ = happyFail (happyExpListPerState 132)

action_133 (65) = happyShift action_173
action_133 _ = happyFail (happyExpListPerState 133)

action_134 _ = happyReduce_71

action_135 (45) = happyShift action_18
action_135 (46) = happyShift action_19
action_135 (47) = happyShift action_20
action_135 (48) = happyShift action_21
action_135 (49) = happyShift action_22
action_135 (50) = happyShift action_23
action_135 (51) = happyShift action_24
action_135 (52) = happyShift action_25
action_135 (54) = happyShift action_26
action_135 (55) = happyShift action_27
action_135 (56) = happyShift action_28
action_135 (57) = happyShift action_29
action_135 (58) = happyShift action_30
action_135 (62) = happyShift action_31
action_135 (66) = happyShift action_32
action_135 (30) = happyGoto action_172
action_135 (33) = happyGoto action_13
action_135 (35) = happyGoto action_14
action_135 (36) = happyGoto action_15
action_135 (37) = happyGoto action_16
action_135 (38) = happyGoto action_17
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (67) = happyShift action_171
action_136 _ = happyFail (happyExpListPerState 136)

action_137 _ = happyReduce_53

action_138 (63) = happyShift action_170
action_138 _ = happyFail (happyExpListPerState 138)

action_139 (68) = happyShift action_169
action_139 _ = happyFail (happyExpListPerState 139)

action_140 _ = happyReduce_73

action_141 (49) = happyShift action_22
action_141 (51) = happyShift action_24
action_141 (52) = happyShift action_92
action_141 (54) = happyShift action_93
action_141 (56) = happyShift action_94
action_141 (58) = happyShift action_95
action_141 (62) = happyShift action_96
action_141 (66) = happyShift action_97
action_141 (20) = happyGoto action_84
action_141 (24) = happyGoto action_85
action_141 (26) = happyGoto action_86
action_141 (27) = happyGoto action_87
action_141 (28) = happyGoto action_88
action_141 (29) = happyGoto action_168
action_141 (36) = happyGoto action_90
action_141 (38) = happyGoto action_91
action_141 _ = happyReduce_65

action_142 (45) = happyShift action_18
action_142 (46) = happyShift action_19
action_142 (47) = happyShift action_20
action_142 (48) = happyShift action_21
action_142 (49) = happyShift action_22
action_142 (50) = happyShift action_23
action_142 (51) = happyShift action_24
action_142 (52) = happyShift action_25
action_142 (54) = happyShift action_26
action_142 (55) = happyShift action_27
action_142 (56) = happyShift action_28
action_142 (57) = happyShift action_29
action_142 (58) = happyShift action_30
action_142 (62) = happyShift action_31
action_142 (66) = happyShift action_32
action_142 (30) = happyGoto action_167
action_142 (33) = happyGoto action_13
action_142 (35) = happyGoto action_14
action_142 (36) = happyGoto action_15
action_142 (37) = happyGoto action_16
action_142 (38) = happyGoto action_17
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (49) = happyShift action_22
action_143 (51) = happyShift action_24
action_143 (52) = happyShift action_92
action_143 (54) = happyShift action_93
action_143 (56) = happyShift action_94
action_143 (58) = happyShift action_95
action_143 (62) = happyShift action_96
action_143 (66) = happyShift action_97
action_143 (20) = happyGoto action_84
action_143 (24) = happyGoto action_85
action_143 (26) = happyGoto action_86
action_143 (27) = happyGoto action_166
action_143 (36) = happyGoto action_90
action_143 (38) = happyGoto action_91
action_143 _ = happyFail (happyExpListPerState 143)

action_144 _ = happyReduce_50

action_145 (49) = happyShift action_22
action_145 (51) = happyShift action_24
action_145 (52) = happyShift action_92
action_145 (54) = happyShift action_93
action_145 (56) = happyShift action_94
action_145 (58) = happyShift action_95
action_145 (62) = happyShift action_149
action_145 (66) = happyShift action_97
action_145 (20) = happyGoto action_144
action_145 (21) = happyGoto action_145
action_145 (22) = happyGoto action_165
action_145 (24) = happyGoto action_147
action_145 (25) = happyGoto action_148
action_145 (36) = happyGoto action_90
action_145 (38) = happyGoto action_91
action_145 _ = happyReduce_46

action_146 _ = happyReduce_61

action_147 _ = happyReduce_58

action_148 _ = happyReduce_43

action_149 (49) = happyShift action_22
action_149 (51) = happyShift action_24
action_149 (52) = happyShift action_163
action_149 (54) = happyShift action_164
action_149 (56) = happyShift action_94
action_149 (58) = happyShift action_95
action_149 (62) = happyShift action_96
action_149 (66) = happyShift action_97
action_149 (15) = happyGoto action_161
action_149 (20) = happyGoto action_162
action_149 (23) = happyGoto action_138
action_149 (24) = happyGoto action_85
action_149 (26) = happyGoto action_139
action_149 (36) = happyGoto action_90
action_149 (38) = happyGoto action_91
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (68) = happyShift action_160
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (65) = happyShift action_159
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (68) = happyShift action_158
action_152 _ = happyFail (happyExpListPerState 152)

action_153 _ = happyReduce_84

action_154 (45) = happyShift action_18
action_154 (46) = happyShift action_19
action_154 (47) = happyShift action_20
action_154 (48) = happyShift action_21
action_154 (49) = happyShift action_22
action_154 (50) = happyShift action_23
action_154 (51) = happyShift action_24
action_154 (52) = happyShift action_78
action_154 (54) = happyShift action_79
action_154 (55) = happyShift action_27
action_154 (56) = happyShift action_28
action_154 (57) = happyShift action_29
action_154 (58) = happyShift action_30
action_154 (62) = happyShift action_31
action_154 (66) = happyShift action_32
action_154 (15) = happyGoto action_74
action_154 (30) = happyGoto action_75
action_154 (31) = happyGoto action_76
action_154 (32) = happyGoto action_157
action_154 (33) = happyGoto action_13
action_154 (35) = happyGoto action_14
action_154 (36) = happyGoto action_15
action_154 (37) = happyGoto action_16
action_154 (38) = happyGoto action_17
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (45) = happyShift action_18
action_155 (46) = happyShift action_19
action_155 (47) = happyShift action_20
action_155 (48) = happyShift action_21
action_155 (49) = happyShift action_22
action_155 (50) = happyShift action_23
action_155 (51) = happyShift action_24
action_155 (52) = happyShift action_25
action_155 (54) = happyShift action_26
action_155 (55) = happyShift action_27
action_155 (56) = happyShift action_28
action_155 (57) = happyShift action_29
action_155 (58) = happyShift action_30
action_155 (62) = happyShift action_31
action_155 (66) = happyShift action_32
action_155 (30) = happyGoto action_156
action_155 (33) = happyGoto action_13
action_155 (35) = happyGoto action_14
action_155 (36) = happyGoto action_15
action_155 (37) = happyGoto action_16
action_155 (38) = happyGoto action_17
action_155 _ = happyFail (happyExpListPerState 155)

action_156 _ = happyReduce_76

action_157 _ = happyReduce_78

action_158 (45) = happyShift action_18
action_158 (46) = happyShift action_19
action_158 (47) = happyShift action_20
action_158 (48) = happyShift action_21
action_158 (49) = happyShift action_22
action_158 (50) = happyShift action_23
action_158 (51) = happyShift action_24
action_158 (52) = happyShift action_25
action_158 (54) = happyShift action_26
action_158 (55) = happyShift action_27
action_158 (56) = happyShift action_28
action_158 (57) = happyShift action_29
action_158 (58) = happyShift action_30
action_158 (62) = happyShift action_31
action_158 (66) = happyShift action_32
action_158 (30) = happyGoto action_193
action_158 (33) = happyGoto action_13
action_158 (35) = happyGoto action_14
action_158 (36) = happyGoto action_15
action_158 (37) = happyGoto action_16
action_158 (38) = happyGoto action_17
action_158 _ = happyFail (happyExpListPerState 158)

action_159 _ = happyReduce_70

action_160 (45) = happyShift action_18
action_160 (46) = happyShift action_19
action_160 (47) = happyShift action_20
action_160 (48) = happyShift action_21
action_160 (49) = happyShift action_22
action_160 (50) = happyShift action_23
action_160 (51) = happyShift action_24
action_160 (52) = happyShift action_25
action_160 (54) = happyShift action_26
action_160 (55) = happyShift action_27
action_160 (56) = happyShift action_28
action_160 (57) = happyShift action_29
action_160 (58) = happyShift action_30
action_160 (62) = happyShift action_31
action_160 (66) = happyShift action_32
action_160 (30) = happyGoto action_192
action_160 (33) = happyGoto action_13
action_160 (35) = happyGoto action_14
action_160 (36) = happyGoto action_15
action_160 (37) = happyGoto action_16
action_160 (38) = happyGoto action_17
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (59) = happyShift action_191
action_161 _ = happyFail (happyExpListPerState 161)

action_162 (49) = happyShift action_22
action_162 (51) = happyShift action_24
action_162 (52) = happyShift action_92
action_162 (54) = happyShift action_93
action_162 (56) = happyShift action_94
action_162 (58) = happyShift action_95
action_162 (62) = happyShift action_149
action_162 (66) = happyShift action_97
action_162 (20) = happyGoto action_144
action_162 (21) = happyGoto action_145
action_162 (22) = happyGoto action_190
action_162 (24) = happyGoto action_147
action_162 (25) = happyGoto action_148
action_162 (36) = happyGoto action_90
action_162 (38) = happyGoto action_91
action_162 _ = happyReduce_50

action_163 (63) = happyShift action_189
action_163 (68) = happyReduce_51
action_163 _ = happyReduce_31

action_164 (59) = happyReduce_32
action_164 _ = happyReduce_41

action_165 _ = happyReduce_47

action_166 _ = happyReduce_63

action_167 _ = happyReduce_64

action_168 _ = happyReduce_67

action_169 (49) = happyShift action_22
action_169 (51) = happyShift action_24
action_169 (52) = happyShift action_92
action_169 (54) = happyShift action_93
action_169 (56) = happyShift action_94
action_169 (58) = happyShift action_95
action_169 (62) = happyShift action_96
action_169 (66) = happyShift action_97
action_169 (20) = happyGoto action_84
action_169 (23) = happyGoto action_187
action_169 (24) = happyGoto action_85
action_169 (26) = happyGoto action_188
action_169 (36) = happyGoto action_90
action_169 (38) = happyGoto action_91
action_169 _ = happyFail (happyExpListPerState 169)

action_170 _ = happyReduce_52

action_171 _ = happyReduce_54

action_172 (63) = happyShift action_186
action_172 _ = happyFail (happyExpListPerState 172)

action_173 _ = happyReduce_72

action_174 _ = happyReduce_92

action_175 (45) = happyShift action_18
action_175 (46) = happyShift action_19
action_175 (47) = happyShift action_20
action_175 (48) = happyShift action_21
action_175 (49) = happyShift action_22
action_175 (50) = happyShift action_23
action_175 (51) = happyShift action_24
action_175 (52) = happyShift action_25
action_175 (54) = happyShift action_26
action_175 (55) = happyShift action_27
action_175 (56) = happyShift action_28
action_175 (57) = happyShift action_29
action_175 (58) = happyShift action_30
action_175 (62) = happyShift action_31
action_175 (66) = happyShift action_32
action_175 (30) = happyGoto action_185
action_175 (33) = happyGoto action_13
action_175 (35) = happyGoto action_14
action_175 (36) = happyGoto action_15
action_175 (37) = happyGoto action_16
action_175 (38) = happyGoto action_17
action_175 _ = happyFail (happyExpListPerState 175)

action_176 _ = happyReduce_24

action_177 _ = happyReduce_26

action_178 (69) = happyShift action_184
action_178 _ = happyReduce_14

action_179 _ = happyReduce_5

action_180 (54) = happyShift action_123
action_180 (7) = happyGoto action_121
action_180 (8) = happyGoto action_183
action_180 _ = happyReduce_16

action_181 (54) = happyShift action_123
action_181 (7) = happyGoto action_121
action_181 (8) = happyGoto action_182
action_181 _ = happyReduce_16

action_182 (65) = happyShift action_198
action_182 _ = happyFail (happyExpListPerState 182)

action_183 _ = happyReduce_18

action_184 (45) = happyShift action_18
action_184 (46) = happyShift action_19
action_184 (47) = happyShift action_20
action_184 (48) = happyShift action_21
action_184 (49) = happyShift action_22
action_184 (50) = happyShift action_23
action_184 (51) = happyShift action_24
action_184 (52) = happyShift action_25
action_184 (54) = happyShift action_26
action_184 (55) = happyShift action_27
action_184 (56) = happyShift action_28
action_184 (57) = happyShift action_29
action_184 (58) = happyShift action_30
action_184 (62) = happyShift action_31
action_184 (66) = happyShift action_32
action_184 (30) = happyGoto action_197
action_184 (33) = happyGoto action_13
action_184 (35) = happyGoto action_14
action_184 (36) = happyGoto action_15
action_184 (37) = happyGoto action_16
action_184 (38) = happyGoto action_17
action_184 _ = happyFail (happyExpListPerState 184)

action_185 _ = happyReduce_9

action_186 _ = happyReduce_38

action_187 _ = happyReduce_49

action_188 (68) = happyShift action_169
action_188 _ = happyReduce_48

action_189 _ = happyReduce_45

action_190 (63) = happyShift action_196
action_190 _ = happyReduce_61

action_191 (49) = happyShift action_22
action_191 (51) = happyShift action_24
action_191 (52) = happyShift action_92
action_191 (54) = happyShift action_93
action_191 (56) = happyShift action_94
action_191 (58) = happyShift action_95
action_191 (62) = happyShift action_195
action_191 (66) = happyShift action_97
action_191 (20) = happyGoto action_144
action_191 (24) = happyGoto action_147
action_191 (25) = happyGoto action_194
action_191 (36) = happyGoto action_90
action_191 (38) = happyGoto action_91
action_191 _ = happyFail (happyExpListPerState 191)

action_192 _ = happyReduce_69

action_193 _ = happyReduce_68

action_194 (63) = happyShift action_199
action_194 _ = happyFail (happyExpListPerState 194)

action_195 (49) = happyShift action_22
action_195 (51) = happyShift action_24
action_195 (52) = happyShift action_92
action_195 (54) = happyShift action_93
action_195 (56) = happyShift action_94
action_195 (58) = happyShift action_95
action_195 (62) = happyShift action_96
action_195 (66) = happyShift action_97
action_195 (20) = happyGoto action_162
action_195 (23) = happyGoto action_138
action_195 (24) = happyGoto action_85
action_195 (26) = happyGoto action_139
action_195 (36) = happyGoto action_90
action_195 (38) = happyGoto action_91
action_195 _ = happyFail (happyExpListPerState 195)

action_196 _ = happyReduce_59

action_197 _ = happyReduce_15

action_198 _ = happyReduce_6

action_199 _ = happyReduce_44

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
happyReduction_24 (HappyAbsSyn30  happy_var_3)
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
happyReduction_29 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  14 happyReduction_30
happyReduction_30 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
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
	(HappyAbsSyn30  happy_var_4) `HappyStk`
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

happyReduce_44 = happyReduce 5 21 happyReduction_44
happyReduction_44 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (Left (P.Implicit happy_var_2 happy_var_4)
	) `HappyStk` happyRest

happyReduce_45 = happySpecReduce_3  21 happyReduction_45
happyReduction_45 _
	(HappyTerminal (TokenLSym happy_var_2))
	_
	 =  HappyAbsSyn21
		 (Left (P.PunnedImplicit happy_var_2)
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  22 happyReduction_46
happyReduction_46 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| []
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  22 happyReduction_47
happyReduction_47 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  23 happyReduction_48
happyReduction_48 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 ([happy_var_1, happy_var_3]
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  23 happyReduction_49
happyReduction_49 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1 : happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  24 happyReduction_50
happyReduction_50 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Data happy_var_1 []
	)
happyReduction_50 _  = notHappyAtAll 

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
	(HappyAbsSyn27  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.List happy_var_2
	)
happyReduction_54 _ _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  24 happyReduction_55
happyReduction_55 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  24 happyReduction_56
happyReduction_56 (HappyAbsSyn36  happy_var_1)
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
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_58 _  = notHappyAtAll 

happyReduce_59 = happyReduce 4 25 happyReduction_59
happyReduction_59 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_60 = happySpecReduce_1  26 happyReduction_60
happyReduction_60 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_2  26 happyReduction_61
happyReduction_61 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_61 _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  27 happyReduction_62
happyReduction_62 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  27 happyReduction_63
happyReduction_63 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  28 happyReduction_64
happyReduction_64 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 ((happy_var_1, happy_var_3)
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_0  29 happyReduction_65
happyReduction_65  =  HappyAbsSyn29
		 ([]
	)

happyReduce_66 = happySpecReduce_1  29 happyReduction_66
happyReduction_66 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 ([happy_var_1]
	)
happyReduction_66 _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_3  29 happyReduction_67
happyReduction_67 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1 : happy_var_3
	)
happyReduction_67 _ _ _  = notHappyAtAll 

happyReduce_68 = happyReduce 6 30 happyReduction_68
happyReduction_68 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 6 30 happyReduction_69
happyReduction_69 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (ForAll happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 5 30 happyReduction_70
happyReduction_70 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 4 30 happyReduction_71
happyReduction_71 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_72 = happyReduce 5 30 happyReduction_72
happyReduction_72 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_73 = happyReduce 4 30 happyReduction_73
happyReduction_73 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_74 = happySpecReduce_1  30 happyReduction_74
happyReduction_74 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  31 happyReduction_75
happyReduction_75 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn31
		 ((Nothing, happy_var_1)
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_3  31 happyReduction_76
happyReduction_76 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn31
		 ((Just happy_var_1, happy_var_3)
	)
happyReduction_76 _ _ _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  32 happyReduction_77
happyReduction_77 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1 :| []
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  32 happyReduction_78
happyReduction_78 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_3  33 happyReduction_79
happyReduction_79 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_3  33 happyReduction_80
happyReduction_80 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenLSym happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (QName [] happy_var_2) happy_var_3
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_3  33 happyReduction_81
happyReduction_81 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenUSym happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (QName [] happy_var_2) happy_var_3
	)
happyReduction_81 _ _ _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  33 happyReduction_82
happyReduction_82 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenLSymQ happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (uncurry QName happy_var_2) happy_var_3
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_3  33 happyReduction_83
happyReduction_83 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenUSymQ happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (uncurry QName happy_var_2) happy_var_3
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happyReduce 4 33 happyReduction_84
happyReduction_84 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Application happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_85 = happySpecReduce_1  33 happyReduction_85
happyReduction_85 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  34 happyReduction_86
happyReduction_86 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  34 happyReduction_87
happyReduction_87 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  34 happyReduction_88
happyReduction_88 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_1  34 happyReduction_89
happyReduction_89 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_89 _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_3  35 happyReduction_90
happyReduction_90 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (Parenthesized happy_var_2
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_2  35 happyReduction_91
happyReduction_91 _
	_
	 =  HappyAbsSyn30
		 (Literal UnitLiteral
	)

happyReduce_92 = happyReduce 5 35 happyReduction_92
happyReduction_92 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_93 = happySpecReduce_3  35 happyReduction_93
happyReduction_93 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (List happy_var_2
	)
happyReduction_93 _ _ _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_1  35 happyReduction_94
happyReduction_94 _
	 =  HappyAbsSyn30
		 (Meta
	)

happyReduce_95 = happySpecReduce_1  35 happyReduction_95
happyReduction_95 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  35 happyReduction_96
happyReduction_96 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  35 happyReduction_97
happyReduction_97 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  35 happyReduction_98
happyReduction_98 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_1  35 happyReduction_99
happyReduction_99 _
	 =  HappyAbsSyn30
		 (Type
	)

happyReduce_100 = happySpecReduce_1  35 happyReduction_100
happyReduction_100 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  35 happyReduction_101
happyReduction_101 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_1  35 happyReduction_102
happyReduction_102 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  36 happyReduction_103
happyReduction_103 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn36
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  37 happyReduction_104
happyReduction_104 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn36
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_1  38 happyReduction_105
happyReduction_105 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn36
		 (StringLiteral happy_var_1
	)
happyReduction_105 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 71 71 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenDatatype -> cont 39;
	TokenDeclare -> cont 40;
	TokenDefine -> cont 41;
	TokenCheck -> cont 42;
	TokenEval -> cont 43;
	TokenTypeOf -> cont 44;
	TokenType -> cont 45;
	TokenLet -> cont 46;
	TokenCase -> cont 47;
	TokenForAll -> cont 48;
	TokenInt happy_dollar_dollar -> cont 49;
	TokenFloat happy_dollar_dollar -> cont 50;
	TokenString happy_dollar_dollar -> cont 51;
	TokenLSym happy_dollar_dollar -> cont 52;
	TokenQLSym happy_dollar_dollar -> cont 53;
	TokenUSym happy_dollar_dollar -> cont 54;
	TokenLSymQ happy_dollar_dollar -> cont 55;
	TokenUSymQ happy_dollar_dollar -> cont 56;
	TokenBackslash -> cont 57;
	TokenUnderscore -> cont 58;
	TokenEq -> cont 59;
	TokenArrow -> cont 60;
	TokenInfixOp happy_dollar_dollar -> cont 61;
	TokenLParen -> cont 62;
	TokenRParen -> cont 63;
	TokenLBrace -> cont 64;
	TokenRBrace -> cont 65;
	TokenLBracket -> cont 66;
	TokenRBracket -> cont 67;
	TokenComma -> cont 68;
	TokenColon -> cont 69;
	TokenSemicolon -> cont 70;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 71 tk tks = happyError' (tks, explist)
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
