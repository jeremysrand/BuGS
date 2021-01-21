BUGS
=======

This is a list of the software bugs (as opposed to the bugs in the game that you shoot) that still need attention:

* The sound is muddy at times on real HW.  Especially when lots of stuff is going on, the sound ends up coming out garbled.  This isn't happening on emulators where everything is always quite clear.  Perhaps I am reaching some limit of the Ensoniq.  Do I need to reduce some sampling frequencies perhaps?
    * I tried reducing the sampling frequency from 11025 for most of the samples to 5513 and I didn't notice any improvement in the quality of the sound on real HW.  Nor did I notice any real degredation on real HW or on an emulator.
* Sometimes a mushroom seems to appear out of nowhere.  I usually see that happen in the middle of the playfield but I don't know if that is the only place that can happen.  What makes it appear is something coming along and marking that tile as dirty and suddenly it is refreshed and the mushoom is visible.


FIXED
=======

* The flea appears before the second level actually begins, in the time before the level starts if you have too few mushrooms at the bottom.  This is due to the way that levels are incremented now in the game state machine.  Similar will probably happen also for the scorpion which randomly appears above a particular level.
* It seems to be possible to both shoot and be killed by the spider in a single frame.  Either the spider should be killed by the shot or the spider should kill the player but not both.
    * Based on the code, I don't think it is possible that this happened in a single frame.  Instead, I think what is happening is that the spider is being shot and then goes through a small number of explosion frames.  The colour used in those explosion frames were detected as a collision to the player.
    * I have changed the colours of the explosion to no longer be detected as a collision for the player.
* It is possible to shoot between two segments of a centipede.  The problem is that there are black pixels between the segments and if things are timed just right (or just wrong), the shot can slot in at those black pixels and end up missing both segments.
    * I am not sure how much can be done about this given how collisions are detected.
    * I have implemented a fix which I believe solves this problem.  The shot is a single pixel wide which allows it to slot in between a segment.  I have changed the collision code to detect a collision if it is also if there is any pixel on in the byte (ie two pixels wide).  That should ensure that the shot cannot pass through a centipede.  Note it also makes things slightly easier to hit where before it might have passed right next to.
* I have seen some mushrooms appear suddenly.  Sometimes, if I am shooting, the shot "hits" an invisible mushroom which then becomes visible.  My guess is that there is something wrong with the code which turns a centipede segment into a mushroom when shot and the tile isn't correctly marked dirty all the time.
    * In theory, there shouldn't be a collision with an invisible mushroom but what happens is that when the shot overlaps with the tile, it becomes dirty.  At that point, the mushroom will appear on the next frame and a collision can then occur.
* On the latest build (0136579125034f41f8415b496d5ba706e86d65d9) on real HW, I can play a game and finish that game.  But when I try to start a second game, I crash.  The stack looks corrupted and execution is way off in the weeds somewhere.  This isn't happening on either emulator.
   * I am thinking this is the same crash as the one which follows.  I tried to reproduce this on real HW again with that debug in place but could not.
* I reproduced a crash on GSPlus after dying and starting a new game.  From the stack, it was clear it was trying to draw a body segment but the jump instruction was set to garbage.  I am hoping this is the same crash as the one saw on real HW.
   * I have added some debug code to detect this.  I am validating that the offset into the draw table for head and body segments is "sane" and if not brk.
   * I reproduced it and ended up at brk $4 with y set to $2270 which is much larger than the max of 156.  Also odd is that X is 1 but I think it needs to be an even number.
   * In order to get the wrong value in Y, I noticed that the segmentSpriteOffset was overwritten with the pattern 70 02 70 02, etc.
   * Something is trashing memory.
   * Just got the same crash on real HW with the same register values and everything.
   * Based on the investigation, it looks like 24 segments have been added which means the segment data structures have all overflowed.  I am adding validation to check that the number of segments added never exceeds 12.
   * I can reproduce it reliably now.  The key is to die on the previous game by colliding with the last segment on a level.  When you start the next game, we will for some reason try to add the 12 segments twice.  I think the "die on the last segment so start the next level" code is somehow getting triggered on the next game and trying to add the same centipedes.
   * Confirmed.  I have fixed the code so that when the game is over, the "die onthe last segment so start the next level code" does not get triggered.  That has fixed the crash.
