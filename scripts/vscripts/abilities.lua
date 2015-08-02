

function trueshot_initialize_agility( keys )

local agiUpgrade=0
    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    local prefix = "modifier_trueshot_damage_agility_mod_"
    local percent = ability:GetLevelSpecialValueFor( "trueshot_ranged_damage", ability:GetLevel() - 1 )
     Timers:CreateTimer( DoUniqueString( "trueshot_updateDamage_" .. target:entindex() ), {
        endTime = 1,
        callback = function()

            if target and (target:HasModifier("modifier_strong_agility_multiplier_datadriven") or target:HasModifier("modifier_medium_agility_multiplier_datadriven") 
                                  or target:HasModifier("modifier_weak_agility_multiplier_datadriven") )then
                -- Adjust damage based on agility of caster
                local agility = caster:GetAgility()
                

                if caster:HasAbility("increase_agility_tier2") and agiUpgrade==0 then
                   agiUpgrade=1
                    damage=0
                    ability=caster:GetAbilityByIndex(1)
                    print("this ran")
                end
                if caster:HasAbility("increase_agility_tier3") and (agiUpgrade==0 or agiUpgrade ==1)then
                    agiUpgrade=2
                    damage=0
                    ability=caster:GetAbilityByIndex(1)
                    print("this ran")
                end
                local multiplier=1
                if target:HasModifier("modifier_strong_agility_multiplier_datadriven") then
                    multiplier=8
                elseif target:HasModifier("modifier_medium_agility_multiplier_datadriven") then
                    multiplier=5
                elseif target:HasModifier("modifier_weak_agility_multiplier_datadriven") then
                    multiplier=2
                end
                --i will need to adjust this for each unit that i want to have a different value. probably going make another function inside this
                local damage = math.floor( agility * percent / 100 )*multiplier
               
               
                
                -- check if unit has attribute
                if not target.TrueshotDamage then
                    target.TrueshotDamage = 0
                end
                
                -- Check if unit doesn't have buff
                if not target:HasModifier( "modifier_trueshot_effect_agility_datadriven" ) then
                    damage = 0
                end
                
                local damage_ref = damage
                
                -- If the stored value is different
                if target.TrueshotDamage ~= damage then
                    -- modifier values
                    local bitTable = { 512, 256, 128, 64, 32, 16, 8, 4, 2, 1 }
                    
                    -- Get the list of modifiers on the hero and loops through removing
                    local modCount = target:GetModifierCount()
                    for i = 0, modCount do
                        for u = 1, #bitTable do
                            local val = bitTable[u]
                            if target:GetModifierNameByIndex( i ) == prefix .. val then
                                target:RemoveModifierByName( prefix .. val )
                            end
                        end
                    end
                    
                    -- Add modifiers
                    for p = 1, #bitTable do
                        local val = bitTable[p]
                        local count = math.floor( damage / val )
                        if count >= 1 then
                            ability:ApplyDataDrivenModifier( caster, target, prefix .. val, {} )
                            damage = damage - val
                        end
                    end
                end
                target.TrueshotDamage = damage_ref
                return 1
            else
                return nil
            end
        end
    })
end

function increase_agility(keys)
     local caster = keys.caster
     local ability = keys.ability
      if caster:HasModifier("modifier_increase_agility") == false then
        ability:ApplyDataDrivenModifier( caster, caster, "modifier_increase_agility", nil)
        caster:SetModifierStackCount("modifier_increase_agility", caster, 1)
    else
        caster:SetModifierStackCount("modifier_increase_agility", caster, (caster:GetModifierStackCount("modifier_increase_agility", caster) + 1))
    end
     if  (caster:GetModifierStackCount("modifier_increase_agility", caster)==5) then
        caster:RemoveAbility("increase_agility")
           caster:RemoveModifierByName("modifier_trueshot_aura_agility_datadriven")
         caster:RemoveModifierByName("modifier_increase_agility")
        caster:AddAbility("increase_agility_tier2")
     
        local newAbility=caster:GetAbilityByIndex(1)
        newAbility:SetLevel(1)  
        newAbility:ApplyDataDrivenModifier( caster, caster, "modifier_increase_agility", nil)
        caster:SetModifierStackCount("modifier_increase_agility", caster, 5)
    end
    if  (caster:GetModifierStackCount("modifier_increase_agility", caster)==15) then
         caster:RemoveAbility("increase_agility_tier2")
        caster:RemoveModifierByName("modifier_trueshot_aura_agility_datadriven")
         caster:RemoveModifierByName("modifier_increase_agility")
              caster:AddAbility("increase_agility_tier3")
        local newAbility=caster:GetAbilityByIndex(1)
        newAbility:SetLevel(1)
        newAbility:ApplyDataDrivenModifier( caster, caster, "modifier_increase_agility", nil)
        caster:SetModifierStackCount("modifier_increase_agility", caster, 15)
    end
    PopupAgiTome(caster, 1)

