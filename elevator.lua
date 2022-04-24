local speaker = peripheral.find("speaker")
elevatorFloor = 15
redstone.setOutput("top", false)
redstone.setOutput("right", false)
 
floorMap = {[15] = 14, [14] = 13, [13] = 12, [12] = 15, [11] = 13, [10] = 12, [9] = 15, [8] = 14, [7] = 12, [6] = 15, [5] = 14, [4] = 13}
 
function goToFloor (requestedFloor, elevFloor, endFloor)
    while elevFloor ~= requestedFloor do
        print("Requested: " .. requestedFloor)
        print("Elevator: " .. elevFloor)    
        if requestedFloor > elevFloor then
            redstone.setOutput("right", true)
            sleep(0.1)
            redstone.setOutput("right", false)
        elseif requestedFloor < elevFloor then
            redstone.setOutput("top", true)
            sleep(0.1)
            redstone.setOutput("top", false)
        end
        sleep(2.5)
        elevFloor = redstone.getAnalogInput("back")
        --sleep(3)
    end
    sleep(1)
    while elevFloor ~= endFloor do
        print("End Floor: " .. endFloor)
        print("Elevator Floor: " .. elevFloor)
        if endFloor > elevFloor then
            redstone.setOutput("right", true)
            sleep(0.1)
            redstone.setOutput("right", false)
        elseif endFloor < elevFloor then
            redstone.setOutput("top", true)
            sleep(0.1)
            redstone.setOutput("top", false)
        end
        sleep(2.5)
        elevFloor = redstone.getAnalogInput("back")
    end
    --print(endFloor)
    --print(elevatorFloor)
    --print(requestedFloor)
    --sleep(1000000)
    speaker.playSound("minecraft:entity.villager.hurt", 3, 2.5)
    sleep(0.3)
    speaker.playSound("minecraft:entity.villager.hurt", 3, 1.5)
    sleep(0.3)
    speaker.playSound("minecraft:entity.villager.hurt", 3, 1)
end
 
 
while true do
    redstoneFloorStrength = redstone.getAnalogInput("back")
    print("Floor Signal: " .. redstoneFloorStrength)
    request = redstone.getAnalogInput("left")
    print("Request: " .. request)
    if request >= 13 then
        goToFloor(15, elevatorFloor, floorMap[request])
    elseif request >= 10 and request <= 12 then
        goToFloor(14, elevatorFloor, floorMap[request])
    elseif request >= 7 and request <= 9 then
        goToFloor(13, elevatorFloor, floorMap[request])
    elseif request >= 4 and request <= 6 then
        goToFloor(12, elevatorFloor, floorMap[request])
    end
    if redstoneFloorStrength ~= 0 then
        elevatorFloor = redstoneFloorStrength
    end
    print("Position: " .. elevatorFloor)
    print("==========")
    sleep(0.1)
end        