* A spider moving left to right went off screen and left garbage on the RHS as it exited.  I have only seen this once.  I think it coincided with the player dying.
    * I have just seen it again.  I think the problem happens when the player dies on the extreme RHS of the screen (perhaps the LHS also but I have seen it on the RHS).  I think the non game tile just beyond the bounds gets marked as dirty but is not put on the dirty non-game tiles list.  So, it remains "dirty" forever and is never cleaned up.  Once that happens, then if a spider traverses the tile, it leaves behind junk.
    * Confirmed.  The code which exploded the player on the RHS would mark the non game tile as dirty because it always marked three tiles in a row as dirty.  But the 3rd when right on the edge is a non-game tile.  It just needed to skip marking it as dirty.
* I am still seeing shots go through almost gone mushrooms sometimes.  I checked more rows of pixels for collisions even though the shot doesn't draw there but it still seems to be possible.  If the height of the shot is equal to the amount it moves in one frame, it shouldn't be possible so that is worth checking.
   * I said I already fixed this below but I only did half the job.  What I tried to implement was a collision detection for the full 8 pixel height of the shot even though the shot is only 6 pixels tall.  In the end, I just implemented that for the "shifted" shot sprite and not the unshifted version.  I have corrected that oversight and that should address this.
* Sometimes at the end of the flea sound, there is a short high pitched tone.
* Sometimes when the player dies, the "you can shoot" indicator is left behind as garbage on-screen.
* Sometimes when you die, a spider may enter and the spider sound will start playing.  Because audio is stopped by player death and it has already happened, the spider sound ends up going on even though the spider is not moving.
* Sometimes the spider doesn't seem to freeze when the player dies.  This may be related to the sound problem also.  If the per-frame spider update code isn't handling player death correctly, that could explain both.
* When a centipede segment is added on the right, if there is a mushroom either right at the edge or maybe on tile from the edge (not sure which), the segment seems to turn around and travel up along the edge of the screen.  Not sure if this can happen on the left side also.  This is likely a problem with the mushroom collision detection and a segment which is mostly off-screen should probably ignore blocking mushrooms until on-screen.
* A shot is able to pass through an almost gone mushroom if lined up just right.  Best to change the sprite code for the shot to scan the two pixels below for a collision.
* I have seen a couple of crashes.  I think an off-screen centipede segment is getting "shot" at the beginning of a level leading to a crash.  Almost definitely related to collision and shot handling.
* I am seeing other crashes where the PC ends up in bank 22 or so.  Need to dig into the stack to figure out where it is coming from.
   * I have confirmed that we are jumping to band 22 from segmentBodyJump_jumpInst.  Not sure how a bad address is ending up in the jump table here.
   * Seems to happen pretty reliably if I die from the last segment and progress to the next level.
   * Caused by both gamePlayer.s and level.s calling start level when the last segment is the one which kills the player.  The player code now defers to the level code to handle starting the level after the player dies that way.
* Sometimes centipede segments seem to be stacked one on top of another.  You think there is just one left but you shoot it and there is one underneath it.  This should not happen.
    * Caused by the lack of head segment collision detection in the slow segment code paths.  I had thought that slow head segments would never collide.  But once you split a slow centipede into two separate segments, you now have slow heads that can collide.
* If you die holding the mouse button down, your next game will start shooting without pressing the mouse button.
   * I was reproducing this reliably on real HW but I don't see it from either emulator.  Need to try to reproduce it again on real HW.
   * The problem is that the game should ignore the first poll from the mouse when starting a new level.  The mouse HW/ADB has put some info in about the state of the mouse and we don't poll it for quite some time.  Even if the mouse changes state, the last state is still there and becomes stale.  The solution I implemented was to throw away the first mouse poll at the start of every level.
