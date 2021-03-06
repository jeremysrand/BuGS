#  Sprites Design

## Performance of Different Stack Ops

Performance of two approaches:
```
      ldx #$abcd   3 cycles
      phx          4 cycles (per push)
```

versus:
```
      pea $abcd    5 cycles
```

When the pattern $abcd appears just once:
  * ldx/phx takes 7 cycles
  * pea takes 5 cycles (best)

When the pattern $abcd appears twice:
  * ldx/phx/phx takes 11 cycles
  * pea/pea takes 10 cycles (best)

When the pattern $abcd appears three times:
  * ldx/phx/phx/phx takes 15 cycles
  * pea/pea/pea takes 15 cycles

When the pattern $abcd appears four times:
  * ldx/phx/phx/phx takes 19 cycles (best)
  * pea/pea/pea takes 20 cycles

So, if a pattern appears four or more times, it is worth using a register for the pattern.  If it appears exactly three times, a register can be used but it buys nothing.  If it appears two or fewer times, a register for the pattern should not be used.

## Colours and Layers

Every level has three primary colours which are used for all sprites.  Because the GS can have up to 16 colours on a line, we have more colours available in the HW than is required for the game.

Each colour is 4 bits wide.  All zeros is always black in all the different palletes for each level.  The bottom two bits are used by the "lowest layer" which is drawn first.  The bottom layer consists of:
   * mushrooms
   * numbers
   * letters
   * symbols
   * spider scores (300, 600 and 900)
   * bug explosions
   * solid squares (primarily the all black square)
   
These sprites generally draw first and overwrite what may have been there before.  There are exceptions though.  Spider scores and bug explosions do generally layer on top of the background but these things still use the "background colours" when drawn.  The reason for this is that these background colours are not considered to be a collision if present when the player is drawn.  We do not want the player to be considered dead just because it touched a spider score or bug explosion.

After the background layer is drawn, other things are drawn in this order:
  * spiders
  * scorpions
  * fleas
  * centipede segments
  * missle
  * player

If that item is exploding, the explosion is also drawn at this time.  Because we only have three non-black colours, the bottom two bits of the colour is used for the "background colour".  Background sprites only set these bits.

Then, these forground sprites can just set the upper two bits to overwrite the background colour.  This turns a load, and, or, store into a load, or, store cycle for each 4 pixels.  Spiders and scorpions never overlap with each other so they can avoid the "and" operation.  Fleas, scores and centipede segments may overlap with other sprites so they maybe need to perform an and operation to preserve background or other foreground pixels from other sprites.

But there is one more optimization I have made.  The majority of foreground sprites are centipede segments and the centipede is mostly green (in the first level colour pallete).  This colour is always 11xx.  That means to make a foreground pixel green, we only need to set the two high bits of the pixel and that can always be done with just an or operation.  If the four pixels consist of only green pixels (one, two, three or four green pixels and no other colours), then that can always be done with just an or operation.  No masking is required.  Again, centipede segments are mostly green and there tends to be lots of segments so this is a useful optimization.

## Clipping

An exception to the "background is drawn first" rule though is the non-playable area of the screen.  This section contains tiles which may be blank or contain information about score, high score, number of lives left etc.  This is made up of background sprites but the non-playable area is drawn last.  That way, a spider or scorpion which is halfway onto the playable area on the left or right side is "trimmed" by overwriting the non-playable portion of the sprite with the non-playable background.  That tile will be marked dirty but unlike the background of the playable area, it is drawn last in order to clip those sprites.

We also need to clip a flea which is dropping down from the top.  The solution there is that the game allocates memory before the SHR page, enough for an extra unseen tile above the screen.  A partially obscured flea is drawn offscreen into that part of memory before the SHR page.

There is a similar problem when the flea reaches the bottom of the screen.  I have decided to just not handle it.  The flea disappears once it reaches the bottom of the screen.  It does not scroll off the bottom.

## Collisions

There are two sprites which need to detect collisions.  We need to detect if the player has collided with a bug when we draw the player.  The way that is done is that any pixel that the player will draw, we check to see if anding that pixel with $c results in a non-zero value.  At least one of those two high bits will be set if the pixel has been drawn by a bug.  Background sprites never set those bits.  From there, we need to figure out if the bug that was collided with is a spider, flea of centipede segment.  The player cannot collide with a scorpion because the are always in different parts of the screen.  Once we know there is a collision, the code looks for tile overlap between the player and the spider, flea or centipede segment in order to figure out what collided.

The player's shot also collides with these things but also collides with mushrooms which are a background sprite.  So, in this case, any non-zero value in a pixel being drawn to by the shot is considered to be a collision.  In fact, the shot is only one pixel wide but a collision is said to occur if either nibble in the byte is non-zero.  Once we have the data from the collision, that is anded with $c and if that is zero, that indicates that a mushroom collision may have occurred.  Based on the address of the collision, that turns into a tile lookup.  Otherwise, that may be a bug collision.  As with player collisions, a check for tile overlap is what is used to figure out what kind of bug caused the collision.
