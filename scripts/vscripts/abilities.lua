
function trueshot_initialize_agility( keys )
    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    local prefix = "modifier_trueshot_damage_agility_mod_"
    
    Timers:CreateTimer( DoUniqueString( "trueshot_updateDamage_" .. target:entindex() ), {
        endTime = 0.25,
        callback = function()

            if target and IsValidEntity(target) and target:GetPrimaryAttribute()==1 then
                -- Adjust damage based on agility of caster
                local agility = caster:GetAgility()
                local percent = ability:GetLevelSpecialValueFor( "trueshot_ranged_damage", ability:GetLevel() - 1 )
              

                --i will need to adjust this for each unit that i want to have a different value. probably going make another function inside this
                local damage = math.floor( agility * percent / 100 )

                
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
                return 0.25
            else
                return nil
            end
        end
    })
end
function trueshot_initialize_strength( keys )
    local caster = keys.caster
    local target = keys.target
    local ability = keys.ability
    local prefix = "modifier_trueshot_damage_strength_mod_"
    
    Timers:CreateTimer( DoUniqueString( "trueshot_updateDamage_" .. target:entindex() ), {
        endTime = 0.25,
        callback = function()

            if target and IsValidEntity(target) and target:GetPrimaryAttribute()==0 then
                -- Adjust damage based on strength of caster
                local strength = caster:GetStrength()
                local percent = ability:GetLevelSpecialValueFor( "trueshot_ranged_damage", ability:GetLevel() - 1 )
              

                --i will need to adjust this for each unit that i want to have a different value. probably going make another function inside this
                local damage = math.floor( strength * percent / 100 )

                
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
                return 0.25
            else
                return nil
            end
        end
    })
end

function trueshot_initialize_intellect( keys )
    local caster = keys.caster
    local target = keys.target
    local ability = keys. ability
    local prefix = "modifier_trueshot_damage_intellect_mod_"
    
    Timers:CreateTimer( DoUniqueString( "trueshot_updateDamage_" .. target:entindex() ), {
        endTime = 0.25,
        callback = function()

            if target and IsValidEntity(target) and target:GetPrimaryAttribute()==2 then
                -- Adjust damage based on intellect of caster
                local intellect = caster:GetIntellect()
                local percent = ability:GetLevelSpecialValueFor( "trueshot_ranged_damage", ability:GetLevel() - 1 )
              

                --i will need to adjust this for each unit that i want to have a different value. probably going make another function inside this
                local damage = math.floor( intellect * percent / 100 )

                
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
                return 0.25
            else
                return nil
            end
        end
    })
end

function SpawnUnit( event )
    DebugPrintTable(event)
    local caster = event.caster
    local pID = event.caster:GetPlayerID()
    local ability = event.ability
    DebugPrintTable(event.caster)
    local point = event.caster:GetAbsOrigin()
    local unit_name = event.UnitName
    -- Create the units on the next frame
    Timers:CreateTimer(0.03,function() 
 

            -- Spawn as many treants as possible
         
                local treant = CreateUnitByName(unit_name, point, true, caster, caster, caster:GetTeamNumber())
                treant:SetControllableByPlayer(pID, true)
                treant:AddNewModifier(caster, ability, "modifier_phased", {duration = 0.03})
               
           
        end
    )
end

function SpawnSuperUnit( event )
    DebugPrintTable(event)
    local caster = event.caster
    local pID = event.caster:GetPlayerID()
    local ability = event.ability
    DebugPrintTable(event.caster)
    local point = event.caster:GetAbsOrigin()
    local unit_name = event.UnitName
    -- Create the units on the next frame
    Timers:CreateTimer(0.03,function() 
 

            -- Spawn as many treants as possible
         
                local treant = CreateUnitByName(unit_name, point, true, caster, caster, caster:GetTeamNumber())
                treant:SetControllableByPlayer(pID, true)
                treant:AddNewModifier(caster, ability, "modifier_phased", {duration = 0.03})
               
           
        end
    )
end