end

function trueshot_initialize_strength( keys )
    local strUpgrade=0
    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
     local percent = ability:GetLevelSpecialValueFor( "trueshot_ranged_damage", ability:GetLevel() - 1 )
    local prefix = "modifier_trueshot_damage_strength_mod_"
    
    Timers:CreateTimer( DoUniqueString( "trueshot_updateDamage_" .. target:entindex() ), {
   


        endTime = 1,
        callback = function()

            if target and (target:HasModifier("modifier_strong_strength_multiplier_datadriven") or target:HasModifier("modifier_medium_strength_multiplier_datadriven") 
                                  or target:HasModifier("modifier_weak_strength_multiplier_datadriven") )then
                -- Adjust damage based on strength of caster
                local strength = caster:GetStrength()
               
                if caster:HasAbility("increase_strength_tier2") and strUpgrade==0 then
                   strUpgrade=1
                    damage=0
                    ability=caster:GetAbilityByIndex(0)
                    print("this ran")
                end
                if caster:HasAbility("increase_strength_tier3") and (strUpgrade==0 or strUpgrade ==1)then
                    strUpgrade=2
                    damage=0
                    ability=caster:GetAbilityByIndex(0)
                    print("this ran")
                end
                
                print("looping")
               
               
                local multiplier=1
                if target:HasModifier("modifier_strong_strength_multiplier_datadriven") then
                    multiplier=8
                elseif target:HasModifier("modifier_medium_strength_multiplier_datadriven") then
                    multiplier=5
                elseif target:HasModifier("modifier_weak_strength_multiplier_datadriven") then
                    multiplier=2
                end
                --i will need to adjust this for each unit that i want to have a different value. probably going make another function inside this
                local damage = math.floor( strength * percent / 100 )*multiplier
             
               
                
                -- check if unit has attribute
                if not target.TrueshotDamage then
                    target.TrueshotDamage = 0
                end
                
                -- Check if unit doesn't have buff
                if not target:HasModifier( "modifier_trueshot_effect_strength_datadriven" ) then
                    damage = 0
                end
                
                local damage_ref = damage
                
                -- If the stored value is different
                if target.TrueshotDamage ~= damage then
                    -- modifier values
                    local bitTable = { 512, 256, 128, 64, 32, 16, 8, 4, 2, 1 }
                    
                    -- Get the list of modifiers on the hero and loops through removing
                    local modCount = target:GetModifierCount()
                    for i = 0, modCount do
                        for u = 1, #bitTable do
                            local val = bitTable[u]
                            if target:GetModifierNameByIndex( i ) == prefix .. val then
                                target:RemoveModifierByName( prefix .. val )
                            end
                        end
                    end
                    
                    -- Add modifiers
                    for p = 1, #bitTable do
                        local val = bitTable[p]
                        local count = math.floor( damage / val )
                        if count >= 1 then
                            ability:ApplyDataDrivenModifier( caster, target, prefix .. val, {} )
                            damage = damage - val
                        end
                    end
                end
                target.TrueshotDamage = damage_ref
                return 1
            else
                return nil
            end
        end
    })
end

