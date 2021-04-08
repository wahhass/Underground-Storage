PrefabFiles = {
	"understorage",
}

Assets =
{
	Asset("ATLAS", "minimap/understorage.xml" ),
	Asset("ATLAS", "images/inventoryimages/understorage.xml"),
}

AddMinimapAtlas("minimap/understorage.xml")

_G = GLOBAL
STRINGS = _G.STRINGS
RECIPETABS = _G.RECIPETABS
Recipe = _G.Recipe
Ingredient = _G.Ingredient
TECH = _G.TECH
TUNING = _G.TUNING

_G.understorage_WORK_DIR = "UnderStorage"

local modtemperatureduration =
{
	[1] = 0, [0.85] = -0.5, [0.75] = -0.6, [0.5] = -1, [0.25] = -2, [0] = -5, [999] = 5,
}

TUNING.PERISH_understorage_MULT = GetModConfigData("FoodSpoilage")
TUNING.TEMP_understorage_MULT = modtemperatureduration[TUNING.PERISH_understorage_MULT]

local understorage = {}
understorage.SLOTS = GetModConfigData("Slots")
understorage.CRAFT = GetModConfigData("Craft")
understorage.LANG = GetModConfigData("Language")
understorage.DEBUG = true

local PERISHABLE_MOD = false

local function updaterecipe(slots)
	if understorage.CRAFT == "Easy" then

		cutstone_value = math.floor(slots / 7)
		boards_value = math.floor(slots / 7)
		marble_value = math.floor(slots / 20)

	elseif understorage.CRAFT == "Hard" then

		cutstone_value = math.floor(slots / 2.6)
		boards_value = math.floor(slots / 2.6)
		marble_value = math.floor(slots / 10)

	else

		cutstone_value = math.floor(slots / 4)
		boards_value = math.floor(slots / 4)
		marble_value = math.floor(slots / 20)
	end
end
updaterecipe(understorage.SLOTS)


----------------------- RECIPE -----------------------

understorage = AddRecipe("understorage",{ Ingredient("cutstone", cutstone_value), Ingredient("marble", marble_value), Ingredient("boards", boards_value) }, RECIPETABS.TOWN, TECH.SCIENCE_TWO, "understorage_placer" )
understorage.atlas = "images/inventoryimages/understorage.xml"


----------------------- WIDGET -----------------------


---------------------- function ----------------------
local function widgetcreation(widgetanimbank, widgetpos, slot_x, slot_y, posslot_x, posslot_y)
	local params = {}
	params.understorage =
	{
		widget =
		{
			slotpos = {},
			animbank = widgetanimbank,
			animbuild = widgetanimbank,
			pos = widgetpos,
			side_align_tip = 160,
		},
	type = "chest",
	}

	for y = slot_y, 0, -1 do
		for x = 0, slot_x do
			table.insert(params.understorage.widget.slotpos, _G.Vector3(80*x-346*2+posslot_x, 80*y-100*2+posslot_y,0))
		end
	end

	local containers = _G.require "containers"
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params.understorage.widget.slotpos ~= nil and #params.understorage.widget.slotpos or 0)

	local old_widgetsetup = containers.widgetsetup
	function containers.widgetsetup(container, prefab, ...)
		local pref = prefab or container.inst.prefab
		if pref == "understorage" then
			local t = params[pref]
			if t ~= nil then
				for k, v in pairs(t) do
					container[k] = v
				end
			container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
			end
		else
			return old_widgetsetup(container, prefab, ...)
		end
	end
end

---------------------- position ----------------------
if GetModConfigData("Position") == ("Left") then
	widgetpos = _G.Vector3(-110,160,0)
elseif GetModConfigData("Position") == ("Center") then
	widgetpos = _G.Vector3(360-(understorage.SLOTS*4.5),160,0)
elseif GetModConfigData("Position") == ("Right") then
	widgetpos = _G.Vector3(820-(understorage.SLOTS*9.3),160,0)
end

----------------- formation function -----------------
if understorage.SLOTS == 20 then
	widgetanimbank = "chest_ui_4x5"
	slot_x = 4
	slot_y = 3
	posslot_x = 90
	posslot_y = 130
elseif understorage.SLOTS == 40 then
	widgetanimbank = "chest_ui_5x8"
	slot_x = 7
	slot_y = 4
	posslot_x = 109
	posslot_y = 42
elseif understorage.SLOTS == 60 then
	widgetanimbank = "chest_ui_5x12"
	slot_x = 11
	slot_y = 4
	posslot_x = 98
	posslot_y = 42
