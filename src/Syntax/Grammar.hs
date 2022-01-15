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
happyExpList = Happy_Data_Array.listArray (0,546) ([0,0,112,0,0,0,448,0,0,0,0,0,0,0,0,64,0,0,0,320,0,0,0,1280,0,0,0,0,0,0,0,28,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,4,0,0,0,2112,0,0,12288,0,0,0,0,32768,0,0,0,128,2,0,63488,4343,1,0,57344,17375,4,0,32768,3967,17,0,0,768,0,0,0,0,2048,0,0,0,4096,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,64,0,0,32768,3967,17,0,0,0,16,0,0,0,12,0,0,56864,1089,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,63480,272,0,0,4096,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,324,0,0,32640,4879,0,0,65024,17469,0,0,0,0,16,0,0,0,2,0,0,0,1,0,0,0,0,0,0,3072,0,0,0,57312,1091,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,32768,3967,17,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,4,0,0,0,0,2,0,0,0,16,0,0,0,66,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16384,272,0,0,0,4352,0,0,0,0,0,0,0,0,0,0,0,4160,0,0,0,21920,68,0,0,1024,1,0,0,0,8192,0,0,0,1024,0,0,0,128,0,0,0,0,0,0,57344,50143,4,0,32768,1912,17,0,0,7650,68,0,0,4096,0,0,0,0,512,0,0,0,128,0,0,0,768,0,0,0,512,0,0,0,0,0,0,32768,3967,17,0,0,21920,68,0,0,63480,272,0,0,0,0,0,0,26624,4373,0,0,0,0,0,0,0,0,4,0,0,4096,0,0,0,0,256,0,0,0,32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5480,17,0,0,21920,196,0,0,0,2048,0,0,56864,1089,0,0,26624,4373,0,0,0,0,0,0,0,0,0,0,57344,17375,4,0,32768,3967,17,0,0,0,0,0,0,0,0,0,0,57312,1091,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,8,0,0,0,0,0,0,63480,272,0,0,0,2048,0,0,0,0,0,0,0,2048,0,0,0,0,4,0,0,0,0,0,0,5480,17,0,0,15870,68,0,0,22144,273,0,0,0,0,0,0,26624,4373,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5480,17,0,0,0,256,0,0,0,128,0,0,0,4096,0,0,32640,4367,0,0,0,0,0,0,0,8192,0,0,57344,17375,4,0,0,0,0,0,0,15870,68,0,0,0,2,0,0,23040,1093,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21920,68,0,0,0,0,0,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,128,0,0,26624,4373,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,21920,68,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Name","Statement","Variant","Variants","ArgumentName","ArgumentNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","BinaryExpression","Juxtaposition","Atom","IntegerLiteral","FloatLiteral","StringLiteral","data","decl","def","type","let","case","forall","int","float","string","lsym","qlsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 66
        bit_end = (st Prelude.+ 1) Prelude.* 66
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..65]
        token_strs_expected = Prelude.concatMap f bits_indexed
        f (Prelude.False, _) = []
        f (Prelude.True, nr) = [token_strs Prelude.!! nr]

action_0 (37) = happyShift action_3
action_0 (38) = happyShift action_4
action_0 (39) = happyShift action_5
action_0 (4) = happyGoto action_6
action_0 (6) = happyGoto action_7
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (37) = happyShift action_3
action_1 (38) = happyShift action_4
action_1 (39) = happyShift action_5
action_1 (6) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyFail (happyExpListPerState 2)

action_3 (49) = happyShift action_13
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (47) = happyShift action_10
action_4 (49) = happyShift action_11
action_4 (5) = happyGoto action_12
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (47) = happyShift action_10
action_5 (49) = happyShift action_11
action_5 (5) = happyGoto action_9
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (66) = happyAccept
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (37) = happyShift action_3
action_7 (38) = happyShift action_4
action_7 (39) = happyShift action_5
action_7 (4) = happyGoto action_8
action_7 (6) = happyGoto action_7
action_7 _ = happyReduce_1

action_8 _ = happyReduce_2

action_9 (57) = happyShift action_15
action_9 (13) = happyGoto action_17
action_9 _ = happyReduce_22

action_10 _ = happyReduce_4

action_11 _ = happyReduce_3

action_12 (57) = happyShift action_15
action_12 (13) = happyGoto action_16
action_12 _ = happyReduce_22

action_13 (57) = happyShift action_15
action_13 (13) = happyGoto action_14
action_13 _ = happyReduce_22

action_14 (59) = happyShift action_27
action_14 (64) = happyShift action_28
action_14 _ = happyFail (happyExpListPerState 14)

action_15 (47) = happyShift action_25
action_15 (48) = happyShift action_26
action_15 (9) = happyGoto action_21
action_15 (10) = happyGoto action_22
action_15 (11) = happyGoto action_23
action_15 (12) = happyGoto action_24
action_15 _ = happyFail (happyExpListPerState 15)

action_16 (64) = happyShift action_20
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (54) = happyShift action_18
action_17 (64) = happyShift action_19
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (40) = happyShift action_36
action_18 (41) = happyShift action_37
action_18 (42) = happyShift action_38
action_18 (43) = happyShift action_39
action_18 (44) = happyShift action_40
action_18 (45) = happyShift action_41
action_18 (46) = happyShift action_42
action_18 (47) = happyShift action_43
action_18 (49) = happyShift action_44
action_18 (50) = happyShift action_45
action_18 (51) = happyShift action_46
action_18 (52) = happyShift action_47
action_18 (57) = happyShift action_48
action_18 (61) = happyShift action_49
action_18 (30) = happyGoto action_59
action_18 (31) = happyGoto action_30
action_18 (32) = happyGoto action_31
action_18 (33) = happyGoto action_32
action_18 (34) = happyGoto action_33
action_18 (35) = happyGoto action_34
action_18 (36) = happyGoto action_35
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (40) = happyShift action_36
action_19 (41) = happyShift action_37
action_19 (42) = happyShift action_38
action_19 (43) = happyShift action_39
action_19 (44) = happyShift action_40
action_19 (45) = happyShift action_41
action_19 (46) = happyShift action_42
action_19 (47) = happyShift action_43
action_19 (49) = happyShift action_44
action_19 (50) = happyShift action_45
action_19 (51) = happyShift action_46
action_19 (52) = happyShift action_47
action_19 (57) = happyShift action_48
action_19 (61) = happyShift action_49
action_19 (30) = happyGoto action_58
action_19 (31) = happyGoto action_30
action_19 (32) = happyGoto action_31
action_19 (33) = happyGoto action_32
action_19 (34) = happyGoto action_33
action_19 (35) = happyGoto action_34
action_19 (36) = happyGoto action_35
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (40) = happyShift action_36
action_20 (41) = happyShift action_37
action_20 (42) = happyShift action_38
action_20 (43) = happyShift action_39
action_20 (44) = happyShift action_40
action_20 (45) = happyShift action_41
action_20 (46) = happyShift action_42
action_20 (47) = happyShift action_43
action_20 (49) = happyShift action_44
action_20 (50) = happyShift action_45
action_20 (51) = happyShift action_46
action_20 (52) = happyShift action_47
action_20 (57) = happyShift action_48
action_20 (61) = happyShift action_49
action_20 (30) = happyGoto action_57
action_20 (31) = happyGoto action_30
action_20 (32) = happyGoto action_31
action_20 (33) = happyGoto action_32
action_20 (34) = happyGoto action_33
action_20 (35) = happyGoto action_34
action_20 (36) = happyGoto action_35
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (47) = happyShift action_25
action_21 (48) = happyShift action_26
action_21 (9) = happyGoto action_21
action_21 (10) = happyGoto action_56
action_21 _ = happyReduce_17

action_22 (64) = happyShift action_55
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (63) = happyShift action_54
action_23 _ = happyReduce_20

action_24 (58) = happyShift action_53
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_15

action_26 _ = happyReduce_16

action_27 (49) = happyShift action_52
action_27 (7) = happyGoto action_50
action_27 (8) = happyGoto action_51
action_27 _ = happyReduce_12

action_28 (40) = happyShift action_36
action_28 (41) = happyShift action_37
action_28 (42) = happyShift action_38
action_28 (43) = happyShift action_39
action_28 (44) = happyShift action_40
action_28 (45) = happyShift action_41
action_28 (46) = happyShift action_42
action_28 (47) = happyShift action_43
action_28 (49) = happyShift action_44
action_28 (50) = happyShift action_45
action_28 (51) = happyShift action_46
action_28 (52) = happyShift action_47
action_28 (57) = happyShift action_48
action_28 (61) = happyShift action_49
action_28 (30) = happyGoto action_29
action_28 (31) = happyGoto action_30
action_28 (32) = happyGoto action_31
action_28 (33) = happyGoto action_32
action_28 (34) = happyGoto action_33
action_28 (35) = happyGoto action_34
action_28 (36) = happyGoto action_35
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (59) = happyShift action_86
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (55) = happyShift action_84
action_30 (56) = happyShift action_85
action_30 _ = happyReduce_68

action_31 (40) = happyShift action_36
action_31 (44) = happyShift action_40
action_31 (45) = happyShift action_41
action_31 (46) = happyShift action_42
action_31 (47) = happyShift action_43
action_31 (49) = happyShift action_44
action_31 (50) = happyShift action_45
action_31 (51) = happyShift action_46
action_31 (57) = happyShift action_83
action_31 (61) = happyShift action_49
action_31 (33) = happyGoto action_82
action_31 (34) = happyGoto action_33
action_31 (35) = happyGoto action_34
action_31 (36) = happyGoto action_35
action_31 _ = happyReduce_71

action_32 _ = happyReduce_74

action_33 _ = happyReduce_84

action_34 _ = happyReduce_85

action_35 _ = happyReduce_86

action_36 _ = happyReduce_83

action_37 (47) = happyShift action_81
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (40) = happyShift action_36
action_38 (41) = happyShift action_37
action_38 (42) = happyShift action_38
action_38 (43) = happyShift action_39
action_38 (44) = happyShift action_40
action_38 (45) = happyShift action_41
action_38 (46) = happyShift action_42
action_38 (47) = happyShift action_43
action_38 (49) = happyShift action_44
action_38 (50) = happyShift action_45
action_38 (51) = happyShift action_46
action_38 (52) = happyShift action_47
action_38 (57) = happyShift action_48
action_38 (61) = happyShift action_49
action_38 (14) = happyGoto action_80
action_38 (30) = happyGoto action_67
action_38 (31) = happyGoto action_30
action_38 (32) = happyGoto action_31
action_38 (33) = happyGoto action_32
action_38 (34) = happyGoto action_33
action_38 (35) = happyGoto action_34
action_38 (36) = happyGoto action_35
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (47) = happyShift action_74
action_39 (53) = happyShift action_75
action_39 (15) = happyGoto action_70
action_39 (16) = happyGoto action_78
action_39 (17) = happyGoto action_79
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_87

action_41 _ = happyReduce_88

action_42 _ = happyReduce_89

action_43 _ = happyReduce_79

action_44 _ = happyReduce_80

action_45 _ = happyReduce_81

action_46 _ = happyReduce_82

action_47 (47) = happyShift action_74
action_47 (53) = happyShift action_75
action_47 (57) = happyShift action_76
action_47 (59) = happyShift action_77
action_47 (15) = happyGoto action_70
action_47 (16) = happyGoto action_71
action_47 (18) = happyGoto action_72
action_47 (19) = happyGoto action_73
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (40) = happyShift action_36
action_48 (41) = happyShift action_37
action_48 (42) = happyShift action_38
action_48 (43) = happyShift action_39
action_48 (44) = happyShift action_40
action_48 (45) = happyShift action_41
action_48 (46) = happyShift action_42
action_48 (47) = happyShift action_43
action_48 (49) = happyShift action_44
action_48 (50) = happyShift action_45
action_48 (51) = happyShift action_46
action_48 (52) = happyShift action_47
action_48 (57) = happyShift action_48
action_48 (58) = happyShift action_69
action_48 (61) = happyShift action_49
action_48 (30) = happyGoto action_68
action_48 (31) = happyGoto action_30
action_48 (32) = happyGoto action_31
action_48 (33) = happyGoto action_32
action_48 (34) = happyGoto action_33
action_48 (35) = happyGoto action_34
action_48 (36) = happyGoto action_35
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (40) = happyShift action_36
action_49 (41) = happyShift action_37
action_49 (42) = happyShift action_38
action_49 (43) = happyShift action_39
action_49 (44) = happyShift action_40
action_49 (45) = happyShift action_41
action_49 (46) = happyShift action_42
action_49 (47) = happyShift action_43
action_49 (49) = happyShift action_44
action_49 (50) = happyShift action_45
action_49 (51) = happyShift action_46
action_49 (52) = happyShift action_47
action_49 (57) = happyShift action_48
action_49 (61) = happyShift action_49
action_49 (14) = happyGoto action_66
action_49 (30) = happyGoto action_67
action_49 (31) = happyGoto action_30
action_49 (32) = happyGoto action_31
action_49 (33) = happyGoto action_32
action_49 (34) = happyGoto action_33
action_49 (35) = happyGoto action_34
action_49 (36) = happyGoto action_35
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (65) = happyShift action_65
action_50 _ = happyReduce_13

action_51 (60) = happyShift action_64
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (57) = happyShift action_15
action_52 (13) = happyGoto action_63
action_52 _ = happyReduce_22

action_53 _ = happyReduce_23

action_54 (47) = happyShift action_25
action_54 (48) = happyShift action_26
action_54 (9) = happyGoto action_21
action_54 (10) = happyGoto action_22
action_54 (11) = happyGoto action_23
action_54 (12) = happyGoto action_62
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (40) = happyShift action_36
action_55 (41) = happyShift action_37
action_55 (42) = happyShift action_38
action_55 (43) = happyShift action_39
action_55 (44) = happyShift action_40
action_55 (45) = happyShift action_41
action_55 (46) = happyShift action_42
action_55 (47) = happyShift action_43
action_55 (49) = happyShift action_44
action_55 (50) = happyShift action_45
action_55 (51) = happyShift action_46
action_55 (52) = happyShift action_47
action_55 (57) = happyShift action_48
action_55 (61) = happyShift action_49
action_55 (30) = happyGoto action_61
action_55 (31) = happyGoto action_30
action_55 (32) = happyGoto action_31
action_55 (33) = happyGoto action_32
action_55 (34) = happyGoto action_33
action_55 (35) = happyGoto action_34
action_55 (36) = happyGoto action_35
action_55 _ = happyFail (happyExpListPerState 55)

action_56 _ = happyReduce_18

action_57 _ = happyReduce_7

action_58 (54) = happyShift action_60
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_8

action_60 (40) = happyShift action_36
action_60 (41) = happyShift action_37
action_60 (42) = happyShift action_38
action_60 (43) = happyShift action_39
action_60 (44) = happyShift action_40
action_60 (45) = happyShift action_41
action_60 (46) = happyShift action_42
action_60 (47) = happyShift action_43
action_60 (49) = happyShift action_44
action_60 (50) = happyShift action_45
action_60 (51) = happyShift action_46
action_60 (52) = happyShift action_47
action_60 (57) = happyShift action_48
action_60 (61) = happyShift action_49
action_60 (30) = happyGoto action_120
action_60 (31) = happyGoto action_30
action_60 (32) = happyGoto action_31
action_60 (33) = happyGoto action_32
action_60 (34) = happyGoto action_33
action_60 (35) = happyGoto action_34
action_60 (36) = happyGoto action_35
action_60 _ = happyFail (happyExpListPerState 60)

action_61 _ = happyReduce_19

action_62 _ = happyReduce_21

action_63 (64) = happyShift action_119
action_63 _ = happyReduce_10

action_64 _ = happyReduce_5

action_65 (49) = happyShift action_52
action_65 (7) = happyGoto action_50
action_65 (8) = happyGoto action_118
action_65 _ = happyReduce_12

action_66 (62) = happyShift action_117
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (63) = happyShift action_116
action_67 _ = happyReduce_24

action_68 (58) = happyShift action_114
action_68 (63) = happyShift action_115
action_68 _ = happyFail (happyExpListPerState 68)

action_69 _ = happyReduce_76

action_70 _ = happyReduce_27

action_71 _ = happyReduce_31

action_72 (47) = happyShift action_74
action_72 (53) = happyShift action_75
action_72 (57) = happyShift action_76
action_72 (15) = happyGoto action_70
action_72 (16) = happyGoto action_71
action_72 (18) = happyGoto action_72
action_72 (19) = happyGoto action_113
action_72 _ = happyReduce_33

action_73 (55) = happyShift action_111
action_73 (59) = happyShift action_112
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_26

action_75 _ = happyReduce_28

action_76 (47) = happyShift action_74
action_76 (53) = happyShift action_75
action_76 (15) = happyGoto action_70
action_76 (16) = happyGoto action_78
action_76 (17) = happyGoto action_110
action_76 _ = happyFail (happyExpListPerState 76)

action_77 (44) = happyShift action_40
action_77 (46) = happyShift action_42
action_77 (47) = happyShift action_104
action_77 (49) = happyShift action_105
action_77 (51) = happyShift action_106
action_77 (53) = happyShift action_107
action_77 (57) = happyShift action_108
action_77 (61) = happyShift action_109
action_77 (20) = happyGoto action_96
action_77 (24) = happyGoto action_97
action_77 (26) = happyGoto action_98
action_77 (27) = happyGoto action_99
action_77 (28) = happyGoto action_100
action_77 (29) = happyGoto action_101
action_77 (34) = happyGoto action_102
action_77 (36) = happyGoto action_103
action_77 _ = happyReduce_59

action_78 (47) = happyShift action_74
action_78 (53) = happyShift action_75
action_78 (15) = happyGoto action_70
action_78 (16) = happyGoto action_78
action_78 (17) = happyGoto action_95
action_78 _ = happyReduce_29

action_79 (64) = happyShift action_94
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (59) = happyShift action_93
action_80 _ = happyFail (happyExpListPerState 80)

action_81 (54) = happyShift action_92
action_81 _ = happyFail (happyExpListPerState 81)

action_82 _ = happyReduce_72

action_83 (40) = happyShift action_36
action_83 (41) = happyShift action_37
action_83 (42) = happyShift action_38
action_83 (43) = happyShift action_39
action_83 (44) = happyShift action_40
action_83 (45) = happyShift action_41
action_83 (46) = happyShift action_42
action_83 (47) = happyShift action_91
action_83 (49) = happyShift action_44
action_83 (50) = happyShift action_45
action_83 (51) = happyShift action_46
action_83 (52) = happyShift action_47
action_83 (57) = happyShift action_48
action_83 (58) = happyShift action_69
action_83 (61) = happyShift action_49
action_83 (15) = happyGoto action_90
action_83 (30) = happyGoto action_68
action_83 (31) = happyGoto action_30
action_83 (32) = happyGoto action_31
action_83 (33) = happyGoto action_32
action_83 (34) = happyGoto action_33
action_83 (35) = happyGoto action_34
action_83 (36) = happyGoto action_35
action_83 _ = happyFail (happyExpListPerState 83)

action_84 (40) = happyShift action_36
action_84 (44) = happyShift action_40
action_84 (45) = happyShift action_41
action_84 (46) = happyShift action_42
action_84 (47) = happyShift action_43
action_84 (49) = happyShift action_44
action_84 (50) = happyShift action_45
action_84 (51) = happyShift action_46
action_84 (57) = happyShift action_48
action_84 (61) = happyShift action_49
action_84 (31) = happyGoto action_89
action_84 (32) = happyGoto action_31
action_84 (33) = happyGoto action_32
action_84 (34) = happyGoto action_33
action_84 (35) = happyGoto action_34
action_84 (36) = happyGoto action_35
action_84 _ = happyFail (happyExpListPerState 84)

action_85 (40) = happyShift action_36
action_85 (44) = happyShift action_40
action_85 (45) = happyShift action_41
action_85 (46) = happyShift action_42
action_85 (47) = happyShift action_43
action_85 (49) = happyShift action_44
action_85 (50) = happyShift action_45
action_85 (51) = happyShift action_46
action_85 (57) = happyShift action_48
action_85 (61) = happyShift action_49
action_85 (31) = happyGoto action_88
action_85 (32) = happyGoto action_31
action_85 (33) = happyGoto action_32
action_85 (34) = happyGoto action_33
action_85 (35) = happyGoto action_34
action_85 (36) = happyGoto action_35
action_85 _ = happyFail (happyExpListPerState 85)

action_86 (49) = happyShift action_52
action_86 (7) = happyGoto action_50
action_86 (8) = happyGoto action_87
action_86 _ = happyReduce_12

action_87 (60) = happyShift action_145
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (56) = happyShift action_85
action_88 _ = happyReduce_70

action_89 (55) = happyShift action_84
action_89 (56) = happyShift action_85
action_89 _ = happyReduce_69

action_90 (54) = happyShift action_144
action_90 _ = happyFail (happyExpListPerState 90)

action_91 (54) = happyReduce_26
action_91 _ = happyReduce_79

action_92 (40) = happyShift action_36
action_92 (41) = happyShift action_37
action_92 (42) = happyShift action_38
action_92 (43) = happyShift action_39
action_92 (44) = happyShift action_40
action_92 (45) = happyShift action_41
action_92 (46) = happyShift action_42
action_92 (47) = happyShift action_43
action_92 (49) = happyShift action_44
action_92 (50) = happyShift action_45
action_92 (51) = happyShift action_46
action_92 (52) = happyShift action_47
action_92 (57) = happyShift action_48
action_92 (61) = happyShift action_49
action_92 (30) = happyGoto action_143
action_92 (31) = happyGoto action_30
action_92 (32) = happyGoto action_31
action_92 (33) = happyGoto action_32
action_92 (34) = happyGoto action_33
action_92 (35) = happyGoto action_34
action_92 (36) = happyGoto action_35
action_92 _ = happyFail (happyExpListPerState 92)

action_93 (44) = happyShift action_40
action_93 (46) = happyShift action_42
action_93 (47) = happyShift action_104
action_93 (49) = happyShift action_105
action_93 (51) = happyShift action_106
action_93 (53) = happyShift action_107
action_93 (57) = happyShift action_108
action_93 (61) = happyShift action_109
action_93 (20) = happyGoto action_96
action_93 (24) = happyGoto action_97
action_93 (26) = happyGoto action_98
action_93 (27) = happyGoto action_99
action_93 (28) = happyGoto action_100
action_93 (29) = happyGoto action_142
action_93 (34) = happyGoto action_102
action_93 (36) = happyGoto action_103
action_93 _ = happyReduce_59

action_94 (40) = happyShift action_36
action_94 (41) = happyShift action_37
action_94 (42) = happyShift action_38
action_94 (43) = happyShift action_39
action_94 (44) = happyShift action_40
action_94 (45) = happyShift action_41
action_94 (46) = happyShift action_42
action_94 (47) = happyShift action_43
action_94 (49) = happyShift action_44
action_94 (50) = happyShift action_45
action_94 (51) = happyShift action_46
action_94 (52) = happyShift action_47
action_94 (57) = happyShift action_48
action_94 (61) = happyShift action_49
action_94 (30) = happyGoto action_141
action_94 (31) = happyGoto action_30
action_94 (32) = happyGoto action_31
action_94 (33) = happyGoto action_32
action_94 (34) = happyGoto action_33
action_94 (35) = happyGoto action_34
action_94 (36) = happyGoto action_35
action_94 _ = happyFail (happyExpListPerState 94)

action_95 _ = happyReduce_30

action_96 (44) = happyShift action_40
action_96 (46) = happyShift action_42
action_96 (47) = happyShift action_104
action_96 (49) = happyShift action_105
action_96 (51) = happyShift action_106
action_96 (53) = happyShift action_107
action_96 (57) = happyShift action_140
action_96 (61) = happyShift action_109
action_96 (20) = happyGoto action_135
action_96 (21) = happyGoto action_136
action_96 (22) = happyGoto action_137
action_96 (24) = happyGoto action_138
action_96 (25) = happyGoto action_139
action_96 (34) = happyGoto action_102
action_96 (36) = happyGoto action_103
action_96 _ = happyReduce_44

action_97 _ = happyReduce_54

action_98 (63) = happyShift action_134
action_98 _ = happyReduce_56

action_99 (55) = happyShift action_133
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (65) = happyShift action_132
action_100 _ = happyReduce_60

action_101 (60) = happyShift action_131
action_101 _ = happyFail (happyExpListPerState 101)

action_102 _ = happyReduce_49

action_103 _ = happyReduce_50

action_104 _ = happyReduce_45

action_105 _ = happyReduce_35

action_106 _ = happyReduce_36

action_107 _ = happyReduce_51

action_108 (44) = happyShift action_40
action_108 (46) = happyShift action_42
action_108 (47) = happyShift action_104
action_108 (49) = happyShift action_105
action_108 (51) = happyShift action_106
action_108 (53) = happyShift action_107
action_108 (57) = happyShift action_108
action_108 (61) = happyShift action_109
action_108 (20) = happyGoto action_96
action_108 (23) = happyGoto action_129
action_108 (24) = happyGoto action_97
action_108 (26) = happyGoto action_130
action_108 (34) = happyGoto action_102
action_108 (36) = happyGoto action_103
action_108 _ = happyFail (happyExpListPerState 108)

action_109 (44) = happyShift action_40
action_109 (46) = happyShift action_42
action_109 (47) = happyShift action_104
action_109 (49) = happyShift action_105
action_109 (51) = happyShift action_106
action_109 (53) = happyShift action_107
action_109 (57) = happyShift action_108
action_109 (61) = happyShift action_109
action_109 (62) = happyShift action_128
action_109 (20) = happyGoto action_96
action_109 (24) = happyGoto action_97
action_109 (26) = happyGoto action_98
action_109 (27) = happyGoto action_127
action_109 (34) = happyGoto action_102
action_109 (36) = happyGoto action_103
action_109 _ = happyFail (happyExpListPerState 109)

action_110 (64) = happyShift action_126
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (40) = happyShift action_36
action_111 (44) = happyShift action_40
action_111 (45) = happyShift action_41
action_111 (46) = happyShift action_42
action_111 (47) = happyShift action_43
action_111 (49) = happyShift action_44
action_111 (50) = happyShift action_45
action_111 (51) = happyShift action_46
action_111 (57) = happyShift action_48
action_111 (61) = happyShift action_49
action_111 (33) = happyGoto action_125
action_111 (34) = happyGoto action_33
action_111 (35) = happyGoto action_34
action_111 (36) = happyGoto action_35
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (44) = happyShift action_40
action_112 (46) = happyShift action_42
action_112 (47) = happyShift action_104
action_112 (49) = happyShift action_105
action_112 (51) = happyShift action_106
action_112 (53) = happyShift action_107
action_112 (57) = happyShift action_108
action_112 (61) = happyShift action_109
action_112 (20) = happyGoto action_96
action_112 (24) = happyGoto action_97
action_112 (26) = happyGoto action_98
action_112 (27) = happyGoto action_99
action_112 (28) = happyGoto action_100
action_112 (29) = happyGoto action_124
action_112 (34) = happyGoto action_102
action_112 (36) = happyGoto action_103
action_112 _ = happyReduce_59

action_113 _ = happyReduce_34

action_114 _ = happyReduce_75

action_115 (40) = happyShift action_36
action_115 (41) = happyShift action_37
action_115 (42) = happyShift action_38
action_115 (43) = happyShift action_39
action_115 (44) = happyShift action_40
action_115 (45) = happyShift action_41
action_115 (46) = happyShift action_42
action_115 (47) = happyShift action_43
action_115 (49) = happyShift action_44
action_115 (50) = happyShift action_45
action_115 (51) = happyShift action_46
action_115 (52) = happyShift action_47
action_115 (57) = happyShift action_48
action_115 (61) = happyShift action_49
action_115 (14) = happyGoto action_123
action_115 (30) = happyGoto action_67
action_115 (31) = happyGoto action_30
action_115 (32) = happyGoto action_31
action_115 (33) = happyGoto action_32
action_115 (34) = happyGoto action_33
action_115 (35) = happyGoto action_34
action_115 (36) = happyGoto action_35
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (40) = happyShift action_36
action_116 (41) = happyShift action_37
action_116 (42) = happyShift action_38
action_116 (43) = happyShift action_39
action_116 (44) = happyShift action_40
action_116 (45) = happyShift action_41
action_116 (46) = happyShift action_42
action_116 (47) = happyShift action_43
action_116 (49) = happyShift action_44
action_116 (50) = happyShift action_45
action_116 (51) = happyShift action_46
action_116 (52) = happyShift action_47
action_116 (57) = happyShift action_48
action_116 (61) = happyShift action_49
action_116 (14) = happyGoto action_122
action_116 (30) = happyGoto action_67
action_116 (31) = happyGoto action_30
action_116 (32) = happyGoto action_31
action_116 (33) = happyGoto action_32
action_116 (34) = happyGoto action_33
action_116 (35) = happyGoto action_34
action_116 (36) = happyGoto action_35
action_116 _ = happyFail (happyExpListPerState 116)

action_117 _ = happyReduce_78

action_118 _ = happyReduce_14

action_119 (40) = happyShift action_36
action_119 (41) = happyShift action_37
action_119 (42) = happyShift action_38
action_119 (43) = happyShift action_39
action_119 (44) = happyShift action_40
action_119 (45) = happyShift action_41
action_119 (46) = happyShift action_42
action_119 (47) = happyShift action_43
action_119 (49) = happyShift action_44
action_119 (50) = happyShift action_45
action_119 (51) = happyShift action_46
action_119 (52) = happyShift action_47
action_119 (57) = happyShift action_48
action_119 (61) = happyShift action_49
action_119 (30) = happyGoto action_121
action_119 (31) = happyGoto action_30
action_119 (32) = happyGoto action_31
action_119 (33) = happyGoto action_32
action_119 (34) = happyGoto action_33
action_119 (35) = happyGoto action_34
action_119 (36) = happyGoto action_35
action_119 _ = happyFail (happyExpListPerState 119)

action_120 _ = happyReduce_9

action_121 _ = happyReduce_11

action_122 _ = happyReduce_25

action_123 (58) = happyShift action_162
action_123 _ = happyFail (happyExpListPerState 123)

action_124 (60) = happyShift action_161
action_124 _ = happyFail (happyExpListPerState 124)

action_125 _ = happyReduce_65

action_126 (40) = happyShift action_36
action_126 (41) = happyShift action_37
action_126 (42) = happyShift action_38
action_126 (43) = happyShift action_39
action_126 (44) = happyShift action_40
action_126 (45) = happyShift action_41
action_126 (46) = happyShift action_42
action_126 (47) = happyShift action_43
action_126 (49) = happyShift action_44
action_126 (50) = happyShift action_45
action_126 (51) = happyShift action_46
action_126 (52) = happyShift action_47
action_126 (57) = happyShift action_48
action_126 (61) = happyShift action_49
action_126 (30) = happyGoto action_160
action_126 (31) = happyGoto action_30
action_126 (32) = happyGoto action_31
action_126 (33) = happyGoto action_32
action_126 (34) = happyGoto action_33
action_126 (35) = happyGoto action_34
action_126 (36) = happyGoto action_35
action_126 _ = happyFail (happyExpListPerState 126)

action_127 (62) = happyShift action_159
action_127 _ = happyFail (happyExpListPerState 127)

action_128 _ = happyReduce_47

action_129 (58) = happyShift action_158
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (63) = happyShift action_157
action_130 _ = happyFail (happyExpListPerState 130)

action_131 _ = happyReduce_67

action_132 (44) = happyShift action_40
action_132 (46) = happyShift action_42
action_132 (47) = happyShift action_104
action_132 (49) = happyShift action_105
action_132 (51) = happyShift action_106
action_132 (53) = happyShift action_107
action_132 (57) = happyShift action_108
action_132 (61) = happyShift action_109
action_132 (20) = happyGoto action_96
action_132 (24) = happyGoto action_97
action_132 (26) = happyGoto action_98
action_132 (27) = happyGoto action_99
action_132 (28) = happyGoto action_100
action_132 (29) = happyGoto action_156
action_132 (34) = happyGoto action_102
action_132 (36) = happyGoto action_103
action_132 _ = happyReduce_59

action_133 (40) = happyShift action_36
action_133 (41) = happyShift action_37
action_133 (42) = happyShift action_38
action_133 (43) = happyShift action_39
action_133 (44) = happyShift action_40
action_133 (45) = happyShift action_41
action_133 (46) = happyShift action_42
action_133 (47) = happyShift action_43
action_133 (49) = happyShift action_44
action_133 (50) = happyShift action_45
action_133 (51) = happyShift action_46
action_133 (52) = happyShift action_47
action_133 (57) = happyShift action_48
action_133 (61) = happyShift action_49
action_133 (30) = happyGoto action_155
action_133 (31) = happyGoto action_30
action_133 (32) = happyGoto action_31
action_133 (33) = happyGoto action_32
action_133 (34) = happyGoto action_33
action_133 (35) = happyGoto action_34
action_133 (36) = happyGoto action_35
action_133 _ = happyFail (happyExpListPerState 133)

action_134 (44) = happyShift action_40
action_134 (46) = happyShift action_42
action_134 (47) = happyShift action_104
action_134 (49) = happyShift action_105
action_134 (51) = happyShift action_106
action_134 (53) = happyShift action_107
action_134 (57) = happyShift action_108
action_134 (61) = happyShift action_109
action_134 (20) = happyGoto action_96
action_134 (24) = happyGoto action_97
action_134 (26) = happyGoto action_98
action_134 (27) = happyGoto action_154
action_134 (34) = happyGoto action_102
action_134 (36) = happyGoto action_103
action_134 _ = happyFail (happyExpListPerState 134)

action_135 _ = happyReduce_44

action_136 (44) = happyShift action_40
action_136 (46) = happyShift action_42
action_136 (47) = happyShift action_104
action_136 (49) = happyShift action_105
action_136 (51) = happyShift action_106
action_136 (53) = happyShift action_107
action_136 (57) = happyShift action_140
action_136 (61) = happyShift action_109
action_136 (20) = happyGoto action_135
action_136 (21) = happyGoto action_136
action_136 (22) = happyGoto action_153
action_136 (24) = happyGoto action_138
action_136 (25) = happyGoto action_139
action_136 (34) = happyGoto action_102
action_136 (36) = happyGoto action_103
action_136 _ = happyReduce_40

action_137 _ = happyReduce_55

action_138 _ = happyReduce_52

action_139 _ = happyReduce_37

action_140 (44) = happyShift action_40
action_140 (46) = happyShift action_42
action_140 (47) = happyShift action_152
action_140 (49) = happyShift action_105
action_140 (51) = happyShift action_106
action_140 (53) = happyShift action_107
action_140 (57) = happyShift action_108
action_140 (61) = happyShift action_109
action_140 (15) = happyGoto action_150
action_140 (20) = happyGoto action_151
action_140 (23) = happyGoto action_129
action_140 (24) = happyGoto action_97
action_140 (26) = happyGoto action_130
action_140 (34) = happyGoto action_102
action_140 (36) = happyGoto action_103
action_140 _ = happyFail (happyExpListPerState 140)

action_141 (63) = happyShift action_149
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (60) = happyShift action_148
action_142 _ = happyFail (happyExpListPerState 142)

action_143 (63) = happyShift action_147
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (40) = happyShift action_36
action_144 (41) = happyShift action_37
action_144 (42) = happyShift action_38
action_144 (43) = happyShift action_39
action_144 (44) = happyShift action_40
action_144 (45) = happyShift action_41
action_144 (46) = happyShift action_42
action_144 (47) = happyShift action_43
action_144 (49) = happyShift action_44
action_144 (50) = happyShift action_45
action_144 (51) = happyShift action_46
action_144 (52) = happyShift action_47
action_144 (57) = happyShift action_48
action_144 (61) = happyShift action_49
action_144 (30) = happyGoto action_146
action_144 (31) = happyGoto action_30
action_144 (32) = happyGoto action_31
action_144 (33) = happyGoto action_32
action_144 (34) = happyGoto action_33
action_144 (35) = happyGoto action_34
action_144 (36) = happyGoto action_35
action_144 _ = happyFail (happyExpListPerState 144)

action_145 _ = happyReduce_6

action_146 (58) = happyShift action_171
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (40) = happyShift action_36
action_147 (41) = happyShift action_37
action_147 (42) = happyShift action_38
action_147 (43) = happyShift action_39
action_147 (44) = happyShift action_40
action_147 (45) = happyShift action_41
action_147 (46) = happyShift action_42
action_147 (47) = happyShift action_43
action_147 (49) = happyShift action_44
action_147 (50) = happyShift action_45
action_147 (51) = happyShift action_46
action_147 (52) = happyShift action_47
action_147 (57) = happyShift action_48
action_147 (61) = happyShift action_49
action_147 (30) = happyGoto action_170
action_147 (31) = happyGoto action_30
action_147 (32) = happyGoto action_31
action_147 (33) = happyGoto action_32
action_147 (34) = happyGoto action_33
action_147 (35) = happyGoto action_34
action_147 (36) = happyGoto action_35
action_147 _ = happyFail (happyExpListPerState 147)

action_148 _ = happyReduce_64

action_149 (40) = happyShift action_36
action_149 (41) = happyShift action_37
action_149 (42) = happyShift action_38
action_149 (43) = happyShift action_39
action_149 (44) = happyShift action_40
action_149 (45) = happyShift action_41
action_149 (46) = happyShift action_42
action_149 (47) = happyShift action_43
action_149 (49) = happyShift action_44
action_149 (50) = happyShift action_45
action_149 (51) = happyShift action_46
action_149 (52) = happyShift action_47
action_149 (57) = happyShift action_48
action_149 (61) = happyShift action_49
action_149 (30) = happyGoto action_169
action_149 (31) = happyGoto action_30
action_149 (32) = happyGoto action_31
action_149 (33) = happyGoto action_32
action_149 (34) = happyGoto action_33
action_149 (35) = happyGoto action_34
action_149 (36) = happyGoto action_35
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (54) = happyShift action_168
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (44) = happyShift action_40
action_151 (46) = happyShift action_42
action_151 (47) = happyShift action_104
action_151 (49) = happyShift action_105
action_151 (51) = happyShift action_106
action_151 (53) = happyShift action_107
action_151 (57) = happyShift action_140
action_151 (61) = happyShift action_109
action_151 (20) = happyGoto action_135
action_151 (21) = happyGoto action_136
action_151 (22) = happyGoto action_167
action_151 (24) = happyGoto action_138
action_151 (25) = happyGoto action_139
action_151 (34) = happyGoto action_102
action_151 (36) = happyGoto action_103
action_151 _ = happyReduce_44

action_152 (58) = happyShift action_166
action_152 (63) = happyReduce_45
action_152 _ = happyReduce_26

action_153 _ = happyReduce_41

action_154 _ = happyReduce_57

action_155 _ = happyReduce_58

action_156 _ = happyReduce_61

action_157 (44) = happyShift action_40
action_157 (46) = happyShift action_42
action_157 (47) = happyShift action_104
action_157 (49) = happyShift action_105
action_157 (51) = happyShift action_106
action_157 (53) = happyShift action_107
action_157 (57) = happyShift action_108
action_157 (61) = happyShift action_109
action_157 (20) = happyGoto action_96
action_157 (23) = happyGoto action_164
action_157 (24) = happyGoto action_97
action_157 (26) = happyGoto action_165
action_157 (34) = happyGoto action_102
action_157 (36) = happyGoto action_103
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_46

action_159 _ = happyReduce_48

action_160 (58) = happyShift action_163
action_160 _ = happyFail (happyExpListPerState 160)

action_161 _ = happyReduce_66

action_162 _ = happyReduce_77

action_163 _ = happyReduce_32

action_164 _ = happyReduce_43

action_165 (63) = happyShift action_157
action_165 _ = happyReduce_42

action_166 _ = happyReduce_39

action_167 (58) = happyShift action_174
action_167 _ = happyReduce_55

action_168 (44) = happyShift action_40
action_168 (46) = happyShift action_42
action_168 (47) = happyShift action_104
action_168 (49) = happyShift action_105
action_168 (51) = happyShift action_106
action_168 (53) = happyShift action_107
action_168 (57) = happyShift action_173
action_168 (61) = happyShift action_109
action_168 (20) = happyGoto action_135
action_168 (24) = happyGoto action_138
action_168 (25) = happyGoto action_172
action_168 (34) = happyGoto action_102
action_168 (36) = happyGoto action_103
action_168 _ = happyFail (happyExpListPerState 168)

action_169 _ = happyReduce_63

action_170 _ = happyReduce_62

action_171 _ = happyReduce_73

action_172 (58) = happyShift action_175
action_172 _ = happyFail (happyExpListPerState 172)

action_173 (44) = happyShift action_40
action_173 (46) = happyShift action_42
action_173 (47) = happyShift action_104
action_173 (49) = happyShift action_105
action_173 (51) = happyShift action_106
action_173 (53) = happyShift action_107
action_173 (57) = happyShift action_108
action_173 (61) = happyShift action_109
action_173 (20) = happyGoto action_151
action_173 (23) = happyGoto action_129
action_173 (24) = happyGoto action_97
action_173 (26) = happyGoto action_130
action_173 (34) = happyGoto action_102
action_173 (36) = happyGoto action_103
action_173 _ = happyFail (happyExpListPerState 173)

action_174 _ = happyReduce_53

action_175 _ = happyReduce_38

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

happyReduce_10 = happySpecReduce_2  7 happyReduction_10
happyReduction_10 (HappyAbsSyn12  happy_var_2)
	(HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn7
		 (Variant [] happy_var_1 happy_var_2 Nothing
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happyReduce 4 7 happyReduction_11
happyReduction_11 ((HappyAbsSyn30  happy_var_4) `HappyStk`
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

happyReduce_16 = happySpecReduce_1  9 happyReduction_16
happyReduction_16 (HappyTerminal (TokenQLSym happy_var_1))
	 =  HappyAbsSyn5
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  10 happyReduction_17
happyReduction_17 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 :| []
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  10 happyReduction_18
happyReduction_18 (HappyAbsSyn10  happy_var_2)
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  11 happyReduction_19
happyReduction_19 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1, Just happy_var_3, [])
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  12 happyReduction_20
happyReduction_20 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 ([happy_var_1]
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  12 happyReduction_21
happyReduction_21 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1 : happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_0  13 happyReduction_22
happyReduction_22  =  HappyAbsSyn12
		 ([]
	)

happyReduce_23 = happySpecReduce_3  13 happyReduction_23
happyReduction_23 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  14 happyReduction_24
happyReduction_24 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn14
		 ([happy_var_1]
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  14 happyReduction_25
happyReduction_25 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1 : happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  15 happyReduction_26
happyReduction_26 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  16 happyReduction_27
happyReduction_27 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  16 happyReduction_28
happyReduction_28 _
	 =  HappyAbsSyn15
		 ("_"
	)

happyReduce_29 = happySpecReduce_1  17 happyReduction_29
happyReduction_29 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| []
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_2  17 happyReduction_30
happyReduction_30 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_30 _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_1  18 happyReduction_31
happyReduction_31 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1 :| [], Nothing, [])
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happyReduce 5 18 happyReduction_32
happyReduction_32 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 ((happy_var_2, Just happy_var_4, [])
	) `HappyStk` happyRest

happyReduce_33 = happySpecReduce_1  19 happyReduction_33
happyReduction_33 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 :| []
	)
happyReduction_33 _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_2  19 happyReduction_34
happyReduction_34 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_34 _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_1  20 happyReduction_35
happyReduction_35 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_35 _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  20 happyReduction_36
happyReduction_36 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_1  21 happyReduction_37
happyReduction_37 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn21
		 (Right happy_var_1
	)
happyReduction_37 _  = notHappyAtAll 

happyReduce_38 = happyReduce 5 21 happyReduction_38
happyReduction_38 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (Left (P.Implicit happy_var_2 happy_var_4)
	) `HappyStk` happyRest

happyReduce_39 = happySpecReduce_3  21 happyReduction_39
happyReduction_39 _
	(HappyTerminal (TokenLSym happy_var_2))
	_
	 =  HappyAbsSyn21
		 (Left (P.PunnedImplicit happy_var_2)
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  22 happyReduction_40
happyReduction_40 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| []
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  22 happyReduction_41
happyReduction_41 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  23 happyReduction_42
happyReduction_42 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 ([happy_var_1, happy_var_3]
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  23 happyReduction_43
happyReduction_43 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_1 : happy_var_3
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  24 happyReduction_44
happyReduction_44 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Data happy_var_1 []
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  24 happyReduction_45
happyReduction_45 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn24
		 (P.Variable happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  24 happyReduction_46
happyReduction_46 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.Tuple happy_var_2
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  24 happyReduction_47
happyReduction_47 _
	_
	 =  HappyAbsSyn24
		 (P.List []
	)

happyReduce_48 = happySpecReduce_3  24 happyReduction_48
happyReduction_48 _
	(HappyAbsSyn27  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.List happy_var_2
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  24 happyReduction_49
happyReduction_49 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  24 happyReduction_50
happyReduction_50 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_1  24 happyReduction_51
happyReduction_51 _
	 =  HappyAbsSyn24
		 (Wildcard
	)

happyReduce_52 = happySpecReduce_1  25 happyReduction_52
happyReduction_52 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happyReduce 4 25 happyReduction_53
happyReduction_53 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_54 = happySpecReduce_1  26 happyReduction_54
happyReduction_54 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_2  26 happyReduction_55
happyReduction_55 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_55 _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  27 happyReduction_56
happyReduction_56 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  27 happyReduction_57
happyReduction_57 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  28 happyReduction_58
happyReduction_58 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 ((happy_var_1, happy_var_3)
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_0  29 happyReduction_59
happyReduction_59  =  HappyAbsSyn29
		 ([]
	)

happyReduce_60 = happySpecReduce_1  29 happyReduction_60
happyReduction_60 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 ([happy_var_1]
	)
happyReduction_60 _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  29 happyReduction_61
happyReduction_61 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1 : happy_var_3
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happyReduce 6 30 happyReduction_62
happyReduction_62 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_63 = happyReduce 6 30 happyReduction_63
happyReduction_63 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (ForAll happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_64 = happyReduce 5 30 happyReduction_64
happyReduction_64 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_65 = happyReduce 4 30 happyReduction_65
happyReduction_65 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_66 = happyReduce 5 30 happyReduction_66
happyReduction_66 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_67 = happyReduce 4 30 happyReduction_67
happyReduction_67 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_68 = happySpecReduce_1  30 happyReduction_68
happyReduction_68 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_68 _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  31 happyReduction_69
happyReduction_69 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  31 happyReduction_70
happyReduction_70 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenInfixOp happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (uncurry QName happy_var_2) happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_1  31 happyReduction_71
happyReduction_71 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_71 _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_2  32 happyReduction_72
happyReduction_72 (HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Application happy_var_1 ((Nothing, happy_var_2) :| [])
	)
happyReduction_72 _ _  = notHappyAtAll 

happyReduce_73 = happyReduce 6 32 happyReduction_73
happyReduction_73 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Application happy_var_1 ((Just happy_var_3, happy_var_5) :| [])
	) `HappyStk` happyRest

happyReduce_74 = happySpecReduce_1  32 happyReduction_74
happyReduction_74 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  33 happyReduction_75
happyReduction_75 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (Parenthesized happy_var_2
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_2  33 happyReduction_76
happyReduction_76 _
	_
	 =  HappyAbsSyn30
		 (Literal UnitLiteral
	)

happyReduce_77 = happyReduce 5 33 happyReduction_77
happyReduction_77 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_78 = happySpecReduce_3  33 happyReduction_78
happyReduction_78 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (List happy_var_2
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  33 happyReduction_79
happyReduction_79 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_1  33 happyReduction_80
happyReduction_80 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_80 _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_1  33 happyReduction_81
happyReduction_81 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_81 _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_1  33 happyReduction_82
happyReduction_82 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_82 _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  33 happyReduction_83
happyReduction_83 _
	 =  HappyAbsSyn30
		 (Type
	)

happyReduce_84 = happySpecReduce_1  33 happyReduction_84
happyReduction_84 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  33 happyReduction_85
happyReduction_85 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  33 happyReduction_86
happyReduction_86 (HappyAbsSyn34  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  34 happyReduction_87
happyReduction_87 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn34
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  35 happyReduction_88
happyReduction_88 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn34
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_1  36 happyReduction_89
happyReduction_89 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn34
		 (StringLiteral happy_var_1
	)
happyReduction_89 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 66 66 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenDatatype -> cont 37;
	TokenDeclare -> cont 38;
	TokenDefine -> cont 39;
	TokenType -> cont 40;
	TokenLet -> cont 41;
	TokenCase -> cont 42;
	TokenForAll -> cont 43;
	TokenInt happy_dollar_dollar -> cont 44;
	TokenFloat happy_dollar_dollar -> cont 45;
	TokenString happy_dollar_dollar -> cont 46;
	TokenLSym happy_dollar_dollar -> cont 47;
	TokenQLSym happy_dollar_dollar -> cont 48;
	TokenUSym happy_dollar_dollar -> cont 49;
	TokenLSymQ happy_dollar_dollar -> cont 50;
	TokenUSymQ happy_dollar_dollar -> cont 51;
	TokenBackslash -> cont 52;
	TokenUnderscore -> cont 53;
	TokenEq -> cont 54;
	TokenArrow -> cont 55;
	TokenInfixOp happy_dollar_dollar -> cont 56;
	TokenLParen -> cont 57;
	TokenRParen -> cont 58;
	TokenLBrace -> cont 59;
	TokenRBrace -> cont 60;
	TokenLBracket -> cont 61;
	TokenRBracket -> cont 62;
	TokenComma -> cont 63;
	TokenColon -> cont 64;
	TokenSemicolon -> cont 65;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 66 tk tks = happyError' (tks, explist)
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