function increase_strength(keys)
     local caster = keys.caster
     local ability = keys.ability
      if caster:HasModifier("modifier_increase_strength") == false then
        ability:ApplyDataDrivenModifier( caster, caster, "modifier_increase_strength", nil)
        caster:SetModifierStackCount("modifier_increase_strength", caster, 1)
    else
        caster:SetModifierStackCount("modifier_increase_strength", caster, (caster:GetModifierStackCount("modifier_increase_strength", caster) + 1))
    end
     if  (caster:GetModifierStackCount("modifier_increase_strength", caster)==5) then
        caster:RemoveAbility("increase_strength")  
        caster:RemoveModifierByName("modifier_trueshot_aura_strength_datadriven")
         caster:RemoveModifierByName("modifier_increase_strength")
          caster:AddAbility("increase_strength_tier2")
        local newAbility=caster:GetAbilityByIndex(0)
        newAbility:SetLevel(1)  
        newAbility:ApplyDataDrivenModifier( caster, caster, "modifier_increase_strength", nil)
        caster:SetModifierStackCount("modifier_increase_strength", caster, 5)
    end
    if  (caster:GetModifierStackCount("modifier_increase_strength", caster)==15) then
         caster:RemoveAbility("increase_strength_tier2")
          caster:RemoveModifierByName("modifier_trueshot_aura_strength_datadriven")
         caster:RemoveModifierByName("modifier_increase_strength")
        caster:AddAbility("increase_strength_tier3")
       
        local newAbility=caster:GetAbilityByIndex(0)
        newAbility:SetLevel(1)
        newAbility:ApplyDataDrivenModifier( caster, caster, "modifier_increase_strength", nil)
        caster:SetModifierStackCount("modifier_increase_strength", caster, 15)
    end
    PopupStrTome(caster, 1)
end

function trueshot_initialize_intellect( keys )
    local intUpgrade=0
    local caster = keys.caster
    local target = keys.target
    local ability = keys. ability
    local prefix = "modifier_trueshot_damage_intellect_mod_"
     local percent = ability:GetLevelSpecialValueFor( "trueshot_ranged_damage", ability:GetLevel() - 1 )
     Timers:CreateTimer( DoUniqueString( "trueshot_updateDamage_" .. target:entindex() ), {
        endTime = 1,
        callback = function()

            if target and (target:HasModifier("modifier_strong_intellect_multiplier_datadriven") or target:HasModifier("modifier_medium_intellect_multiplier_datadriven") 
                                  or target:HasModifier("modifier_weak_intellect_multiplier_datadriven") )then
                -- Adjust damage based on intellect of caster
                local intellect = caster:GetIntellect()
               
                     if caster:HasAbility("increase_intellect_tier2") and intUpgrade==0 then
                   intUpgrade=1
                    damage=0
                    ability=caster:GetAbilityByIndex(2)
                    print("this ran")
                end
                if caster:HasAbility("increase_intellect_tier3") and (intUpgrade==0 or intUpgrade ==1)then
                    intUpgrade=2
                    damage=0
                    ability=caster:GetAbilityByIndex(2)
                    print("this ran")
                end
                local multiplier=1
                if target:HasModifier("modifier_strong_intellect_multiplier_datadriven") then
                    multiplier=8
                elseif target:HasModifier("modifier_medium_intellect_multiplier_datadriven") then
                    multiplier=5
                elseif target:HasModifier("modifier_weak_intellect_multiplier_datadriven") then
                    multiplier=2
                end
                --i will need to adjust this for each unit that i want to have a different value. probably going make another function inside this
                local damage = math.floor( intellect * percent / 100 )*multiplier
                 
               
                
                -- check if unit has attribute
                if not target.TrueshotDamage then
                    target.TrueshotDamage = 0
                end
                
                -- Check if unit doesn't have buff
                if not target:HasModifier( "modifier_trueshot_effect_intellect_datadriven" ) then
                    damage = 0
                end
                
                local damage_ref = damage
                
                -- If the stored value is different
                if target.TrueshotDamage ~= damage then
                    -- modifier values
                    local bitTable = { 512, 256, 128, 64, 32, 16, 8, 4, 2, 1 }
                    
                    -- Get the list of modifiers on the hero and loops through removing
                    local modCount = target:GetModifierCount()
                    for i = 0, modCount do
                        for u = 1, #bitTable do
                            local val = bitTable[u]
                            if target:GetModifierNameByIndex( i ) == prefix .. val then
                                target:RemoveModifierByName( prefix .. val )
                            end
                        end
                    end
                    
                    -- Add modifiers
                    for p = 1, #bitTable do
                        local val = bitTable[p]
                        local count = math.floor( damage / val )
                        if count >= 1 then
                            ability:ApplyDataDrivenModifier( caster, target, prefix .. val, {} )
                            damage = damage - val
                        end
                    end
                end
                target.TrueshotDamage = damage_ref
                return 1
            else
                return nil
            end
        end
    })
