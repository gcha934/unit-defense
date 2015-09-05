-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')
function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  DebugPrint("[BAREBONES] Performing pre-load precache")

  -- Particles can be precached individually or by folder
  -- It it likely that precaching a single particle system will precache all of its children, but this may not be guaranteed


  -- Models can also be precached by folder or individually

  -- PrecacheModel should generally used over PrecacheResource for individual models

  -- Sounds can precached here like anything else
  


  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  --PrecacheUnitByNameSync("", context)
  
PrecacheUnitByNameSync("Troll Priest", context)
PrecacheUnitByNameSync("Slayer", context)
PrecacheUnitByNameSync("Naga", context)
 PrecacheUnitByNameSync("Troll Duplicator", context)
  PrecacheUnitByNameSync("Ghost", context)
  PrecacheUnitByNameSync("Juggernaut", context)
PrecacheUnitByNameSync("Centaur Chief", context)
PrecacheUnitByNameSync("Frost Wyrm", context)
PrecacheUnitByNameSync("Zealot", context)
PrecacheUnitByNameSync("Toxic Slinger", context)
PrecacheUnitByNameSync("Teddy", context)
PrecacheUnitByNameSync("Water Elemental", context)
PrecacheUnitByNameSync("Fire Beast", context)
PrecacheUnitByNameSync( "Spellbreaker", context)
PrecacheUnitByNameSync( "Normal Knight", context)
PrecacheUnitByNameSync("Marine", context)
PrecacheUnitByNameSync("Revenant", context)
PrecacheUnitByNameSync( "Avatar", context)
PrecacheUnitByNameSync("Hunter", context)
PrecacheUnitByNameSync("Aloof Giant", context)
PrecacheUnitByNameSync("Succubus", context)
PrecacheUnitByNameSync("Troll Dummy", context)
--creeps 
 
 PrecacheUnitByNameSync("Sheep", context)
  PrecacheUnitByNameSync("Wolfcub", context)
  PrecacheUnitByNameSync( "Black Drake", context)
  PrecacheUnitByNameSync ("Spiderling", context)
  PrecacheUnitByNameSync(  "Skeleton", context)
  PrecacheUnitByNameSync(  "Zombie", context)
  PrecacheUnitByNameSync( "Crab", context)
  PrecacheUnitByNameSync ("Drodo", context)
  PrecacheUnitByNameSync( "Razorback", context)
  PrecacheUnitByNameSync( "Boss_Puck", context)
  PrecacheUnitByNameSync( "Wild Beast", context)
  PrecacheUnitByNameSync( "Gargoyle", context)
  PrecacheUnitByNameSync("Blue Thunder", context)
  PrecacheUnitByNameSync( "Green Wyvern", context)
  PrecacheUnitByNameSync(  "Flamewalker", context)
  PrecacheUnitByNameSync(   "Old Grizzly", context)
  PrecacheUnitByNameSync("Kodos", context)
  PrecacheUnitByNameSync( "Armored Beetle", context)
  PrecacheUnitByNameSync( "Infernal", context)
  PrecacheUnitByNameSync("Boss_Iron_Bear", context)
  PrecacheUnitByNameSync("Calamity", context)
  PrecacheUnitByNameSync(  "Machine Golem", context)
  PrecacheUnitByNameSync( "The Corrupted", context)
  PrecacheUnitByNameSync("Vile Shrooms", context)
  PrecacheUnitByNameSync("Vaal", context)
  PrecacheUnitByNameSync("Headless Magus", context)
  PrecacheUnitByNameSync("Golden Sheep", context)
  PrecacheUnitByNameSync( "Carty", context)
  PrecacheUnitByNameSync("Grand Eagle", context)
  PrecacheUnitByNameSync("Boss_Defiler", context)
PrecacheUnitByNameSync("Armored Turtle", context)
PrecacheUnitByNameSync("Wraith", context)
PrecacheUnitByNameSync("Boss_Phoenix", context)
PrecacheUnitByNameSync("Obsidian Golem", context)
PrecacheUnitByNameSync("Kobold Runner", context)
PrecacheUnitByNameSync("The Undying", context)
PrecacheUnitByNameSync("Spitting Lizard", context)
PrecacheUnitByNameSync("Smeevil Bird", context)
PrecacheUnitByNameSync("NightCrawler", context)
PrecacheUnitByNameSync("Purgatory Demon", context)


PrecacheResource(particle,"particles/econ/courier/courier_cluckles/courier_cluckles_ambient_death.vpcf",context)
  

end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()

end