module Types where

import Data.Enum
import Data.Maybe
import Data.Map

-- Cube, Stack, Wall

data Cube = Blue | Brown | Red | Orange | Yellow

instance showCube :: Show Cube where
    show Blue = "Blue"
    show Brown = "Brown"
    show Red = "Red"
    show Orange = "Orange"
    show Yellow = "Yellow"

instance eqCube :: Eq Cube where
    (==) a b = fromEnum a == fromEnum b
    (/=) a b = not (a == b)

instance ordCube :: Ord Cube where
    compare a b = fromEnum a `compare` fromEnum b

instance enumCube :: Enum Cube where
    cardinality = Cardinality 5
    firstEnum = cubeFirst
    lastEnum = cubeLast
    succ = defaultSucc cubeToEnum cubeFromEnum
    pred = defaultPred cubeToEnum cubeFromEnum
    toEnum = cubeToEnum
    fromEnum = cubeFromEnum

cubeFirst = Blue
cubeLast = Yellow

cubeFromEnum Blue = 0
cubeFromEnum Brown = 1
cubeFromEnum Red = 2
cubeFromEnum Orange = 3
cubeFromEnum Yellow = 4

cubeToEnum 0 = Just Blue
cubeToEnum 1 = Just Brown
cubeToEnum 2 = Just Red
cubeToEnum 3 = Just Orange
cubeToEnum 4 = Just Yellow
cubeToEnum _ = Nothing

type Stack = [Cube]

type Wall = [Stack]

-- Transformer
type Transformer = Wall -> Wall

type TransformerId = String

type TransformerRecord = {
    id :: TransformerId,
    name :: String,
    function :: Transformer
}

-- Levels and chapters

type LevelId = String

type ChapterId = String

type Level = {
    id :: LevelId,
    name :: String,
    initial :: Wall,
    target :: Wall
}

type Chapter = {
    id :: ChapterId,
    name :: String,
    transformers :: [TransformerRecord],
    levels :: [Level]
}

-- Game state

type GameState = {
    currentLevel :: LevelId,
    levelState :: Map LevelId [TransformerId]
}
