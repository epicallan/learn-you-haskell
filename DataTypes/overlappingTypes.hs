-- Normally, we cannot write an instance of a typeclass for a specialized version of a polymorphic type.
-- The [Char] type is the polymorphic type [a] specialized to the type Char.
-- We are thus prohibited from declaring [Char] to be an instance of a typeclass.
-- This is highly inconvenient, since strings are ubiquitous in real code.


{-# LANGUAGE TypeSynonymInstances, OverlappingInstances #-}

import Data.List

class Foo a where
    foo :: a -> String

instance Foo a => Foo [a] where
    foo = intercalate ", " . map foo

instance Foo Char where
    foo c = [c]

instance Foo String where
    foo = id
