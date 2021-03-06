module Generator.OptionalArgsTests exposing (all)

import Expect
import Graphqelm.Generator.Let exposing (LetBinding)
import Graphqelm.Generator.OptionalArgs as OptionalArgs
import Graphqelm.Parser.CamelCaseName as CamelCaseName
import Graphqelm.Parser.ClassCaseName as ClassCaseName
import Graphqelm.Parser.Scalar as Scalar
import Graphqelm.Parser.Type as Type
import Test exposing (Test, describe, test)


all : Test
all =
    describe "optional args generator"
        [ test "no args" <|
            \() ->
                []
                    |> OptionalArgs.generate [ "Api" ]
                    |> Expect.equal Nothing
        , test "no optional args, only required" <|
            \() ->
                [ { name = CamelCaseName.build "id"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.NonNullable
                  }
                ]
                    |> OptionalArgs.generate [ "Api" ]
                    |> Expect.equal Nothing
        , test "with an optional string arg" <|
            \() ->
                [ { name = CamelCaseName.build "contains"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate [ "Api" ]
                    |> expectResult
                        { typeAlias = "{ contains : OptionalArgument String }"
                        , letBindings =
                            [ "filledInOptionals" => "fillInOptionals { contains = Absent }"
                            , "optionalArgs" => """[ Argument.optional "contains" filledInOptionals.contains (Encode.string) ]
                |> List.filterMap identity"""
                            ]
                        }
        , test "with multiple optional string args" <|
            \() ->
                [ { name = CamelCaseName.build "id"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                , { name = CamelCaseName.build "contains"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.String) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate [ "Api" ]
                    |> expectResult
                        { typeAlias = "{ id : OptionalArgument String, contains : OptionalArgument String }"
                        , letBindings =
                            [ "filledInOptionals" => "fillInOptionals { id = Absent, contains = Absent }"
                            , "optionalArgs" => """[ Argument.optional "id" filledInOptionals.id (Encode.string), Argument.optional "contains" filledInOptionals.contains (Encode.string) ]
                |> List.filterMap identity"""
                            ]
                        }
        , test "with an optional int arg" <|
            \() ->
                [ { name = CamelCaseName.build "first"
                  , description = Nothing
                  , typeRef = Type.TypeReference (Type.Scalar Scalar.Int) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate [ "Api" ]
                    |> expectResult
                        { letBindings =
                            [ "filledInOptionals" => "fillInOptionals { first = Absent }"
                            , "optionalArgs" => """[ Argument.optional "first" filledInOptionals.first (Encode.int) ]
                |> List.filterMap identity"""
                            ]
                        , typeAlias = "{ first : OptionalArgument Int }"
                        }
        , test "with an optional enum arg" <|
            \() ->
                [ { name = CamelCaseName.build "episode"
                  , description = Nothing
                  , typeRef = Type.TypeReference ("Episode" |> ClassCaseName.build |> Type.EnumRef) Type.Nullable
                  }
                ]
                    |> OptionalArgs.generate [ "Api" ]
                    |> expectResult
                        { typeAlias = "{ episode : OptionalArgument Api.Enum.Episode.Episode }"
                        , letBindings =
                            [ "filledInOptionals" => "fillInOptionals { episode = Absent }"
                            , "optionalArgs" => """[ Argument.optional "episode" filledInOptionals.episode ((Encode.enum Api.Enum.Episode.toString)) ]
                |> List.filterMap identity"""
                            ]
                        }
        ]


expectResult :
    { letBindings : List LetBinding
    , typeAlias : String
    }
    -> Maybe OptionalArgs.Result
    -> Expect.Expectation
expectResult expected actual =
    actual
        |> Maybe.map (\value -> { value | annotatedArg = value.annotatedArg "Foo" })
        |> Maybe.map (\value -> { value | typeAlias = value.typeAlias.body })
        |> Maybe.map
            (\value ->
                { letBindings = value.letBindings
                , typeAlias = value.typeAlias
                }
            )
        |> Expect.equal (Just expected)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)