end
function increase_intellect(keys)
     local caster = keys.caster
     local ability = keys.ability
      if caster:HasModifier("modifier_increase_intellect") == false then
        ability:ApplyDataDrivenModifier( caster, caster, "modifier_increase_intellect", nil)
        caster:SetModifierStackCount("modifier_increase_intellect", caster, 1)
    else
        caster:SetModifierStackCount("modifier_increase_intellect", caster, (caster:GetModifierStackCount("modifier_increase_intellect", caster) + 1))
    end
     if  (caster:GetModifierStackCount("modifier_increase_intellect", caster)==5) then
        caster:RemoveAbility("increase_intellect")
      
        caster:RemoveModifierByName("modifier_trueshot_aura_intellect_datadriven")
         caster:RemoveModifierByName("modifier_increase_intellect")
           caster:AddAbility("increase_intellect_tier2")
        local newAbility=caster:GetAbilityByIndex(2)
        newAbility:SetLevel(1)  
        newAbility:ApplyDataDrivenModifier( caster, caster, "modifier_increase_intellect", nil)
        caster:SetModifierStackCount("modifier_increase_intellect", caster, 5)
    end
    if  (caster:GetModifierStackCount("modifier_increase_intellect", caster)==15) then
         caster:RemoveAbility("increase_intellect_tier2")
          caster:RemoveModifierByName("modifier_trueshot_aura_intellect_datadriven")
         caster:RemoveModifierByName("modifier_increase_intellect")
        caster:AddAbility("increase_intellect_tier3")
       
        local newAbility=caster:GetAbilityByIndex(2)
        newAbility:SetLevel(1)
        newAbility:ApplyDataDrivenModifier( caster, caster, "modifier_increase_intellect", nil)
        caster:SetModifierStackCount("modifier_increase_intellect", caster, 15)
    end
    PopupIntTome(caster, 1)
end
function SpawnUnit( event )

    local caster = event.caster
    local pID = caster:GetPlayerID()
    local ability = event.ability
 
    local point = event.caster:GetAbsOrigin()
    local unit_name = randomUnit()
   
    -- Create the units on the next frame
    Timers:CreateTimer(0.03,function() 
 

                print(unit_name,"unit name")
                local unit = CreateUnitByName(unit_name, point, true, caster, caster, caster:GetTeamNumber())
                
                unit:SetControllableByPlayer(pID, true)
                unit:AddNewModifier(caster, ability, "modifier_phased", {duration = 0.03})
               unit:SetHullRadius(60)
             
        end
    )
end


   function randomUnit()

    unitIndex=20--math.random(21)
    print(unitIndex,"this is unit index")
        if unitIndex==1 then
            return "Slayer"
        elseif unitIndex== 2 then
            return "Troll Priest"
        elseif unitIndex== 3 then
            return "Naga"
        elseif unitIndex== 4 then
            return "Centaur Chief"   
        elseif unitIndex== 5 then
            return "Troll Duplicator" 
        elseif unitIndex== 6 then
            return "Ghost"
        elseif unitIndex== 7 then
            return "Juggernaut"
        elseif unitIndex== 8 then
            return "Frost Wyrm"
        elseif unitIndex== 9 then
            return "Zealot" 
        elseif unitIndex== 10 then
            return "Teddy"
        elseif unitIndex== 11 then
            return "Water Elemental"
        elseif unitIndex== 12 then
            return "Toxic Slinger"
        elseif unitIndex== 13 then
            return "Fire Beast"
        elseif unitIndex== 14 then
            return "Normal Knight"
        elseif unitIndex== 15 then
            return "Spellbreaker"
         elseif unitIndex== 16 then
            return "Marine"
         elseif unitIndex== 17 then
            return "Revenant"
        elseif unitIndex== 18 then
            return "Avatar"
    
        elseif unitIndex== 19 then
            return "Hunter"
         elseif unitIndex== 20 then
            return  "Aloof Giant"
      
        end
        
     end   




--start of creep abilities--

--[[
    Author: Ractidous
    Date: 29.01.2015.
    Hide caster's model.
]]

   
    

