BUGS
=======

This is a list of the software bugs (as opposed to the bugs in the game that you shoot) that still need attention:

* On the latest build (0136579125034f41f8415b496d5ba706e86d65d9) on real HW, on startup I head the spider loop once and then I can play a game and finish that game.  But when I try to start a second game, I crash.  The stack looks corrupted and execution is way off in the weeds somewhere.  This isn't happening on either emulator.
* A spider moving left to right went off screen and left garbage on the RHS as it exited.  I have only seen this once.  I think it coincided with the player dying.
* Sometimes when the player dies, the "you can shoot" indicator is left behind as garbage on-screen.
* If you die holding the mouse button down, your next game will start shooting without pressing the mouse button.
   * I was reproducing this reliably on real HW but I don't see it from either emulator.  Need to try to reproduce it again on real HW.
   * I also don't see how this happens given how the code is structured.



FIXED
=======

* When a centipede segment is added on the right, if there is a mushroom either right at the edge or maybe on tile from the edge (not sure which), the segment seems to turn around and travel up along the edge of the screen.  Not sure if this can happen on the left side also.  This is likely a problem with the mushroom collision detection and a segment which is mostly off-screen should probably ignore blocking mushrooms until on-screen.
* A shot is able to pass through an almost gone mushroom if lined up just right.  Best to change the sprite code for the shot to scan the two pixels below for a collision.
* I have seen a couple of crashes.  I think an off-screen centipede segment is getting "shot" at the beginning of a level leading to a crash.  Almost definitely related to collision and shot handling.
* I am seeing other crashes where the PC ends up in bank 22 or so.  Need to dig into the stack to figure out where it is coming from.
   * I have confirmed that we are jumping to band 22 from segmentBodyJump_jumpInst.  Not sure how a bad address is ending up in the jump table here.
   * Seems to happen pretty reliably if I die from the last segment and progress to the next level.
   * Caused by both gamePlayer.s and level.s calling start level when the last segment is the one which kills the player.  The player code now defers to the level code to handle starting the level after the player dies that way.
* Sometimes centipede segments seem to be stacked one on top of another.  You think there is just one left but you shoot it and there is one underneath it.  This should not happen.
    * Caused by the lack of head segment collision detection in the slow segment code paths.  I had thought that slow head segments would never collide.  But once you split a slow centipede into two separate segments, you now have slow heads that can collide.
