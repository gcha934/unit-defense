  -- This is the primary barebones gamemode script and should be used to assist in initializing your game mode


  -- Set this to true if you want to see a complete debug output of all events/processes done by barebones
  -- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
  BAREBONES_DEBUG_SPEW = false

  if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
  end
--GLOBAL VARIABLES
SPAWN_TIMER=45
ELASPED_TIME=0
UNIT_NAME=0
DOWNTIME=10
START_DELAY=3
ROUND=1
OFFSET=0
MESSAGE_TIMER=0


players= {}
str={}
agi={}
int={}
units={}

FIRST_ROUND=true
MAX_CREEPS=59
pregame=true
BOSS_SPAWN_CHECK=false
UnitCounter=nil
UnitCounter1=nil
UnitCounter2=nil
UnitCounter3=nil




  -- This library allow for easily delayed/timed actions
  require('libraries/timers')
  -- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
  require('libraries/physics')
  -- This library can be used for advanced 3D projectile systems.
  require('libraries/projectiles')
  -- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
  require('libraries/notifications')
  -- This library can be used for starting customized animations on units from lua
  require('libraries/animations')

  -- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
  require('internal/gamemode')
  require('internal/events')

  -- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
  require('settings')
  -- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
  require('events')
  require('abilities')
  require('popups')

  -- [SCOREBOARD] requirements
require('players')
require('libraries/scoreboard')

  function GameMode:OnPlayerPickHero(keys)
    DebugPrint('[BAREBONES] OnPlayerPickHero')
    DebugPrintTable(keys)

    local heroClass = keys.hero
    local hero = EntIndexToHScript(keys.heroindex)
    local player = EntIndexToHScript(keys.player)

    local playerID = hero:GetPlayerID()
  -- Set this player's health bar color
  local teamID = PlayerResource:GetTeam( playerID )
  local color = TEAM_COLORS[teamID]
  -- Add this player to the global list so we can get them later etc...
  hero:SetGold(500, false)
  players[playerID] = playerID
  
  if playerID==0 then

    hero:SetOrigin(originp1)
    hero:SetRespawnsDisabled(true)
 
  elseif playerID==1 then
   hero:SetRespawnsDisabled(true)
   hero:SetOrigin(originp2)
   
 elseif playerID==2 then
  hero:SetRespawnsDisabled(true)
  hero:SetOrigin(originp3)

elseif playerID==3 then
  hero:SetRespawnsDisabled(true)
  hero:SetOrigin(originp4)
  
end
hero:AddNewModifier(hero,nil, "modifier_rooted", {duration = 999999})

units[playerID]=0;
str[playerID]=0
int[playerID]=0
agi[playerID]=0

 

local event_data =
{
    key1 = "value2",
    key2 = "value2",
}
CustomGameEventManager:Send_ServerToAllClients( "my_event_name", event_data )



end
  --[[
    This function should be used to set up Async precache calls at the beginning of the gameplay.

    In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
    after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
    be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
    precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
    defined on the unit.

    This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
    time, you can call the functions individually (for example if you want to precache units in a new wave of
    holdout).


    
    This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
    ]]
    function GameMode:PostLoadPrecache()
      DebugPrint("[BAREBONES] Performing Post-Load precache")    
    --PrecacheItemByNameAsync("item_example_item", function(...) end)
    --PrecacheItemByNameAsync("example_ability", function(...) end)

    --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
    --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
  end

  --[[
    This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
    It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
    ]]
    function GameMode:OnFirstPlayerLoaded()
      DebugPrint("[BAREBONES] First Player has loaded")
    end

  --[[
    This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
    It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
    ]]
    function GameMode:OnAllPlayersLoaded()
      DebugPrint("[BAREBONES] All Players have loaded into the game")
    end

  --[[
    This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
    if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
    levels, changing the starting gold, removing/adding abilities, adding physics, etc.

    The hero parameter is the hero entity that just spawned in
    ]]
    function GameMode:OnHeroInGame(hero)
      DebugPrint("[BAREBONES] Hero spawned in game for first time -- " .. hero:GetUnitName())

    -- This line for example will set the starting gold of every hero to 500 unreliable gold


    -- These lines will create an item and add it to the player, effectively ensuring they start with the item
    --local item = CreateItem("item_example_item", hero, hero)
    --hero:AddItem(item)

    --[[ --These lines if uncommented will replace the W ability of any hero that loads into the game
      --with the "example_ability" ability

    local abil = hero:GetAbilityByIndex(1)
    hero:RemoveAbility(abil:GetAbilityName())
    hero:AddAbility("example_ability")]]

    --I NEED TO FILL THIS WITH PREGAME START STUFF
  end

  --[[
    This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
    gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
    is useful for starting any game logic timers/thinkers, beginning the first round, etc.
    ]]
    function GameMode:OnGameInProgress()

      OFFSET=GameRules:GetGameTime()
        SetupBoard()
    CreateColumnHeaders()
      for i=0,3 do
        if players[i] ~= nil then
          
         setupScoreboard(i)
       end
       end
    --initialise unit counter display


      --since game time with 0:00

        --instructions display
        --and timer to delay them

      end




      function start()
        for nPlayerID = 0, (DOTA_MAX_TEAM_PLAYERS-1) do
    MakeLabelForPlayer( nPlayerID )
  end

        Instructions()
        SpawnCreeps()



      end

