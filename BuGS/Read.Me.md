#  BuGS:

This game represents my attempt to reproduce my favourite arcade game from when I was growing up.  It should work on any Apple //gs, with or without an accelerator and should run at a fixed 60 (or 50) frames per second.  Starting with v2.0 of BuGS, if you have Internet access on your GS using an Uthernet II card or similar, then you can see the top scores by the community and upload your own high scores into the database.

See below for information about game play.  There are also a number of caveats related to emulators, networking, trackballs and sound cards which are described in subsequent sections.  Finally, there is a section of acknowledgements and information on how to contact me.

## Game Play:

Use a mouse or an ADB trackball to control your player on the screen.  You can move up, down, left and right at the bottom 1/4th or so of the screen.  Click the mouse button to fire or hold the mouse button down to fire repeatedly.  Only one shot can be on screen at a time so if you shoot something at the top of the screen, it will take longer for you to be able to shoot again.  You cannot pass through a mushroom in the play area but you can shoot mushrooms to destroy them.  Do not let any of the bugs in the game touch you or your turn will be over.  You start with 3 lives and every 12,000 points you accumulate, an extra life is added.  The goal is to destroy all of the centipede segments in a level and when you do, the game goes to the next level where there are more centipedes or faster centipedes.

At the beginning of the game, the field will be populated with a random set of mushrooms and a centipede will enter the screen from the top an dmove down row by row towards you.  A centipede will drop down one row and turn around when it reaches the side of the play area or if there is a mushroom in its way.  When you shoot a segment of the centipede, the segment will be turned into a new mushroom.  If you shoot the head or the tail of the centipede, then it will be one segment shorter.  If you shoot the centipede in the middle, it splits into two centipedes.  If one or more centipede segments reach the bottom of the screen, they will travel up and then down row by row and single centipede segments will be added randomly on the left and the right of the play area.  These randomly added segments make it harder to clear the level so try to get all of the centipede segments before they reach the bottom of the screen.  Shooting a body segment awards you 10 points but shooting a head segment awards 100 points.

From the first level, a spider will appear randomly on the right edge of the play area and move towards the left or vice versa.  The spider moves jerkily up, down or on diagonals in an unpredictable way.  Best to stay behind a spider because they never backtrack.  You get 300, 600 or 900 points for shooting a spider depending on how close they were to you when you shot it.  At higher scores, the spider will restrict its movement to fewer rows at the bottom of the screen making it more likely to collide with you.  You do not need to shoot spiders to clear levels and you can choose to just avoid them.

From the second level, a flea may appear and drop from the top of the screen down to the bottom, depositing mushrooms randomly behind it.  A flea appears if the number of mushrooms in the bottom part of the screen drops below a particular threshold and they will continue to drop until enough mushrooms exist there.  If you shoot a flea once, it accelerates and drops at you extra quickly.  You must shoot them twice to destroy them.  At higher scores, the flea is always fast but only takes one shot to destroy.  Also at higher scores, the number of mushrooms required at the bottom of the screen goes up leading to more fleas.  A flea adds 200 points to your score but as with spiders, you can choose to just avoid them.

From the third level, a scorpion may appear on the right side of the screen and move to the left or vice versa.  The scorpion only ever travels across a single row on the screen and always on the upper part of the game play area so you never need to worry about colliding with a scorpion.  But a scorpion poisons any mushroom it passes over.  A poisoned mushroom changes colour and whenever a centipede touches a poisoned mushroom, it will just drop straight down towards the bottom of the screen, passing through mushrooms which may in the way.  In order to "heal" the centipede, you must shoot the head segment.  If you do not, it will reach the bottom of the screen and then move up row by row and down again like a normal centipede.  Note that a poisoned centipede that reaches the bottom of the screen does not trigger the addition of random single centipede segments.  It is not a bad idea to try to destroy poisoned mushrooms.  Shooting a scorpion awares 1000 points.  At higher scores, the scorpion will sometimes cross the screen twice as quickly making it harder to hit.

## Emulators:

Unfortunately, not all GS emulators work well with BuGS.  I recommend mame or KeGS based on my testing.  Some notes about specific emulators are below:

**mame:** This emulator is not very friendly but is probably the best for playing BuGS.  The mouse is handled well and the sound and graphics look good.  If you are on a Mac, I highly recommend Kelvin Sherlock's Ample which makes running mame much easier.  There was a problem with versions 0.231 and 0.232 of mame when playing BuGS.  I recommend using a newer or older version of mame.  Also, you can emulate an Uthernet card in mame and it is possible to get the network up and share your scores.  You can find Ample at - http://github.com/ksherlock/ample

