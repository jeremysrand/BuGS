TODO
=======

* When a centipede segment is added on the right, if there is a mushroom either right at the edge or maybe on tile from the edge (not sure which), the segment seems to turn around and travel up along the edge of the screen.  Not sure if this can happen on the left side also.  This is likely a problem with the mushroom collision detection and a segment which is mostly off-screen should probably ignore blocking mushrooms until on-screen.
* At the end of the game, the score should be compared to the high score.  If larger, store the high score.
* When a collision is detected with the player, the thing collided with should explode.  That also means that the bugs in general do not update when the player has died, unless they are exploding in which case they do.
* When the player dies, the mushrooms need to be reset and the score incremented for damaged and poisoned mushrooms.
* So much more.
* Why is there no sound?  Because I haven't coded any...