function ColorForTeam( teamID )
  local color = GameMode.m_TeamColors[ teamID ]
  if color == nil then
    color = { 255, 255, 255 } -- default to white
  end
  return color
end
---------------------------------------------------------------------------
-- Put a label over a player's hero so people know who is on what team
---------------------------------------------------------------------------
function MakeLabelForPlayer( nPlayerID )
  if not PlayerResource:HasSelectedHero( nPlayerID) then
    return
  end

  local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID)
  if hero == nil then
    return
  end

  local color = ColorForTeam( nPlayerID+1)
  PlayerResource:SetCustomTeamAssignment(nPlayerID,DOTA_TEAM_GOODGUYS)
  hero:SetCustomHealthLabel( PlayerResource:GetPlayerName(nPlayerID), color[1], color[2], color[3])
  PlayerResource:SetCustomPlayerColor(nPlayerID,color[1],color[2],color[3])
end





      function SpawnCreeps()




  --if statement for when gametime has elapsed 45 seconds

  if  GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    --roundinfo display
    if FIRST_ROUND==true then

   
      
       GameRules:SendCustomMessage("         Wave ".. ColorIt(ROUND,"red") .. " start", 0, 0)
       FIRST_ROUND=false

   end
   if GameRules:GetGameTime()>= OFFSET then
     --info on creep spawn specific stuff
     RoundInformation()
      --this should hold the time at the END of the downtime
      if GameRules:GetGameTime()>OFFSET+SPAWN_TIMER then
        ROUND=ROUND+1
           GameRules:SendCustomMessage("         Wave ".. ColorIt(ROUND,"red") .. " start", 0, 0)
        OFFSET=GameRules:GetGameTime()+DOWNTIME
        SPAWN_TIMER=45
        return 1.5
      end
      if BOSS_SPAWN_CHECK==false then
        CreepSpawnLocation()
      end
      
    end
   
    

  end
 

      UnitCount()


  

end





