# OpenMUD


## Gameplay notes

OpenMUD is a text-based RPG game wherein there exists Guilds, Forts, Player Killing, and Sparring. 

### Guilds

When you join the game you're not part of a guild. You can join a guild by requesting to join and being accepted, being sent an invite, or creating your own. 

Now why would one want to be in a guild? Read on...

### Forts

Forts are areas that can be held by a guild. Forts are protected by a guild and can be attacked by a guild. There exists a leaderboard that ranks guilds based on time they've held any given fort for.

### Player Killing

In order to prevent another guild from taking your guild's fort, you can kill players that are not in your guild. You can also just kill players for fun if you're in a non-safe zone. There exists a leaderboard for ranking players based on kills.

### Sparring

There are two types of sparring: 1) Guild vs Guild and 2) Player vs Player.

#### Guild vs Guild

You get thrown into an arena and duel it out with up to 5 members of another guild.

#### Player vs Player   

Simple 1 on 1 sparring in an arena.

### Other notes

All of this requires there to be weapons and some sort of way to purchase weapons, I'll figure this out later.

## Implementation notes

### Behaviour Tree 

- Start node
- Start node points to a control flow node
- Control flow node points to a decision node
- Decision node points to a control flow node or a leaf node

But these need to be implemented as a registry, which means that others can propose new sibling Behaviours but not new Parents or remove any existing Behaviours.