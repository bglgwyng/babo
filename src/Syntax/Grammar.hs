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
	| HappyAbsSyn31 (Disk)
	| HappyAbsSyn32 (NonEmpty Disk)
	| HappyAbsSyn36 (Literal)

happyExpList :: Happy_Data_Array.Array Prelude.Int Prelude.Int
happyExpList = Happy_Data_Array.listArray (0,742) ([0,0,4032,0,0,0,49152,15,0,0,0,0,0,0,0,0,8192,0,0,0,0,40,0,0,0,10240,0,0,0,61440,20975,4,0,0,61424,1105,0,0,61440,20975,4,0,0,0,0,0,0,4032,0,0,0,0,0,0,0,0,0,0,0,0,0,59392,8,0,0,0,16384,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,61440,20975,4,0,0,10240,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10240,322,0,0,0,0,0,0,0,61424,1233,0,0,61440,20975,4,0,0,0,0,0,0,0,1024,32,0,0,0,64,0,0,0,0,0,0,0,0,0,0,0,0,16384,0,0,0,0,64,0,0,0,0,33,0,0,10240,0,0,0,0,0,32,0,0,0,8196,0,0,61440,20975,4,0,0,61424,1105,0,0,0,0,8,0,0,0,4096,0,0,0,32768,16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16936,0,0,0,0,264,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10240,2,0,0,0,17069,4,0,0,10240,2,0,0,0,0,32,0,0,0,256,0,0,0,1024,0,0,0,61424,1105,0,0,4096,20719,4,0,0,61200,1104,0,0,4096,20719,4,0,0,61200,1104,0,0,4096,20719,4,0,0,59392,8,0,0,0,232,0,0,0,59392,0,0,0,0,232,0,0,0,59392,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,16,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,61440,20975,4,0,0,44288,1090,0,0,61440,20975,4,0,0,0,0,0,0,0,17069,4,0,0,0,0,0,0,0,0,16,0,0,0,8,0,0,0,0,64,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17069,4,0,0,44288,3138,0,0,0,0,32,0,0,61424,1105,0,0,0,17069,4,0,0,0,0,0,0,0,0,0,0,0,61424,1105,0,0,61440,20975,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,20975,4,0,0,61424,1105,0,0,61440,20975,4,0,0,10240,0,0,0,0,0,32,0,0,0,4096,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,61440,20975,4,0,0,0,256,0,0,0,0,64,0,0,0,512,0,0,0,16384,0,0,0,0,0,0,0,0,40,0,0,0,61424,1105,0,0,0,0,0,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,2,0,0,0,0,0,0,61440,20975,4,0,0,0,2048,0,0,0,0,0,0,0,0,128,0,0,0,0,16,0,0,0,0,0,0,0,17069,4,0,0,61424,1105,0,0,0,17069,4,0,0,0,0,0,0,0,17069,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17069,4,0,0,0,4096,0,0,0,0,2,0,0,0,4096,0,0,0,0,0,0,0,61424,1105,0,0,61440,20975,4,0,0,0,0,0,0,0,0,0,0,0,61424,1105,0,0,0,0,0,0,0,61424,1105,0,0,0,1024,0,0,0,44288,1090,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,17069,4,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,61440,20975,4,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,8192,0,0,0,0,32,0,0,0,0,512,0,0,0,0,0,0,0,61424,1105,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,0,0,0,0,0,0,0,0,128,0,0,0,17069,4,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,17069,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Statements","Name","Statement","Variant","Variants","ArgumentName","ArgumentNames","Argument","Arguments_","Arguments","CommaSeperated","LocalName","LocalName_","LocalName_s","LambdaArgument","LambdaArguments","Constructor","PatternArgument","PatternArguments","TuplePattern","Pattern__","Pattern_","Pattern","Patterns","Case","Cases","Expression","Disk","Spine","BinaryExpression","Identifier","Atom","IntegerLiteral","FloatLiteral","StringLiteral","data","decl","def","check","eval","typeOf","type","let","case","forall","int","float","string","lsym","qlsym","usym","lsymQ","usymQ","'\\\\'","'_'","'='","'->'","'?'","infixOp","'('","')'","'{'","'}'","'['","']'","','","':'","';'","%eof"]
        bit_start = st Prelude.* 72
        bit_end = (st Prelude.+ 1) Prelude.* 72
        read_bit = readArrayBit happyExpList
        bits = Prelude.map read_bit [bit_start..bit_end Prelude.- 1]
        bits_indexed = Prelude.zip bits [0..71]
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
action_6 (61) = happyShift action_30
action_6 (63) = happyShift action_31
action_6 (67) = happyShift action_32
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
action_7 (61) = happyShift action_30
action_7 (63) = happyShift action_31
action_7 (67) = happyShift action_32
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
action_8 (61) = happyShift action_30
action_8 (63) = happyShift action_31
action_8 (67) = happyShift action_32
action_8 (30) = happyGoto action_12
action_8 (33) = happyGoto action_13
action_8 (35) = happyGoto action_14
action_8 (36) = happyGoto action_15
action_8 (37) = happyGoto action_16
action_8 (38) = happyGoto action_17
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (72) = happyAccept
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
action_13 _ = happyReduce_73

action_14 (63) = happyShift action_63
action_14 _ = happyReduce_84

action_15 _ = happyReduce_99

action_16 _ = happyReduce_100

action_17 _ = happyReduce_101

action_18 _ = happyReduce_98

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
action_20 (61) = happyShift action_30
action_20 (63) = happyShift action_31
action_20 (67) = happyShift action_32
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

action_22 _ = happyReduce_102

action_23 _ = happyReduce_103

action_24 _ = happyReduce_104

action_25 _ = happyReduce_94

action_26 _ = happyReduce_95

action_27 _ = happyReduce_96

action_28 _ = happyReduce_97

action_29 (52) = happyShift action_54
action_29 (54) = happyShift action_55
action_29 (58) = happyShift action_56
action_29 (63) = happyShift action_57
action_29 (65) = happyShift action_58
action_29 (15) = happyGoto action_50
action_29 (16) = happyGoto action_51
action_29 (18) = happyGoto action_52
action_29 (19) = happyGoto action_53
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_93

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
action_31 (61) = happyShift action_30
action_31 (63) = happyShift action_31
action_31 (64) = happyShift action_49
action_31 (67) = happyShift action_32
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
action_32 (61) = happyShift action_30
action_32 (63) = happyShift action_31
action_32 (67) = happyShift action_32
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
action_34 (70) = happyShift action_45
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (63) = happyShift action_41
action_35 (13) = happyGoto action_43
action_35 _ = happyReduce_26

action_36 _ = happyReduce_4

action_37 _ = happyReduce_3

action_38 (63) = happyShift action_41
action_38 (13) = happyGoto action_42
action_38 _ = happyReduce_26

action_39 (63) = happyShift action_41
action_39 (13) = happyGoto action_40
action_39 _ = happyReduce_26

action_40 (65) = happyShift action_117
action_40 (70) = happyShift action_118
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (52) = happyShift action_115
action_41 (54) = happyShift action_116
action_41 (9) = happyGoto action_111
action_41 (10) = happyGoto action_112
action_41 (11) = happyGoto action_113
action_41 (12) = happyGoto action_114
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (70) = happyShift action_110
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (59) = happyShift action_108
action_43 (70) = happyShift action_109
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
action_44 (61) = happyShift action_30
action_44 (63) = happyShift action_31
action_44 (67) = happyShift action_32
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
action_45 (61) = happyShift action_30
action_45 (63) = happyShift action_31
action_45 (67) = happyShift action_32
action_45 (30) = happyGoto action_106
action_45 (33) = happyGoto action_13
action_45 (35) = happyGoto action_14
action_45 (36) = happyGoto action_15
action_45 (37) = happyGoto action_16
action_45 (38) = happyGoto action_17
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (68) = happyShift action_105
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (69) = happyShift action_104
action_47 _ = happyReduce_28

action_48 (64) = happyShift action_102
action_48 (69) = happyShift action_103
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_90

action_50 _ = happyReduce_32

action_51 _ = happyReduce_36

action_52 (52) = happyShift action_54
action_52 (54) = happyShift action_55
action_52 (58) = happyShift action_56
action_52 (63) = happyShift action_57
action_52 (15) = happyGoto action_50
action_52 (16) = happyGoto action_51
action_52 (18) = happyGoto action_52
action_52 (19) = happyGoto action_101
action_52 _ = happyReduce_38

action_53 (60) = happyShift action_99
action_53 (65) = happyShift action_100
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_30

action_55 _ = happyReduce_31

action_56 _ = happyReduce_33

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
action_58 (63) = happyShift action_96
action_58 (67) = happyShift action_97
action_58 (20) = happyGoto action_84
action_58 (24) = happyGoto action_85
action_58 (26) = happyGoto action_86
action_58 (27) = happyGoto action_87
action_58 (28) = happyGoto action_88
action_58 (29) = happyGoto action_89
action_58 (36) = happyGoto action_90
action_58 (38) = happyGoto action_91
action_58 _ = happyReduce_64

action_59 (52) = happyShift action_54
action_59 (54) = happyShift action_55
action_59 (58) = happyShift action_56
action_59 (15) = happyGoto action_50
action_59 (16) = happyGoto action_59
action_59 (17) = happyGoto action_83
action_59 _ = happyReduce_34

action_60 (70) = happyShift action_82
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (65) = happyShift action_81
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
action_63 (61) = happyShift action_30
action_63 (63) = happyShift action_31
action_63 (67) = happyShift action_32
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
action_64 (61) = happyShift action_30
action_64 (63) = happyShift action_31
action_64 (67) = happyShift action_32
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
action_65 (61) = happyShift action_30
action_65 (63) = happyShift action_31
action_65 (67) = happyShift action_32
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
action_66 (61) = happyShift action_30
action_66 (63) = happyShift action_31
action_66 (67) = happyShift action_32
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
action_67 (61) = happyShift action_30
action_67 (63) = happyShift action_31
action_67 (67) = happyShift action_32
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
action_68 (61) = happyShift action_30
action_68 (63) = happyShift action_31
action_68 (67) = happyShift action_32
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
action_69 _ = happyReduce_78

action_70 (52) = happyShift action_64
action_70 (54) = happyShift action_65
action_70 (55) = happyShift action_66
action_70 (56) = happyShift action_67
action_70 _ = happyReduce_82

action_71 (52) = happyShift action_64
action_71 (54) = happyShift action_65
action_71 (55) = happyShift action_66
action_71 (56) = happyShift action_67
action_71 _ = happyReduce_81

action_72 (52) = happyShift action_64
action_72 (54) = happyShift action_65
action_72 (55) = happyShift action_66
action_72 (56) = happyShift action_67
action_72 _ = happyReduce_80

action_73 (52) = happyShift action_64
action_73 (54) = happyShift action_65
action_73 (55) = happyShift action_66
action_73 (56) = happyShift action_67
action_73 _ = happyReduce_79

action_74 (59) = happyShift action_154
action_74 _ = happyFail (happyExpListPerState 74)

action_75 _ = happyReduce_74

action_76 (69) = happyShift action_153
action_76 _ = happyReduce_76

action_77 (64) = happyShift action_152
action_77 _ = happyFail (happyExpListPerState 77)

action_78 (59) = happyReduce_30
action_78 _ = happyReduce_94

action_79 (59) = happyReduce_31
action_79 _ = happyReduce_95

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
action_80 (61) = happyShift action_30
action_80 (63) = happyShift action_31
action_80 (67) = happyShift action_32
action_80 (30) = happyGoto action_151
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
action_81 (63) = happyShift action_96
action_81 (67) = happyShift action_97
action_81 (20) = happyGoto action_84
action_81 (24) = happyGoto action_85
action_81 (26) = happyGoto action_86
action_81 (27) = happyGoto action_87
action_81 (28) = happyGoto action_88
action_81 (29) = happyGoto action_150
action_81 (36) = happyGoto action_90
action_81 (38) = happyGoto action_91
action_81 _ = happyReduce_64

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
action_82 (61) = happyShift action_30
action_82 (63) = happyShift action_31
action_82 (67) = happyShift action_32
action_82 (30) = happyGoto action_149
action_82 (33) = happyGoto action_13
action_82 (35) = happyGoto action_14
action_82 (36) = happyGoto action_15
action_82 (37) = happyGoto action_16
action_82 (38) = happyGoto action_17
action_82 _ = happyFail (happyExpListPerState 82)

action_83 _ = happyReduce_35

action_84 (49) = happyShift action_22
action_84 (51) = happyShift action_24
action_84 (52) = happyShift action_92
action_84 (54) = happyShift action_93
action_84 (56) = happyShift action_94
action_84 (58) = happyShift action_95
action_84 (63) = happyShift action_148
action_84 (67) = happyShift action_97
action_84 (20) = happyGoto action_143
action_84 (21) = happyGoto action_144
action_84 (22) = happyGoto action_145
action_84 (24) = happyGoto action_146
action_84 (25) = happyGoto action_147
action_84 (36) = happyGoto action_90
action_84 (38) = happyGoto action_91
action_84 _ = happyReduce_49

action_85 _ = happyReduce_59

action_86 (69) = happyShift action_142
action_86 _ = happyReduce_61

action_87 (60) = happyShift action_141
action_87 _ = happyFail (happyExpListPerState 87)

action_88 (71) = happyShift action_140
action_88 _ = happyReduce_65

action_89 (66) = happyShift action_139
action_89 _ = happyFail (happyExpListPerState 89)

action_90 _ = happyReduce_54

action_91 _ = happyReduce_55

action_92 _ = happyReduce_50

action_93 _ = happyReduce_40

action_94 _ = happyReduce_41

action_95 _ = happyReduce_56

action_96 (49) = happyShift action_22
action_96 (51) = happyShift action_24
action_96 (52) = happyShift action_92
action_96 (54) = happyShift action_93
action_96 (56) = happyShift action_94
action_96 (58) = happyShift action_95
action_96 (63) = happyShift action_96
action_96 (67) = happyShift action_97
action_96 (20) = happyGoto action_84
action_96 (23) = happyGoto action_137
action_96 (24) = happyGoto action_85
action_96 (26) = happyGoto action_138
action_96 (36) = happyGoto action_90
action_96 (38) = happyGoto action_91
action_96 _ = happyFail (happyExpListPerState 96)

action_97 (49) = happyShift action_22
action_97 (51) = happyShift action_24
action_97 (52) = happyShift action_92
action_97 (54) = happyShift action_93
action_97 (56) = happyShift action_94
action_97 (58) = happyShift action_95
action_97 (63) = happyShift action_96
action_97 (67) = happyShift action_97
action_97 (68) = happyShift action_136
action_97 (20) = happyGoto action_84
action_97 (24) = happyGoto action_85
action_97 (26) = happyGoto action_86
action_97 (27) = happyGoto action_135
action_97 (36) = happyGoto action_90
action_97 (38) = happyGoto action_91
action_97 _ = happyFail (happyExpListPerState 97)

action_98 (70) = happyShift action_134
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
action_99 (61) = happyShift action_30
action_99 (63) = happyShift action_31
action_99 (67) = happyShift action_32
action_99 (30) = happyGoto action_133
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
action_100 (63) = happyShift action_96
action_100 (67) = happyShift action_97
action_100 (20) = happyGoto action_84
action_100 (24) = happyGoto action_85
action_100 (26) = happyGoto action_86
action_100 (27) = happyGoto action_87
action_100 (28) = happyGoto action_88
action_100 (29) = happyGoto action_132
action_100 (36) = happyGoto action_90
action_100 (38) = happyGoto action_91
action_100 _ = happyReduce_64

action_101 _ = happyReduce_39

action_102 _ = happyReduce_89

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
action_103 (61) = happyShift action_30
action_103 (63) = happyShift action_31
action_103 (67) = happyShift action_32
action_103 (14) = happyGoto action_131
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
action_104 (61) = happyShift action_30
action_104 (63) = happyShift action_31
action_104 (67) = happyShift action_32
action_104 (14) = happyGoto action_130
action_104 (30) = happyGoto action_47
action_104 (33) = happyGoto action_13
action_104 (35) = happyGoto action_14
action_104 (36) = happyGoto action_15
action_104 (37) = happyGoto action_16
action_104 (38) = happyGoto action_17
action_104 _ = happyFail (happyExpListPerState 104)

action_105 _ = happyReduce_92

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
action_108 (61) = happyShift action_30
action_108 (63) = happyShift action_31
action_108 (67) = happyShift action_32
action_108 (30) = happyGoto action_129
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
action_109 (61) = happyShift action_30
action_109 (63) = happyShift action_31
action_109 (67) = happyShift action_32
action_109 (30) = happyGoto action_128
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
action_110 (61) = happyShift action_30
action_110 (63) = happyShift action_31
action_110 (67) = happyShift action_32
action_110 (30) = happyGoto action_127
action_110 (33) = happyGoto action_13
action_110 (35) = happyGoto action_14
action_110 (36) = happyGoto action_15
action_110 (37) = happyGoto action_16
action_110 (38) = happyGoto action_17
action_110 _ = happyFail (happyExpListPerState 110)

action_111 (52) = happyShift action_115
action_111 (54) = happyShift action_116
action_111 (9) = happyGoto action_111
action_111 (10) = happyGoto action_126
action_111 _ = happyReduce_21

action_112 (70) = happyShift action_125
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (69) = happyShift action_124
action_113 _ = happyReduce_24

action_114 (64) = happyShift action_123
action_114 _ = happyFail (happyExpListPerState 114)

action_115 _ = happyReduce_19

action_116 _ = happyReduce_20

action_117 (54) = happyShift action_122
action_117 (7) = happyGoto action_120
action_117 (8) = happyGoto action_121
action_117 _ = happyReduce_16

action_118 (45) = happyShift action_18
action_118 (46) = happyShift action_19
action_118 (47) = happyShift action_20
action_118 (48) = happyShift action_21
action_118 (49) = happyShift action_22
action_118 (50) = happyShift action_23
action_118 (51) = happyShift action_24
action_118 (52) = happyShift action_25
action_118 (54) = happyShift action_26
action_118 (55) = happyShift action_27
action_118 (56) = happyShift action_28
action_118 (57) = happyShift action_29
action_118 (61) = happyShift action_30
action_118 (63) = happyShift action_31
action_118 (67) = happyShift action_32
action_118 (30) = happyGoto action_119
action_118 (33) = happyGoto action_13
action_118 (35) = happyGoto action_14
action_118 (36) = happyGoto action_15
action_118 (37) = happyGoto action_16
action_118 (38) = happyGoto action_17
action_118 _ = happyFail (happyExpListPerState 118)

action_119 (65) = happyShift action_180
action_119 _ = happyFail (happyExpListPerState 119)

action_120 (71) = happyShift action_179
action_120 _ = happyReduce_17

action_121 (66) = happyShift action_178
action_121 _ = happyFail (happyExpListPerState 121)

action_122 (63) = happyShift action_41
action_122 (13) = happyGoto action_177
action_122 _ = happyReduce_26

action_123 _ = happyReduce_27

action_124 (52) = happyShift action_115
action_124 (54) = happyShift action_116
action_124 (9) = happyGoto action_111
action_124 (10) = happyGoto action_112
action_124 (11) = happyGoto action_113
action_124 (12) = happyGoto action_176
action_124 _ = happyFail (happyExpListPerState 124)

action_125 (45) = happyShift action_18
action_125 (46) = happyShift action_19
action_125 (47) = happyShift action_20
action_125 (48) = happyShift action_21
action_125 (49) = happyShift action_22
action_125 (50) = happyShift action_23
action_125 (51) = happyShift action_24
action_125 (52) = happyShift action_25
action_125 (54) = happyShift action_26
action_125 (55) = happyShift action_27
action_125 (56) = happyShift action_28
action_125 (57) = happyShift action_29
action_125 (61) = happyShift action_30
action_125 (63) = happyShift action_31
action_125 (67) = happyShift action_32
action_125 (30) = happyGoto action_175
action_125 (33) = happyGoto action_13
action_125 (35) = happyGoto action_14
action_125 (36) = happyGoto action_15
action_125 (37) = happyGoto action_16
action_125 (38) = happyGoto action_17
action_125 _ = happyFail (happyExpListPerState 125)

action_126 _ = happyReduce_22

action_127 _ = happyReduce_7

action_128 (59) = happyShift action_174
action_128 _ = happyFail (happyExpListPerState 128)

action_129 _ = happyReduce_8

action_130 _ = happyReduce_29

action_131 (64) = happyShift action_173
action_131 _ = happyFail (happyExpListPerState 131)

action_132 (66) = happyShift action_172
action_132 _ = happyFail (happyExpListPerState 132)

action_133 _ = happyReduce_70

action_134 (45) = happyShift action_18
action_134 (46) = happyShift action_19
action_134 (47) = happyShift action_20
action_134 (48) = happyShift action_21
action_134 (49) = happyShift action_22
action_134 (50) = happyShift action_23
action_134 (51) = happyShift action_24
action_134 (52) = happyShift action_25
action_134 (54) = happyShift action_26
action_134 (55) = happyShift action_27
action_134 (56) = happyShift action_28
action_134 (57) = happyShift action_29
action_134 (61) = happyShift action_30
action_134 (63) = happyShift action_31
action_134 (67) = happyShift action_32
action_134 (30) = happyGoto action_171
action_134 (33) = happyGoto action_13
action_134 (35) = happyGoto action_14
action_134 (36) = happyGoto action_15
action_134 (37) = happyGoto action_16
action_134 (38) = happyGoto action_17
action_134 _ = happyFail (happyExpListPerState 134)

action_135 (68) = happyShift action_170
action_135 _ = happyFail (happyExpListPerState 135)

action_136 _ = happyReduce_52

action_137 (64) = happyShift action_169
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (69) = happyShift action_168
action_138 _ = happyFail (happyExpListPerState 138)

action_139 _ = happyReduce_72

action_140 (49) = happyShift action_22
action_140 (51) = happyShift action_24
action_140 (52) = happyShift action_92
action_140 (54) = happyShift action_93
action_140 (56) = happyShift action_94
action_140 (58) = happyShift action_95
action_140 (63) = happyShift action_96
action_140 (67) = happyShift action_97
action_140 (20) = happyGoto action_84
action_140 (24) = happyGoto action_85
action_140 (26) = happyGoto action_86
action_140 (27) = happyGoto action_87
action_140 (28) = happyGoto action_88
action_140 (29) = happyGoto action_167
action_140 (36) = happyGoto action_90
action_140 (38) = happyGoto action_91
action_140 _ = happyReduce_64

action_141 (45) = happyShift action_18
action_141 (46) = happyShift action_19
action_141 (47) = happyShift action_20
action_141 (48) = happyShift action_21
action_141 (49) = happyShift action_22
action_141 (50) = happyShift action_23
action_141 (51) = happyShift action_24
action_141 (52) = happyShift action_25
action_141 (54) = happyShift action_26
action_141 (55) = happyShift action_27
action_141 (56) = happyShift action_28
action_141 (57) = happyShift action_29
action_141 (61) = happyShift action_30
action_141 (63) = happyShift action_31
action_141 (67) = happyShift action_32
action_141 (30) = happyGoto action_166
action_141 (33) = happyGoto action_13
action_141 (35) = happyGoto action_14
action_141 (36) = happyGoto action_15
action_141 (37) = happyGoto action_16
action_141 (38) = happyGoto action_17
action_141 _ = happyFail (happyExpListPerState 141)

action_142 (49) = happyShift action_22
action_142 (51) = happyShift action_24
action_142 (52) = happyShift action_92
action_142 (54) = happyShift action_93
action_142 (56) = happyShift action_94
action_142 (58) = happyShift action_95
action_142 (63) = happyShift action_96
action_142 (67) = happyShift action_97
action_142 (20) = happyGoto action_84
action_142 (24) = happyGoto action_85
action_142 (26) = happyGoto action_86
action_142 (27) = happyGoto action_165
action_142 (36) = happyGoto action_90
action_142 (38) = happyGoto action_91
action_142 _ = happyFail (happyExpListPerState 142)

action_143 _ = happyReduce_49

action_144 (49) = happyShift action_22
action_144 (51) = happyShift action_24
action_144 (52) = happyShift action_92
action_144 (54) = happyShift action_93
action_144 (56) = happyShift action_94
action_144 (58) = happyShift action_95
action_144 (63) = happyShift action_148
action_144 (67) = happyShift action_97
action_144 (20) = happyGoto action_143
action_144 (21) = happyGoto action_144
action_144 (22) = happyGoto action_164
action_144 (24) = happyGoto action_146
action_144 (25) = happyGoto action_147
action_144 (36) = happyGoto action_90
action_144 (38) = happyGoto action_91
action_144 _ = happyReduce_45

action_145 _ = happyReduce_60

action_146 _ = happyReduce_57

action_147 _ = happyReduce_42

action_148 (49) = happyShift action_22
action_148 (51) = happyShift action_24
action_148 (52) = happyShift action_162
action_148 (54) = happyShift action_163
action_148 (56) = happyShift action_94
action_148 (58) = happyShift action_95
action_148 (63) = happyShift action_96
action_148 (67) = happyShift action_97
action_148 (15) = happyGoto action_160
action_148 (20) = happyGoto action_161
action_148 (23) = happyGoto action_137
action_148 (24) = happyGoto action_85
action_148 (26) = happyGoto action_138
action_148 (36) = happyGoto action_90
action_148 (38) = happyGoto action_91
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (69) = happyShift action_159
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (66) = happyShift action_158
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (69) = happyShift action_157
action_151 _ = happyFail (happyExpListPerState 151)

action_152 _ = happyReduce_83

action_153 (45) = happyShift action_18
action_153 (46) = happyShift action_19
action_153 (47) = happyShift action_20
action_153 (48) = happyShift action_21
action_153 (49) = happyShift action_22
action_153 (50) = happyShift action_23
action_153 (51) = happyShift action_24
action_153 (52) = happyShift action_78
action_153 (54) = happyShift action_79
action_153 (55) = happyShift action_27
action_153 (56) = happyShift action_28
action_153 (57) = happyShift action_29
action_153 (61) = happyShift action_30
action_153 (63) = happyShift action_31
action_153 (67) = happyShift action_32
action_153 (15) = happyGoto action_74
action_153 (30) = happyGoto action_75
action_153 (31) = happyGoto action_76
action_153 (32) = happyGoto action_156
action_153 (33) = happyGoto action_13
action_153 (35) = happyGoto action_14
action_153 (36) = happyGoto action_15
action_153 (37) = happyGoto action_16
action_153 (38) = happyGoto action_17
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (45) = happyShift action_18
action_154 (46) = happyShift action_19
action_154 (47) = happyShift action_20
action_154 (48) = happyShift action_21
action_154 (49) = happyShift action_22
action_154 (50) = happyShift action_23
action_154 (51) = happyShift action_24
action_154 (52) = happyShift action_25
action_154 (54) = happyShift action_26
action_154 (55) = happyShift action_27
action_154 (56) = happyShift action_28
action_154 (57) = happyShift action_29
action_154 (61) = happyShift action_30
action_154 (63) = happyShift action_31
action_154 (67) = happyShift action_32
action_154 (30) = happyGoto action_155
action_154 (33) = happyGoto action_13
action_154 (35) = happyGoto action_14
action_154 (36) = happyGoto action_15
action_154 (37) = happyGoto action_16
action_154 (38) = happyGoto action_17
action_154 _ = happyFail (happyExpListPerState 154)

action_155 _ = happyReduce_75

action_156 _ = happyReduce_77

action_157 (45) = happyShift action_18
action_157 (46) = happyShift action_19
action_157 (47) = happyShift action_20
action_157 (48) = happyShift action_21
action_157 (49) = happyShift action_22
action_157 (50) = happyShift action_23
action_157 (51) = happyShift action_24
action_157 (52) = happyShift action_25
action_157 (54) = happyShift action_26
action_157 (55) = happyShift action_27
action_157 (56) = happyShift action_28
action_157 (57) = happyShift action_29
action_157 (61) = happyShift action_30
action_157 (63) = happyShift action_31
action_157 (67) = happyShift action_32
action_157 (30) = happyGoto action_192
action_157 (33) = happyGoto action_13
action_157 (35) = happyGoto action_14
action_157 (36) = happyGoto action_15
action_157 (37) = happyGoto action_16
action_157 (38) = happyGoto action_17
action_157 _ = happyFail (happyExpListPerState 157)

action_158 _ = happyReduce_69

action_159 (45) = happyShift action_18
action_159 (46) = happyShift action_19
action_159 (47) = happyShift action_20
action_159 (48) = happyShift action_21
action_159 (49) = happyShift action_22
action_159 (50) = happyShift action_23
action_159 (51) = happyShift action_24
action_159 (52) = happyShift action_25
action_159 (54) = happyShift action_26
action_159 (55) = happyShift action_27
action_159 (56) = happyShift action_28
action_159 (57) = happyShift action_29
action_159 (61) = happyShift action_30
action_159 (63) = happyShift action_31
action_159 (67) = happyShift action_32
action_159 (30) = happyGoto action_191
action_159 (33) = happyGoto action_13
action_159 (35) = happyGoto action_14
action_159 (36) = happyGoto action_15
action_159 (37) = happyGoto action_16
action_159 (38) = happyGoto action_17
action_159 _ = happyFail (happyExpListPerState 159)

action_160 (59) = happyShift action_190
action_160 _ = happyFail (happyExpListPerState 160)

action_161 (49) = happyShift action_22
action_161 (51) = happyShift action_24
action_161 (52) = happyShift action_92
action_161 (54) = happyShift action_93
action_161 (56) = happyShift action_94
action_161 (58) = happyShift action_95
action_161 (63) = happyShift action_148
action_161 (67) = happyShift action_97
action_161 (20) = happyGoto action_143
action_161 (21) = happyGoto action_144
action_161 (22) = happyGoto action_189
action_161 (24) = happyGoto action_146
action_161 (25) = happyGoto action_147
action_161 (36) = happyGoto action_90
action_161 (38) = happyGoto action_91
action_161 _ = happyReduce_49

action_162 (64) = happyShift action_188
action_162 (69) = happyReduce_50
action_162 _ = happyReduce_30

action_163 (59) = happyReduce_31
action_163 _ = happyReduce_40

action_164 _ = happyReduce_46

action_165 _ = happyReduce_62

action_166 _ = happyReduce_63

action_167 _ = happyReduce_66

action_168 (49) = happyShift action_22
action_168 (51) = happyShift action_24
action_168 (52) = happyShift action_92
action_168 (54) = happyShift action_93
action_168 (56) = happyShift action_94
action_168 (58) = happyShift action_95
action_168 (63) = happyShift action_96
action_168 (67) = happyShift action_97
action_168 (20) = happyGoto action_84
action_168 (23) = happyGoto action_186
action_168 (24) = happyGoto action_85
action_168 (26) = happyGoto action_187
action_168 (36) = happyGoto action_90
action_168 (38) = happyGoto action_91
action_168 _ = happyFail (happyExpListPerState 168)

action_169 _ = happyReduce_51

action_170 _ = happyReduce_53

action_171 (64) = happyShift action_185
action_171 _ = happyFail (happyExpListPerState 171)

action_172 _ = happyReduce_71

action_173 _ = happyReduce_91

action_174 (45) = happyShift action_18
action_174 (46) = happyShift action_19
action_174 (47) = happyShift action_20
action_174 (48) = happyShift action_21
action_174 (49) = happyShift action_22
action_174 (50) = happyShift action_23
action_174 (51) = happyShift action_24
action_174 (52) = happyShift action_25
action_174 (54) = happyShift action_26
action_174 (55) = happyShift action_27
action_174 (56) = happyShift action_28
action_174 (57) = happyShift action_29
action_174 (61) = happyShift action_30
action_174 (63) = happyShift action_31
action_174 (67) = happyShift action_32
action_174 (30) = happyGoto action_184
action_174 (33) = happyGoto action_13
action_174 (35) = happyGoto action_14
action_174 (36) = happyGoto action_15
action_174 (37) = happyGoto action_16
action_174 (38) = happyGoto action_17
action_174 _ = happyFail (happyExpListPerState 174)

action_175 _ = happyReduce_23

action_176 _ = happyReduce_25

action_177 (70) = happyShift action_183
action_177 _ = happyReduce_14

action_178 _ = happyReduce_5

action_179 (54) = happyShift action_122
action_179 (7) = happyGoto action_120
action_179 (8) = happyGoto action_182
action_179 _ = happyReduce_16

action_180 (54) = happyShift action_122
action_180 (7) = happyGoto action_120
action_180 (8) = happyGoto action_181
action_180 _ = happyReduce_16

action_181 (66) = happyShift action_197
action_181 _ = happyFail (happyExpListPerState 181)

action_182 _ = happyReduce_18

action_183 (45) = happyShift action_18
action_183 (46) = happyShift action_19
action_183 (47) = happyShift action_20
action_183 (48) = happyShift action_21
action_183 (49) = happyShift action_22
action_183 (50) = happyShift action_23
action_183 (51) = happyShift action_24
action_183 (52) = happyShift action_25
action_183 (54) = happyShift action_26
action_183 (55) = happyShift action_27
action_183 (56) = happyShift action_28
action_183 (57) = happyShift action_29
action_183 (61) = happyShift action_30
action_183 (63) = happyShift action_31
action_183 (67) = happyShift action_32
action_183 (30) = happyGoto action_196
action_183 (33) = happyGoto action_13
action_183 (35) = happyGoto action_14
action_183 (36) = happyGoto action_15
action_183 (37) = happyGoto action_16
action_183 (38) = happyGoto action_17
action_183 _ = happyFail (happyExpListPerState 183)

action_184 _ = happyReduce_9

action_185 _ = happyReduce_37

action_186 _ = happyReduce_48

action_187 (69) = happyShift action_168
action_187 _ = happyReduce_47

action_188 _ = happyReduce_44

action_189 (64) = happyShift action_195
action_189 _ = happyReduce_60

action_190 (49) = happyShift action_22
action_190 (51) = happyShift action_24
action_190 (52) = happyShift action_92
action_190 (54) = happyShift action_93
action_190 (56) = happyShift action_94
action_190 (58) = happyShift action_95
action_190 (63) = happyShift action_194
action_190 (67) = happyShift action_97
action_190 (20) = happyGoto action_143
action_190 (24) = happyGoto action_146
action_190 (25) = happyGoto action_193
action_190 (36) = happyGoto action_90
action_190 (38) = happyGoto action_91
action_190 _ = happyFail (happyExpListPerState 190)

action_191 _ = happyReduce_68

action_192 _ = happyReduce_67

action_193 (64) = happyShift action_198
action_193 _ = happyFail (happyExpListPerState 193)

action_194 (49) = happyShift action_22
action_194 (51) = happyShift action_24
action_194 (52) = happyShift action_92
action_194 (54) = happyShift action_93
action_194 (56) = happyShift action_94
action_194 (58) = happyShift action_95
action_194 (63) = happyShift action_96
action_194 (67) = happyShift action_97
action_194 (20) = happyGoto action_161
action_194 (23) = happyGoto action_137
action_194 (24) = happyGoto action_85
action_194 (26) = happyGoto action_138
action_194 (36) = happyGoto action_90
action_194 (38) = happyGoto action_91
action_194 _ = happyFail (happyExpListPerState 194)

action_195 _ = happyReduce_58

action_196 _ = happyReduce_15

action_197 _ = happyReduce_6

action_198 _ = happyReduce_43

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
happyReduction_20 (HappyTerminal (TokenUSym happy_var_1))
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

happyReduce_31 = happySpecReduce_1  15 happyReduction_31
happyReduction_31 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  16 happyReduction_32
happyReduction_32 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  16 happyReduction_33
happyReduction_33 _
	 =  HappyAbsSyn15
		 ("_"
	)

happyReduce_34 = happySpecReduce_1  17 happyReduction_34
happyReduction_34 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| []
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_2  17 happyReduction_35
happyReduction_35 (HappyAbsSyn17  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  18 happyReduction_36
happyReduction_36 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn11
		 ((happy_var_1 :| [], Nothing, [])
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happyReduce 5 18 happyReduction_37
happyReduction_37 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn11
		 ((happy_var_2, Just happy_var_4, [])
	) `HappyStk` happyRest

happyReduce_38 = happySpecReduce_1  19 happyReduction_38
happyReduction_38 (HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 :| []
	)
happyReduction_38 _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  19 happyReduction_39
happyReduction_39 (HappyAbsSyn19  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn19
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  20 happyReduction_40
happyReduction_40 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_1  20 happyReduction_41
happyReduction_41 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_41 _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  21 happyReduction_42
happyReduction_42 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn21
		 (Right happy_var_1
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happyReduce 5 21 happyReduction_43
happyReduction_43 (_ `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn21
		 (Left (P.Implicit happy_var_2 happy_var_4)
	) `HappyStk` happyRest

happyReduce_44 = happySpecReduce_3  21 happyReduction_44
happyReduction_44 _
	(HappyTerminal (TokenLSym happy_var_2))
	_
	 =  HappyAbsSyn21
		 (Left (P.PunnedImplicit happy_var_2)
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  22 happyReduction_45
happyReduction_45 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| []
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  22 happyReduction_46
happyReduction_46 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_1 :| toList happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

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

happyReduce_50 = happySpecReduce_1  24 happyReduction_50
happyReduction_50 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn24
		 (P.Variable happy_var_1
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  24 happyReduction_51
happyReduction_51 _
	(HappyAbsSyn23  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.Tuple happy_var_2
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_2  24 happyReduction_52
happyReduction_52 _
	_
	 =  HappyAbsSyn24
		 (P.List []
	)

happyReduce_53 = happySpecReduce_3  24 happyReduction_53
happyReduction_53 _
	(HappyAbsSyn27  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (P.List happy_var_2
	)
happyReduction_53 _ _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  24 happyReduction_54
happyReduction_54 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_1  24 happyReduction_55
happyReduction_55 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Literal happy_var_1
	)
happyReduction_55 _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  24 happyReduction_56
happyReduction_56 _
	 =  HappyAbsSyn24
		 (Wildcard
	)

happyReduce_57 = happySpecReduce_1  25 happyReduction_57
happyReduction_57 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_57 _  = notHappyAtAll 

happyReduce_58 = happyReduce 4 25 happyReduction_58
happyReduction_58 (_ `HappyStk`
	(HappyAbsSyn22  happy_var_3) `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (P.Data happy_var_2 (toList happy_var_3)
	) `HappyStk` happyRest

happyReduce_59 = happySpecReduce_1  26 happyReduction_59
happyReduction_59 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn24
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_2  26 happyReduction_60
happyReduction_60 (HappyAbsSyn22  happy_var_2)
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn24
		 (P.Data happy_var_1 (toList happy_var_2)
	)
happyReduction_60 _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  27 happyReduction_61
happyReduction_61 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn27
		 ([happy_var_1]
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_3  27 happyReduction_62
happyReduction_62 (HappyAbsSyn27  happy_var_3)
	_
	(HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1 : happy_var_3
	)
happyReduction_62 _ _ _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  28 happyReduction_63
happyReduction_63 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn28
		 ((happy_var_1, happy_var_3)
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_0  29 happyReduction_64
happyReduction_64  =  HappyAbsSyn29
		 ([]
	)

happyReduce_65 = happySpecReduce_1  29 happyReduction_65
happyReduction_65 (HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 ([happy_var_1]
	)
happyReduction_65 _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  29 happyReduction_66
happyReduction_66 (HappyAbsSyn29  happy_var_3)
	_
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn29
		 (happy_var_1 : happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happyReduce 6 30 happyReduction_67
happyReduction_67 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenLSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Let happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_68 = happyReduce 6 30 happyReduction_68
happyReduction_68 ((HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn17  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (ForAll happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_69 = happyReduce 5 30 happyReduction_69
happyReduction_69 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn14  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Case happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 4 30 happyReduction_70
happyReduction_70 ((HappyAbsSyn30  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Lambda happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_71 = happyReduce 5 30 happyReduction_71
happyReduction_71 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn19  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (LambdaCase (toList happy_var_2) happy_var_4
	) `HappyStk` happyRest

happyReduce_72 = happyReduce 4 30 happyReduction_72
happyReduction_72 (_ `HappyStk`
	(HappyAbsSyn29  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (LambdaCase [] happy_var_3
	) `HappyStk` happyRest

happyReduce_73 = happySpecReduce_1  30 happyReduction_73
happyReduction_73 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_73 _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_1  31 happyReduction_74
happyReduction_74 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn31
		 ((Nothing, happy_var_1)
	)
happyReduction_74 _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  31 happyReduction_75
happyReduction_75 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn31
		 ((Just happy_var_1, happy_var_3)
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  32 happyReduction_76
happyReduction_76 (HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1 :| []
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  32 happyReduction_77
happyReduction_77 (HappyAbsSyn32  happy_var_3)
	_
	(HappyAbsSyn31  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_1 :| toList happy_var_3
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  33 happyReduction_78
happyReduction_78 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Arrow happy_var_1 happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_3  33 happyReduction_79
happyReduction_79 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenLSym happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (QName [] happy_var_2) happy_var_3
	)
happyReduction_79 _ _ _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_3  33 happyReduction_80
happyReduction_80 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenUSym happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (QName [] happy_var_2) happy_var_3
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_3  33 happyReduction_81
happyReduction_81 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenLSymQ happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (uncurry QName happy_var_2) happy_var_3
	)
happyReduction_81 _ _ _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  33 happyReduction_82
happyReduction_82 (HappyAbsSyn30  happy_var_3)
	(HappyTerminal (TokenUSymQ happy_var_2))
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (Infix happy_var_1 (uncurry QName happy_var_2) happy_var_3
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happyReduce 4 33 happyReduction_83
happyReduction_83 (_ `HappyStk`
	(HappyAbsSyn32  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Application happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_84 = happySpecReduce_1  33 happyReduction_84
happyReduction_84 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  34 happyReduction_85
happyReduction_85 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  34 happyReduction_86
happyReduction_86 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn20
		 (QName [] happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  34 happyReduction_87
happyReduction_87 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  34 happyReduction_88
happyReduction_88 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn20
		 (uncurry QName happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  35 happyReduction_89
happyReduction_89 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (Parenthesized happy_var_2
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_2  35 happyReduction_90
happyReduction_90 _
	_
	 =  HappyAbsSyn30
		 (Literal UnitLiteral
	)

happyReduce_91 = happyReduce 5 35 happyReduction_91
happyReduction_91 (_ `HappyStk`
	(HappyAbsSyn14  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (Tuple (happy_var_2 : happy_var_4)
	) `HappyStk` happyRest

happyReduce_92 = happySpecReduce_3  35 happyReduction_92
happyReduction_92 _
	(HappyAbsSyn14  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (List happy_var_2
	)
happyReduction_92 _ _ _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_1  35 happyReduction_93
happyReduction_93 _
	 =  HappyAbsSyn30
		 (Meta
	)

happyReduce_94 = happySpecReduce_1  35 happyReduction_94
happyReduction_94 (HappyTerminal (TokenLSym happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  35 happyReduction_95
happyReduction_95 (HappyTerminal (TokenUSym happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (QName [] happy_var_1)
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  35 happyReduction_96
happyReduction_96 (HappyTerminal (TokenLSymQ happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_1  35 happyReduction_97
happyReduction_97 (HappyTerminal (TokenUSymQ happy_var_1))
	 =  HappyAbsSyn30
		 (Identifier (uncurry QName happy_var_1)
	)
happyReduction_97 _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  35 happyReduction_98
happyReduction_98 _
	 =  HappyAbsSyn30
		 (Type
	)

happyReduce_99 = happySpecReduce_1  35 happyReduction_99
happyReduction_99 (HappyAbsSyn36  happy_var_1)
	 =  HappyAbsSyn30
		 (Literal happy_var_1
	)
happyReduction_99 _  = notHappyAtAll 

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

happyReduce_102 = happySpecReduce_1  36 happyReduction_102
happyReduction_102 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn36
		 (uncurry IntegerLiteral happy_var_1
	)
happyReduction_102 _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  37 happyReduction_103
happyReduction_103 (HappyTerminal (TokenFloat happy_var_1))
	 =  HappyAbsSyn36
		 (uncurry (FloatLiteral (fst happy_var_1)) (snd happy_var_1)
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  38 happyReduction_104
happyReduction_104 (HappyTerminal (TokenString happy_var_1))
	 =  HappyAbsSyn36
		 (StringLiteral happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 72 72 notHappyAtAll (HappyState action) sts stk []

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
	TokenQuestionMark -> cont 61;
	TokenInfixOp happy_dollar_dollar -> cont 62;
	TokenLParen -> cont 63;
	TokenRParen -> cont 64;
	TokenLBrace -> cont 65;
	TokenRBrace -> cont 66;
	TokenLBracket -> cont 67;
	TokenRBracket -> cont 68;
	TokenComma -> cont 69;
	TokenColon -> cont 70;
	TokenSemicolon -> cont 71;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 72 tk tks = happyError' (tks, explist)
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
