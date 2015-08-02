  -- This is the primary barebones gamemode script and should be used to assist in initializing your game mode


  -- Set this to true if you want to see a complete debug output of all events/processes done by barebones
  -- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
  BAREBONES_DEBUG_SPEW = true

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
FIRST_ROUND=true
MAX_CREEPS=60
pregame=true
BOSS_SPAWN_CHECK=false

-- Place holder till they fix the playername function
aux_vector = {"Player 1", "Player 2", "Player 3", "Player 4", "Player 5", "Player 6"}



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
    hero:AddNewModifier(hero,nil, "modifier_rooted", {duration = 999999})
  elseif playerID==1 then
   hero:SetRespawnsDisabled(true)
   hero:SetOrigin(originp2)
   hero:AddNewModifier(hero,nil, "modifier_rooted", {duration = 999999})
 elseif playerID==2 then
  hero:SetRespawnsDisabled(true)
  hero:SetOrigin(originp3)
  hero:AddNewModifier(hero,nil, "modifier_rooted", {duration = 999999})
elseif playerID==3 then
  hero:SetRespawnsDisabled(true)
  hero:SetOrigin(originp4)
  hero:AddNewModifier(hero,nil, "modifier_rooted", {duration = 999999})
end


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
      --initialise unit counter display
      


      --since game time with 0:00

        --instructions display
        --and timer to delay them

      end




      function start()
        Instructions()
        SpawnCreeps()



      end
      function SpawnCreeps()




  --if statement for when gametime has elapsed 45 seconds

  if  GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
    --roundinfo display
    if FIRST_ROUND==true then
     Timers:CreateTimer(function()
       GameRules:SendCustomMessage("         Wave ".. ColorIt(ROUND,"red") .. " start", 0, 0)
       FIRST_ROUND=false
       return SPAWN_TIMER+DOWNTIME
     end
     )
   end
   if GameRules:GetGameTime()>= OFFSET then
     --info on creep spawn specific stuff
     RoundInformation()
      --this should hold the time at the END of the downtime
      if GameRules:GetGameTime()>OFFSET+SPAWN_TIMER then
        ROUND=ROUND+1
        OFFSET=GameRules:GetGameTime()+DOWNTIME
        return 1.0
      end
      if BOSS_SPAWN_CHECK==false then
        CreepSpawnLocation()
      end
      
    end
   
    UnitCount()
  end
 --print(OFFSET,"offset")
     --print(OFFSET+SPAWN_TIMER,"offset+SPAWN_TIMER")
      --print(BOSS_SPAWN_CHECK,"boss spawn check")




  

end





function RoundInformation()


  if ROUND == 1 then
    UNIT_NAME="sheep"
  elseif ROUND ==2 then
    UNIT_NAME="wolfcub"
  elseif ROUND ==3 then
    UNIT_NAME="black drake"
  elseif ROUND ==4 then
    UNIT_NAME="spiderling"
  elseif ROUND ==5 then
    UNIT_NAME="skeleton"
  elseif ROUND ==6 then
    UNIT_NAME="zombie"
  elseif ROUND ==7 then
    UNIT_NAME="crab"
  elseif ROUND ==8 then
    UNIT_NAME="drodo"
  elseif ROUND ==9 then
    UNIT_NAME="razorback"
  elseif ROUND ==10 then
    UNIT_NAME= "boss_puck"
  elseif ROUND ==11 then
    UNIT_NAME= "sheep"    
    BOSS_SPAWN_CHECK=false
  end
end

