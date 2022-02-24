# babo

## Getting Started
```shell
alex Tokens.x -o src/Concrete/Tokens.hs && happy Grammar.y -o src/Concrete/Grammar.hs
stack build

cat examples/example1.babo | stack run
```