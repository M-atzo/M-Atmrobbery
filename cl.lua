local robbing = false

Citizen.CreateThread(function()
    while true do 
        Wait(0)
        if IsControlPressed(0,38) then 
            if robbing then
                ClearPedTasks(cache.ped)
            end
        end
    end
end)


local options = {
    label = 'Ryöstä automaatti',
    icon = 'fa-solid fa-coins',
    onSelect = function()

        robbing = true 
        lib.playAnim(cache.ped, 'random@robbery', 'f_cower_01', 8.0, 8.0, -1, 17)
        local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'easy'}, {'1'})
        if success then

         local Onnistuit = lib.callback('annamoney', false, false)
            if Onnistuit then
            lib.notify({
                description = 'Onnistuit ryöstössä',
                type = 'success',
                icon = 'fa-solid fa-bank'
            })
            end
        else
            lib.notify({
                description = 'Ryöstäminen epäonnistui',
                type = 'error',
                icon = 'fa-solid fa-bank'
            })
        end
        ClearPedTasks(cache.ped)
        robbing = false
    end,
    canInteract = function() 
        local hasCrowbar, weapon = GetCurrentPedWeapon(cache.ped, true)
        return weapon == joaat('weapon_crowbar')
    end
    
}

exports.ox_target:addModel('prop_fleeca_atm','prop_atm_03','prop_atm_01','prop_atm_02', options)