function CreepSpawnLocation()

  if players[0]~=nil then
    local point = Entities:FindByName( nil, "spawner"):GetAbsOrigin()     
    local start = Entities:FindByName( nil, "pos1")
         --have to replace sheep with UNIT_NAME later
         local unit = CreateUnitByName(UNIT_NAME, point, true, nil, nil, DOTA_TEAM_BADGUYS)
         unit:SetInitialGoalEntity(start)
         unit:SetMustReachEachGoalEntity(true)
       end

       if players[1]~=nil then
        local point = Entities:FindByName( nil, "spawner1"):GetAbsOrigin()     
        local start = Entities:FindByName( nil, "2pos1")
         --have to replace sheep with UNIT_NAME later
         local unit = CreateUnitByName(UNIT_NAME, point, true, nil, nil, DOTA_TEAM_BADGUYS)
         unit:SetInitialGoalEntity(start)
         unit:SetMustReachEachGoalEntity(true)
       end

       if players[2]~=nil then
        local point = Entities:FindByName( nil, "spawner2"):GetAbsOrigin()     
        local start = Entities:FindByName( nil, "3pos1")
         --have to replace sheep with UNIT_NAME later
         local unit = CreateUnitByName(UNIT_NAME, point, true, nil, nil, DOTA_TEAM_BADGUYS)
         unit:SetInitialGoalEntity(start)
         unit:SetMustReachEachGoalEntity(true)
       end

       if players[3]~=nil then
        local point = Entities:FindByName( nil, "spawner3"):GetAbsOrigin()     
        local start = Entities:FindByName( nil, "4pos1")
         --have to replace sheep with UNIT_NAME later
         local unit = CreateUnitByName(UNIT_NAME, point, true, nil, nil, DOTA_TEAM_BADGUYS)
         unit:SetInitialGoalEntity(start)
         unit:SetMustReachEachGoalEntity(true)
       end

       if ROUND%10==0 then
        BOSS_SPAWN_CHECK=true
      end
     

    end

    function UnitCount()

  -- make this player specific later and vector specific somehow
  --need to check if this counter includes playerowned units
  if players[0]~=nil then
    local UnitCounter = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
      originp1,
      nil,
      2500,
      DOTA_UNIT_TARGET_TEAM_ENEMY,
      DOTA_UNIT_TARGET_CREEP,
      0,
      0,
      false)

    if ( ROUND%10==0 and  GameRules:GetGameTime()>= OFFSET+SPAWN_TIMER-2) and UnitCounter~=nil then
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
      local UnitCounter = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
        originp2,
        nil,
        2500,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_CREEP,
        0,
        0,
        false)
          if ( ROUND%10==0 and  GameRules:GetGameTime()>= OFFSET+SPAWN_TIMER-2) and UnitCounter1~=nil then
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
        players[0]=nil
    
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
      local UnitCounter2 = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
        originp3,
        nil,
        2500,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_CREEP,
        0,
        0,
        false)
      
          if ( ROUND%10==0 and  GameRules:GetGameTime()>= OFFSET+SPAWN_TIMER-2) and UnitCounter2~=nil then
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
        players[0]=nil
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
      local UnitCounter3 = FindUnitsInRadius(DOTA_TEAM_GOODGUYS,
        originp4,
        nil,
        2500,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_CREEP,
        0,
        0,
        false)
      

          if ( ROUND%10==0 and  GameRules:GetGameTime()>= OFFSET+SPAWN_TIMER-2) and UnitCounter3~=nil then
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
        players[0]=nil
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


    if players[0]==nil and players[1]==nil and players[2] == nil and players[3] ==nil then
      Timers:CreateTimer(3, function()
        ancient=Entities:FindByName(nil, "dota_goodguys_fort")
        ancient:ForceKill(false);
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
    GameMode = self
    DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')

    -- Call the internal function to set up the rules/behaviors specified in constants.lua
    -- This also sets up event hooks for all event handlers in events.lua
    -- Check out internals/gamemode to see/modify the exact code
    GameMode:_InitGameMode()
    originp1=Entities:FindByName(nil,"originp1"):GetAbsOrigin()
    originp2=Entities:FindByName(nil,"originp2"):GetAbsOrigin()
    originp3=Entities:FindByName(nil,"originp3"):GetAbsOrigin()
    originp4=Entities:FindByName(nil,"originp4"):GetAbsOrigin()
    -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
    Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )
    GameRules:GetGameModeEntity():SetDamageFilter(Dynamic_Wrap(GameMode,"FilterDamage"),self)
    SendToServerConsole("r_farz 7000")
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
      Timers:CreateTimer(5, function()
       GameRules:SendCustomMessage(ColorIt("Creep start spawning at 00:00","red") , 0, 0)

     end
     )
      Timers:CreateTimer(10, function()
       GameRules:SendCustomMessage(ColorIt("Boss spawns every 10 rounds","purple") , 0, 0)

     end
     )
      Timers:CreateTimer(20, function()
       GameRules:SendCustomMessage(ColorIt("Good Luck!","red") , 0, 0)

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