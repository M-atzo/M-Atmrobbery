local aika = 300

local atm = {}




lib.callback.register('annamoney', function(pelaaja)
    local coordit = GetEntityCoords(GetPlayerPed(pelaaja))
    for i = #atm, 1, -1 do 
        local automaatti = atm[i]
        if os.time() >= automaatti.atmcooldown then
            table.remove( atm, i )
        else
            local distance = #(coordit-automaatti.atmcoordit)
            if distance < 1.5 then
            local time = automaatti.atmcooldown - os.time()
            TriggerClientEvent('ox_lib:notify', pelaaja, {
                description = 'Aikaa jäljellä '..time.. ' Sekunttia',
                type = 'error',
                icon = 'fa-solid fa-clock'
            })
                return false
            end
        end
    end
    table.insert(atm, {atmcoordit = coordit,atmcooldown = os.time() + aika})
    local mahdolisuus = math.random(1,500)
    exports.ox_inventory:AddItem(pelaaja, 'money', mahdolisuus)
    return true
end)