function Cooldown(keys)

    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    local cooldown = ability:GetCooldown(ability:GetLevel() - 1)
   if ability:IsCooldownReady() then 
 
    ability:StartCooldown(cooldown)
    keys.caster:AddNoDraw()
    EmitSoundOn("Hero_Puck.Phase_Shift",caster)
     ability:ApplyDataDrivenModifier(caster, caster,  "modifier_phase_shift_buff_datadriven", { duration = 1.5 })
    end
end


--[[
    Author: Ractidous
    Date: 29.01.2015.
    Show caster's model.
]]
function ShowCaster( event )
    event.caster:RemoveNoDraw()


  -- 10 second delayed, run once using gametime (respect pauses)

end

--[[
    Author: Ractidous
    Date: 13.02.2015.
    Stop a sound on the target unit.
]]
function StopSound( event )
    StopSoundEvent( event.sound_name, event.target )
end


function ManaShield( event )
    local caster = event.caster
    local ability = event.ability
    local damage_per_mana = ability:GetLevelSpecialValueFor("damage_per_mana", ability:GetLevel() - 1 )
    local absorption_percent = ability:GetLevelSpecialValueFor("absorption_tooltip", ability:GetLevel() - 1 ) * 0.01
    local damage = event.Damage * absorption_percent
    local not_reduced_damage = event.Damage - damage

    local caster_mana = caster:GetMana()
    local mana_needed = damage / damage_per_mana

    -- Check if the not reduced damage kills the caster
    local oldHealth = caster.OldHealth - not_reduced_damage

    -- If it doesnt then do the HP calculation
    if oldHealth >= 1 then
       -- print("Damage taken "..damage.." | Mana needed: "..mana_needed.." | Current Mana: "..caster_mana)

        -- If the caster has enough mana, fully heal for the damage done
        if mana_needed <= caster_mana then
            caster:SpendMana(mana_needed, ability)
            caster:SetHealth(oldHealth)
            
            -- Impact particle based on damage absorbed
            local particleName = "particles/units/heroes/hero_medusa/medusa_mana_shield_impact.vpcf"
            local particle = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN_FOLLOW, caster)
            ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
            ParticleManager:SetParticleControl(particle, 1, Vector(mana_needed,0,0))
        else
            local newHealth = oldHealth - damage
            mana_needed =
            caster:SpendMana(mana_needed, ability)
            caster:SetHealth(newHealth)
        end
    end 
end

-- Keeps track of the targets health
function ManaShieldHealth( event )
    local caster = event.caster

    caster.OldHealth = caster:GetHealth()
end

function StunAura( event )
  
    local caster = event.caster
    local pID = event.caster:GetPlayerID()
    local ability = event.ability
  
    local point = event.caster:GetAbsOrigin()
    local unit_name = event.UnitName
  
end

function ManaBreak( keys )
    local target = keys.target
    local caster = keys.caster
    local ability = keys.ability
    --20+20% per damage
    local manaBurn = ability:GetLevelSpecialValueFor("mana_per_hit", (ability:GetLevel() - 1))+(caster:GetAverageTrueAttackDamage()/2)
    local manaDamage = ability:GetLevelSpecialValueFor("damage_per_burn", (ability:GetLevel() - 1))
   
    local damageTable = {}
    damageTable.attacker = caster
    damageTable.victim = target
    damageTable.damage_type = ability:GetAbilityDamageType()
    damageTable.ability = ability

    -- If the target is not magic immune then reduce the mana and deal damage
    if not target:IsMagicImmune() then
        -- Checking the mana of the target and calculating the damage
        if(target:GetMana() >= manaBurn) then
            damageTable.damage = manaBurn * manaDamage
            target:ReduceMana(manaBurn)
        else
            damageTable.damage = target:GetMana() * manaDamage
            target:ReduceMana(manaBurn)
        end

        ApplyDamage(damageTable)
    end
end


