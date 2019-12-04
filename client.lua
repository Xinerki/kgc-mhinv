
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

backWeapon = 0
sidearmWeapon = 0
meleeWeapon = 0

addEventHandler("onClientResourceStart", resourceRoot, function()
	triggerServerEvent("mhinv:initPlayer", resourceRoot)
end)

function updateWeaponObjects(backWepId, sideWepId, meleeWepId)
	triggerServerEvent("mhinv:updateWeaponObjects", resourceRoot, backWepId, sideWepId, meleeWepId)
end

wepSlots = {
	unarmed = 0,
	melee = 1,
	handgun = 2,
	shotgun = 3,
	smg = 4,
	assaultrifle = 5, 
	rifle = 6,
	heavy = 7,
}

addEventHandler ( "onClientPlayerWeaponSwitch", localPlayer, function(previousWeaponSlot, currentWeaponSlot)

	lastWepID = getPedWeapon(localPlayer, previousWeaponSlot)
	wepId = getPedWeapon(localPlayer, currentWeaponSlot)
	
	if wepId == 9 then -- chainsaw
		triggerServerEvent("mhinv:takeWeapon", localPlayer, wepId)
		cancelEvent()
	end
	
	if currentWeaponSlot >= 8 then -- anything above heavy
		triggerServerEvent("mhinv:takeWeapon", localPlayer, wepId)
		cancelEvent()
	end
	
	
	if currentWeaponSlot == wepSlots.handgun and sidearmWeapon ~= 0 and getSlotFromWeapon(sidearmWeapon) ~= currentWeaponSlot then
		triggerServerEvent("mhinv:takeWeapon", localPlayer, getPedWeapon(localPlayer, getSlotFromWeapon(sidearmWeapon)))
		sidearmWeapon = getPedWeapon(localPlayer, getSlotFromWeapon(sidearmWeapon))
		cancelEvent()
	end
	
	if currentWeaponSlot == wepSlots.smg and sidearmWeapon ~= 0 and getSlotFromWeapon(sidearmWeapon) ~= currentWeaponSlot then
		triggerServerEvent("mhinv:takeWeapon", localPlayer, getPedWeapon(localPlayer, getSlotFromWeapon(sidearmWeapon)))
		sidearmWeapon = getPedWeapon(localPlayer, getSlotFromWeapon(sidearmWeapon))
		cancelEvent()
	end
	
	if (currentWeaponSlot == wepSlots.shotgun or currentWeaponSlot == wepSlots.rifle or currentWeaponSlot == wepSlots.assaultrifle or currentWeaponSlot == wepSlots.heavy) and backWeapon ~= 0 and getSlotFromWeapon(backWeapon) ~= currentWeaponSlot then
		triggerServerEvent("mhinv:takeWeapon", localPlayer, getPedWeapon(localPlayer, getSlotFromWeapon(backWeapon)))
		backWeapon = getPedWeapon(localPlayer, getSlotFromWeapon(backWeapon))
		cancelEvent()
	end
	
	
	if previousWeaponSlot == wepSlots.melee then
		if meleeWeapon == 0 then
			meleeWeapon = lastWepID
		elseif meleeWeapon ~= lastWepID then
			meleeWeapon = 0
		end
	end
	
	if previousWeaponSlot == wepSlots.handgun or previousWeaponSlot == wepSlots.smg then
		if sidearmWeapon == 0 or sidearmWeapon ~= lastWepID then
			sidearmWeapon = lastWepID
		end
		if previousWeaponSlot == wepSlots.handgun and sidearmWeapon > 27 then triggerServerEvent("mhinv:takeWeapon", localPlayer, wepId) end -- take smg away if pistol present
		if previousWeaponSlot == wepSlots.smg and sidearmWeapon < 25 then triggerServerEvent("mhinv:takeWeapon", localPlayer, wepId) end -- do same if smg present first
		
	end
	
	if previousWeaponSlot == wepSlots.rifle or previousWeaponSlot == wepSlots.assaultrifle or previousWeaponSlot == wepSlots.shotgun or previousWeaponSlot == wepSlots.heavy then
		if backWeapon == 0 or backWeapon ~= lastWepID then
			backWeapon = lastWepID
		end
		if previousWeaponSlot == wepSlots.rifle and backWeapon < 33 then triggerServerEvent("mhinv:takeWeapon", localPlayer, wepId) end -- take assrifle away if rifle present
		if previousWeaponSlot == wepSlots.assaultrifle and backWeapon < 31 then triggerServerEvent("mhinv:takeWeapon", localPlayer, wepId) end -- do same if assrifle present first
		if previousWeaponSlot == wepSlots.shotgun and backWeapon > 27 then triggerServerEvent("mhinv:takeWeapon", localPlayer, wepId) end -- ...and shotgun
		if previousWeaponSlot == wepSlots.heavy and backWeapon < 35 then triggerServerEvent("mhinv:takeWeapon", localPlayer, wepId) end -- ...and heavy..
		
	end

	if wepId == meleeWeapon then meleeWeapon = 0 end
	if wepId == backWeapon then backWeapon = 0 end
	if wepId == sidearmWeapon then sidearmWeapon = 0 end
		
	
	updateWeaponObjects(backWeapon, sidearmWeapon, meleeWeapon)
end)



