name = "UnderStorage"
version = "2.5a"

desc_variant = {en = "Your personal space.\n\nMod version: "..version}
description = desc_variant["en"]

author = "WahHass"
forumthread = ""
api_version = 10

all_clients_require_mod = true
client_only_mod = false
dst_compatible = true


server_filter_tags = {"understorage"}

icon_atlas = "understorage.xml"
icon = "understorage.tex"
----------------------


configuration_options =
{
	{
		name = "Craft",
		label = "Craft",
		options =
	{
		{description = "Easy", data = "Easy"},
		{description = "Normal", data = "Normal"},
		{description = "Hard", data = "Hard"},
	},
		default = "Normal",
	},

	{
		name = "Slots",
		label = "Slots",
		options =
	{
		{description = "20", data = 20},
		{description = "40", data = 40},
		{description = "60", data = 60},
		{description = "80", data = 80},
	},
		default = 80,
	},

	{
		name = "Position",
		label = "Position",
		options =
	{
		{description = "Left", data = "Left"},
		{description = "Center", data = "Center"},
		{description = "Right", data = "Right"},
	},
		default = "Center",
	},

	{
		name = "FoodSpoilage",
		label = "Food Spoilage",
		options =
	{
		{description = "Default", data = 1, hover = " "},
		{description = "Little Slower", data = 0.85, hover = "Little Slower"},
		{description = "Like the Winter", data = 0.75, hover = "Like the Winter "},
		{description = "Like an Ice Box", data = 0.5, hover = "Like an Ice Box"},
		{description = "Better than Ice Box", data = 0.25, hover = "Better than Ice Box"},
		{description = "No Spoilage", data = 0, hover = " "},
		{description = "What?!!!", data = 999, hover = "Wow this is just cheating"},
	},
		default = 1,
	},

	{
		name = "Destroyable",
		label = "Destroyable",
		options =
	{
		{description = "All", data = "DestroyByAll"},
		{description = "Only Player", data = "DestroyByPlayer"},
		{description = "Disabled ", data = "DestroyOff"},
	},
		default = "DestroyByAll",
	},

	{
		name = "Language",
		label = "Language",
		options =
	{
		{description = "English", data = "En"},
		{description = "Finnish", data = "Fn"},
		{description = "Francais", data = "Fr"},
		{description = "Croatian", data = "Cr"},
		{description = "German", data = "Gr"},
		{description = "Chinese", data = "TCh"},
		{description = "Polish", data = "Pl"},
		{description = "Portuguese", data = "Pr"},
		{description = "Spanish", data = "Sp"},
		{description = "Swedish", data = "Sw"},
		{description = "Turkish", data = "Tr"},
	},
		default = "En",
	},
}