function RoundInformation()


  if ROUND == 1 then
    UNIT_NAME="Sheep"
  elseif ROUND ==2 then
    UNIT_NAME="Wolfcub"
  elseif ROUND ==3 then
    UNIT_NAME="Black Drake"
  elseif ROUND ==4 then
    UNIT_NAME="Spiderling"
  elseif ROUND ==5 then
    UNIT_NAME="Skeleton"
  elseif ROUND ==6 then
    UNIT_NAME="Zombie"
  elseif ROUND ==7 then
    UNIT_NAME="Crab"
  elseif ROUND ==8 then
    UNIT_NAME="Drodo"
  elseif ROUND ==9 then
    UNIT_NAME="Razorback"
  elseif ROUND ==10 then
    UNIT_NAME= "Boss_Puck"
  elseif ROUND ==11 then
    UNIT_NAME= "Wild Beast"    
    BOSS_SPAWN_CHECK=false
  elseif ROUND ==12 then
    UNIT_NAME= "Gargoyle"
  elseif ROUND ==13 then
    UNIT_NAME="Blue Thunder"
  elseif ROUND ==14 then
    UNIT_NAME=  "Green Wyvern"
  elseif ROUND ==15 then
    UNIT_NAME=  "Flamewalker"
   elseif ROUND ==16 then
    UNIT_NAME=  "Old Grizzly" 
   elseif ROUND ==17 then
    UNIT_NAME= "Kodos"
   elseif ROUND ==18 then
    UNIT_NAME= "Armored Beetle"
   elseif ROUND ==19 then
    UNIT_NAME=  "Infernal"
   elseif ROUND ==20 then
    UNIT_NAME= "Boss_Iron_Bear"
   elseif ROUND ==21 then
    UNIT_NAME= "Calamity"
    BOSS_SPAWN_CHECK=false
    elseif ROUND ==22 then
    UNIT_NAME= "Machine Golem"
    elseif ROUND ==23 then
    UNIT_NAME= "The Corrupted"
    elseif ROUND ==24 then
    UNIT_NAME= "Vile Shrooms"
    elseif ROUND ==25 then
    UNIT_NAME= "Vaal"
    elseif ROUND ==26 then
    UNIT_NAME= "Headless Magus"
    elseif ROUND ==27 then
    UNIT_NAME= "Golden Sheep"
    elseif ROUND ==28 then
    UNIT_NAME= "Carty"
    elseif ROUND ==29 then
    UNIT_NAME= "Grand Eagle"
    elseif ROUND ==30 then
    UNIT_NAME= "Boss_Defiler"
     elseif ROUND ==31 then
    UNIT_NAME= "Armored Turtle"
      BOSS_SPAWN_CHECK=false
       elseif ROUND ==32 then
    UNIT_NAME= "Wraith"
     elseif ROUND ==33 then
    UNIT_NAME= "Obsidian Golem"
     elseif ROUND ==34 then
    UNIT_NAME= "Kobold Runner"
     elseif ROUND ==35 then
    UNIT_NAME= "The Undying"
     elseif ROUND ==36 then
    UNIT_NAME= "Spitting Lizard"
     elseif ROUND ==37 then
    UNIT_NAME= "Smeevil Bird"
     elseif ROUND ==38 then
    UNIT_NAME= "NightCrawler"
     elseif ROUND ==39 then
    UNIT_NAME= "Purgatory Demon"
     elseif ROUND ==40 then
    UNIT_NAME= "Boss_Phoenix"


  end
end

function CreepSpawnLocation()

  if players[0]~=nil then
    local point = Entities:FindByName( nil, "spawner"):GetAbsOrigin()     
    local start = Entities:FindByName( nil, "pos4")
       
         local unit = CreateUnitByName(UNIT_NAME, point, true, nil, nil, DOTA_TEAM_BADGUYS)
         unit:SetInitialGoalEntity(start)
         unit:SetMustReachEachGoalEntity(true)
       end

       if players[1]~=nil then
        local point = Entities:FindByName( nil, "spawner1"):GetAbsOrigin()     
        local start = Entities:FindByName( nil, "2pos4")
     
         local unit = CreateUnitByName(UNIT_NAME, point, true, nil, nil, DOTA_TEAM_BADGUYS)
         unit:SetInitialGoalEntity(start)
         unit:SetMustReachEachGoalEntity(true)
       end

       if players[2]~=nil then
        local point = Entities:FindByName( nil, "spawner2"):GetAbsOrigin()     
        local start = Entities:FindByName( nil, "3pos4")
    
         local unit = CreateUnitByName(UNIT_NAME, point, true, nil, nil, DOTA_TEAM_BADGUYS)
         unit:SetInitialGoalEntity(start)
         unit:SetMustReachEachGoalEntity(true)
       end

       if players[3]~=nil then
        local point = Entities:FindByName( nil, "spawner3"):GetAbsOrigin()     
        local start = Entities:FindByName( nil, "4pos4")
     
         local unit = CreateUnitByName(UNIT_NAME, point, true, nil, nil, DOTA_TEAM_BADGUYS)
         unit:SetInitialGoalEntity(start)
         unit:SetMustReachEachGoalEntity(true)
       end

       if ROUND%10==0 then
        BOSS_SPAWN_CHECK=true
        SPAWN_TIMER=60
        countdown()
     
      end
     

    end

    function countdown()
Timers:CreateTimer(1, function()
      ShowBossMessage(  "BOSS TIME!", 3 )

     end
     )


Timers:CreateTimer(7, function()
      ShowBossMessage(  "50", 5 )

     end
     )
Timers:CreateTimer(17, function()
      ShowBossMessage(  "40", 5 )

     end
     )

Timers:CreateTimer(27, function()
      ShowBossMessage(  "30", 5 )

     end
     )
Timers:CreateTimer(37, function()
      ShowBossMessage("20", 5 )

     end
     )
Timers:CreateTimer(47, function()
      ShowBossMessage(  "10", 5 )

     end
     )

