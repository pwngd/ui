--!nolint
--!nocheck
local assert = assert
local type = type
local setfenv = setfenv
if LPH_OBFUSCATED == nil then
	LPH_ENCNUM = function(toEncrypt, ...)
		assert(type(toEncrypt) == "number" and #{...} == 0, "LPH_ENCNUM only accepts a single constant double or integer as an argument.")
		return toEncrypt
	end
	LPH_NUMENC = LPH_ENCNUM

	LPH_ENCSTR = function(toEncrypt, ...)
		assert(type(toEncrypt) == "string" and #{...} == 0, "LPH_ENCSTR only accepts a single constant string as an argument.")
		return toEncrypt
	end
	LPH_STRENC = LPH_ENCSTR

	LPH_ENCFUNC = function(toEncrypt, encKey, decKey, ...)
		-- not checking decKey value since this shim is meant to be used without obfuscation/whitelisting
		assert(type(toEncrypt) == "function" and type(encKey) == "string" and #{...} == 0, "LPH_ENCFUNC accepts a constant function, constant string, and string variable as arguments.")
		return toEncrypt
	end
	LPH_FUNCENC = LPH_ENCFUNC

	LPH_JIT = function(f, ...)
		assert(type(f) == "function" and #{...} == 0, "LPH_JIT only accepts a single constant function as an argument.")
		return f
	end
	LPH_JIT_MAX = LPH_JIT

	LPH_NO_VIRTUALIZE = function(f, ...)
		assert(type(f) == "function" and #{...} == 0, "LPH_NO_VIRTUALIZE only accepts a single constant function as an argument.")
		return f
	end

	LPH_NO_UPVALUES = function(f, ...)
		assert(type(setfenv) == "function", "LPH_NO_UPVALUES can only be used on Lua versions with getfenv & setfenv")
		assert(type(f) == "function" and #{...} == 0, "LPH_NO_UPVALUES only accepts a single constant function as an argument.")
		return f
	end

	LPH_CRASH = function(...)
		assert(#{...} == 0, "LPH_CRASH does not accept any arguments.")
	end
end

LPH_NO_UPVALUES(function()
local function Hook_Adonis(meta_defs)
    for _, tbl in meta_defs do
        for i, func in tbl do
            if type(func) == "function" and islclosure(func) then
                local dummy_func = LPH_NO_UPVALUES(function()
                    return pcall(coroutine.close, coroutine.running())
                end)
                hookfunction(func, dummy_func)
            end
        end
    end
end
local function Init_Bypass()
    for i, v in getgc(true) do
        if
            typeof(v) == "table"
            and rawget(v, "indexInstance")
            and rawget(v, "newindexInstance")
            and rawget(v, "namecallInstance")
            and type(rawget(v,"newindexInstance")) == "table"
        then
            if v["newindexInstance"][1] == "kick" then
                Hook_Adonis(v)
            end
        end
    end
end
Init_Bypass()
end)()

task.wait()

local success, lib = pcall(function()
	local uis = game:GetService("UserInputService")
	local ts = game:GetService("TweenService")
	if _G.gb==nil then _G.gb = {} end
	local garbage = _G.gb
	local lib = {}
	lib.saveCfg = false
	lib.cfgFolder = "WCFG"

	lib.themes = {
		default = {
			name = "default",
			animations = true,
			animationSpeed = 1,
			accentColor = Color3.new(0.11764705882352941, 0.7568627450980392, 0.2784313725490196),
			backgroundColor = Color3.new(0.1, 0.1, 0.1),
			highlightColor = Color3.new(0, 0, 0),
			textColor = Color3.new(1, 1, 1),
			titleColor = Color3.new(1, 1, 1),
			topbarColor = Color3.fromRGB(0, 0, 0),
			subtitleColor = Color3.new(0.560784, 0.560784, 0.560784),
			disabledColor = Color3.new(1, 0.466667, 0.466667),
			moduleColor = Color3.new(1,1,1),
			moduleTransparency = 0.9,
            moduleBorderColor = Color3.new(0.3,0.3,0.3),
			font = Font.new("rbxasset://fonts/families/SourceSansPro.json",Enum.FontWeight.Regular,Enum.FontStyle.Normal),
			fontHeader = Font.new("rbxasset://fonts/families/SourceSansPro.json",Enum.FontWeight.Heavy,Enum.FontStyle.Normal),
			cornerRadius = UDim.new(0,0),
			backgroundTransparency = 0,
			topbarTransparency = 0.2,
			animationTime = 0.2,
			backgroundImg = "rbxasset://textures/ui/GuiImagePlaceholder.png",
			backgroundImgTransparency = 1,
			backgroundImgColor = Color3.new(1,1,1),
			strokeThickness = 3,
			strokeTransparency = 1,
			strokeColor = nil,
			strokeLineJoinMode = Enum.LineJoinMode.Round,

			gradient = { 
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.new(0.5, 0.5, 0.5)),
				}),
				Rotation = 45
			},
            gradientType = "background",

            titleGradient = { 
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(0.396078, 0.658824, 1)),
                    ColorSequenceKeypoint.new(0.5, Color3.new(0.698039, 0.352941, 1)),
                    ColorSequenceKeypoint.new(1, Color3.new(0.917647, 1, 0.654902)),
				}),
				Rotation = 0
			},

			-- decorGradient = { 
			-- 	Color = ColorSequence.new({
			-- 		ColorSequenceKeypoint.new(0, Color3.new(0.396078, 0.658824, 1)),
            --         ColorSequenceKeypoint.new(0.5, Color3.new(0.698039, 0.352941, 1)),
            --         ColorSequenceKeypoint.new(1, Color3.new(0.917647, 1, 0.654902)),
			-- 	}),
			-- 	Rotation = 0
			-- },
            
            modulePadding = UDim.new(0,8)
		},

        blue = {
			name = "blue",
            backgroundColor = Color3.new(0.094118, 0.101961, 0.560784),
			moduleBorderColor = Color3.new(0.000000, 0.000000, 0.000000),
			accentColor = Color3.new(0.164706, 0.180392, 1.000000),
			topbarColor = Color3.new(0.000000, 0.000000, 0.000000),
			gradient = { 
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, Color3.new(0.443137, 0.443137, 0.443137)),
				}),
				Rotation = 45
			},
			titleGradient = { 
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(0.247059, 0.258824, 1.000000)),
                    ColorSequenceKeypoint.new(1, Color3.new(0.168627, 0.184314, 0.419608)),
				}),
				Rotation = 90
			},
			topbarButtonTransparency = 1,
			strokeThickness = 3,
			strokeTransparency = 0,
			strokeColor = Color3.new(0.054902, 0.054902, 1.000000),
        },

		red = {
			name = "red",
			accentColor = Color3.new(0.5,0,0),
			titleGradient = { 
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1.000000, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.new(0.000000, 0.000000, 0.000000)),
				}),
				Rotation = 90
			},
			topbarButtonTransparency = 1,
			backgroundColor =  Color3.new(0.05, 0.05, 0.05),
			moduleColor = Color3.new(0.454902, 0.454902, 0.454902),
		},

		green = {
			name = "green",
			accentColor = Color3.new(0.000000, 0.725490, 0.011765),
			titleGradient = { 
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(0.000000, 0.725490, 0.011765)),
                    ColorSequenceKeypoint.new(1, Color3.new(0.000000, 0.000000, 0.000000)),
				}),
				Rotation = 90
			},
			topbarButtonTransparency = 1,
			backgroundColor =  Color3.new(0.05, 0.05, 0.05),
			moduleColor = Color3.new(0.454902, 0.454902, 0.454902),
			cornerRadius = UDim.new(0,8)
		}
	}

	lib.theme = lib.themes.default

	local window = {}
	window.__index = window
	window.__metatable = nil

	local Signal = {}  
	Signal.__index = Signal  
	function Signal.new() return setmetatable({ _callbacks = {} }, Signal) end  
	function Signal:Connect(cb) table.insert(self._callbacks, cb) return { Disconnect = function() for i, v in ipairs(self._callbacks) do if v == cb then table.remove(self._callbacks, i) break end end end } end  
	function Signal:Fire(...) for _, cb in ipairs(self._callbacks) do cb(...) end end

	local function deepCopy(original)
        if type(original)~="table" then return end
		local copy = {}
		for key, value in original do
			copy[key] = type(value) == "table" and deepCopy(value) or value
		end
		return copy
	end

	local function deepMerge(t1, t2)
		local merged = deepCopy(t1)
		for k, v in pairs(t2) do
			if type(v) == "table" and type(merged[k]) == "table" then
				merged[k] = deepMerge(merged[k], v)
			else
				merged[k] = deepCopy(v) or v
			end
		end
		return merged
	end

	local function applyProperties(inst,props)
		for i, v in props do
			inst[i] = v
		end
		return inst
	end

	local function addGarbage(...)
		local g=table.pack(...)
		table.insert(garbage,g)
		return g[1]
	end

	local function clrGarbage()
		for _, v in garbage do
			if v[1]==nil then continue end
			if typeof(v[1]) == "Instance" then
				if v[1]:IsA("Instance") then
					v[1]:Destroy()
				end
			elseif v[2] then
				if type(v[1][v[2]]) == "function" then
					v[1][v[2]](v[1])
				end
			end
		end
		table.clear(garbage)
	end

	local function genStr()
		local res = ""
		for i=1, math.random(8,16) do
			res = res .. string.char(math.random(33,126))
		end
		return res
	end

	local function roundToNearest(value, step)
		return math.round(value / step) * step
	end

	function lib.Destroy()
		clrGarbage()
		script:Destroy()
	end

	-- WINDOW
	function lib:CreateWindow(cfg)
		cfg = if cfg~=nil then cfg else {}
		if cfg.theme and cfg.theme~=lib.themes.default and cfg.doNotMergeTheme == nil then
			local newTheme = deepMerge(lib.themes.default, cfg.theme)
			cfg.theme = newTheme
		end 
		local self = setmetatable({
			name = cfg.name or " SpedWare",
			icon = cfg.icon or "",
			size = cfg.size or UDim2.new(0.3,0,0.3,0),
			aspectRatio = cfg.aspectRatio or 1.6,
			theme = cfg.theme or lib.theme,
			keybinds = {}
		}, window)

		local player=game:GetService("Players").LocalPlayer
		local mouse=player:GetMouse()
		local activeTab=nil
		local drag=false
		local mPos=nil
		local fPos=nil
		local fSize=nil
		local dragInput=nil
		local minimized=false
		local resizing=false
		local oldSize=UDim2.new()
		local cornerThreshold = 20
		local _createdPages = {}

		local function enableDrag(ui:GuiObject)
			ui.InputBegan:Connect(function(input:InputObject)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local frameAbsPos = ui.AbsolutePosition
					local frameAbsSize = ui.AbsoluteSize

					mPos=input.Position
					fPos=ui.Position
					fSize=ui.Size

					local bottomRightCorner = frameAbsPos + frameAbsSize
					local inCorner = (mPos.X >= bottomRightCorner.X - cornerThreshold and 
						mPos.Y >= bottomRightCorner.Y - cornerThreshold)

					resizing = inCorner
					drag = not inCorner
				end
			end)
			addGarbage(uis.InputEnded:Connect(function(input:InputObject)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					drag=false
					resizing=false
				end
			end), "Disconnect")
			addGarbage(uis.InputChanged:Connect(LPH_NO_UPVALUES(LPH_NO_VIRTUALIZE(function(input:InputObject)
				if input.UserInputType==Enum.UserInputType.MouseMovement and mPos then
					if drag then
						local delta=input.Position-mPos
						ui.Position=UDim2.new(
							fPos.X.Scale, fPos.X.Offset + delta.X,
							fPos.Y.Scale, fPos.Y.Offset + delta.Y
						)
					elseif resizing then
						local delta=input.Position-mPos
						ui.Size = UDim2.new(
							fSize.X.Scale, fSize.X.Offset + delta.X,
							fSize.Y.Scale, fSize.Y.Offset + delta.Y
						)
					end
				end
			end))), "Disconnect")
		end

		local function addTheme(element,conf)
			element.FontFace = conf.font or self.theme.font
			element.TextColor3 = conf.color or self.theme.textColor
		end

		local function activateTab(tab)
			if activeTab then
				activeTab.BackgroundColor3 = self.theme.backgroundColor
			end
			activeTab=tab
			local h,s,v = self.theme.accentColor:ToHSV()
			tab.BackgroundColor3 = Color3.fromHSV(h,s,v*0.2)
		end

		local function addPage(pageName:string,tabContainer:Frame,pages:Frame,layout:UIPageLayout,decor:GuiObject,imageButton:string)
			local tab:GuiButton? = nil
			if imageButton then
				tab = Instance.new("ImageButton")
				tab.Image = imageButton
			else
				tab = Instance.new("TextButton")
				tab.Text = pageName
				tab.TextWrapped = true
				tab.TextTruncate = Enum.TextTruncate.AtEnd
				tab.Font = Enum.Font.SourceSans
				tab.TextSize = 15
				tab.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
			tab.BorderSizePixel = 0
			tab.BackgroundColor3 = self.theme.backgroundColor
			tab.Size = UDim2.new(0, 0, 1, 0)
			tab.BackgroundTransparency = self.theme.backgroundTransparency
			tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
			tab.Parent = tabContainer
			local decorClone = decor:Clone()
			decorClone.Parent = tab

			if self.theme.animations then
				tab.MouseEnter:Connect(function()
					tab:TweenSize(UDim2.new(.1, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2*self.theme.animationSpeed, true)
				end)
				tab.MouseLeave:Connect(function()
					tab:TweenSize(UDim2.new(0, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1*self.theme.animationSpeed, true)
				end)
			end

			if self.theme.decorGradient then
				decorClone.BackgroundColor3 = Color3.new(1,1,1)
				local gradient:UIGradient = Instance.new("UIGradient")
				applyProperties(gradient,self.theme.decorGradient)
				gradient.Parent = decorClone
				gradient.Offset = Vector2.new((#pages:GetChildren()-2)*0.33,0)
			end

            if pages:FindFirstChildWhichIsA("UIGradient") then
                local grad = pages:FindFirstChildWhichIsA("UIGradient"):Clone()
                grad.Offset = Vector2.new(0,.45)
                grad.Parent = tab
            end

			local page = Instance.new("ScrollingFrame")
			page.Size = UDim2.fromScale(1,1)
			page.BackgroundTransparency = 1
			page.BorderSizePixel = 0
			page.BackgroundColor3 = BrickColor.Random().Color
			page.ClipsDescendants = true
			page.ScrollBarThickness = 2
            page.ScrollBarImageTransparency=1
			page.CanvasSize = UDim2.new(0,0,0,0)
			page.AutomaticCanvasSize = Enum.AutomaticSize.Y
			page.Parent = pages

			local list = Instance.new("UIListLayout")
			list.FillDirection = Enum.FillDirection.Horizontal
			list.Wraps = true
			list.Padding = self.theme.modulePadding
			list.Parent = page

			local mainFrame_padding:UIPadding = Instance.new("UIPadding")
			mainFrame_padding.PaddingTop = UDim.new(0,tabContainer.AbsoluteSize.Y+8)
			mainFrame_padding.PaddingRight = UDim.new(self.theme.modulePadding.Scale,self.theme.modulePadding.Offset)
			mainFrame_padding.PaddingLeft = UDim.new(self.theme.modulePadding.Scale,self.theme.modulePadding.Offset)
			mainFrame_padding.PaddingBottom = UDim.new(0,tabContainer.AbsoluteSize.Y+8)
			mainFrame_padding.Parent = page

			tabContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				mainFrame_padding.PaddingTop = UDim.new(0,tabContainer.AbsoluteSize.Y+8)
				mainFrame_padding.PaddingBottom = UDim.new(0,tabContainer.AbsoluteSize.Y+8)
			end)

			addGarbage(tab.Activated:Connect(function()
				activateTab(tab)
				layout:JumpTo(page)
			end), "Disconnect")

			return page, tab
		end

		local function addModule(page,conf)
			conf = if conf~=nil then conf else {}
			local module = Instance.new("Frame")
			module.BackgroundColor3 = self.theme.moduleColor
			module.BackgroundTransparency = self.theme.moduleTransparency or self.theme.backgroundTransparency
			module.BorderSizePixel = 0
			module.LayoutOrder = conf.layoutOrder or 0
			module.Size = conf.size or UDim2.new(.49,0,0,100)
			module.Parent = page
			
			local realFrame = Instance.new("Frame")
			realFrame.BackgroundTransparency = 1
			realFrame.Size = UDim2.fromScale(1,1)
			realFrame.Parent = module
			
			local minSize = module.Size
			local function updateSize(added)
				task.wait()
				local totalHeight = 0
				for _, child in realFrame:GetChildren() do
					if child:IsA("GuiObject") then
						totalHeight = totalHeight + math.max(34,child.Size.Y.Offset)
					end
				end
				module.Size = UDim2.new(minSize.X.Scale, minSize.X.Offset, if totalHeight > 0 then 0 else minSize.Y.Scale, if totalHeight > 0 then totalHeight+1 else minSize.Y.Offset)

				pcall(function() 
					if added:IsA("GuiObject") and self.theme["animations"]~=nil then
						local currentTween = nil
						added.BackgroundColor3 = self.theme.moduleColor
						added.MouseEnter:Connect(function()
							if currentTween then currentTween:Cancel() end
							currentTween = ts:Create(added, TweenInfo.new(0.05*self.theme.animationSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency=0.9})
							currentTween:Play()
						end)
						added.MouseLeave:Connect(function()
							if currentTween then currentTween:Cancel() end
							currentTween = ts:Create(added, TweenInfo.new(0.2*self.theme.animationSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {BackgroundTransparency=1})
							currentTween:Play()
						end)
					end
				end)
			end
			realFrame.ChildAdded:Connect(updateSize)
			realFrame.ChildRemoved:Connect(updateSize)
			
			local list = Instance.new("UIListLayout")
			list.Padding = UDim.new(0,4)
			list.Parent = realFrame

			local padding = Instance.new("UIPadding")
			padding.PaddingRight=UDim.new(0,4)
			padding.PaddingLeft=UDim.new(0,4)
			padding.Parent = module

			local rfpadding = Instance.new("UIPadding")
			rfpadding.PaddingTop = UDim.new(0,9)
			rfpadding.Parent = realFrame

			local stroke = Instance.new("UIStroke")
			stroke.Color = self.theme.moduleBorderColor or self.theme.accentColor
			stroke.Thickness = 1
			stroke.LineJoinMode = self.theme.strokeLineJoinMode
			stroke.Parent = module

			local uiCorner = Instance.new("UICorner")
			uiCorner.CornerRadius = self.theme.cornerRadius
			uiCorner.Parent = module

			local name = Instance.new("TextLabel")
			name.Text = conf.name or ""
			name.BackgroundColor3 = self.theme.backgroundColor
			name.BackgroundTransparency = 1
			name.BorderSizePixel = 0
			name.Size = UDim2.new(0.3,0,0,5)
			name.FontFace = self.theme.font
			name.TextColor3 = self.theme.textColor
			name.TextStrokeTransparency = 0
			name.TextStrokeColor3 = Color3.new(0,0,0)
			name.TextSize = 14
			name.AnchorPoint = Vector2.new(0,0.5)
			name.Position = UDim2.new(0.1,0,0,0)
			name.Parent = module

			return realFrame
		end

		local function addInput(parent,conf)
			conf = if conf~=nil then conf else {}
			local frame = Instance.new("Frame")
			frame.BackgroundTransparency = 1
			frame.Size = UDim2.new(1,0,0,30)
			frame.Parent = parent

			local name = Instance.new("TextLabel")
			name.Text = conf.name or ""
			name.BackgroundColor3 = self.theme.backgroundColor
			name.BackgroundTransparency = 1
			name.BorderSizePixel = 0
			name.Size = UDim2.new(1,0,0.5,0)
			name.FontFace = self.theme.font
			name.TextColor3 = self.theme.textColor
			name.TextStrokeTransparency = 0
			name.TextStrokeColor3 = Color3.new(0,0,0)
			name.TextScaled = true
			name.Position = UDim2.new(0,0,0,0)
			name.TextXAlignment = Enum.TextXAlignment.Left
			name.Parent = frame

			if conf.editable == nil then
				conf.editable = true
			end
			
			local input = Instance.new("TextBox")
			input.TextEditable = conf.editable
			input.Interactable = conf.editable
			input.PlaceholderText = conf.placeholder or ""
			input.BorderSizePixel = 1
			input.BorderMode = Enum.BorderMode.Middle
			input.BorderColor3 = self.theme.accentColor
			input.BackgroundColor3 = self.theme.backgroundColor
			input.BackgroundTransparency = 0
			input.PlaceholderColor3 = self.theme.subtitleColor
			input.TextColor3 = self.theme.textColor
			input.Size = UDim2.fromScale(1, 0.5)
			input.Position = UDim2.fromScale(0, 0.5)
			input.FontFace = self.theme.font
			input.TextStrokeTransparency = 0
			input.TextStrokeColor3 = Color3.new(0,0,0)
			input.TextScaled = true
			input.Text = conf.text or ""
			input.Parent = frame

			if parent.Parent.Parent:FindFirstChildWhichIsA("UIGradient") then
                local grad = parent.Parent.Parent:FindFirstChildWhichIsA("UIGradient"):Clone()
                grad.Offset = Vector2.new(0,0)
                grad.Parent = input
            end

			return frame, input
		end

		local function addCheckbox(parent,conf)
			conf = if conf~=nil then conf else {}
			local frame = Instance.new("Frame")
			frame.BackgroundTransparency = 1
			frame.Size = UDim2.new(1,0,0,15)
			frame.Parent = parent

			local button = Instance.new("TextButton")
			button.Text = ""
			button.BackgroundColor3 = self.theme.backgroundColor
			button.BorderSizePixel = 1
			button.BorderMode = Enum.BorderMode.Middle
			button.BorderColor3 = self.theme.accentColor
			button.TextColor3 = self.theme.accentColor
			button.TextXAlignment = Enum.TextXAlignment.Center
			button.TextYAlignment = Enum.TextYAlignment.Center
			button.Position = UDim2.new(0,0,0,0)
			button.Size = UDim2.fromScale(1, 1)
			button.Parent = frame

			local aspectRatio = Instance.new("UIAspectRatioConstraint")
			aspectRatio.AspectRatio = 1
			aspectRatio.Parent = button

			local list = Instance.new("UIListLayout")
			list.FillDirection = Enum.FillDirection.Horizontal
			list.Padding = UDim.new(0.02,0)
			list.Parent = frame

			local name = Instance.new("TextLabel")
			name.Text = conf.name or ""
			name.LayoutOrder = 2
			name.BackgroundColor3 = self.theme.backgroundColor
			name.BackgroundTransparency = 1
			name.BorderSizePixel = 0
			name.Position = UDim2.new(0,0,0,0)
			name.Size = UDim2.new(1,0,1,0)
			name.FontFace = self.theme.font
			name.TextColor3 = self.theme.textColor
			name.TextStrokeTransparency = 0
			name.TextStrokeColor3 = Color3.new(0,0,0)
			name.TextScaled = true
			name.TextXAlignment = Enum.TextXAlignment.Left
			name.Parent = frame

			return frame, button
		end

		local function addButton(parent,conf)
			conf = if conf~=nil then conf else {}
			local frame = Instance.new("Frame")
			frame.BackgroundTransparency = 1
			frame.Size = UDim2.new(1,0,0,15)
			frame.Parent = parent

			local button = Instance.new("TextButton")
			button.Text = conf.name or ""
			button.BackgroundColor3 = self.theme.backgroundColor
			button.BorderSizePixel = 1
			button.BorderMode = Enum.BorderMode.Middle
			button.BorderColor3 = self.theme.accentColor
			button.TextColor3 = self.theme.accentColor
			button.TextXAlignment = Enum.TextXAlignment.Center
			button.TextYAlignment = Enum.TextYAlignment.Center
			button.Position = UDim2.new(0,0,0,0)
			button.Size = UDim2.fromScale(1, 1)
			button.FontFace = self.theme.font
			button.TextColor3 = self.theme.textColor
			button.TextStrokeTransparency = 0
			button.TextStrokeColor3 = Color3.new(0,0,0)
			button.TextScaled = true
			button.Parent = frame

			return frame, button
		end

		local function addSlider(parent,conf)
			conf = if conf~=nil then conf else {}
			local label = conf.name
			local value = conf.value
			local prefix = conf.prefix
			local range = conf.range
			local percent = conf.value/(conf.range[2]-conf.range[1])

			local frame = Instance.new("Frame")
			frame.BackgroundTransparency = 1
			frame.Size = UDim2.new(1,0,0,30)
			frame.Parent = parent

			local name = Instance.new("TextLabel")
			name.Text = label or ""
			name.BackgroundColor3 = self.theme.backgroundColor
			name.BackgroundTransparency = 1
			name.BorderSizePixel = 0
			name.Size = UDim2.new(1,0,0.5,0)
			name.FontFace = self.theme.font
			name.TextColor3 = self.theme.textColor
			name.TextStrokeTransparency = 0
			name.TextStrokeColor3 = Color3.new(0,0,0)
			name.TextScaled = true
			name.Position = UDim2.new(0,0,0,0)
			name.TextXAlignment = Enum.TextXAlignment.Left
			name.Parent = frame

			local input = Instance.new("TextButton")
			input.Text = ""
			input.BorderSizePixel = 1
			input.BorderMode = Enum.BorderMode.Middle
			input.BorderColor3 = self.theme.accentColor
			input.BackgroundColor3 = self.theme.backgroundColor
			input.BackgroundTransparency = 0
			input.Size = UDim2.fromScale(1, 0.5)
			input.Position = UDim2.fromScale(0, 0.5)
			input.Parent = frame

			local text = Instance.new("TextLabel")
			text.Text = value .. prefix
			text.Active = false
			text.FontFace = self.theme.font
			text.TextColor3 = self.theme.textColor
			text.TextStrokeTransparency = 0
			text.TextStrokeColor3 = Color3.new(0,0,0)
			text.TextScaled = true
			text.Size = UDim2.fromScale(1, 1)
			text.ZIndex = 100
			text.BackgroundTransparency = 1
			text.Parent = input

			local bar = Instance.new("Frame")
			bar.Active = false
			bar.BorderSizePixel = 0
			bar.BackgroundColor3 = self.theme.accentColor
			bar.Size = UDim2.new(percent,0,1,0)
			bar.Position = UDim2.new(0,0,0,0)
			bar.Parent = input

			if parent.Parent.Parent:FindFirstChildWhichIsA("UIGradient") then
                local grad = parent.Parent.Parent:FindFirstChildWhichIsA("UIGradient"):Clone()
                grad.Offset = Vector2.new(0,0)
                grad.Parent = input
            end

			return frame, input, bar, text
		end

		function self.Destroy()
			table.clear(self)
			setmetatable(self, nil)
		end

		-- add window to gc
		addGarbage(self, "Destroy")

		local function setupMainUI()
			local gui:ScreenGui = addGarbage(Instance.new("ScreenGui"))
			gui.ResetOnSpawn = false
			gui.DisplayOrder = 999999999
			gui.IgnoreGuiInset = true
			gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

			local PARENT = nil
			if get_hidden_gui or gethui then
				local hiddenUI = get_hidden_gui or gethui
				PARENT = hiddenUI()
			elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
				syn.protect_gui(gui)
				PARENT = game:GetService("CoreGui")
			else
				PARENT = game:GetService("CoreGui")
			end
			gui.Parent = PARENT

			local decor:Frame = Instance.new("Frame")
			decor.BorderSizePixel = 0
			decor.BackgroundColor3 = self.theme.accentColor
			decor.BackgroundTransparency = 0
			decor.Size = UDim2.new(1, 0, 0.1, 0)
			decor.BorderColor3 = Color3.fromRGB(0, 0, 0)

			-- canvas group
			local canvasGroup:CanvasGroup = Instance.new("CanvasGroup")
			canvasGroup.Position = UDim2.new(0.3,0,0.3,0)
			canvasGroup.Size = self.size
			canvasGroup.BackgroundTransparency = 1
			canvasGroup.BackgroundColor3 = self.theme.backgroundColor
			canvasGroup.BorderSizePixel = 0
			canvasGroup.ZIndex = 999999999
			canvasGroup.Parent = gui
			if self.theme.animations then
				canvasGroup.GroupTransparency = 1
			end

			-- local aspectRatio:UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			-- aspectRatio.AspectRatio = self.aspectRatio
			-- aspectRatio.Parent = canvasGroup

			local cornerRadius:UICorner = Instance.new("UICorner")
			cornerRadius.CornerRadius = self.theme.cornerRadius
			cornerRadius.Parent = canvasGroup

			local uiStroke:UIStroke = Instance.new("UIStroke")
			uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			uiStroke.LineJoinMode = self.theme.strokeLineJoinMode
			uiStroke.Color = self.theme.strokeColor or self.theme.accentColor
			uiStroke.Thickness = self.theme.strokeThickness
			uiStroke.Transparency = self.theme.strokeTransparency
			uiStroke.Parent = canvasGroup

			-- main frame
			local mainFrame:Frame = Instance.new("Frame")
			mainFrame.Size = UDim2.fromScale(1,1)
			mainFrame.BackgroundTransparency = self.theme.backgroundTransparency
			mainFrame.BackgroundColor3 = self.theme.backgroundColor
			mainFrame.ClipsDescendants = true
			mainFrame.Parent = canvasGroup

			if self.theme.gradient then
				local gradient = Instance.new("UIGradient")
				applyProperties(gradient,self.theme.gradient)
				if self.theme.gradientType == "background" then
					gradient.Parent = mainFrame
				else
					gradient.Parent = canvasGroup
					gradient:Clone().Parent = uiStroke
				end
			end

			local pageLayout = Instance.new("UIPageLayout")
			pageLayout.Animated = self.theme.animations
			pageLayout.TweenTime = 0.2 * self.theme.animationSpeed
			pageLayout.EasingStyle = Enum.EasingStyle.Quad
			pageLayout.EasingDirection = Enum.EasingDirection.Out
			pageLayout.ScrollWheelInputEnabled=false
			pageLayout.TouchInputEnabled=false
			pageLayout.GamepadInputEnabled=false
			pageLayout.Circular=true
			pageLayout.Parent = mainFrame

			-- top bar
			local topbar:Frame = Instance.new("Frame")
			topbar.Position = UDim2.new()
			topbar.Size = UDim2.new(1,0,0.1,0)
			topbar.BackgroundColor3 = self.theme.topbarColor or self.theme.backgroundColor
			topbar.BackgroundTransparency = self.theme.topbarTransparency
			topbar.ZIndex = 999999999
			topbar.BorderSizePixel = 0
			topbar.Parent = canvasGroup

			local topbarUiListLayout:UIListLayout = Instance.new("UIListLayout")
			topbarUiListLayout.Padding = UDim.new(0,2)
			topbarUiListLayout.FillDirection = Enum.FillDirection.Horizontal
			topbarUiListLayout.Wraps = false
			topbarUiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
			topbarUiListLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
			topbarUiListLayout.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
			topbarUiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			topbarUiListLayout.VerticalFlex = Enum.UIFlexAlignment.None
			topbarUiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			topbarUiListLayout.Parent = topbar

			local title:TextLabel = Instance.new("TextLabel")
			title.Text = " "..self.name
			title.FontFace = self.theme.fontHeader
			title.TextScaled = true
			title.TextColor3 = self.theme.titleColor or self.theme.textColor
			title.BackgroundTransparency = 1
			title.BorderSizePixel = 0
			title.Size = UDim2.new(0, 0, 1, 0)
			title.Position = UDim2.new()
			title.LayoutOrder = 0
			title.TextXAlignment = Enum.TextXAlignment.Center
			title.TextYAlignment = Enum.TextYAlignment.Center
			title.Parent = topbar
			if self.theme.titleGradient then
				local gradient = Instance.new("UIGradient")
				applyProperties(gradient,self.theme.titleGradient)
				gradient.Parent = title
			end

			-- tabs
			local tabs:Frame = Instance.new("Frame")
			tabs.BorderSizePixel = 0
			tabs.BackgroundTransparency = 1
			tabs.Size = UDim2.new(0.5, 0, 1, 0)
			tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
			tabs.LayoutOrder = 100
			tabs.Parent = topbar
			local tabLL:UIListLayout = topbarUiListLayout:Clone()
			tabLL.Padding = UDim.new(0,5)
			tabLL.VerticalAlignment = Enum.VerticalAlignment.Top
			tabLL.Parent = tabs
			local tabPadding:UIPadding = Instance.new("UIPadding")
			tabPadding.PaddingTop = UDim.new(0, 2)
			tabPadding.PaddingRight = UDim.new(0, 2)
			tabPadding.PaddingLeft = UDim.new(0, 2)
			tabPadding.Parent = tabs

			local minimize:TextButton = Instance.new("TextButton")
			minimize.AutoButtonColor = true
			minimize.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
			minimize.BackgroundTransparency = self.theme.topbarButtonTransparency or 0.9
			minimize.BorderSizePixel = 0
			minimize.Size = UDim2.new(1,0,1,0)
			minimize.FontFace = self.theme.fontHeader
			minimize.TextColor3 = Color3.new(1,1,1)
			minimize.LayoutOrder = 9998
			minimize.TextScaled = true
			minimize.Text = "-"
			minimize.TextXAlignment = Enum.TextXAlignment.Center
			minimize.TextYAlignment = Enum.TextYAlignment.Center
			minimize.Parent = topbar
			local minimizeAR:UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			minimizeAR.AspectRatio = 1
			minimizeAR.Parent = minimize

			local exit:TextButton = minimize:Clone()
			exit.BackgroundColor3 = Color3.fromRGB(255, 57, 57)
			exit.Text = "X"
			exit.LayoutOrder = 9999
			exit.Parent = topbar

			enableDrag(canvasGroup)

			exit.Activated:Connect(function()
				gui.Enabled = false
			end)

			minimize.Activated:Connect(function()
				local oldClr = canvasGroup.GroupColor3
				canvasGroup.GroupColor3 = Color3.new(0,0,0)
				if minimized then
					mainFrame.Visible = true
					minimize.Text = "-"
					topbar.Size = UDim2.fromScale(1,0.1)
					canvasGroup.Size = oldSize
				else
					mainFrame.Visible = false
					minimize.Text = "+"
					oldSize = canvasGroup.Size
					canvasGroup.Size = UDim2.fromOffset(topbar.AbsoluteSize.X,topbar.AbsoluteSize.Y)
					topbar.Size = UDim2.fromScale(1,1)
				end
				task.wait()
				canvasGroup.GroupColor3 = oldClr
				minimized = not minimized
			end)

			task.spawn(function()
				for _, v in gui:GetDescendants() do
					v.Name = genStr()
				end
			end)

			return tabs, mainFrame, pageLayout, decor, pageLayout, canvasGroup
		end
		local tabs, mainFrame, pageLayout, decor, pageLayout, canvasGroup = setupMainUI()

        -- EXPOSED API --
		function self:JumpTo(page)
			pageLayout:JumpTo(_createdPages[page.name][1])
			activateTab(_createdPages[page.name][2])
		end

        function self:CreatePage(pageConf,_internal)
            local page, tab = nil, nil
			if _internal then
				page = _internal[1]
				tab = _internal[2]
			else
				page, tab = addPage(pageConf.name,tabs,mainFrame,pageLayout,decor)
			end

			if _createdPages[pageConf.name] ~= nil then
				error("Do not create duplicate page names")
				return
			end

            local pageObj = {name=pageConf.name}
			_createdPages[pageConf.name] = {page,tab}

			function pageObj:Destroy()
				page:Destroy()
				tab:Destroy()
				table.clear(pageObj)
				table.clear(_createdPages[pageConf.name])
				_createdPages[pageConf.name]=nil
				table.clear(pageConf)
			end

			function pageObj:CreateModule(modConf)
				local module = addModule(page,modConf)
				local moduleObj = {}
				function moduleObj:CreateInput(inConf)
					local frame, input = addInput(module, inConf)
					local inputObj = {value=inConf.value or nil}
					inputObj.Changed = Signal.new()

					input.Text = inConf.value or ""

					input.FocusLost:Connect(function()
						if inConf.inputType and inConf.inputType == "number" then
							local num = tonumber(input.Text)
							if num==nil then
								input.Text = if input.Text ~= "" then "Must be a number" else ""
								return
							end
							inputObj.value = num
							inputObj.Changed:Fire(num)
							return
						end
						inputObj.Changed:Fire(input.Text)
					end)
					return inputObj
				end
				function moduleObj:CreateCheckbox(checkConf)
					local frame, box = addCheckbox(module, checkConf)
					local checkObj = {}
					checkObj.value=checkConf.defaultState or false
					checkObj.Changed = Signal.new()

					box.Activated:Connect(function()
						checkObj.value = not checkObj.value
						box.Text = if checkObj.value then "X" else ""
						checkObj.Changed:Fire(checkObj.value)
					end)

					return checkObj
				end
				function moduleObj:CreateButton(buttonConf)
					local frame, button = addButton(module, buttonConf)
					local buttonObj = {}
					buttonObj.Changed = Signal.new()

					button.Activated:Connect(function()
						buttonObj.Changed:Fire()
					end)

					return buttonObj
				end
				function moduleObj:CreateSlider(sliderConf)
					if sliderConf.range==nil or (sliderConf.range[2]-sliderConf.range[1])<0 then warn("Range nil or invalid") return end
					if sliderConf.value==nil or typeof(sliderConf.value)~="number" then sliderConf.value = 0 end
					if sliderConf.prefix==nil then sliderConf.prefix = "" end
					if sliderConf.step==nil then sliderConf.step = 0.01 end
					local frame, button, bar, text = addSlider(module, sliderConf)
					local sliderObj = {value=sliderConf.value or nil}
					sliderObj.Changed = Signal.new()

					local range = sliderConf.range[2]-sliderConf.range[1]

					local function updateSlider(input)
						local minX = button.AbsolutePosition.X
						local maxX = minX + button.AbsoluteSize.X
						local x = math.clamp(input.Position.X, minX, maxX)
						local percent = (x - minX) / (maxX - minX)
						percent = math.max(0,percent)
						bar.Size = UDim2.new(percent,0,1,0)
						local newValue = math.floor(range*percent)
						text.Text = newValue .. sliderConf.prefix
						sliderObj.value = newValue
						sliderObj.Changed:Fire(newValue)
					end

					local connection = nil
					button.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							updateSlider(input)
							if connection then connection:Disconnect() end
							connection = uis.InputChanged:Connect(function(movement)
								if movement.UserInputType == Enum.UserInputType.MouseMovement or movement.UserInputType == Enum.UserInputType.Touch then
									updateSlider(movement)
								end
							end)
						end
					end)
																
					button.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							updateSlider(input)
							if connection then
								connection:Disconnect()
							end
						end
					end)
					uis.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
if connection then
								connection:Disconnect()
							end
																		end
																	end)
					return sliderObj
				end
				return moduleObj
			end
            return pageObj
        end

		local settingsFrame, settingsBtn = addPage("CFG", tabs, mainFrame, pageLayout, decor, "rbxasset://LuaPackages/Packages/_Index/FoundationImages/FoundationImages/SpriteSheets/img_set_2x_25.png")
		local settingsBtn_AspectRatio = Instance.new("UIAspectRatioConstraint")
		settingsBtn_AspectRatio.AspectRatio = 1
		settingsBtn_AspectRatio.Parent = settingsBtn
		settingsBtn.LayoutOrder = 10
		settingsBtn.ImageRectOffset = Vector2.new(0,370)
		settingsBtn.ImageRectSize = Vector2.new(72,72)

		local settingsPage = self:CreatePage({name="CFG"}, {settingsFrame,settingsBtn})

		local settingsModule = settingsPage:CreateModule({name="Settings", size=UDim2.new(1,0,0.5,0)})

		local resetSizeButton = settingsModule:CreateButton({name="Reset Size"})
		resetSizeButton.Changed:Connect(function()
			canvasGroup.Size = self.size
		end)
		
		settingsModule:CreateInput({name="Theme", text= "Loaded Theme: " .. (self.theme.name or "Unnamed"), editable=false})
		settingsModule:CreateInput({name="Credits", text="UI Lib: tarneks/pwngd", editable=false})

		self.SettingsPage = settingsPage

		task.spawn(function()
			if self.theme.animations then
				local function spawnShine(parent)
					local thing = Instance.new("Frame")
					thing.Size = UDim2.fromScale(1, 1)
					thing.BackgroundTransparency = 0
					thing.BackgroundColor3 = Color3.new(1,1,1)
	
					local gradient = Instance.new("UIGradient")
					local ti = TweenInfo.new(0.5*self.theme.animationSpeed, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)
					local offset1 = {Offset = Vector2.new(1.5, 0)}
					local create = ts:Create(gradient, ti, offset1)
					local startingPos = Vector2.new(-1, 0)
					
					gradient.Rotation = 45
					gradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.new(1.000000, 1.000000, 1.000000)),
						ColorSequenceKeypoint.new(1, Color3.new(1.000000, 1.000000, 1.000000)),
					}
					gradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(0.5, 0.5),
						NumberSequenceKeypoint.new(1, 1),
					}
					gradient.Offset = startingPos
					gradient.Parent = thing
					thing.ZIndex = 999999999
					thing.Parent = parent
	
					create:Play()
					create.Completed:Wait()
					thing:Destroy()
				end
				
				ts:Create(canvasGroup, TweenInfo.new(0.2*self.theme.animationSpeed), {GroupTransparency=0}):Play()
				spawnShine(canvasGroup)
			end
		end)

		return self
	end
	return lib
end)
return lib