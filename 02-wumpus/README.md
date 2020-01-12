# Grand Theft Wumpus

This is a game from the book _Land of Lisp_.

## Background Story

In this new version of Hunt the Wumpus, you are the Lisp alien. You and the
Wumpus have just robbed a liquor store and made off with the loot. However,
during the escape, the Wumpus decides to double-cross you and run off with the
money and your car. But before he drives off, you manage to cap him a couple of
times in the kidney.

Now you’re in a pretty tough situation. You don’t have a car or any money, and
no way to track down your former partner in crime. But you also have no choice.
You have your principles, so you’re going to hunt the Wumpus. You know he won’t
be able to get very far with his injuries. He will most likely need to lie low
for a few days to recover, which means he will still be somewhere in Congestion
City. The problem is that the roads in this town are impossibly convoluted, and
no one can find their way around, especially an out-of-towner like yourself.
How are you ever going to find the Wumpus in this impossible maze?

Luckily, being the Lisp alien, you always carry your trusty pocket computer.
Using Lisp and your graph utilities, you’re fully equipped to analyze
complicated data such as the Congestion City roadways and intersections.
Surely, you have the tools to conquer this impenetrable road system.

The Wumpus has been your partner in crime for a while now, so you know his MO
quite well. He will always carefully scout out any new hiding place before he
uses it. And since he is injured, any location one or two blocks away (that is,
one or two graph edges away) from his hiding place should be marked with some
telltale signs: his blood stains.

A problem is that he still has his trusty AK-47, while you have only a handgun
with a single bullet. If you’re going to take him out, you’ll need to be
absolutely sure you’ve tracked him down. You’ll need to charge into his hideout
and shoot him down immediately, and you’ll have only one chance to pull this
off.

Unfortunately, you and the Wumpus aren’t the only criminals in this town. The
most feared outlaw group in Congestion City is the Gruesome Glowworm Gang.
These guys are a band of ruthless kidnappers. If you run into them, they will
kidnap you, beat you up, rob you, blindfold you, and then kick you out of their
car and leave you in some random part of town.

Luckily, they can be avoided if you know to keep an eye out for their glowing
thoraxes (hence their name). If you see some blinking lights, you know that
these guys are one street away from your current location. Also, you know the
gang has exactly three separate teams that work the city from three separate
locations.

Finally, you still need to contend with the cops. You know they’ve probably set
up some roadblocks in town to try to catch you and the Wumpus. You should still
be able to visit any location in Congestion City, but you need to be careful
which streets you travel. (In other words, the cops will catch you if you
travel along the wrong edge.) Unfortunately, you don’t know how many of these
roadblocks there may be.

As you can see, finding the Wumpus and getting back your money and car will be
tough. If you think you’re Lisp alien enough to take on the Wumpus, then let’s
write this game and hunt him down!

## Commands

- walk: walk to a node

- charge: if you think you know where the wumpus is, you can _charge_ into that
  node. If you were right, you win. If you were mistaken and the wumpus wasn't
  there, then you have wasted your one bullet and you lose. If you walk into
  the wumpus's node, he gets the jump on you and you lose.

## How to Play

You play in the REPL.

1. `clisp`

2. `(load "wumpus.cl")`

2. `(new-game)`

3. open `known-city.png` up in a browser.

4. Enter commands in the REPL. e.g. `(walk 20)` or `(charge 13)`

5. Refresh your browser to see an updated version of the known city.

6. At the end of the game (or during the the game if you're a dirty cheat) you
   can look at `city.png` to see the whole city.
