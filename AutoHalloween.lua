

voidPos = Vector3.new(0, -1409, 0)


-- UI Script
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DimensionTeleportUI"
screenGui.Parent = playerGui

-- Create main frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BackgroundTransparency = 0.2
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Create corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Create toggle button
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(0.5, -60, 0.5, -20)
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextScaled = true
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Text = "START"
toggleButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 5)
buttonCorner.Parent = toggleButton

-- Variables
local isRunning = false
local loopConnection = nil

-- Function to check for dimensional tears
local function hasDimensionalTears()
    local dimensionalTears = workspace.DimensionalTearSpawner.DimensionalTears
    for _, tear in ipairs(dimensionalTears:GetChildren()) do
        if tear:IsA("Model") and tear:FindFirstChild("DimensionalTear") and 
           tear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX") and 
           tear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX"):FindFirstChild("ProximityPrompt") and
           tear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX"):FindFirstChild("ProximityPrompt").Enabled then
            return true
        end
    end
    return false
end

-- Your functions (unchanged)
function teleport(targetPosition)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
end

function openClosestDimensionTear()
    DimensionalTears = workspace.DimensionalTearSpawner.DimensionalTears
    local closestTear = nil
    local closestDistance = math.huge

    for _, tear in ipairs(DimensionalTears:GetChildren()) do
        if tear:IsA("Model") and tear:FindFirstChild("DimensionalTear") and tear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX"):FindFirstChild("ProximityPrompt") then
            if tear:FindFirstChild("DimensionalTear") and tear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX"):FindFirstChild("ProximityPrompt").Enabled then
                local distance = (tear.DimensionalTear.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestTear = tear
                end
            end
        end
    end

    if closestTear then
        teleport(closestTear.DimensionalTear.Position) 
        wait(0.2)
        
        local openPrompt = closestTear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX"):FindFirstChild("ProximityPrompt")
        if openPrompt then
            openPrompt.HoldDuration = 0
            fireproximityprompt(openPrompt)
            wait(0.1)
        end
    end
end



local function teleportToAllDimensionTear()
    DimensionalTears = workspace.DimensionalTearSpawner.DimensionalTears
    

    for _, tear in ipairs(DimensionalTears:GetChildren()) do
        if tear:IsA("Model") and tear:FindFirstChild("DimensionalTear") and tear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX"):FindFirstChild("ProximityPrompt") then
            if tear:FindFirstChild("DimensionalTear")  then
                teleport(tear.DimensionalTear.Position) 
                wait(0.3)
                
            end
        end
    end

    


end

function DimensionTearCount()
    count = 0
    DimensionalTears = workspace.DimensionalTearSpawner.DimensionalTears
    
    for _, tear in ipairs(DimensionalTears:GetChildren()) do
        if tear:IsA("Model") and tear:FindFirstChild("DimensionalTear") and tear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX"):FindFirstChild("ProximityPrompt") then
            if tear:FindFirstChild("DimensionalTear") and tear:FindFirstChild("DimensionalTear"):FindFirstChild("DimensionHopVFX"):FindFirstChild("ProximityPrompt").Enabled then
                count = count + 1
            end
        end
    end
    return count

end

function openAllDimensionalTear()
    loops = DimensionTearCount()
    for i = 1, loops do 
        openClosestDimensionTear()
    end

end

function isStringIncluded(smallString, bigString)
    return string.find(bigString, smallString, 1, true) ~= nil
end

local function findClosestDimensionTearEnermy()
    local closestPucci = nil
    local closestPucciDistance = math.huge
    HostleNpc = workspace.NPCs.Hostile
    for _, npc in ipairs(HostleNpc:GetChildren()) do
        -- isStringIncluded("Pucci",npc.Name) 
        if  not npc:FindFirstChild("KoichiLuggageQuest (Objective2)") and not npc:FindFirstChild("GiornoBrunoQuest (Objective1)") and not npc:FindFirstChild("GiornoLucaQuest (Objective2)") and not isStringIncluded("Mafia",npc.Name) and not isStringIncluded("Vampi",npc.Name) and not isStringIncluded("Zombie",npc.Name) and not isStringIncluded("Thug",npc.Name)  and not isStringIncluded("Police",npc.Name) and not isStringIncluded("Shadow",npc.Name) and npc:FindFirstChild("HumanoidRootPart")   then
            print("Found")
            local distance = (npc:WaitForChild("HumanoidRootPart").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestPucciDistance then
                    closestPucciDistance = distance
                    closestPucci = npc
            end
        end
    end

    return closestPucci
end



local function FindClosestPucci()
    local closestPucci = nil
    local closestPucciDistance = math.huge
    HostleNpc = workspace.NPCs.Hostile
    for _, npc in ipairs(HostleNpc:GetChildren()) do
        -- isStringIncluded("Pucci",npc.Name) 
        if  isStringIncluded("Pucci",npc.Name) and npc:FindFirstChild("HumanoidRootPart")   then
            print("Found")
            local distance = (npc:WaitForChild("HumanoidRootPart").Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestPucciDistance then
                    closestPucciDistance = distance
                    closestPucci = npc
            end
        end
    end

    return closestPucci
end

local function PressKey(key)
    VirtualInputManager = game:GetService("VirtualInputManager")
    local keyMap = {
        Q = Enum.KeyCode.Q,
        E = Enum.KeyCode.E,
        W = Enum.KeyCode.W,
        R = Enum.KeyCode.R,
        Y = Enum.KeyCode.Y,
        V = Enum.KeyCode.V,
        SPACE = Enum.KeyCode.Space,
        ONE = Enum.KeyCode.One,
        TWO = Enum.KeyCode.Two,
        THREE = Enum.KeyCode.Three,
        FOUR = Enum.KeyCode.Four,
        FIVE = Enum.KeyCode.Five,
        SIX = Enum.KeyCode.Six,
        SEVEN = Enum.KeyCode.Seven,
        EIGHT = Enum.KeyCode.Eight,
        NINE = Enum.KeyCode.Nine,
        ZERO = Enum.KeyCode.Zero
    }
    
    local keyCode = keyMap[key]
    if not keyCode then
        print("Invalid key: " .. tostring(key))
        return
    end
    
    print("Pressing key: " .. key .. " (" .. tostring(keyCode) .. ")")
    
    -- Simulate key down
    VirtualInputManager:SendKeyEvent(true, keyCode, false, nil, false)
    
    -- Hold for a small duration
    task.wait(0.1)
    
    -- Simulate key up (releasing)
    VirtualInputManager:SendKeyEvent(false, keyCode, false, nil, false)
    
    print("Pressed key: " .. key)
end
local function setGravity(enabled)
    local workspace = game:GetService("Workspace")
    if enabled then
        workspace.Gravity = 196.2 -- Default Roblox gravity
        gravityEnabled = true
        print("Gravity enabled")
    else
        workspace.Gravity = 0
        gravityEnabled = false
        print("Gravity disabled - floating mode")
    end
end

local function GetPucciHp(pucci)
    if pucci:FindFirstChild("Humanoid") then
        return pucci.Humanoid.Health
    else
        return 0
    end
end

local function faceTheFloor()
    local player = game.Players.LocalPlayer.Character.HumanoidRootPart
    player.Character.Humanoid.PlatformStand = true
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = player.Character.HumanoidRootPart
        local currentPosition = rootPart.Position
        
        -- Look at a point directly below
        local lookAtPosition = currentPosition - Vector3.new(0, 10, 0)
        rootPart.CFrame = CFrame.lookAt(currentPosition, lookAtPosition)
    end
end

-- Function to clear character's momentum
local function clearMomentum()
    local player = game.Players.LocalPlayer
    if not player or not player.Character then
        return
    end
    
    local character = player.Character
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChild("Humanoid")
    
    if humanoidRootPart then
        -- Reset velocity
        humanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        humanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
        
        -- Reset assembly linear and angular velocity
        humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        humanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end
    
    if humanoid then
        -- Stop any walking/falling animations
        humanoid.WalkSpeed = 0
        wait(0.1)
        humanoid.WalkSpeed = 16 -- Reset to default or your desired speed
    end
end

-- Example usage:


local function faceTarget(target)
    
    game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
    local rootPart = game.Players.LocalPlayer.Character.HumanoidRootPart
    if rootPart and target  then
        local targetPos = target.Position
        local currentPos = rootPart.Position
        
        -- Calculate direction (only on Y axis)
        local direction = (targetPos - currentPos)
        
        
        
        -- Set CFrame to face the target
        rootPart.CFrame = CFrame.lookAt(currentPos, currentPos + direction)
        
        
    
    end
end

local function waitForCharacter()
    local character = game:GetService("Players").LocalPlayer.Character
    
    if character then
        repeat wait() until character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Humanoid")
        return character
    end
    
    local charAdded = player.CharacterAdded:Wait()
    repeat wait() until charAdded:FindFirstChild("HumanoidRootPart") and charAdded:FindFirstChild("Humanoid") 
    
    return charAdded
end

local function safeTeleport(position)
    local character = waitForCharacter()
    local humanoid = character:WaitForChild("Humanoid")
    local rootPart = character:WaitForChild("HumanoidRootPart")
    if rootPart and humanoid then
        -- Save current gravity state
        local wasGravityEnabled = gravityEnabled
        
        -- Disable gravity temporarily
        setGravity(false)
        
        -- Teleport
        rootPart.Velocity = Vector3.new(0, 0, 0)
        rootPart.CFrame = CFrame.new(position)
        
        -- Wait for physics to settle
        task.wait(0.2)
        
        -- Reset velocity
        
        rootPart.Velocity = Vector3.new(0, 0, 0)
        rootPart.RotVelocity = Vector3.new(0, 0, 0)
        
        -- Reset assembly linear and angular velocity
        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        rootPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        
        -- Restore gravity if it was enabled
        if wasGravityEnabled then
            setGravity(true)
        end
        
        print("Safe teleported to: " .. tostring(position))
    end
end

local function KillWithBlood(pucci)
    if not pucci:FindFirstChild("HumanoidRootPart") then
            return
    end
    
    pucciLocation = pucci:WaitForChild("HumanoidRootPart").Position
    teleport(pucciLocation + Vector3.new(0, 20, 0))
    faceTarget(pucci:WaitForChild("HumanoidRootPart"))
    clearMomentum()
    PressKey("V")
    wait(0.2)
    for i=1, 3 do
        pucciLocation = pucci:WaitForChild("HumanoidRootPart").Position
        safeTeleport(pucciLocation + Vector3.new(0, 4, 0))
        if not pucci:FindFirstChild("HumanoidRootPart") then
            break
        end
        faceTarget(pucci:WaitForChild("HumanoidRootPart"))
        
        wait(0.1)
    end
    pucciLocation = pucci:WaitForChild("HumanoidRootPart").Position
    safeTeleport(pucciLocation + Vector3.new(0, 4, 0))
    wait(0.7)
    
    for i=1, 10 do
        safeTeleport(voidPos)
        
        wait(0.2)
    end
    

    task.wait(2)
end

function LeftClick()
    VirtualInputManager = game:GetService("VirtualInputManager")
    -- Press down (Button Down)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    
    -- Short delay to simulate a real click
    task.wait(0.05)
    
    -- Release (Button Up)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
end
function ForcePlayerStandSummon()
    Toggle = game:GetService("Players").LocalPlayer.Character:WaitForChild("PlayerStates"):WaitForChild("Toggles")
    Toggle:SetAttribute("ForceStandSummon", true)
end

local function KillWithStandPunch(pucci)
    time = 0 
    while GetPucciHp(pucci) > 0 and isRunning do
        if not pucci:FindFirstChild("HumanoidRootPart") then
                break
        end
        pucciLocation = pucci:WaitForChild("HumanoidRootPart").Position
        teleport(pucciLocation + Vector3.new(0, 8, 0))
        faceTarget(pucci:WaitForChild("HumanoidRootPart"))
        if time % 2 == 0 then
            LeftClick()
            clearMomentum()
        end
        if time % 50 == 0 then
            ForcePlayerStandSummon()
        end
        
        time = time + 1
        wait(0.1)
    end

end

local function getBloodSuckCooldown()
    moveList = game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"):FindFirstChild("HUD"):FindFirstChild("Screen"):FindFirstChild("Keybinds"):FindFirstChild("MoveKeybinds")
    if moveList then
        for _, move in ipairs(moveList:GetChildren()) do
            if string.find(move.Name, "Hotkey") then
                if move:FindFirstChild("AbilityInfo").Text == "BLOOD SUCK" then
                    if tonumber(move:FindFirstChild("CooldownTimer").Text)  == nil then 
                        return 0 
                    else
                        return tonumber(move:FindFirstChild("CooldownTimer").Text) 
                    end
                end
               
            end
        end
    end
    return 999
end

local function FightEnermy(pucci)
    if not pucci:FindFirstChild("HumanoidRootPart") then
        return
    end
    
    pucciLocation = pucci:WaitForChild("HumanoidRootPart").Position
    setGravity(false)
    
    --if GetPucciHp(pucci) > 150 and getBloodSuckCooldown() == 0 then
      --  KillWithBlood(pucci)
    --else 
        KillWithStandPunch(pucci)
    --end
    setGravity(true)

end


function pickUpItems()
    for _,v in ipairs(workspace:GetChildren()) do
        if (v.Name == "DIO's Diary" and v:FindFirstChild("Handle")) then
            if v:FindFirstChild(v.Name) then
                teleport(v:FindFirstChild(v.Name).Position)
            end
            
            
            prompt = v:FindFirstChild("Handle"):FindFirstChild("ProximityPrompt")
            
            
            wait(0.2)
            if not prompt then
                continue
            end
            prompt.HoldDuration = 0
            fireproximityprompt(prompt)
            wait(0.1)

            
        end
    end

end

function teleportToRandomDimensionSpawn()
    dimensionFolder = workspace:WaitForChild("DimensionalTearSpawner"):WaitForChild("DimensionalTears")
    repeat 
    randomNumber = math.random(1, #dimensionFolder:GetChildren())
    randomTear = dimensionFolder:GetChildren()[randomNumber]
    until randomTear:FindFirstChild("DimensionalTear") 
    teleport(randomTear.DimensionalTear.Position)

end

function AutoTrickOrTreat()
    folder = game:GetService("Workspace").Map.Civilian_Spawns
function teleport(targetPosition)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
end

main = folder:FindFirstChild("Main Area")
mainAreaPosition = Vector3.new(975, 580, 107)
teleport(mainAreaPosition)

for _, item in pairs(main:GetChildren()) do
    if item.Name == "Spawn" then
        if not item:FindFirstChild("NPC_SpawnLocation") then
            continue
        end
        if not item:FindFirstChild("NPC_SpawnLocation"):FindFirstChild("TrickOrTreatPoint") then
            continue
        end
        if not item:FindFirstChild("Door") then
            continue
        end
        prompt = item:FindFirstChild("NPC_SpawnLocation"):FindFirstChild("TrickOrTreatPoint"):FindFirstChild("TrickOrTreatPrompt")
        if prompt.Enabled == false then
            continue
        end
        part = item:FindFirstChild("Door"):FindFirstChild("Part")
        if not part then
            continue
        end
        teleport(part.position)
        wait(0.3)
        fireproximityprompt(prompt)
        task.wait(5)

    end
    
end
print("end of main area")
wait(2)
CoastralArea = game:GetService("Workspace").Map.Civilian_Spawns["Coastal Area"]
CoastralAreaPosition =  Vector3.new(944, 548, -1473)
teleport(CoastralAreaPosition)

for _, item in pairs(CoastralArea:GetChildren()) do
    if item.Name == "Spawn" then
        if not item:FindFirstChild("NPC_SpawnLocation") then
            continue
        end
        if not item:FindFirstChild("NPC_SpawnLocation"):FindFirstChild("TrickOrTreatPoint") then
            continue
        end
        if not item:FindFirstChild("Door") then
            continue
        end
        prompt = item:FindFirstChild("NPC_SpawnLocation"):FindFirstChild("TrickOrTreatPoint"):FindFirstChild("TrickOrTreatPrompt")
        if prompt.Enabled == false then
            continue
        end
        part = item:FindFirstChild("Door"):FindFirstChild("Part")
        if not part then
            continue
        end
        teleport(part.position)
        wait(0.3)
        fireproximityprompt(prompt)
        task.wait(5)

    end
    
end
print("end of Coastral area")
end

function AutoGhostFly()
    clienetLootFile = game:GetService("Workspace").ClientLoot

function teleport(targetPosition)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
end

for _, item in pairs(clienetLootFile:GetChildren()) do
    if item.Name == "SoulWisp" then
        teleport(item:FindFirstChild("Core").position)
        wait(0.3)
    end
    
end
end


-- Main loop function
local function startLoop()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerName = player.Name
    if playerName == 'xiehank9' then
        while isRunning do
            AutoGhostFly()
            wait(0.3)
            AutoTrickOrTreat()
            wait(0.3)
        end
    end
end



-- Button click handler
toggleButton.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    setGravity(true)
    local player = game.Players.LocalPlayer
    player.Character.Humanoid.PlatformStand = false
    if isRunning then
        toggleButton.Text = "STOP"
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        -- Start the loop in a separate coroutine
        coroutine.wrap(startLoop)()
    else
        toggleButton.Text = "START"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)

print("UI Loaded - Press START to begin teleportation")