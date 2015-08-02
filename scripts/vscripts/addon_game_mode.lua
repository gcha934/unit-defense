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
PrecacheUnitByNameSync("Ghost Rider", context)
PrecacheUnitByNameSync("Hunter", context)
PrecacheUnitByNameSync("Aloof Giant", context)
PrecacheUnitByNameSync("", context)
PrecacheUnitByNameSync("", context)
--creeps 
 
 PrecacheUnitByNameSync("sheep", context)
  PrecacheUnitByNameSync("wolfcub", context)
  PrecacheUnitByNameSync( "black drake", context)
  PrecacheUnitByNameSync ("spiderling", context)
  PrecacheUnitByNameSync(  "skeleton", context)
  PrecacheUnitByNameSync(  "zombie", context)
  PrecacheUnitByNameSync( "crab", context)
  PrecacheUnitByNameSync ("drodo", context)
  PrecacheUnitByNameSync( "razorback", context)
  PrecacheUnitByNameSync( "boss_puck", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)
  PrecacheUnitByNameSync("", context)



end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()

end