function DeathHeal( event )
    local caster = event.caster
    local attacker = event.attacker
    local ability = event.ability
    local cooldown = ability:GetCooldown(ability:GetLevel() - 1)
    local casterHP = caster:GetHealth()
    local casterMana = caster:GetMana()
    local abilityManaCost = ability:GetManaCost( ability:GetLevel() - 1 )

    -- Change it to your game needs
  
    if casterHP == 0 and ability:IsCooldownReady() and casterMana >= abilityManaCost  then
       
        -- Variables for Reincarnation
        local heal=ability:GetLevelSpecialValueFor( "heal", ability:GetLevel() - 1 )
        local heal_radius = ability:GetLevelSpecialValueFor( "heal_radius", ability:GetLevel() - 1 )
        
        local respawnPosition = caster:GetAbsOrigin()
        local reincarnate_time = ability:GetLevelSpecialValueFor( "reincarnate_time", ability:GetLevel() - 1 )
  
       

        -- Particle
        local particleName = "particles/units/heroes/hero_skeletonking/wraith_king_reincarnate.vpcf"
        caster.ReincarnateParticle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, caster )
        ParticleManager:SetParticleControl(caster.ReincarnateParticle, 0, respawnPosition)
        ParticleManager:SetParticleControl(caster.ReincarnateParticle, 1, Vector(slow_radius,0,0))

        -- End Particle after reincarnating
        Timers:CreateTimer(reincarnate_time, function() 
            ParticleManager:DestroyParticle(caster.ReincarnateParticle, false)
        end)

        -- Grave and rock particles
        -- The parent "particles/units/heroes/hero_skeletonking/skeleton_king_death.vpcf" misses the grave model
        local model = "models/props_gameplay/tombstoneb01.vmdl"
        local grave = Entities:CreateByClassname("prop_dynamic")
        grave:SetModel(model)
        grave:SetAbsOrigin(respawnPosition)

        local particleName = "particles/units/heroes/hero_skeletonking/skeleton_king_death_bits.vpcf"
        local particle1 = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, caster )
        ParticleManager:SetParticleControl(particle1, 0, respawnPosition)

        local particleName = "particles/units/heroes/hero_skeletonking/skeleton_king_death_dust.vpcf"
        local particle2 = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN_FOLLOW, caster )
        ParticleManager:SetParticleControl(particle2, 0, respawnPosition)

        -- End grave after reincarnating
        Timers:CreateTimer(reincarnate_time, function() grave:RemoveSelf() end)     

      

        -- Slow
        local allies = FindUnitsInRadius(caster:GetTeamNumber(), respawnPosition, nil, heal_radius, 
                                    DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, 
                                    DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
      
       
        for _,unit in pairs(allies) do
            --ability:ApplyDataDrivenModifier(caster, unit, "modifier_reincarnation_slow", nil)
            
            unit:Heal(heal,caster)
        end

    end


end

function Alacrity( keys )
    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability

    -- Ability variables
   
    local damage = ability:GetLevelSpecialValueFor("bonus_damage", ability:GetLevel() - 1 )+(caster:GetAverageTrueAttackDamage()*1.5)
    local attack_speed = ability:GetLevelSpecialValueFor("bonus_attack_speed", ability:GetLevel() - 1 )+(caster:GetAverageTrueAttackDamage())
    local damage_modifier = keys.damage_modifier
    local speed_modifier = keys.speed_modifier

    -- Apply the bonus modifiers
    ability:ApplyDataDrivenModifier(caster, target, damage_modifier, {}) 
    ability:ApplyDataDrivenModifier(caster, target, speed_modifier, {})

    -- Set the values
    target:SetModifierStackCount(damage_modifier, ability, damage)
    target:SetModifierStackCount(speed_modifier, ability, attack_speed) 
end

function ConjureImage( event )

 local caster = event.caster
 --local player = caster:GetPlayerID()

 local ability = event.ability
 local unit_name = caster:GetUnitName()
 local origin = caster:GetAbsOrigin()
 local duration = ability:GetLevelSpecialValueFor( "illusion_duration", ability:GetLevel() - 1 )
--ghetto solution to cap total number of illusions to stop it from going insane accidently
if #Entities:FindAllByNameWithin(unit_name, caster:GetAbsOrigin(), 3000)<20 then


 -- handle_UnitOwner needs to be nil, else it will crash the game.

     local illusion = CreateUnitByName(unit_name, origin, true, caster, nil, caster:GetTeamNumber())
    -- illusion:SetPlayerID(caster:GetPlayerID())
     illusion:SetControllableByPlayer(caster:GetPlayerOwnerID(), true)

     -- Level Up the unit to the casters level
     local casterLevel = caster:GetLevel()
     for i=1,casterLevel-1 do
      illusion:HeroLevelUp(false)
     end

     -- Set the skill points to 0 and learn the skills of the caster
     --illusion:SetAbilityPoints(0)
     for abilitySlot=0,15 do
      local ability = caster:GetAbilityByIndex(abilitySlot)
      if ability ~= nil then 
       local abilityLevel = ability:GetLevel()
       local abilityName = ability:GetAbilityName()
       local illusionAbility = illusion:FindAbilityByName(abilityName)
       illusionAbility:SetLevel(abilityLevel)
      end
     end

     -- Recreate the items of the caster
     for itemSlot=0,5 do
      local item = caster:GetItemInSlot(itemSlot)
      if item ~= nil then
       local itemName = item:GetName()
       local newItem = CreateItem(itemName, illusion, illusion)
       illusion:AddItem(newItem)
      end
     end


     -- Add our datadriven Metamorphosis modifier if appropiate
     -- You can add other buffs that want to be passed to illusions this way


   --not illusion but behave like one
     illusion:AddNewModifier(caster, ability, "modifier_kill", {duration = duration})
     illusion:AddNewModifier(caster, ability, "modifier_phased", {duration = 0.03})
 

  Timers:CreateTimer(duration-0.05, function()
       illusion:AddNoDraw()
      local particleName = "particles/units/heroes/hero_phantom_lancer/phantomlancer_illusion_destroy.vpcf"
        local particle = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, illusion )

    
    end
  )
    
    end
