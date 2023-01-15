local tInv = {
	bChanged = false, --if a inventory slot has changed
	tSlots, --wich slot has changed tSlots[nSlot] = {name, count}
	tLastInv, --snapshot of last inventory (before it changed)
    bTerminate, --if the handling is to be terminated
}

function tInv.init()
    tInv.bChanged = false
    tInv.bTerminate = false
    tInv.tLastInv = getInventory()
    parallel.waitForAny(HandleInvChange, main)
end

function tInv.terminate()
    tInv.bTerminate = true
    os.queueEvent("turtle_inventory")
    return true
end

function cmpInventory(tInv1, tInv2) --[[ Compares 2 snapshots of inventory.
    11/05/2022 v0.3.0 Param: tInv1, tInv2 - snapshots from inventory (getInventory).
    Returns: nil - if tInv1 or tInv2 not supplied.
                true - if snapshots are equals.
                table - if snapshots are diferent.
    Sintax: cmpInventory(tInv1, tInv2)
    ex: cmpInventory(tInv1, tInv2) - compares tInv1 with tInv2.]]
    if (not tInv1) or (not tInv2) then
        return nil, "cmpInventory(tInv1, tInv2) - You must supply inventory1 and inventory2 to compare"
    end
    local tDif
    for iSlot = 1, 16 do
        if tInv1[iSlot] then
            for k, v in pairs(tInv1[iSlot]) do
                if tInv2[iSlot] and tInv2[iSlot][k] then
                    if tInv2[iSlot][k] ~= tInv1[iSlot][k] then
                        if not tDif then tDif = {} end	
                        tDif[iSlot] = {["name"] = k, ["count"] = tInv2[iSlot][k] - tInv1[iSlot][k]}
                    end
                elseif not tDif then tDif = {}
                    tDif[iSlot] = {["name"] = k, ["count"] = -tInv1[iSlot][k]}
                end
            end
        elseif tInv2[iSlot] then
            for k, v in pairs(tInv2[iSlot]) do
                if not tDif then tDif = {} end	
                tDif[iSlot] = {["name"] = k, ["count"] = tInv2[iSlot][k]}
            end
        end
    end

    if tDif then return false, tDif
    else return true
    end
end

function getInventory() --[[ Builds a table with the slot, the name and quantity of items in inventory.
    04/12/2021 v0.2.0 Returns:  table[slot][itemName]=Quantity.
    Sintax: getInventory()]]
    local tInv = {}
    for iSlot = 1, 16 do
        local tData = turtle.getItemDetail(iSlot)
        if tData then
        tInv[iSlot] = {}
        tInv[iSlot][tData.name] = tData.count
        end
    end
    return tInv
end

function main()
    while true do
        print("this is main")
        sleep(20)
        tInv.terminate()
    end
end

function HandleInvChange()
    while true do
        os.pullEvent("turtle_inventory")
        if tInv.bTerminate then return true, "Handle turtle inventory change terminated." end
        tInv.bChanged = true
        local inv2 = getInventory()
        local _, tDif = cmpInventory(tInv.tLastInv, inv2)
        tInv.tLastInv = inv2
        print(textutils.serialize(tDif))
    end
end

tInv.init()
