
models = { -- convenience
	[2] = 333,
	[3] = 334,
	[4] = 335,
	[5] = 336,
	[6] = 337,
	[7] = 338,
	[8] = 339,
	
	[22] = 346,
	[23] = 347,
	[24] = 348,
	
	[25] = 349,
	[26] = 350,
	[27] = 351,
	
	[28] = 352,
	[29] = 353,
	[32] = 372,
	
	[30] = 355,
	[31] = 356,
	
	[33] = 357,
	[34] = 358,
	
	[35] = 359,
	[36] = 360,
	[37] = 361,
	[38] = 362,
}

addEvent("mhinv:takeWeapon", true)
addEventHandler("mhinv:takeWeapon", root, function(wepId)
	takeWeapon(client, wepId)
end)

createdWeapons = {
	--[[
		["ownersName"] = {
			backWepObj = 0, 
			sideWepObj = 0, 
			meleeWepObj = 0, 
		}
	]]
}

addEvent("mhinv:initPlayer", true)
addEventHandler("mhinv:initPlayer", resourceRoot, function()

	createdWeapons[getPlayerName(client)] = {}
	
	createdWeapons[getPlayerName(client)].backWepObj = createObject(351, 0, 0, 0)
	setElementDimension(createdWeapons[getPlayerName(client)].backWepObj, getElementDimension(client))
	setElementInterior(createdWeapons[getPlayerName(client)].backWepObj, getElementInterior(client))
	exports.bone_attach:attachElementToBone(createdWeapons[getPlayerName(client)].backWepObj, client, 3, 0.05, -0.125, 0.35, 0, 125, 0)
	setElementAlpha(createdWeapons[getPlayerName(client)].backWepObj, 0)
	
	createdWeapons[getPlayerName(client)].sideWepObj = createObject(346, 0, 0, 0)
	setElementDimension(createdWeapons[getPlayerName(client)].sideWepObj, getElementDimension(client))
	setElementInterior(createdWeapons[getPlayerName(client)].sideWepObj, getElementInterior(client))
	exports.bone_attach:attachElementToBone(createdWeapons[getPlayerName(client)].sideWepObj, client, 4, 0.21, 0.05, 0, 15, 210, 90)
	setElementAlpha(createdWeapons[getPlayerName(client)].sideWepObj, 0)
	
	createdWeapons[getPlayerName(client)].meleeWepObj = createObject(336, 0, 0, 0)
	setElementDimension(createdWeapons[getPlayerName(client)].meleeWepObj, getElementDimension(client))
	setElementInterior(createdWeapons[getPlayerName(client)].meleeWepObj, getElementInterior(client))
	exports.bone_attach:attachElementToBone(createdWeapons[getPlayerName(client)].meleeWepObj, client, 4, -0.175, 0.1, 0.0, 15, -80, 90)
	setElementAlpha(createdWeapons[getPlayerName(client)].meleeWepObj, 0)
end)

addEvent("mhinv:updateWeaponObjects", true)
addEventHandler("mhinv:updateWeaponObjects", resourceRoot, function(backWepId, sideWepId, meleeWepId)
	if backWepId ~= 0 then
		setElementModel(createdWeapons[getPlayerName(client)].backWepObj, models[backWepId])
		setElementAlpha(createdWeapons[getPlayerName(client)].backWepObj, 255)
	else
		setElementAlpha(createdWeapons[getPlayerName(client)].backWepObj, 0)
	end

	if sideWepId ~= 0 then
		setElementModel(createdWeapons[getPlayerName(client)].sideWepObj, models[sideWepId])
		setElementAlpha(createdWeapons[getPlayerName(client)].sideWepObj, 255)
	else
		setElementAlpha(createdWeapons[getPlayerName(client)].sideWepObj, 0)
	end

	if meleeWepId ~= 0 then
		setElementModel(createdWeapons[getPlayerName(client)].meleeWepObj, models[meleeWepId])
		setElementAlpha(createdWeapons[getPlayerName(client)].meleeWepObj, 255)
	else
		setElementAlpha(createdWeapons[getPlayerName(client)].meleeWepObj, 0)
	end
	
	setElementDimension(createdWeapons[getPlayerName(client)].backWepObj, getElementDimension(client))
	setElementInterior(createdWeapons[getPlayerName(client)].backWepObj, getElementInterior(client))
	setElementDimension(createdWeapons[getPlayerName(client)].sideWepObj, getElementDimension(client))
	setElementInterior(createdWeapons[getPlayerName(client)].sideWepObj, getElementInterior(client))
	setElementDimension(createdWeapons[getPlayerName(client)].meleeWepObj, getElementDimension(client))
	setElementInterior(createdWeapons[getPlayerName(client)].meleeWepObj, getElementInterior(client))
	
end)

addEventHandler("onPlayerQuit", root, function()
	destroyElement(createdWeapons[getPlayerName(client)].backWepObj)
	destroyElement(createdWeapons[getPlayerName(client)].sideWepObj)
	destroyElement(createdWeapons[getPlayerName(client)].meleeWepObj)
	-- that should do it
end)