end

function ToggleAutocast (event)
    local ability = event.ability
            ability:ToggleAutoCast()
end




function PoisonSting(event)
   local caster = event.caster

 local ability = event.ability
 
 local target = event.target
 --+25% scale
     local bonusdamage =(caster:GetAverageTrueAttackDamage()/4)


local damage_table = {} 
damage_table.attacker = caster
    damage_table.damage_type = ability:GetAbilityDamageType()
    damage_table.ability = ability
    damage_table.victim = target
    damage_table.damage=bonusdamage
    ApplyDamage(damage_table)
end


function SplashDamage(keys)
    local caster = keys.caster
    local ability = keys.ability
    local splash = ability:GetLevelSpecialValueFor("splash_damage", ability:GetLevel() - 1 )
    local keydamage =math.floor( caster:GetAverageTrueAttackDamage()*splash/ 100 )
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1 )
  
    local target = keys.target
   
    local targets = FindUnitsInRadius(caster:GetTeam(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false)

    for i = 1, #targets do
        if targets[i] ~= target then --avoid dealing twice the damage
            local damageTable = {
                victim = targets[i],
                attacker = caster,
                damage = keydamage,
                damage_type = DAMAGE_TYPE_PHYSICAL,
            }
            ApplyDamage(damageTable)

        end
    end
end
function stormbolt(keys)
 local caster = keys.caster
    local ability = keys.ability
local radius = ability:GetLevelSpecialValueFor("bolt_aoe", ability:GetLevel() - 1 )
    local keydamage=caster:GetAverageTrueAttackDamage()*5
    local target = keys.target
   
    local targets = FindUnitsInRadius(caster:GetTeam(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false)

    for i = 1, #targets do
            local damageTable = {
                victim = targets[i],
                attacker = caster,
                damage = keydamage,
                damage_type = DAMAGE_TYPE_MAGICAL,
            }
            ApplyDamage(damageTable)

        
    end

end

function Immolation(keys)

     local caster = keys.caster
    local ability = keys.ability
    local keydamage=0

    local burnDamage =caster:GetAverageTrueAttackDamage()
if burnDamage>ability:GetLevelSpecialValueFor("scaling", ability:GetLevel() - 1 ) then 
    keydamage=burnDamage
else
    --scale by 20% before +30 damage
    keydamage=caster:GetAverageTrueAttackDamage()/5
end
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1 )

    local targets = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false)
    for i = 1, #targets do
       
            local damageTable = {
                victim = targets[i],
                attacker = caster,
                damage = keydamage,
                damage_type = DAMAGE_TYPE_PHYSICAL,
            }
            ApplyDamage(damageTable)  
    end