Timers:CreateTimer(52, function()
      ShowBossMessage(  "5..", 1 )

     end
     )


Timers:CreateTimer(53, function()
      ShowBossMessage(  "4..", 1 )

     end
     )
Timers:CreateTimer(54, function()
      ShowBossMessage(  "3..", 1 )

     end
     )
Timers:CreateTimer(55, function()
      ShowBossMessage( "2..", 1 )

     end
     )
Timers:CreateTimer(56, function()
      ShowBossMessage(  "1..", 1 )

     end
     )




    end

    function UnitCount()

  -- make this player specific later and vector specific somehow
  --need to check if this counter includes playerowned units
  if players[0]~=nil then
     UnitCounter = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
      originp1,
      nil,
      2500,
      DOTA_UNIT_TARGET_TEAM_ENEMY,
      DOTA_UNIT_TARGET_CREEP,
      0,
      0,
      false)

    if ( ROUND%10==0 and  GameRules:GetGameTime()>= OFFSET+SPAWN_TIMER-2) and #UnitCounter~=0 then
         local UnitKill = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
          originp1,
          nil,
          2500,
          DOTA_UNIT_TARGET_TEAM_BOTH,
          DOTA_UNIT_TARGET_ALL,
          0,
          0,
          false)
        for k,v in pairs(UnitKill) do
          v:ForceKill(false)
        end
        players[0]=nil
      end
  


    
    if #UnitCounter>MAX_CREEPS then
        --change this later to be player specific
        local UnitKill = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
          originp1,
          nil,
          2500,
          DOTA_UNIT_TARGET_TEAM_BOTH,
          DOTA_UNIT_TARGET_ALL,
          0,
          0,
          false)
        for k,v in pairs(UnitKill) do
          v:ForceKill(false)
        end
        players[0]=nil
      end
    end
    if players[1]~=nil then
    UnitCounter1 = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
        originp2,
        nil,
        2500,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_CREEP,
        0,
        0,
        false)
          if ( ROUND%10==0 and  GameRules:GetGameTime()>= OFFSET+SPAWN_TIMER-2) and #UnitCounter1~=0 then
         local UnitKill = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
          originp2,
          nil,
          2500,
          DOTA_UNIT_TARGET_TEAM_BOTH,
          DOTA_UNIT_TARGET_ALL,
          0,
          0,
          false)
        for k,v in pairs(UnitKill) do
          v:ForceKill(false)
        end
        players[1]=nil
    
    end
      if #UnitCounter1>MAX_CREEPS then
  --change this later to be player specific
        local UnitKill = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
          originp2,
          nil,
          2500,
          DOTA_UNIT_TARGET_TEAM_BOTH,
          DOTA_UNIT_TARGET_ALL,
          0,
          0,
          false)
        for k,v in pairs(UnitKill) do
          v:ForceKill(false)
        end
        players[1]=nil
      end
    end

    if players[2]~=nil then
     UnitCounter2 = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
        originp3,
        nil,
        2500,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_CREEP,
        0,
        0,
        false)
      
          if ( ROUND%10==0 and  GameRules:GetGameTime()>= OFFSET+SPAWN_TIMER-2) and #UnitCounter2~=0 then
         local UnitKill = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
          originp3,
          nil,
          2500,
          DOTA_UNIT_TARGET_TEAM_BOTH,
          DOTA_UNIT_TARGET_ALL,
          0,
          0,
          false)
        for k,v in pairs(UnitKill) do
          v:ForceKill(false)
        end
        players[2]=nil
      end
    



      if #UnitCounter2>MAX_CREEPS then
      --change this later to be player specific
      local UnitKill = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
        originp3,
        nil,
        2500,
        DOTA_UNIT_TARGET_TEAM_BOTH,
        DOTA_UNIT_TARGET_ALL,
        0,
        0,
        false)
        for k,v in pairs(UnitKill) do
          v:ForceKill(false)
        end
      players[2]=nil
      end
    end
    if players[3]~=nil then
     UnitCounter3 = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
        originp4,
        nil,
        2500,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_CREEP,
        0,
        0,
        false)
      

          if ( ROUND%10==0 and  GameRules:GetGameTime()>= OFFSET+SPAWN_TIMER-2) and #UnitCounter3~=0 then
         local UnitKill = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
          originp4,
          nil,
          2500,
          DOTA_UNIT_TARGET_TEAM_BOTH,
          DOTA_UNIT_TARGET_ALL,
          0,
          0,
          false)
        for k,v in pairs(UnitKill) do
          v:ForceKill(false)
        end
        players[3]=nil
      end
    

        if #UnitCounter3>MAX_CREEPS then
        --change this later to be player specific
        local UnitKill = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
          originp4,
          nil,
          2500,
          DOTA_UNIT_TARGET_TEAM_BOTH,
          DOTA_UNIT_TARGET_ALL,
          0,
          0,
          false)
        for k,v in pairs(UnitKill) do
          v:ForceKill(false)
        end
        players[3]=nil
      end

    end