else
	widgetanimbank = "chest_ui_5x16"
	slot_x = 15
	slot_y = 4
	posslot_x = 91
	posslot_y = 42
end
---------------------- call function ----------------------
widgetcreation(widgetanimbank, widgetpos, slot_x, slot_y, posslot_x, posslot_y)

---------------------------------------------------
-------------------- TRANSLATE --------------------
---------------------------------------------------

--------------------- Russian ---------------------
local RegisterRussianName = GLOBAL.rawget(GLOBAL,"RegisterRussianName")
if RegisterRussianName and understorage.LANG == "En" then
	RegisterRussianName("understorage","Кладовая","she","Кладовой")
	STRINGS.RECIPE_DESC.understorage = "Нужно больше места!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "Мне очень нравится это большое хранилище!"

--------------------- Finnish ----------------------

elseif understorage.LANG == "Fn" then
	STRINGS.NAMES.understorage = "Varasto"
	STRINGS.RECIPE_DESC.understorage = "Tarvitsee enemmän tilaa!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "Tykkään tää on mahtava varasto!"

--------------------- French ----------------------

elseif understorage.LANG == "Fr" then
	STRINGS.NAMES.understorage = "Debarras"
	STRINGS.RECIPE_DESC.understorage = "Besoin de plus d'espace!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "J'apprecie beaucoup le gain de place!"

--------------------- Croatian ----------------------

elseif understorage.LANG == "Cr" then
	STRINGS.NAMES.understorage = "Skladište"
	STRINGS.RECIPE_DESC.understorage = "Treba više mjesta!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "Sviđa mi se ovo skladište!"

--------------------- German ----------------------

elseif understorage.LANG == "Gr" then
	STRINGS.NAMES.understorage = "Vorratskammer"
	STRINGS.RECIPE_DESC.understorage = "Brauche mehr Platz!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "Ich mag die Vorratskammer!"

--------------------- Traditional Chinese ----------------------

elseif understorage.LANG == "TCh" then
	STRINGS.NAMES.understorage = "儲藏室"
	STRINGS.RECIPE_DESC.understorage = "需要更多空間!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "這個儲藏室很好，我很喜歡！"

--------------------- Polish ----------------------

elseif understorage.LANG == "Pl" then
	STRINGS.NAMES.understorage = "Składzik"
	STRINGS.RECIPE_DESC.understorage = "Więcej miejsca!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "Naprawdę uwielbiam ten ogromny składzik!"

--------------------- Portuguese ----------------------

elseif understorage.LANG == "Pr" then
	STRINGS.NAMES.understorage = "Porão"
	STRINGS.RECIPE_DESC.understorage = "Preciso de mais espaço!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "¡Me encanta un montón, es una bodega estupenda!"

--------------------- Spanish ----------------------

elseif understorage.LANG == "Sp" then
	STRINGS.NAMES.understorage = "Bodega"
	STRINGS.RECIPE_DESC.understorage = "¡Se necesita más espacio!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "¡Me encanta este gran almacén!"

--------------------- Swedish ----------------------

elseif understorage.LANG == "Sw" then
	STRINGS.NAMES.understorage = "Förråd"
	STRINGS.RECIPE_DESC.understorage = "Behöver mer utrymme!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "Jag gillar verkligen detta bra föråd!"

--------------------- Turkish ----------------------

elseif understorage.LANG == "Tr" then
	STRINGS.NAMES.understorage = "Depo"
	STRINGS.RECIPE_DESC.understorage = "Daha fazla alan gerek!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "Bu depoyu gercekten begendim!"

--------------------- English ----------------------
else
	STRINGS.NAMES.understorage = "understorage"
	STRINGS.RECIPE_DESC.understorage = "Need more space!"
	STRINGS.CHARACTERS.GENERIC.DESCRIBE.understorage = "I really like this! It is a great under ground storage!"
end

---------------------- DEBUGGING ----------------------

if understorage.DEBUG then
	print("----- under storage DEBUG ----- ")
	print("slots = " .. understorage.SLOTS)
	print("perish = " .. TUNING.PERISH_understorage_MULT)
	print("recipe: cutstone = " .. cutstone_value .. " marble = " .. marble_value .. " boards = " ..  boards_value)
	print("widget: widgetanimbank = " .. widgetanimbank .. " widgetpos = ", widgetpos, " slot_x = " .. slot_x .. " slot_y = " .. slot_y .. " posslot_x = " .. posslot_x .. " posslot_y = " .. posslot_y)
end