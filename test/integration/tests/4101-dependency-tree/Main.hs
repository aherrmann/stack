import Control.Monad (when)
import StackTest
import System.Directory (getCurrentDirectory)

main :: IO ()
main =
  if isWindows
  then do return ()
  else do

  stackCheckStdout ["ls", "dependencies", "tree"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "├─┬ files 0.1.0.0"
                           , "│ ├─┬ base 4.12.0.0"
                           , "│ │ ├─┬ ghc-prim 0.5.3"
                           , "│ │ │ └── rts 1.0"
                           , "│ │ ├─┬ integer-gmp 1.0.2.0"
                           , "│ │ │ └─┬ ghc-prim 0.5.3"
                           , "│ │ │   └── rts 1.0"
                           , "│ │ └── rts 1.0"
                           , "│ ├─┬ filelock 0.1.1.2"
                           , "│ │ ├─┬ base 4.12.0.0"
                           , "│ │ │ ├─┬ ghc-prim 0.5.3"
                           , "│ │ │ │ └── rts 1.0"
                           , "│ │ │ ├─┬ integer-gmp 1.0.2.0"
                           , "│ │ │ │ └─┬ ghc-prim 0.5.3"
                           , "│ │ │ │   └── rts 1.0"
                           , "│ │ │ └── rts 1.0"
                           , "│ │ └─┬ unix 2.7.2.2"
                           , "│ │   ├─┬ base 4.12.0.0"
                           , "│ │   │ ├─┬ ghc-prim 0.5.3"
                           , "│ │   │ │ └── rts 1.0"
                           , "│ │   │ ├─┬ integer-gmp 1.0.2.0"
                           , "│ │   │ │ └─┬ ghc-prim 0.5.3"
                           , "│ │   │ │   └── rts 1.0"
                           , "│ │   │ └── rts 1.0"
                           , "│ │   ├─┬ bytestring 0.10.8.2"
                           , "│ │   │ ├─┬ base 4.12.0.0"
                           , "│ │   │ │ ├─┬ ghc-prim 0.5.3"
                           , "│ │   │ │ │ └── rts 1.0"
                           , "│ │   │ │ ├─┬ integer-gmp 1.0.2.0"
                           , "│ │   │ │ │ └─┬ ghc-prim 0.5.3"
                           , "│ │   │ │ │   └── rts 1.0"
                           , "│ │   │ │ └── rts 1.0"
                           , "│ │   │ ├─┬ deepseq 1.4.4.0"
                           , "│ │   │ │ ├─┬ array 0.5.3.0"
                           , "│ │   │ │ │ └─┬ base 4.12.0.0"
                           , "│ │   │ │ │   ├─┬ ghc-prim 0.5.3"
                           , "│ │   │ │ │   │ └── rts 1.0"
                           , "│ │   │ │ │   ├─┬ integer-gmp 1.0.2.0"
                           , "│ │   │ │ │   │ └─┬ ghc-prim 0.5.3"
                           , "│ │   │ │ │   │   └── rts 1.0"
                           , "│ │   │ │ │   └── rts 1.0"
                           , "│ │   │ │ └─┬ base 4.12.0.0"
                           , "│ │   │ │   ├─┬ ghc-prim 0.5.3"
                           , "│ │   │ │   │ └── rts 1.0"
                           , "│ │   │ │   ├─┬ integer-gmp 1.0.2.0"
                           , "│ │   │ │   │ └─┬ ghc-prim 0.5.3"
                           , "│ │   │ │   │   └── rts 1.0"
                           , "│ │   │ │   └── rts 1.0"
                           , "│ │   │ ├─┬ ghc-prim 0.5.3"
                           , "│ │   │ │ └── rts 1.0"
                           , "│ │   │ └─┬ integer-gmp 1.0.2.0"
                           , "│ │   │   └─┬ ghc-prim 0.5.3"
                           , "│ │   │     └── rts 1.0"
                           , "│ │   └─┬ time 1.8.0.2"
                           , "│ │     ├─┬ base 4.12.0.0"
                           , "│ │     │ ├─┬ ghc-prim 0.5.3"
                           , "│ │     │ │ └── rts 1.0"
                           , "│ │     │ ├─┬ integer-gmp 1.0.2.0"
                           , "│ │     │ │ └─┬ ghc-prim 0.5.3"
                           , "│ │     │ │   └── rts 1.0"
                           , "│ │     │ └── rts 1.0"
                           , "│ │     └─┬ deepseq 1.4.4.0"
                           , "│ │       ├─┬ array 0.5.3.0"
                           , "│ │       │ └─┬ base 4.12.0.0"
                           , "│ │       │   ├─┬ ghc-prim 0.5.3"
                           , "│ │       │   │ └── rts 1.0"
                           , "│ │       │   ├─┬ integer-gmp 1.0.2.0"
                           , "│ │       │   │ └─┬ ghc-prim 0.5.3"
                           , "│ │       │   │   └── rts 1.0"
                           , "│ │       │   └── rts 1.0"
                           , "│ │       └─┬ base 4.12.0.0"
                           , "│ │         ├─┬ ghc-prim 0.5.3"
                           , "│ │         │ └── rts 1.0"
                           , "│ │         ├─┬ integer-gmp 1.0.2.0"
                           , "│ │         │ └─┬ ghc-prim 0.5.3"
                           , "│ │         │   └── rts 1.0"
                           , "│ │         └── rts 1.0"
                           , "│ ├─┬ mtl 2.2.2"
                           , "│ │ ├─┬ base 4.12.0.0"
                           , "│ │ │ ├─┬ ghc-prim 0.5.3"
                           , "│ │ │ │ └── rts 1.0"
                           , "│ │ │ ├─┬ integer-gmp 1.0.2.0"
                           , "│ │ │ │ └─┬ ghc-prim 0.5.3"
                           , "│ │ │ │   └── rts 1.0"
                           , "│ │ │ └── rts 1.0"
                           , "│ │ └─┬ transformers 0.5.6.2"
                           , "│ │   └─┬ base 4.12.0.0"
                           , "│ │     ├─┬ ghc-prim 0.5.3"
                           , "│ │     │ └── rts 1.0"
                           , "│ │     ├─┬ integer-gmp 1.0.2.0"
                           , "│ │     │ └─┬ ghc-prim 0.5.3"
                           , "│ │     │   └── rts 1.0"
                           , "│ │     └── rts 1.0"
                           , "│ └─┬ subproject 0.1.0.0"
                           , "│   └─┬ base 4.12.0.0"
                           , "│     ├─┬ ghc-prim 0.5.3"
                           , "│     │ └── rts 1.0"
                           , "│     ├─┬ integer-gmp 1.0.2.0"
                           , "│     │ └─┬ ghc-prim 0.5.3"
                           , "│     │   └── rts 1.0"
                           , "│     └── rts 1.0"
                           , "└─┬ subproject 0.1.0.0"
                           , "  └─┬ base 4.12.0.0"
                           , "    ├─┬ ghc-prim 0.5.3"
                           , "    │ └── rts 1.0"
                           , "    ├─┬ integer-gmp 1.0.2.0"
                           , "    │ └─┬ ghc-prim 0.5.3"
                           , "    │   └── rts 1.0"
                           , "    └── rts 1.0"
                           ]
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

  stackCheckStdout ["ls", "dependencies", "tree", "--depth=1"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "├─┬ files 0.1.0.0"
                           , "│ ├── base 4.12.0.0"
                           , "│ ├── filelock 0.1.1.2"
                           , "│ ├── mtl 2.2.2"
                           , "│ └── subproject 0.1.0.0"
                           , "└─┬ subproject 0.1.0.0"
                           , "  └── base 4.12.0.0"
                           ]
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

  stackCheckStdout ["ls", "dependencies", "tree", "subproject"] $ \stdOut -> do
    let expected = unlines [ "Packages"
                           , "└─┬ subproject 0.1.0.0"
                           , "  └─┬ base 4.12.0.0"
                           , "    ├─┬ ghc-prim 0.5.3"
                           , "    │ └── rts 1.0"
                           , "    ├─┬ integer-gmp 1.0.2.0"
                           , "    │ └─┬ ghc-prim 0.5.3"
                           , "    │   └── rts 1.0"
                           , "    └── rts 1.0"
                           ]
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]

  stackCheckStdout ["ls", "dependencies", "json"] $ \stdOut -> do
    currdir <- getCurrentDirectory
    let expected = "[{\"dependencies\":[\"base\",\"bytestring\",\"time\"],\"name\":\"unix\",\"version\":\"2.7.2.2\",\"license\":\"BSD-3\"},{\"dependencies\":[\"base\"],\"name\":\"transformers\",\"version\":\"0.5.6.2\",\"license\":\"BSD-3\"},{\"dependencies\":[\"base\",\"deepseq\"],\"name\":\"time\",\"version\":\"1.8.0.2\",\"license\":\"BSD-3\"},{\"location\":{\"url\":\"file://" ++ currdir ++ "/subproject/\",\"type\":\"project package\"},\"dependencies\":[\"base\"],\"name\":\"subproject\",\"version\":\"0.1.0.0\",\"license\":\"AllRightsReserved\"},{\"dependencies\":[],\"name\":\"rts\",\"version\":\"1.0\",\"license\":\"BSD-3\"},{\"location\":{\"url\":\"https://hackage.haskell.org/package/mtl-2.2.2\",\"type\":\"hackage\"},\"dependencies\":[\"base\",\"transformers\"],\"name\":\"mtl\",\"version\":\"2.2.2\",\"license\":\"BSD3\"},{\"dependencies\":[\"ghc-prim\"],\"name\":\"integer-gmp\",\"version\":\"1.0.2.0\",\"license\":\"BSD-3\"},{\"dependencies\":[\"rts\"],\"name\":\"ghc-prim\",\"version\":\"0.5.3\",\"license\":\"BSD-3\"},{\"location\":{\"url\":\"file://" ++ currdir ++ "/\",\"type\":\"project package\"},\"dependencies\":[\"base\",\"filelock\",\"mtl\",\"subproject\"],\"name\":\"files\",\"version\":\"0.1.0.0\",\"license\":\"AllRightsReserved\"},{\"location\":{\"url\":\"https://github.com/snoyberg/filelock/archive/4f080496d8bf153fbe26e64d1f52cf73c7db25f6.tar.gz\",\"type\":\"archive\"},\"dependencies\":[\"base\",\"unix\"],\"name\":\"filelock\",\"version\":\"0.1.1.2\",\"license\":\"PublicDomain\"},{\"dependencies\":[\"array\",\"base\"],\"name\":\"deepseq\",\"version\":\"1.4.4.0\",\"license\":\"BSD-3\"},{\"dependencies\":[\"base\",\"deepseq\",\"ghc-prim\",\"integer-gmp\"],\"name\":\"bytestring\",\"version\":\"0.10.8.2\",\"license\":\"BSD-3\"},{\"dependencies\":[\"ghc-prim\",\"integer-gmp\",\"rts\"],\"name\":\"base\",\"version\":\"4.12.0.0\",\"license\":\"BSD-3\"},{\"dependencies\":[\"base\"],\"name\":\"array\",\"version\":\"0.5.3.0\",\"license\":\"BSD-3\"}]\n"
    when (stdOut /= expected) $
      error $ unlines [ "Expected:", expected, "Actual:", stdOut ]
