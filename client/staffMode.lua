isStaffMode, serverInteraction = false,false

RegisterNetEvent("astra_staff:cbStaffState")
AddEventHandler("astra_staff:cbStaffState", function(isStaff)
    isStaffMode = isStaff
    serverInteraction = false
    if isStaffMode then
        local cVar1 = "~r~"
        local cVar2 = "/\\"
        Citizen.CreateThread(function()
            while isStaffMode do
                Wait(650)
                if cVar1 == "~r~" then cVar1 = "~s~" else cVar1 = "~r~" end
            end
        end)
        Citizen.CreateThread(function()
            while isStaffMode do
                Wait(450)
                if cVar2 == "/\\" then cVar2 = "\\/" else cVar2 = "/\\" end
            end
        end)
        Citizen.CreateThread(function()
            while isStaffMode do
                Wait(1)
                RageUI.Text({message = cVar1..cVar2.." ~s~Mode modération actif "..cVar1..cVar2.."\n"..generateReportDisplay()})
            end
        end)
    else
        NoClip(false)
    end
end)