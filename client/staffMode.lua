isStaffMode, serverInteraction, reportsTable, waitingReports, takenReports, closedReports = false,false,{},0,0,0

RegisterNetEvent("astra_staff:cbStaffState")
AddEventHandler("astra_staff:cbStaffState", function(isStaff)
    isStaffMode = isStaff
    serverInteraction = false
    if isStaff then
        local cVar1 = "~y~"
        local cVar2 = "/\\"
        Citizen.CreateThread(function()
            while isStaff do
                Wait(650)
                if cVar1 == "~y~" then cVar1 = "~o~" else cVar1 = "~y~" end
            end
        end)
        Citizen.CreateThread(function()
            while isStaff do
                Wait(450)
                if cVar2 == "/\\" then cVar2 = "\\/" else cVar2 = "/\\" end
            end
        end)
        Citizen.CreateThread(function()
            while isStaff do
                Wait(1)
                RageUI.Text({message = cVar1..cVar2.." Mode modération actif "..cVar2})
            end
        end)
    end
end)