**KeGS:** Kent has released some updates for this emulator recently and v1.05 seems to work well with BuGS.  You will want to press F8 to constrain the mouse to the emulator.  You can find the latest version at kegs.sourceforge.net.  I don't think there is any support for networking in KeGS today however.

**GSPlus:** This emulator is based on KeGS and I generally find it to be a good emulator but it does not work well with BuGS.  The main problem is related to mouse handling.  GSPlus tries to map the host's mouse position to the corresponding position on the emulator's screen.  When they do this, the emulator often stops updating the mouse position when it reaches the side of the emulated screen.  With a game like BuGS (or Arkanoid for a similar example), the mouse is used as an analog input to the game.  So when the mouse reaches a screen edge, you will no longer be able to move the player in that direction.  Other than this mouse input problem, everything else seems to work but I suspect you will find the game frustrating because of these "virtual barriers" due to mouse input.

**GSPort:** This is another KeGS based emulator.  I can no longer test with this emulator on my Mac so I don't know how well BuGS works with GSPort.  My guess is that the sound and graphics will probably be good but it may suffer from the same mouse input problem as GSPlus.  Feedback welcome.

**Sweet16:** This is another emulator I cannot test any longer on my Mac.  But I do have feedback from others who say it suffers from the same kind of mouse input problems as GSPlus.  Worse, there are graphics problems related to handling vertical blanking.  BuGS will not work well under Sweet16 unfortunately.

## Network Support:

With v2.0 of BuGS, network support has been added to the game.  When the game is launched on a machine that has a network connection, a request is made to get the top 10 high scores from the online database.  These are shown as "Global High Scores" in the game.  And when a game is over, if your score gets onto your own local high score list, then it is also uploaded to the server.  Even if you do not have a GS with a network connection, you can see the global high scores in a web browser here:

http://scores.rand-emonium.com/

If you have the necessary hardware to support a network connection on your GS, then make sure you have the latest version of Marinetti installed as available from here:

http://www.apple2.org/marinetti/

My testing was done with Marinetti v3.0b11.  Also, make sure you have the correct link layer installed for your network connection.  If you have network applications like Webber working, then networking should work with BuGS also.

Make sure that Tool128, the hash tool, is installed on your machine.  Hashing is used to provide a bit of security to the online score database.  This tool is distributed with BuGS.  Drag it to your System folder and the Finder should offer to put it in the right place for you.  You do *not* need to install Tool128 if you plan to play the game offline but installing it shouldn't cause a problem.  But if you do not have both Marinetti and Tool128 installed when you launch BuGS, then no attempt will be made to make network requests from the game.  If you do not see the global high score list, then that likely indicates that something isn't configured correctly.

If something goes wrong with the network connection, you may see a network error instead of the global high score list.  Feel free to contact me if you are seeing errors and I will try to help find the problem.

Finally, the only scores that will be posted in the online database are those that get onto your local high score list.  If you are upgrading to v2.0 of BuGS and already have 10 high scores that you cannot easily beat, then you may find the game doesn't send any of your new scores to the server.  If you want to reset your local high score list to make it easier to submit high scores to the server, delete the BuGS.settings file.  This will clear your local high score list and your next ten games will be guaranteed to make your local high score list and therefore get posted to the online database.

## Trackballs:

The original arcade game is played using a trackball so for the best experience, I would recommend using an ADB trackball if you have one.  Below is a list of trackballs for which I have some feedback saying they work:

**Kensington Turbo Mouse Version 5.0 (Model Number 64210):** This is the trackball I am using on my GS and it works great for me.

**Kensington Turbo Mouse Version 3.0:** This trackball is known to work well with the GS and should work with BuGS but I have no direct feedback at this time.

**Logitech TrackMan Mouse (Model Number T-AA1-4MD):** This trackball was tested during WozFest in March 2021 and the feedback is that it worked with BuGS.

Some ADB trackballs will not work.  The root problem seems to be whether it behaves like a regular ADB mouse or whether it might need some custom driver.  Custom drivers were only written for the Mac for these trackballs so they probably don't work well with the GS, nor with BuGS.  This is a list of the trackballs for which I have some feedback saying they do not work:

**Kensington Turbo Mouse Version 4.0:** Apparently Version 4.0 of the Turbo Mouse required a driver on the Mac and due to that, it is not likely to work well for BuGS.  It has been tested and it did not work well.

