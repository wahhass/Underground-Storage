require "prefabutil"

local assets =
{
	Asset("ANIM", "anim/understorage.zip"),
	Asset("ANIM", "anim/chest_ui_4x5.zip"),
	Asset("ANIM", "anim/chest_ui_5x8.zip"),
	Asset("ANIM", "anim/chest_ui_5x12.zip"),
	Asset("ANIM", "anim/chest_ui_5x16.zip"),
}

local understorage_DESTROY = GetModConfigData("Destroyable", understorage_WORK_DIR)

local function onopen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_open")
	if TheWorld.state.issnowcovered then
		inst.AnimState:PlayAnimation("open_snow")
	else
		inst.AnimState:PlayAnimation("open")
	end
end

local function onclose(inst)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/chest_close")
	if TheWorld.state.issnowcovered then
		inst.AnimState:PlayAnimation("closed_snow")
	else
		inst.AnimState:PlayAnimation("closed")
	end
end

local function onhammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	if inst.components.container ~= nil then
		inst.components.container:DropEverything()
	end
	local fx = SpawnPrefab("collapse_big")
	fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	fx:SetMaterial("wood")
	inst:Remove()
end

local function onhit(inst, worker)
	if TheWorld.state.issnowcovered then
		inst.AnimState:PlayAnimation("hit_snow")
		inst.AnimState:PushAnimation("closed_snow")
	else
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("closed")
	end
	if inst.components.container ~= nil then
		inst.components.container:Close()
	end
end

local function onbuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("closed")
end

local function fn(Sim)
	local inst = CreateEntity()
		inst.entity:AddTransform()
		inst.entity:AddAnimState()
		inst.entity:AddSoundEmitter()
		inst.entity:AddMiniMapEntity()
		inst.entity:AddNetwork()

		inst.MiniMapEntity:SetIcon("understorage.tex")

		MakeObstaclePhysics(inst, 1.25)

		inst:AddTag("structure")
		inst:AddTag("chest")
		inst:AddTag("iceunderstorage")
		inst.AnimState:SetBank("understorage")
		inst.AnimState:SetBuild("understorage")
		inst.AnimState:PlayAnimation("closed", true)

		inst.entity:SetPristine()

		if not TheWorld.ismastersim then
			return inst
		end

		inst:AddComponent("inspectable")
		inst:AddComponent("container")
		inst.components.container:WidgetSetup("understorage")
		inst.components.container.onopenfn = onopen
		inst.components.container.onclosefn = onclose

		inst:AddComponent("lootdropper")

		if understorage_DESTROY == "DestroyByAll" or understorage_DESTROY == "DestroyByPlayer" then
			inst:AddComponent("workable")
			inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
			inst.components.workable:SetWorkLeft(5)
			inst.components.workable:SetOnFinishCallback(onhammered)
			inst.components.workable:SetOnWorkCallback(onhit)
		end

		if understorage_DESTROY == "DestroyByPlayer" then
			local old_Destroy = inst.components.workable.Destroy
			function inst.components.workable:Destroy(destroyer)
				if destroyer.components.playercontroller == nil then return	end
				return old_Destroy(self,destroyer)
			end
		end

		inst:ListenForEvent("snowcoveredchanged", function()
			if TheWorld.state.issnowcovered then
				inst.AnimState:PlayAnimation("closed_snow", true)
			else
				inst.AnimState:PlayAnimation("closed", true)
			end
		end, TheWorld)

	return inst
end

return Prefab( "common/understorage", fn, assets),
	   MakePlacer("common/understorage_placer", "understorage", "understorage", "closed")
