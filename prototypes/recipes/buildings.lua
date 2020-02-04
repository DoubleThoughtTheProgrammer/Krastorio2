return
{
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
	{
		type = "recipe",
		name = "kr-greenhouse",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"wood" , 20},
			{"iron-beam", 10},
			{"glass", 20},
			{"automation-core", 2}
		},
		result = "kr-greenhouse"		
    },	
	{
		type = "recipe",
		name = "kr-crusher",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"iron-beam", 10},
			{"iron-gear-wheel", 20},
			{"copper-cable", 6},
			{"automation-core", 2}
		},
		result = "kr-crusher"
    },
	{
		type = "recipe",
		name = "kr-shelter",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"iron-beam", 25},
			{"iron-plate", 25},
			{"copper-cable", 10},
			{"coal", 50}
		},
		result = "kr-shelter"
    },
	{
		type = "recipe",
		name = "kr-mineral-water-pumpjack",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"automation-core", 2},
			{"steel-gear-wheel", 5},
			{"steel-beam", 5},
			{"pipe", 5}			
		},
		result = "kr-mineral-water-pumpjack"
    },
	{
		type = "recipe",
		name = "kr-air-purifier",
		energy_required = 20,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 4},
			{"advanced-circuit", 4},
			{"plastic-bar", 20},
			{"engine-unit", 1}
		},
		result = "kr-air-purifier"
    },
	{
		type = "recipe",
		name = "kr-sentinel",
		energy_required = 10,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 1},
			{"iron-plate", 2},
			{"copper-cable", 1},
			{"automation-core", 1}
		},
		result = "kr-sentinel"
    },
	{
		type = "recipe",
		name = "kr-fuel-refinery",
		energy_required = 10,
		enabled = false,
		ingredients =
		{
			{"steel-plate", 5},
			{"iron-gear-wheel", 5},
			{"electronic-circuit", 5},
			{"pipe", 5}
		},
		result = "kr-fuel-refinery"
    },
	{
		type = "recipe",
		name = "kr-gas-power-station",
		energy_required = 30,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 10},
			{"engine-unit", 20},
			{"electronic-circuit", 4},
			{"pipe", 4}
		},
		result = "kr-gas-power-station"
    },
	-- -- --
	-- NEW LABORATORIES
	-- -- --
    {
		type = "recipe",
		name = "biusart-lab",
		energy_required = 10,
		enabled = false,
		ingredients =
		{
			{"advanced-circuit", 10},
			{"steel-beam", 5},
			{"iron-plate", 10},
			{"copper-cable", 10}
		},
		result = "biusart-lab"
    },
	{
		type = "recipe",
		name = "kr-singularity-lab",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"ai-core", 20},
			{"steel-beam", 30},
			{"steel-plate", 60},
			{"electric-engine-unit", 30},
			{"rare-metals", 20}
		},
		result = "kr-singularity-lab"
    },
	-- -- --
	-- MEDIUM CONTEINERS
	-- -- --
	{
		type = "recipe",
		name = "kr-medium-active-provider-container",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"kr-medium-container", 1},
			{"advanced-circuit", 5},
		},
		subgroup = "kr-logistics-2",
		order = "a[medium-active-provider-container]",
		result = "kr-medium-active-provider-container"
    },
	{
		type = "recipe",
		name = "kr-medium-buffer-container",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"kr-medium-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-2",
		order = "b[medium-buffer-container]",
		result = "kr-medium-buffer-container"
    },
	{
		type = "recipe",
		name = "kr-medium-container",
		energy_required = 10,
		enabled = false,
		ingredients =
		{
			{"steel-chest", 2},
			{"steel-beam", 10}
		},
		subgroup = "storage",
		order = "a[items]-d[medium-container]",
		result = "kr-medium-container"
    },
	{
		type = "recipe",
		name = "kr-medium-passive-provider-container",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"kr-medium-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-2",
		order = "c[medium-passive-provider-container]",
		result = "kr-medium-passive-provider-container"
	},
	{
		type = "recipe",
		name = "kr-medium-requester-container",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"kr-medium-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-2",
		order = "d[medium-requester-container]",
		result = "kr-medium-requester-container"
    },
	{
		type = "recipe",
		name = "kr-medium-storage-container",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"kr-medium-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-2",
		order = "e[medium-storage-container]",
		result = "kr-medium-storage-container"
    },	
	-- -- --
	-- BIG CONTEINERS
	-- -- --
	{
		type = "recipe",
		name = "kr-big-active-provider-container",
		energy_required = 3,
		enabled = false,
		ingredients =
		{
			{"kr-big-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-3",
		order = "a[big-active-provider-container]",
		result = "kr-big-active-provider-container"
    },
	{
		type = "recipe",
		name = "kr-big-buffer-container",
		energy_required = 3,
		enabled = false,
		ingredients =
		{
			{"kr-big-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-3",
		order = "b[big-buffer-container]",
		result = "kr-big-buffer-container"
    },	
	{
		type = "recipe",
		name = "kr-big-container",
		energy_required = 30,
		enabled = false,
		ingredients =
		{
			{"kr-medium-container", 4},
			{"steel-beam", 20}
		},
		subgroup = "storage",
		order = "a[items]-dz[big-container]",
		result = "kr-big-container"
    },
	{
		type = "recipe",
		name = "kr-big-passive-provider-container",
		energy_required = 3,
		enabled = false,
		ingredients =
		{
			{"kr-big-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-3",
		order = "c[big-passive-provider-container]",
		result = "kr-big-passive-provider-container"
    },
	{
		type = "recipe",
		name = "kr-big-requester-container",
		energy_required = 3,
		enabled = false,
		ingredients =
		{
			{"kr-big-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-3",
		order = "d[big-requester-container]",
		result = "kr-big-requester-container"
    },	
	{
		type = "recipe",
		name = "kr-big-storage-container",
		energy_required = 3,
		enabled = false,
		ingredients =
		{
			{"kr-big-container", 1},
			{"advanced-circuit", 5}
		},
		subgroup = "kr-logistics-3",
		order = "e[big-storage-container]",
		result = "kr-big-storage-container"
    },	
	-- -- --
	-- FLUID STORAGES
	-- -- --
	{
		type = "recipe",
		name = "kr-fluid-storage-1",
		energy_required = 10,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 20},
			{"kr-steel-pipe", 4}
		},
		result = "kr-fluid-storage-1"
    },	
	{
		type = "recipe",
		name = "kr-fluid-storage-2",
		energy_required = 30,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 20},
			{"kr-steel-pipe", 12}
		},
		result = "kr-fluid-storage-2"
    },	
	-- -- --
	{
		type = "recipe",
		name = "kr-steel-pipe",
		normal =
		{
			enabled = false,
			ingredients = 
			{
				{"steel-plate", 1}
			},
			result = "kr-steel-pipe"
		},
		expensive =
		{
			enabled = false,
			ingredients = 
			{
				{"steel-plate", 2}
			},
			result = "kr-steel-pipe"
		}		
	},  
	{
		type = "recipe",
		name = "kr-steel-pipe-to-ground",
		enabled = false,
		ingredients =
		{
			{"kr-steel-pipe", 15},
			{"steel-plate", 5}
		},		
		result = "kr-steel-pipe-to-ground",
		result_count = 2
	},
	{
		type = "recipe",
		name = "kr-steel-pump",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"steel-gear-wheel", 4},
			{"engine-unit", 1},
			{"steel-beam", 1},
			{"kr-steel-pipe", 1}
		},
		result = "kr-steel-pump"
	},
	{
		type = "recipe",
		name = "kr-electrolysis-plant",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 10},
			{"automation-core", 3},
			{"copper-plate", 10},
			{"engine-unit", 2}
		},
		result = "kr-electrolysis-plant"
    },	
	{
		type = "recipe",
		name = "kr-filtration-plant",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 10},
			{"automation-core", 3},
			{"glass", 10},
			{"engine-unit", 2}
		},
		result = "kr-filtration-plant"
    },
	{
		type = "recipe",
		name = "kr-atmospheric-condenser",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 10},
			{"steel-gear-wheel", 10},
			{"electronic-circuit", 3},			
			{"engine-unit", 2}
		},
		result = "kr-atmospheric-condenser"
    },	
	{
		type = "recipe",
		name = "kr-fluid-burner",
		energy_required = 30,
		enabled = false,
		ingredients =
		{
			{"steel-beam", 10},
			{"steel-plate", 20},
			{"electronic-circuit", 3}
		},
		result = "kr-fluid-burner"
    },		
	{
		type = "recipe",
		name = "kr-quarry-drill",
		energy_required = 120,
		enabled = false,
		ingredients = 
		{
			{"steel-beam", 50},
			{"steel-plate", 50},			
			{"electric-engine-unit", 100},
			{"processing-unit", 20}
		},
		result = "kr-quarry-drill"
	},	
	{
		type = "recipe",
		name = "kr-fusion-reactor",
		energy_required = 120,
		enabled = false,
		ingredients = 
		{
			{"steel-beam", 500},
			{"steel-plate", 500},
			{"processing-unit", 100}
		},
		result = "kr-fusion-reactor"
	},	
	{
		type = "recipe",
		name = "kr-advanced-steam-turbine",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"steam-turbine", 2},
			{"steel-gear-wheel", 10},
			{"steel-beam", 50},
			{"kr-steel-pipe", 10},				
			{"electric-engine-unit", 50}					
		},
		result = "kr-advanced-steam-turbine"
    },
	{
		type = "recipe",
		name = "kr-matter-plant",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"imersium-beam", 10},
			{"kr-steel-pipe", 10},		
			{"electronic-components", 10},				
			{"ai-core", 5}					
		},
		result = "kr-matter-plant"
    },
	{
		type = "recipe",
		name = "kr-matter-assembler",
		energy_required = 60,
		enabled = false,
		ingredients =
		{
			{"imersium-beam", 4},
			{"kr-steel-pipe", 4},		
			{"electronic-components", 10},			
			{"ai-core", 3}					
		},
		result = "kr-matter-assembler"
    },
	{
		type = "recipe",
		name = "kr-antimatter-reactor",
		energy_required = 600,
		enabled = false,
		ingredients =
		{
			{"ai-core", 100},
			{"electronic-components", 100},		
			{"imersium-beam", 500},
			{"imersium-plate", 500}			
		},
		result = "kr-antimatter-reactor"
    },
	---
	-- Belts
	---
	-- Advanced
	{
		type = "recipe",
		name = "kr-advanced-splitter",
		category = "crafting-with-fluid",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"express-splitter", 1},
			{"steel-gear-wheel", 10},	
			{"rare-metals", 5},			
			{type = "fluid", name = "sulfuric-acid", amount = 50, catalyst_amount = 50}	
		},
		result = "kr-advanced-splitter"
    },
	{
		type = "recipe",
		name = "kr-advanced-transport-belt",
		category = "crafting-with-fluid",
		energy_required = 0.5,
		enabled = false,
		ingredients =
		{
			{"express-transport-belt", 1},	
			{"steel-gear-wheel", 20},
			{"rare-metals", 2},			
			{type = "fluid", name = "sulfuric-acid", amount = 50, catalyst_amount = 50}				
		},
		result = "kr-advanced-transport-belt"
    },	
	{
		type = "recipe",
		name = "kr-advanced-underground-belt",
		category = "crafting-with-fluid",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"express-underground-belt", 2},	
			{"steel-gear-wheel", 40},
			{"rare-metals", 5},			
			{type = "fluid", name = "sulfuric-acid", amount = 50, catalyst_amount = 50}				
		},
		result = "kr-advanced-underground-belt",
		result_count = 2
    },
	-- Superior
	{
		type = "recipe",
		name = "kr-superior-splitter",
		category = "crafting-with-fluid",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"kr-advanced-splitter", 1},
			{"processing-unit", 10},	
			{"imersium-gear-wheel", 10},			
			{type = "fluid", name = "nitric-acid", amount = 25, catalyst_amount = 50}	
		},
		result = "kr-superior-splitter"
    },
	{
		type = "recipe",
		name = "kr-superior-transport-belt",
		category = "crafting-with-fluid",
		energy_required = 0.5,
		enabled = false,
		ingredients =
		{
			{"kr-advanced-transport-belt", 1},	
			{"imersium-gear-wheel", 20},
			{type = "fluid", name = "nitric-acid", amount = 25, catalyst_amount = 50}				
		},
		result = "kr-superior-transport-belt"
    },
	{
		type = "recipe",
		name = "kr-superior-underground-belt",
		category = "crafting-with-fluid",
		energy_required = 2,
		enabled = false,
		ingredients =
		{
			{"kr-advanced-underground-belt", 2},	
			{"imersium-gear-wheel", 40},	
			{type = "fluid", name = "nitric-acid", amount = 50, catalyst_amount = 50}				
		},
		result = "kr-superior-underground-belt",
		result_count = 2
    }
	---
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
}