COOLING_RATE = 10
Default_Stone_Chance = 1
Default_Copper_Chance = 10
Default_Iron_Chance = 10
Default_Diamond_Chance = 10
Default_Coal_Chance = 10
Default_Gold_Chance = 10
Default_Mese_Chance = 10
Moreores_Tin_Chance = 10
Moreores_Silver_Chance = 10
Moreores_Mithril_Chance = 10
Technic_Uranium_Chance = 10
Technic_Sulfur_Chance = 10
Technic_Chromium_Chance = 10

--Molten rock takes 10 times longer to turn into stone than lava takes to turn into molten rock.
COOLING_RATIO = 10
Abm_Interval = 10.0

--Nodes/Items
minetest.register_node("lavacooling:moltenrock", {
	description = "Molten Rock",
	inventory_image = minetest.inventorycube("lavacooling_moltenrock.png"),
	tiles = {
		"lavacooling_moltenrock.png"
	},
	paramtype = "light",
	light_source = 10,
	groups = {cracky=3, hot=3, igniter=1},
		sounds = default.node_sound_stone_defaults(),
})

--Section below is not required for a new Server/Game
-- It is purely here to prevent Unknown Nodes appearing on Cryt-Survival from it's Original Implementation.
minetest.register_node("lavacooling:obsidian", {
	description = "Obsidian",
	tiles = {"lavacooling_obsidian.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	drop = {
		items = {
			{
			items = {"default:obsidian"},
			rarity = 6,
			},
		},
	},
})

minetest.register_node("lavacooling:pumice", {
	description = "Pumice",
	tiles = {"lavacooling_pumice.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "default:obsidian",
	recipe = {
		{"lavacooling:obsidian"},
	}
})

--End of Server Stuff, The above is purely here for older servers, you could probably comment it all out.

--Crafts
minetest.register_craft({
	type = "fuel",
	recipe = "lavacooling:moltenrock",
	burntime = 30,
})

-- Options for Lava as a renewable
-- Using Condensed Cobble
-- Pumic - (Grind) to Sand Dust - (Compressed) to sand - (Compressed) to SandStone - 

minetest.register_abm ({
	nodenames = {"default:lava_source"},
	neighbors = {"default:lava_flowing"},
	interval = 8.0,
	chance = 1,
	action = function (pos)
	    if minetest.env: get_node(pos, {name = "default:lava_source"}) 
			and minetest.env: get_node({x=pos.x-1, y=pos.y, z=pos.z}).name == "default:lava_flowing"
			and minetest.env: get_node({x=pos.x+1, y=pos.y, z=pos.z}).name == "default:lava_flowing"
			and minetest.env: get_node({x=pos.x, y=pos.y, z=pos.z-1}).name == "default:lava_flowing"
			and minetest.env: get_node({x=pos.x, y=pos.y, z=pos.z+1}).name == "default:lava_flowing"
			and minetest.env: get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air"
		then
			minetest.env: add_node (pos, {name = "lavacooling:moltenrock"})
		end
	end,
})

minetest.register_abm ({
--	nodenames = {"default:lava_flowing"},
	nodenames = {"default:sandstone"},
	neighbours = {"default:lava_source"},
	interval = 2.0,
	chance = 1,
	action = function (pos)
--		if minetest.env: get_node(pos, {name = "default:lava_source"})
		if minetest.env: get_node(pos, {name = "default:sandstone"})
			and minetest.env: get_node({x=pos.x-1, y=pos.y, z=pos.z}).name == "default:lava_source"
			and minetest.env: get_node({x=pos.x+1, y=pos.y, z=pos.z}).name == "default:lava_source"
			and minetest.env: get_node({x=pos.x, y=pos.y, z=pos.z-1}).name == "default:lava_source"
			and minetest.env: get_node({x=pos.x, y=pos.y, z=pos.z+1}).name == "default:lava_source"
			and minetest.env: get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "default:lava_source"
			and minetest.env: get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "default:lava_source"
		then 
			minetest.env: add_node (pos, {name = "default:lava_source"})
		end
	end,
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = Abm_Interval,
	chance = COOLING_RATIO * COOLING_RATE * Default_Stone_Chance,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone"})
	end
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = Abm_Interval,
	chance = COOLING_RATIO * COOLING_RATE * Default_Copper_Chance,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone_with_copper"}) 
	end
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = Abm_Interval,
	chance = COOLING_RATIO * COOLING_RATE * Default_Iron_Chance,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone_with_iron"}) 
	end
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = Abm_Interval,
	chance = COOLING_RATIO * COOLING_RATE * Default_Mese_Chance,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone_with_mese"}) 
	end
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = Abm_Interval,
	chance = COOLING_RATIO * COOLING_RATE * Default_Diamond_Chance,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone_with_diamond"}) 
	end
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = Abm_Interval,
	chance = COOLING_RATIO * COOLING_RATE * Default_Coal_Chance,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone_with_coal"}) 
	end
})

minetest.register_abm ({
	nodenames = {"lavacooling:moltenrock"},
	interval = Abm_Interval,
	chance = COOLING_RATIO * COOLING_RATE * Default_Gold_Chance,
	action = function (pos)
		minetest.env: add_node (pos, {name = "default:stone_with_gold"}) 
	end
})

if minetest.get_modpath("moreores") then
	minetest.register_abm ({
		nodenames = {"lavacooling:moltenrock"},
		interval = Abm_Interval,
		chance = COOLING_RATIO * COOLING_RATE * Moreores_Tin_Chance,
		action = function (pos)
			minetest.env: add_node (pos, {name = "moreores:mineral_tin"}) 
		end
	})
	
	minetest.register_abm ({
		nodenames = {"lavacooling:moltenrock"},
		interval = Abm_Interval,
		chance = COOLING_RATIO * COOLING_RATE * Moreores_Silver_Chance,
		action = function (pos)
			minetest.env: add_node (pos, {name = "moreores:mineral_silver"}) 
		end
	})

	minetest.register_abm ({
		nodenames = {"lavacooling:moltenrock"},
		interval = Abm_Interval,
		chance = COOLING_RATIO * COOLING_RATE * Moreores_Mithril_Chance,
		action = function (pos)
			minetest.env: add_node (pos, {name = "moreores:mineral_mithril"}) 
		end
	})

	if minetest.get_modpath("technic") then
	
		minetest.register_abm ({
			nodenames = {"lavacooling:moltenrock"},
			interval = Abm_Interval,
			chance = COOLING_RATIO * COOLING_RATE * Technic_Uranium_Chance,
			action = function (pos)
				minetest.env: add_node (pos, {name = "technic:mineral_uranium"}) 
			end
		})

		minetest.register_abm ({
			nodenames = {"lavacooling:moltenrock"},
			interval = Abm_Interval,
			chance = COOLING_RATIO * COOLING_RATE * Technic_Sulfur_Chance,
			action = function (pos)
				minetest.env: add_node (pos, {name = "technic:mineral_sulfur"}) 
			end
		})

		minetest.register_abm ({
			nodenames = {"lavacooling:moltenrock"},
			interval = Abm_Interval,
			chance = COOLING_RATIO * COOLING_RATE * Technic_Chromium_Chance,
			action = function (pos)
				minetest.env: add_node (pos, {name = "technic:mineral_chromium"}) 
			end
		})

	end
end

