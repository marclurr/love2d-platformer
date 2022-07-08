# Abandoned love2d platformer

This project started as a way for me to build a reusable framework for making 2d games using Love2D. 
The plan was to build it out while developing a 'micro-metroidvania'. I'd decided I could get something releasable built in about 40 hours work. 
According to my work diary I spent about 40 hours just building the engine, UI and tweaking the player movement, 
but I still thought I could turn it into a game in about another 20 hours.
After some time I became annoyed with how the entities worked so I went off on a tangent and refactored the entity management code to use the tiny ECS library and
changed the goal from metroidvania to 'level based collectathon with melee attack'. 

It's now probably at the point where you could just make levels and new entities for it, but I've decided not to continue due to boredom. 

There are some good things about this project though:

- It's not a bad crack at a platformer using an ECS architecture. Good examples of this are surprisingly thin on the ground, and while I wouldn't call this a masterpiece it works as a starting point
- The platformer movement is smooth and predictable and quite fun to bounce around the level

Things I'd do differently:

- I know for sure I won't do UI in the same way again
- I'd like an easier way to customise drawing on a per-entity basis. The method I used was a bit of a bodge which would make for a lot of duplication
- A better animation system that allows animations and transitions to be defined in a declarative manner, instead of hand coded for each entity (i.e., an animation state machine)
