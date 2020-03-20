It is noted that given the kinematic body solution with the periodic effects
blocks, they will "jump" during the physics frame and create a glitch area which
the player can be affected with but cannot be obtained via a physics collision.

That sounded like a shit-ton of nonsense.

let's just say that if I want a hurt block to intersect a basic platform, they
cannot be on the same collision level or else that will fuck everything up.

Solotuion

Effect blocks will have the collision layer 2 and the collision mask of nothing
