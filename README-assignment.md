# Pet Haskell Assignment Report
_by Adnan Abdulhussein (aa1462)_

## Overview

I have grown to really enjoy programming in Haskell, and this is one of the
reasons I decided to do _Pet_ over _Robocode_. However, when I first looked at
the _Pet_ assignment I wasn't sure what to do -- the examples didn't _really_
appeal to me.

After a bit of thought I decided that I wanted to build an example of the
difference between _object-oriented/imperative_ and _functional_ programming
languages (in that I wanted to see how easy it would be to _port_ programs
between the types of languages). I also wanted to have a go at using a GUI
library in Haskell.

Overall I enjoyed the assignment, however if given more time I could have
produced a better end result.

## Initial idea

My intial idea was to reproduce the _Db_ assignment from Java in Haskell. This
went pretty well, until I _stupidly_ deleted the files accidently (command line
_fun_). I had not yet implemented a GUI yet so I decided to look into that
before I started the assignment again.

## Choosing a GUI library

It seemed there were two popular GUI libraries for Haskell,
[_WxHaskell_](http://www.haskell.org/haskellwiki/WxHaskell) and
[_Gtk2Hs_](http://projects.haskell.org/gtk2hs/). I initially went for
_WxHaskell_ however it didn't work properly on my machine. So I went for
_Gtk2Hs_ instead.

## Oxo

Given the time I had used up starting the assignment (messing up on the first
idea and spending about two days installing the GUI library), it seemed _Db_
would take too long to redo. So I decided to do _Oxo_ (again from Java), as it
would only require one window to operate.

The logic was straight forward, and generally easier than in Java, thanks to
lists. The interesting part was the _GUI_. I needed the _game state_ to be
known and updated each time a cell was clicked. I started out changing all the
buttons' actions each time a cell was clicked, but that would only add a new
action to the stack (so it would eventually be executing functions multiple
times) and there was no way to disconnect previous actions because all the
newly generated actions for all the buttons would need to have been known
beforehand -- this couldn't be done because the actions had to be built button
by button (i.e. traversing through the list in Haskell).

Then it hit me. I could just use a label to hold the game state (who's turn it
was, whether the game was over and who the winner is). I then just pass this
label as a parameter to the actions and read and update it as necessary -- thus
determining the game state without any messy action changing. The label needed
to be shown anyway so that the users could have an idea of what was going on in
the game.

There was one issue with _Gtk2Hs_, I was unable to close the window properly
with the `New Game` button. This was because, bizarrely enough, there is no
way to close/hide a window in _Gtk2Hs_, well according to it's documentation
anyway.

_Unfortunately_, I was unable to get round to implementing the AI I used in the
Java assignment due to running out of time, and had to leave it as a
multiplayer game.

