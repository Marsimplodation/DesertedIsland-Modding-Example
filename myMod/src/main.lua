local texturePath1 = "./Mods/myMod/textures/test.png"
local texturePath2 = "./Mods/myMod/textures/test2.png"
local textures={texturePath1, texturePath2}

local modItem = modItem or {};

function ModStart()
    modItem = api.item();
    modItem.name = "ModItem";
    modItem.texture = textures[1];
    modItem.craftable = true;
    modItem.assetBundle = "./Mods/myMod/samplemodbundle";
    modItem.assetName = "Orb";
    
    local recipe = {api.itemCost()};
    recipe[1].count = 2;
    recipe[1].name = "Log";

    api.registerItem(modItem);
    api.addRecipe(modItem.name, recipe);
    api.addFood(modItem.name, 3.0);

    local weapon = api.weapon();
    weapon.damage = 100;
    weapon.tier = api.weaponTiers.Stone;
    weapon.types = {api.effectiveTypes.Enemy};
    weapon.animation = api.weaponAnimation.throwing;
    api.addWeapon(modItem.name, weapon);

    local spawnable = api.spawnable();
    spawnable.drops = {"Log"};
    spawnable.health = 20.0;
    spawnable.count = 100;
    api.addSpawnableObject("ModItem", spawnable);

end

local start = 0.0;

local i = 0;
function ModUpdate(deltaTime)

    start = deltaTime + start;
    if(start >= 0.05)then
        start = 0.0;
        i = math.fmod((i + 1), 2);

        modItem.texture = textures[i+1];
        api.updateItem(modItem);
    end
end