if(GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then
    if players[0]==nil and players[1]==nil and players[2] == nil and players[3] ==nil then
      Timers:CreateTimer(3, function()
        ancient=Entities:FindByName(nil, "dota_goodguys_fort")
        ancient:ForceKill(false);
      end
      )
    end
end
if(GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS and ROUND ==41) then

  
      
      Timers:CreateTimer(3, function()
       GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
      GameRules:SetCustomVictoryMessage("Congratulations!")
  
      end
      )

  
  end
end

--message and color settings
function ShowBossMessage( msg, dur )
  local msg = {
    message = msg,
    duration = dur
  }
  FireGameEvent("show_center_message",msg)
end




  -- This function initializes the game mode and is called before anyone loads into the game
  -- It can be used to pre-initialize any values/tables that will be needed later
  function GameMode:InitGameMode()
   
    DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')

    -- Call the internal function to set up the rules/behaviors specified in constants.lua
    -- This also sets up event hooks for all event handlers in events.lua
    -- Check out internals/gamemode to see/modify the exact code
    GameMode:_InitGameMode()
    originp1=Entities:FindByName(nil,"originp1"):GetAbsOrigin()
    originp2=Entities:FindByName(nil,"originp2"):GetAbsOrigin()
    originp3=Entities:FindByName(nil,"originp3"):GetAbsOrigin()
    originp4=Entities:FindByName(nil,"originp4"):GetAbsOrigin()
    GameMode.m_TeamColors = {}
  GameMode.m_TeamColors[1] = { 255, 0, 0 }
  GameMode.m_TeamColors[2] = { 0, 255, 0 }
  GameMode.m_TeamColors[3] = { 0, 0, 255 }
  GameMode.m_TeamColors[4] = { 255, 128, 64 }
    -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
    Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )
    GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(GameMode,"FilterDamage"),GameMode)
 
   SendToConsole("dota_camera_disable_zoom 1")
   GameRules:SetPostGameTime(60)
    Timers:CreateTimer(function()
     start()
     return 1.5
   end
   )
    Instructions()
  end




  function  Instructions()
    if  GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME and pregame==true then
      -- A timer running every second that starts 5 seconds in the future, respects pauses
        Timers:CreateTimer(2, function()
       GameRules:SendCustomMessage(ColorIt("Use the 4th skill to buy units","blue") , 0, 0)

     end
     )    Timers:CreateTimer(2, function()
       GameRules:SendCustomMessage(ColorIt("Units that you spawn are completely random","blue") , 0, 0)

     end
     )



               Timers:CreateTimer(10, function()
       GameRules:SendCustomMessage(ColorIt("First 3 skills upgrades the damage of your units","blue") , 0, 0)

     end
     )


      Timers:CreateTimer(15, function()
       GameRules:SendCustomMessage(ColorIt("You lose if your creep counter reaches ".. MAX_CREEPS+1,"red") , 0, 0)

     end
     )
      Timers:CreateTimer(20, function()
       GameRules:SendCustomMessage(ColorIt("Boss spawns every 10 rounds","purple") , 0, 0)

     end
     )
      Timers:CreateTimer(25, function()
       GameRules:SendCustomMessage(ColorIt("You must clear all units by the end of the boss wave","red") , 0, 0)

     end
     )
        Timers:CreateTimer(30, function()
       GameRules:SendCustomMessage(ColorIt("good luck","red") , 0, 0)

     end
     )
      pregame=false
    end
  end
  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')


  -- This is an example console command
  function GameMode:ExampleConsoleCommand()
    print( '******* Example Console Command ***************' )
    local cmdPlayer = Convars:GetCommandClient()
    if cmdPlayer then
      local playerID = cmdPlayer:GetPlayerID()
      if playerID ~= nil and playerID ~= -1 then
        -- Do something here for the player who called this command
        PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_viper", 1000, 1000)
      end
    end

    print( '*********************************************' )
  end