module Test.Dragen2.BoundedArbitrary where

import GHC.TypeLits
import Data.Kind
import Test.QuickCheck

import Test.Dragen2.Algebra
import Test.Dragen2.TypeLevel

----------------------------------------
-- | Depth-bounded arbitrary generation

type MaxDepth = Int
type BoundedGen a = MaxDepth -> Gen a


class BoundedArbitrary (a :: Type) where
  boundedArbitrary :: BoundedGen a


newtype DepthBounded (n :: Nat) (a :: Type)
  = MkDepthBounded
  { getDepthBounded :: a
  } deriving (Show, Functor)

instance (KnownNat d, BoundedArbitrary a) => Arbitrary (DepthBounded d a) where
  arbitrary = MkDepthBounded <$> boundedArbitrary (max 0 (numVal @d))

-- | This global instance exists as a workaround of TH's stage restriction.
-- More info coming soon.
instance {-# OVERLAPPABLE #-} BoundedArbitrary a where
  boundedArbitrary = error "BoundedArbitrary: default dummy instance called"

----------------------------------------
-- | Depth-bounded arbitrary generation of parametric types

class BoundedArbitrary1 (f :: Type -> Type) where
  liftBoundedGen :: BoundedGen a -> BoundedGen (f a)

instance BoundedArbitrary1 f => BoundedArbitrary (Fix f) where
  boundedArbitrary depth = Fix <$> liftBoundedGen boundedArbitrary depth


genFix :: forall f. BoundedArbitrary1 f => BoundedGen (Fix f)
genFix = boundedArbitrary @(Fix f)

genEval :: forall f a. (BoundedArbitrary1 f, Algebra f a) => BoundedGen a
genEval depth = eval <$> genFix @f depth