end    

 function Starfall(keys)

     local caster = keys.caster
    local ability = keys.ability
    --scale by 500%
    local keydamage =caster:GetAverageTrueAttackDamage()*5
    local radius = ability:GetLevelSpecialValueFor("radius", ability:GetLevel() - 1 )

    local targets = FindUnitsInRadius(caster:GetTeam(), caster:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, 0, 0, false)
    for i = 1, #targets do
       
            local damageTable = {
                victim = targets[i],
                attacker = caster,
                damage = keydamage,
                damage_type = DAMAGE_TYPE_PHYSICAL,
            }
            ApplyDamage(damageTable)  
    end
end
 function Rabid( event )
    local caster = event.caster
    local targets = event.target_entities
    local ability = event.ability
    local rabid_duration = ability:GetLevelSpecialValueFor( "rabid_duration", ability:GetLevel() - 1 )+caster:GetAverageTrueAttackDamage()/10

    -- Unit name contains a part of the unit name, so you can make different levels of the unit and they will still be registered
    -- If you change this to "" in the parameter passed, it will affect all self-controlled units
   

  
    -- If the ability is found, take the ability specials and add the duration
    -- We expect a rabid_duration_bonus in the synergy ability
  
    -- Iterate over all the units
    for _,unit in pairs(targets) do
       
            
            ability:ApplyDataDrivenModifier(caster, unit, "modifier_rabid", { duration = rabid_duration })
    end
   
    -- Apply to the caster
    ability:ApplyDataDrivenModifier(caster, caster, "modifier_rabid", { duration = rabid_duration })

end

function Fervor( keys )
    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    local ability_level = ability:GetLevel() - 1
    local modifier = keys.modifier
    local max_stacks = ability:GetLevelSpecialValueFor("max_stacks", ability_level)

    -- Check if we have an old target
    if caster.fervor_target then
        -- Check if that old target is the same as the attacked target
        if caster.fervor_target == target then
            -- Check if the caster has the attack speed modifier
            if caster:HasModifier(modifier) then
                -- Get the current stacks
                local stack_count = caster:GetModifierStackCount(modifier, ability)

                -- Check if the current stacks are lower than the maximum allowed
                if stack_count < max_stacks then
                    -- Increase the count if they are
                    caster:SetModifierStackCount(modifier, ability, stack_count + 1)
                end
            else
                -- Apply the attack speed modifier and set the starting stack number
                ability:ApplyDataDrivenModifier(caster, caster, modifier, {})
                caster:SetModifierStackCount(modifier, ability, 1)
            end
        else
            -- If its not the same target then set it as the new target and remove the modifier
            caster:RemoveModifierByName(modifier)
            caster.fervor_target = target
        end
    else
        caster.fervor_target = target
    end
end

function LightningStrike( keys)
      local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    local target = keys.target

    local bonus=math.random(caster:GetAverageTrueAttackDamage()*2)
    
     local damageTable = {
                victim = target,
                attacker = caster,
                damage = bonus,
                damage_type = DAMAGE_TYPE_MAGICAL
            }
             ApplyDamage(damageTable) 
    

end
--damage block
function GameMode:FilterDamage( filterTable )
    for k, v in pairs( filterTable ) do
        print("Order: " .. k .. " " .. tostring(v) )
    end
    local victim= EntIndexToHScript(filterTable["entindex_victim_const"])
      if victim:HasModifier("lesser_damage_block") then
        if  filterTable["damage"]<=25 then
            return false
        end       
    end
    return true
end
function Flatten(keys)
    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    local target = keys.target
    local half = math.floor(target:GetHealth()/2)
 local damageTable = {
                victim = target,
                attacker = caster,
                damage = half,
                damage_type = DAMAGE_TYPE_PURE
            }
             ApplyDamage(damageTable) 
        print(damage,"this is damage")
     

end
function findProjectileInfo(class_name)
    if particle_names[class_name] ~= nil then
        return particle_names[class_name], projectile_speeds[class_name]
    end

    kv_heroes = LoadKeyValues("scripts/npc/npc_heroes.txt")
    kv_hero = kv_heroes[class_name]

    if kv_hero["ProjectileModel"] ~= nil and kv_hero["ProjectileModel"] ~= "" then
        particle_names[class_name] = kv_hero["ProjectileModel"]
        projectile_speeds[class_name] = kv_hero["ProjectileSpeed"]
    else
        particle_names[class_name] = particle_names["base"]
        projectile_speeds[class_name] = projectile_speeds["base"]
    end

    return particle_names[class_name], projectile_speeds[class_name]
end