I don't have any more recommendations for trackballs.  If you have a trackball that does or does not work, let me know and we can continue to build a list of which are good and which to avoid.

## Sound Cards:

In BuGS, the sound effects are in stereo if you have a stereo sound card in your GS.  When you shoot from the left side, the sound should come from the left speaker.  When a spider enters the screen on the right side, the sound of the spider should come from the right speaker and then pan to the left as the spider travels across the screen.

However, it seems that there is some inconsistency between what channel maps to the left or right speaker.  The documentation from Apple says one thing but emulators and recent sound cards like the 2Soniq and 4Soniq do the opposite.  It may be that some sound cards follow Apple's documentation while other do not.  By default, BuGS has adopted the "standard" that emulators have set.  But if you find that the sound seems to be backwards, hit the "S" key from the main screen on BuGS to swap the stereo channels.  Press "S" again to swap them back.  This option will be saved so you shouldn't need to swap the stereo channels again the next time you play.

## Updates:

I do hope to improve BuGS so watch for updates.  One feature I would like to implement is a global high score list.  For people with Internet connectivity on their GS's, their high scores would be shared to a server and we could all compare our best scores amongst ourselves.

In order to make updating the game easy, I have adoped Speccie's "Versions".  If you have the "Check File PIF" installed, you can select BuGS in the Finder, then select Extras -> Check File... and it will tell you whether there has been an update.

## Acknowledgements:

This project would not have been a success without help from the Apple // community, especially the appleiigs slack channel where I got tons of help and encouragement.  I have to thank some people for their support, help and contributions of code and other materials that helped make BuGS possible.  Please know that if your name is missing, that is my fault.  I should have been keeping track of this early on but I find myself writing this in the later days of the project and I am almost certainly going to make a mistake.  I apologize if I have left you off and I would encourage you to contact me and help me correct my mistake.

* @fatdog on slack who provided multiple sound samples for the game including the spider, flea and the beat sound.  As well, he provided the wonderful icon for the game.
* Mark Collins who pointed me to a source of sound effects and information on how to convert digital sound into a format that would work on the GS.
* John Brooks who was instrumental in getting the animation algorithm performant.  He described a series of optimizations that I could persue and sure enough, implementing a couple of them got me back to 60 frames per second.  He also provided code for a fast random number generator and fast mouse polling.
* Antoine Vignau for his technical support, especially when it came time to look at sound.  He often posted comments that warned me that the road I was going down was going to be a problem (like trying to use the toolbox for polling the mouse) and of course he was right.
* Brutal Deluxe in general for their incredible reference information about the Apple //gs, especially their page about Mr. Sprite.  I very nearly used Mr. Sprite for this project but there were further assumptions and optimizations I could do because of the limited colour palette so I decided to hand code my sprites.  But their ideas were key to my approach and I read those web pages multiple times.
* Dagen Brock for GSPlus and for his technical support and encouragement on slack.  GSPlus was the emulator I used primarily and when I did a "build and run", GSPlus always launched reliably and quickly so I could test the latest code.
* Andrew Roughan for his work testing the beta builds and helping to make the release as good as possible.
* Mike Westerfield and The Byte Works for the ORCA tools which I have used for building this project.
* Kelvin Sherlock for GoldenGate and ProFuse which are fundamental tools I used for building this project.
* Ken Gagne and Juiced.GS for making tools like ORCA and GoldenGate available.
* Stephen Heumann for NetDisk which I used to transfer my latest build to my real GS for testing.
* Ewen Wannop (Speccie) for his great network tools, especially Versions which I am using to assist in pushing out fixes and new versions of BuGS.  I had a problem with the Check File Finder extension but very quickly he found the problem.  I very much appreciate his support getting that problem fixed.
* Stefan Wessels for his extensive testing leading up to v2.0 of BuGS.  At the time of updating this document, he is trying very hard to beat my high score online and is very close to doing so (his scores are posted as SQW).  Thanks so much for your help and enthusiasm and I am sure you will beat my score soon.

## Contact:

If you are having problems or have some feedback about the game, you can reach me at:

jeremy@rand-family.com

My Apple // projects are all available at:

http://rand-emonium.com/

My website also seems to work in Speccie's incredible "Webber" web browser for the GS so you can browse and download my projects there.

The latest high scores in BuGS posted to the online database can be found here:

http://scores.rand-emonium.com/

If you want to see how BuGS works, check out:

http://github.com/jeremysrand/BuGS

All of the source code is there.  And you can find more of my Apple // projects here:

http://github.com/jeremysrand/

I hope you enjoy BuGS.

# Apple // Forever!
