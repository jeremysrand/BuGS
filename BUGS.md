BUGS
=======

This is a list of the software bugs (as opposed to the bugs in the game that you shoot) that still need attention:

* When a centipede segment is added on the right, if there is a mushroom either right at the edge or maybe on tile from the edge (not sure which), the segment seems to turn around and travel up along the edge of the screen.  Not sure if this can happen on the left side also.  This is likely a problem with the mushroom collision detection and a segment which is mostly off-screen should probably ignore blocking mushrooms until on-screen.
* Sometimes centipede segments seem to be stacked one on top of another.  You think there is just one left but you shoot it and there is one underneath it.  This should not happen.
* A spider moving left to right went off screen and left garbage on the RHS as it exited.  I have only seen this once.  I think it coincided with the player dying.
* Sometimes when the player dies, the "you can shoot" indicator is left behind as garbage on-screen.
* I have seen a couple of crashes.  I think an off-screen centipede segment is getting "shot" at the beginning of a level leading to a crash.  Almost definitely related to collision and shot handling.
* I am seeing other crashes where the PC ends up in bank 22 or so.  Need to dig into the stack to figure out where it is coming from.


FIXED
=======

* A shot is able to pass through an almost gone mushroom if lined up just right.  Best to change the sprite code for the shot to scan the two pixels below for a collision.
