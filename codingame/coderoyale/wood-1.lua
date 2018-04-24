    -- Auto-generated code below aims at helping you parse
    -- the standard input according to the problem statement.
    structCoords = {}
    numberOfBarracks = 0
    numSites = tonumber(io.read())
    for i = 0, numSites - 1 do
        next_token = string.gmatch(io.read(), "[^%s]+")
        siteId = tonumber(next_token())
        x = tonumber(next_token())
        y = tonumber(next_token())
        radius = tonumber(next_token())
        structCoords[siteId] = {x = x, y = y, radius = radius}
    end

    -- game loop
    repeatGold = -1
    while true do
        -- touchedSite: -1 if none
        next_token = string.gmatch(io.read(), "[^%s]+")
        gold = tonumber(next_token())
        touchedSite = tonumber(next_token())
        structures = {}
        for i = 0, numSites - 1 do
            -- gold: used in future leagues
            -- maxMineSize: used in future leagues
            -- structureType: -1 = No structure, 2 = Barracks
            -- owner: -1 = No structure, 0 = Friendly, 1 = Enemy
            next_token = string.gmatch(io.read(), "[^%s]+")

            siteId = tonumber(next_token())
            gold = tonumber(next_token())
            maxMineSize = tonumber(next_token())
            structureType = tonumber(next_token())
            owner = tonumber(next_token())
            param1 = tonumber(next_token())
            param2 = tonumber(next_token())
            -- io.stderr:write(siteId .. "\n")
            structures[siteId] = {
                gold = gold,
                maxMineSize = maxMineSize,
                structureType = structureType,
                owner = owner,
                param1 = param1,
                param2 = param2
            }
        end
        numUnits = tonumber(io.read())
        local units = {}
        local myQueen, hisQueen
        for i = 0, numUnits - 1 do
            -- unitType: -1 = QUEEN, 0 = KNIGHT, 1 = ARCHER
            next_token = string.gmatch(io.read(), "[^%s]+")
            x = tonumber(next_token())
            y = tonumber(next_token())
            owner = tonumber(next_token())
            unitType = tonumber(next_token())
            health = tonumber(next_token())
            units[#units] = {
                x = x,
                y=y,
                owner = owner,
                unitType = unitType,
                health = health
            }
            if unitType == -1 then
                if owner == 0 then
                    myQueen = {
                        x = x,
                        y=y,
                        owner = owner,
                        unitType = unitType,
                        health = health
                    }
                else
                    hisQueen = {
                        x = x,
                        y=y,
                        owner = owner,
                        unitType = unitType,
                        health = health
                    }
                end
            end

        end
        local min = {20000^2, -1}
        if repeatGold > 0 and touchedSite ~= -1 then 
            print("BUILD " .. touchedSite .. " MINE")
            repeatGold = repeatGold -1
        elseif (touchedSite ~= -1 and structures[touchedSite].owner ~= 0)then
            if numberOfBarracks == 0 then 
                print("BUILD " .. touchedSite .. " BARRACKS-ARCHER")
            elseif numberOfBarracks == 1 then
                print("BUILD " .. touchedSite .. " BARRACKS-KNIGHT")
            elseif (numberOfBarracks-2) %6 < 3 then
                print("BUILD " .. touchedSite .. " MINE")
                repeatGold = structures[touchedSite].maxMineSize -1
            else
                print("BUILD " .. touchedSite .. " TOWER")
            end
            numberOfBarracks= numberOfBarracks+1
        else
            for siteId, tab in pairs(structures) do
                if tab.owner ~= 0 and tab.structureType~=1 then
                    dist = (structCoords[siteId].x - myQueen.x)^2 + (structCoords[siteId].y - myQueen.y)^2
                    if dist< min[1] then 
                        min[1] = dist 
                        min[2] = siteId
                    end
                end

            end
            if min[2] ~= -1 then
                print("MOVE " .. structCoords[min[2]].x.." "..structCoords[min[2]].y)
            else
                print("WAIT")
            end

        end
        
        local minEnemy = {20000^2, -1}
        for siteId, tab in pairs(structures) do
            if tab.owner == 0 and tab.structureType==2 then
                dist = (structCoords[siteId].x - hisQueen.x)^2 + (structCoords[siteId].y - hisQueen.y)^2
                if dist< minEnemy[1] then 
                    minEnemy[1] = dist 
                    minEnemy[2] = siteId
                end
            end

        end
        if minEnemy[2] ~= -1 then
            print("TRAIN " .. minEnemy[2])
        else
            print("TRAIN 1")
        end


        -- Write an action using print()
        -- To debug: io.stderr:write("Debug message\n")

        -- First line: A valid queen action
        -- Second line: A set of training instructions
    end