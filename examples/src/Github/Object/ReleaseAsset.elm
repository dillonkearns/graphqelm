-- Do not manually edit this file, it was auto-generated by Graphqelm
-- https://github.com/dillonkearns/graphqelm


module Github.Object.ReleaseAsset exposing (..)

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
selection : (a -> constructor) -> SelectionSet (a -> constructor) Github.Object.ReleaseAsset
selection constructor =
    Object.selection constructor


{-| The asset's content-type
-}
contentType : Field String Github.Object.ReleaseAsset
contentType =
    Object.fieldDecoder "contentType" [] Decode.string


{-| Identifies the date and time when the object was created.
-}
createdAt : Field Github.Scalar.DateTime Github.Object.ReleaseAsset
createdAt =
    Object.fieldDecoder "createdAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime)


{-| The number of times this asset was downloaded
-}
downloadCount : Field Int Github.Object.ReleaseAsset
downloadCount =
    Object.fieldDecoder "downloadCount" [] Decode.int


{-| Identifies the URL where you can download the release asset via the browser.
-}
downloadUrl : Field Github.Scalar.Uri Github.Object.ReleaseAsset
downloadUrl =
    Object.fieldDecoder "downloadUrl" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Uri)


id : Field Github.Scalar.Id Github.Object.ReleaseAsset
id =
    Object.fieldDecoder "id" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Id)


{-| Identifies the title of the release asset.
-}
name : Field String Github.Object.ReleaseAsset
name =
    Object.fieldDecoder "name" [] Decode.string


{-| Release that the asset is associated with
-}
release : SelectionSet decodesTo Github.Object.Release -> Field (Maybe decodesTo) Github.Object.ReleaseAsset
release object =
    Object.selectionField "release" [] object (identity >> Decode.nullable)


{-| The size (in bytes) of the asset
-}
size : Field Int Github.Object.ReleaseAsset
size =
    Object.fieldDecoder "size" [] Decode.int


{-| Identifies the date and time when the object was last updated.
-}
updatedAt : Field Github.Scalar.DateTime Github.Object.ReleaseAsset
updatedAt =
    Object.fieldDecoder "updatedAt" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.DateTime)


{-| The user that performed the upload
-}
uploadedBy : SelectionSet decodesTo Github.Object.User -> Field decodesTo Github.Object.ReleaseAsset
uploadedBy object =
    Object.selectionField "uploadedBy" [] object identity


{-| Identifies the URL of the release asset.
-}
url : Field Github.Scalar.Uri Github.Object.ReleaseAsset
url =
    Object.fieldDecoder "url" [] (Decode.oneOf [ Decode.string, Decode.float |> Decode.map toString, Decode.int |> Decode.map toString, Decode.bool |> Decode.map toString ] |> Decode.map Github.Scalar.Uri)
