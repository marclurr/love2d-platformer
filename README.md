# Abandoned love2d platformer

This project started as a way for me to build a reusable framework for making 2d games using Love2D. 
The plan was to build it out while developing a 'micro-metroidvania'. I'd decided I could get something releasable built in about 40 hours work. 
According to my work diary I spent about 40 hours just building the engine, UI and tweaking the player movement, 
but I still thought I could turn it into a game in about another 20 hours.
After some time I became annoyed with how the entities worked so I went off on a tangent and refactored the entity management code to use the tiny ECS library and
changed the goal from metroidvania to 'level based collectathon with melee attack'. At this point I stopped tracking my time, I've probably spent about 80-100 hours working on what is really nothing more than a tech-demo.

It's now probably at the point where you could just make levels and new entities for it, but I've decided not to continue due to boredom. 

## Good things

- It's not a bad crack at a platformer using an ECS architecture. Good examples of this are surprisingly thin on the ground, and while I wouldn't call this a masterpiece it works as a starting point
- The platformer movement is smooth and predictable and quite fun to bounce around the level
- The camera supports sub-pixel scrolling which looks very nice in a pixel-art game (It's worth noting you can get this for free if you render at the window resolution but with scaled textures, instead of rendering at a low resolution and scaling that up like I did)

## Different next time

- I know for sure I won't do UI in the same way again
- I'd like an easier way to customise drawing on a per-entity basis. The method I used was a bit of a bodge which would make for a lot of duplication
- A better animation system that allows animations and transitions to be defined in a declarative manner, instead of hand coded for each entity (i.e., an animation state machine)
- I'd like the platforming movement to give the player more leeway when they collided right on the very corner of an object (e.g., jumping over spikes, or being unfairly blocked by a ceilling because they jumped a fraction too soon). I tried doing this with smaller collision boxes and while it made those things feel better
it made the collision look inaccurate in other scenarios

## ECS resources

I did a silly amount of looking around for good ECS resources and I did find a few which helped me

- Spelunky Classic rewritten in C++ using th EnTT library https://github.com/dbeef/spelunky-psp, https://github.com/skypjack/entt
- The EnTT author, skypjack, is a real ECS proponent has written many articles about the subject on his blog https://skypjack.github.io/tags/#entt
- Commando Kibbles is a nice demo written using Tiny ECS its self https://github.com/bakpakin/tiny-ecs/tree/demo-commandokibbles
- 
## libs 

- hump (only ended up using gamestate part of this) - https://love2d.org/wiki/HUMP
- anim8 - https://github.com/kikito/anim8 
- bump - https://github.com/kikito/bump.lua 
- classic - https://github.com/rxi/classic
- tiny ECS - https://love2d.org/wiki/tiny-ecs

## Assets

The lovely art is by o-lobster on itch.io: https://o-lobster.itch.io/platformmetroidvania-pixel-art-asset-pack
