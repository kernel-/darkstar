-----------------------------------
-- Area: Maze of Shakhrami
--  NM:  Aqrabuamelu
-----------------------------------
require("scripts/globals/status");
-----------------------------------


-----------------------------------
-- onMobInitialize Action
-----------------------------------

function onMobInitialize(mob)
    mob:addStatusEffect(EFFECT_ICE_SPIKES,45,0,0);
    mob:getStatusEffect(EFFECT_ICE_SPIKES):setFlag(32);
end;

-----------------------------------
-- onSpikesDamage
-----------------------------------

function onSpikesDamage(mob,target,damage)
    local INT_diff = mob:getStat(MOD_INT) - target:getStat(MOD_INT);

    if (INT_diff > 20) then
        INT_diff = 20 + (INT_diff - 20) / 2;
    end

    local dmg = INT_diff+damage/2;
    local params = {};
    params.bonusmab = 0;
    params.includemab = false;
    dmg = addBonusesAbility(mob, ELE_ICE, target, dmg, params);
    dmg = dmg * applyResistanceAddEffect(mob,target,ELE_ICE,0);
    dmg = adjustForTarget(target,dmg,ELE_ICE);

    if (dmg < 0) then
        dmg = 10
    end
    
    dmg = finalMagicNonSpellAdjustments(mob,target,ELE_ICE,dmg);

    return SUBEFFECT_ICE_SPIKES,44,dmg;

end;

-----------------------------------
-- onMobDeath
-----------------------------------

function onMobDeath(mob, killer)
    UpdateNMSpawnPoint(mob:getID());
    mob:setRespawnTime(math.random((7200),(7800))); -- 120 to 130 min
end;