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

The technically interesting part of this game is that its really an experiment in enabling real, useful, Modding / User-Generated Content. 

We'll mess with this by implementing a Behaviour Tree for each Entity in the game, which has a list of actions that the entity can do at any given time in the game. This Behaviour Tree will be implemented as a Registry to which anyone can contribute. 

There are two key problems we want to explore and solve with this experiment: 

- We need a way to determine which the correct Behaviour is to use for each Entity, many players may submit a `SpawnMonster` behaviour, but we need to know which `SpawnMonster` submission is the desired one (Determining Legitimacy).
- We must require that any of the behaviours that are submitted to the Registry must be valid, meaning that they must adhere to the "Physics" of the game.


### Architecture 

- 


### Behaviour Tree 

- Start node
- Start node points to a control flow node
- Control flow node points to a decision node
- Decision node points to a control flow node or a leaf node

But these need to be implemented as a registry, which means that others can propose new sibling Behaviours but not new Parents or remove any existing Behaviours.


## Rough thinking

- [x] Do ALL Entities have a Behaviour Tree, or just NPC-like Entities?
    - I don't think a Fort needs a behaviour tree, it should simply be implemented as an Entity with specific Components.
- [ ] Lets play through an example where we have a Fort that has an `OwnedByComponent` and a player wants to add a new `OwnedByComponent` to it which has new logic that allows for there to be two owner Guilds (because of alliances)
    - This would require the player to add an `AllianceComponent` to the `Guild` Entity alongside the new change to the `Fort Entity.
        - The question then becomes, how do you implement logic in the new `AllianceComponent` contract that works reads the new `OwnedByComponent` contract?
            - I think this may be possible by just deploying each contract separately, registering each in the correct place, and writing the logic in each contract such that it reads the respective registry for the respective contract and makes calls to the contract found there rather than internal calls.
- [ ] Can the client be written to automatically update 
- [ ] Is it true that new Content submissions naturally respect the Physics because they can't just destroy a Fort for example?
    - What happens if someone adds a `DestroyableComponent` to the `Fort`?
        - Client-side
            - The client should be updated to show 
- [ ] Real UGC requires more than Behaviour addition, you must be able to add new Entities, Components, Systems, alongside Behaviours so I need to figure out how the ECS registry works