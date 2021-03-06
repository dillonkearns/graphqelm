-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.ReviewRequest exposing (..)

import Github.InputObject
import Github.Interface
import Github.Object
import Github.Scalar
import Github.Union
import Graphqelm.Field as Field exposing (Field)
import Graphqelm.Internal.Builder.Argument as Argument exposing (Argument)
import Graphqelm.Internal.Builder.Object as Object
import Graphqelm.Internal.Encode as Encode exposing (Value)
import Graphqelm.OptionalArgument exposing (OptionalArgument(Absent))
import Graphqelm.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| Select fields to build up a SelectionSet for this object.
-}
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReviewRequest
selection constructor =
    Object.selection constructor


{-| Identifies the primary key from the database.
-}
databaseId : Field (Maybe Int) Github.Object.ReviewRequest
databaseId =
    Object.fieldDecoder "databaseId" [] (Decode.int |> Decode.nullable)


id : Field Github.Scalar.Id Github.Object.ReviewRequest
id =
    Object.fieldDecoder "id" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Id)


{-| Identifies the pull request associated with this review request.
-}
pullRequest : SelectionSet decodesTo Github.Object.PullRequest -> Field decodesTo Github.Object.ReviewRequest
pullRequest object =
    Object.selectionField "pullRequest" [] object identity


{-| The reviewer that is requested.
-}
requestedReviewer : SelectionSet decodesTo Github.Union.RequestedReviewer -> Field (Maybe decodesTo) Github.Object.ReviewRequest
requestedReviewer object =
    Object.selectionField "requestedReviewer" [] object (identity >> Decode.nullable)


{-| Identifies the author associated with this review request.
-}
reviewer : SelectionSet decodesTo Github.Object.User -> Field (Maybe decodesTo) Github.Object.ReviewRequest
reviewer object =
    Object.selectionField "reviewer" [] object (identity >> Decode.nullable)
