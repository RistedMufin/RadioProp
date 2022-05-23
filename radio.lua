local lastTalkState = false

Citizen.CreateThread( function(data)
	while true do
		Citizen.Wait(5)
		if not IsPedSittingInAnyVehicle(PlayerPedId()) then
			if (IsControlJustPressed(0,19))  then
					local player = PlayerPedId()
					if ( DoesEntityExist( player ) and not IsEntityDead( player ) ) then
					RequestAnimDict("random@arrests");
					while not HasAnimDictLoaded("random@arrests") do
						Citizen.Wait(10)
					end
					local prop = GetHashKey("prop_cs_hand_radio")
					while not HasModelLoaded(prop) do
					RequestModel(prop)
					Citizen.Wait(1)
					end
					if HasModelLoaded(prop) then
					object = CreateObject(prop, GetEntityCoords(PlayerPedId()), true)
					AttachEntityToEntity(object, player, GetPedBoneIndex(player, 0x49D9), 0.15, 0.05, 0.02, 105.0, 0.0, 140.0, true, true, false, true, 1, true) -- 0x49D9
					TaskPlayAnim(PlayerPedId(),"random@arrests","generic_radio_chatter", 8.0, 0.0, -1, 49, 0, 0, 0, 0);
					end
					lastTalkState = true
					end
				elseif IsControlJustReleased(0,19) then
					StopAnimTask(PlayerPedId(), "random@arrests","generic_radio_chatter", -4.0);
					Citizen.Wait(100)
					DeleteObject(object)
					lastTalkState = false
				elseif not IsPedOnFoot(PlayerPedId()) then
					StopAnimTask(PlayerPedId(), "random@arrests","generic_radio_chatter", -4.0);
					Citizen.Wait(100)
					DeleteObject(object)
					lastTalkState = false
            end
		end
	end
end)
