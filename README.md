# Abandoned love2d platformer

This project started as a way for me to build a reusable framework for making 2d games using Love2D. 
The plan was to build it out while developing a 'micro-metroidvania'. I'd decided I could get something releasable built in about 40 hours work. 
According to my work diary I spent about 40 hours just building the engine, UI and tweaking the player movement, 
but I still thought I could turn it into a game in about another 20 hours.
After some time I became annoyed with how the entities worked so I went off on a tangent and refactored the entity management code to use the tiny ECS library and
changed the goal from metroidvania to 'level based collectathon with melee attack'. At this point I stopped tracking my time, I've probably spent about 80-100 hours working on what is really nothing more than a tech-demo.

It's now probably at the point where you could just make levels and new entities for it, but I've decided not to continue due to boredom. 

There are some good things about this project though:

- It's not a bad crack at a platformer using an ECS architecture. Good examples of this are surprisingly thin on the ground, and while I wouldn't call this a masterpiece it works as a starting point
- The platformer movement is smooth and predictable and quite fun to bounce around the level
- The camera supports sub-pixel scrolling which looks very nice in a pixel-art game (It's worth noting you can get this for free if you render at the window resolution but with scaled textures, instead of rendering at a low resolution and scaling that up like I did)

Things I'd do differently:

- I know for sure I won't do UI in the same way again
- I'd like an easier way to customise drawing on a per-entity basis. The method I used was a bit of a bodge which would make for a lot of duplication
- A better animation system that allows animations and transitions to be defined in a declarative manner, instead of hand coded for each entity (i.e., an animation state machine)
- I'd like the platforming movement to give the player more leeway when they collided right on the very corner of an object (i.e., jumping over spikes, or being unfairly blocked by a ceilling because they jumped a fraction too soon). I tried doing this with smaller collision boxes and while it mode those things feel better
it made the collision look inaccurate in other scenarios


## libs 

- hump (only ended up using gamestate part of this) - https://love2d.org/wiki/HUMP
- anim8 - https://github.com/kikito/anim8 
- bump - https://github.com/kikito/bump.lua 
- classic - https://github.com/rxi/classic
- tiny ECS - https://love2d.org/wiki/tiny-ecs

## Assets

The lovely art is by o-lobster on itch.io: https://o-lobster.itch.io/platformmetroidvania-pixel-art-asset-pack
