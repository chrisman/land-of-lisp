# 🎲⚔️ Dice War

making a strategy game

## How To

*It's A CLISP Game (TM)*

1. `clisp`

2. `(load "dice.cl")`

and then!

Play vs computer:

```
(play-vs-computer (game-tree (gen-board) 0 0 t))
```

Human vs human!

```
(play-vs-computer (game-tree (gen-board) 0 0 t))
```

## Notes

- featuring a game-tree and an AI

- the memoization and tail calls are supposed to have made this game much more
  optimized, but it still grinds to a halt on my computer when playing on a 3x3
  board

## references

- <https://www.scribd.com/doc/26902/whyfp>
