
local _detalhes = 		_G._detalhes
local AceLocale = LibStub ("AceLocale-3.0")
local Loc = AceLocale:GetLocale ( "Details" )

local gump = 			_detalhes.gump
local _
--lua locals
local _math_floor= math.floor
local _type = type
local _math_abs = math.abs
local _tinsert = tinsert
local _unpack = unpack
local _ipairs = ipairs
local _table_wipe = table.wipe
local _table_insert = table.insert
local _math_max = math.max
--api locals
local _GetScreenWidth = GetScreenWidth
local _GetScreenHeight = GetScreenHeight
local _UIParent = UIParent
local _CreateFrame = CreateFrame
local _UISpecialFrames = UISpecialFrames

function DetailsCreateCoolTip()

	if (_G.GameCooltip) then
		return _G.GameCooltip
	end

----------------------------------------------------------------------
	--> Cooltip Startup
----------------------------------------------------------------------

	--> Start Cooltip Table
		local CoolTip = {}
		_G.GameCooltip = CoolTip
	
	--> Containers
		CoolTip.LeftTextTable = {}
		CoolTip.LeftTextTableSub = {}
		CoolTip.RightTextTable = {}
		CoolTip.RightTextTableSub = {}
		CoolTip.LeftIconTable = {}
		CoolTip.LeftIconTableSub = {}
		CoolTip.RightIconTable = {}
		CoolTip.RightIconTableSub = {}
		CoolTip.Banner = {false, false, false}
		CoolTip.TopIconTableSub = {}
		CoolTip.StatusBarTable = {}
		CoolTip.StatusBarTableSub = {}
		
		CoolTip.FunctionsTableMain = {} --> menus
		CoolTip.FunctionsTableSub = {} --> menus
		CoolTip.ParametersTableMain = {} --> menus
		CoolTip.ParametersTableSub = {} --> menus
		
		CoolTip.FixedValue = nil --> menus
		CoolTip.SelectedIndexMain = nil --> menus
		CoolTip.SelectedIndexSec = {} --> menus

	
	--options table
		CoolTip.OptionsList = {
			["IconSize"] = true,
			["HeightAnchorMod"] = true,
			["WidthAnchorMod"] = true,
			["MinWidth"] = true,
			["FixedWidth"] = true,
			["FixedHeight"] = true,
			["FixedWidthSub"] = true,
			["FixedHeightSub"] = true,
			["IgnoreSubMenu"] = true,
			["TextHeightMod"] = true,
			["ButtonHeightMod"] = true,
			["ButtonHeightModSub"] = true,
			["YSpacingMod"] = true,
			["YSpacingModSub"] = true,
			["ButtonsYMod"] = true,
			["ButtonsYModSub"] = true,
			["IconHeightMod"] = true,
			["StatusBarHeightMod"] = true,
			["StatusBarTexture"] = true,
			["TextSize"] = true,
			["TextFont"] = true,
			["NoFade"] = true,
			["MyAnchor"] = true,
			["Anchor"] = true,
			["RelativeAnchor"] = true,
			["NoLastSelectedBar"] = true,
			["SubMenuIsTooltip"] = true,
			["LeftBorderSize"] = true,
			["RightBorderSize"] = true
			
		}
		CoolTip.OptionsTable = {
			["IconSize"] = nil,
			["HeightAnchorMod"] = nil,
			["WidthAnchorMod"] = nil,
			["MinWidth"] = nil,
			["FixedWidth"] = nil,
			["FixedHeight"] = nil,
			["FixedWidthSub"] = nil,
			["FixedHeightSub"] = nil,
			["IgnoreSubMenu"] = nil,
			["TextHeightMod"] = nil,
			["ButtonHeightMod"] = nil,
			["ButtonHeightModSub"] = nil,
			["YSpacingMod"] = nil,
			["YSpacingModSub"] = nil,
			["ButtonsYMod"] = nil,
			["ButtonsYModSub"] = nil,
			["IconHeightMod"] = nil,
			["StatusBarHeightMod"] = nil,
			["StatusBarTexture"] = nil,
			["TextSize"] = nil,
			["TextFont"] = nil,
			["NoFade"] = nil,
			["MyAnchor"] = nil,
			["Anchor"] = nil,
			["RelativeAnchor"] = nil,
			["NoLastSelectedBar"] = nil,
			["SubMenuIsTooltip"] = nil,
			["LeftBorderSize"] = nil,
			["RightBorderSize"] = nil
		}
	
		--cprops
		CoolTip.Indexes = 0 --> amount of lines current on shown
		CoolTip.IndexesSub = {} --> amount of lines current on shown
		CoolTip.HaveSubMenu = false --> amount of lines current on shown
		CoolTip.SubIndexes = 0 --> amount of lines current on shown on sub menu
		CoolTip.Type = 1 --> 1 tooltip 2 tooltip with bars 3 menu 4 menu + submenus
		CoolTip.Host = nil --> frame to anchor
		CoolTip.LastSize = 0 --> last size
		
		CoolTip.LastIndex = 0
		
		--defaults
		CoolTip.default_height = 20
		CoolTip.default_text_size = 10.5
		CoolTip.default_text_font = "GameFontHighlight"
		
	--> Create Frames
	
		--> main frame
		local frame1 = CreateFrame ("Frame", "CoolTipFrame1", UIParent, "CooltipMainFrameTemplate")
		tinsert (UISpecialFrames, "CoolTipFrame1")
		gump:CreateFlashAnimation (frame1)
		
		--> secondary frame
		local frame2 = CreateFrame ("Frame", "CoolTipFrame2", UIParent, "CooltipMainFrameTemplate")
		tinsert (UISpecialFrames, "CoolTipFrame2")
		gump:CreateFlashAnimation (frame2)
		
		frame2:SetPoint ("bottomleft", frame1, "bottomright")
	
		CoolTip.frame1 = frame1
		CoolTip.frame2 = frame2
		gump:Fade (frame1, 0)
		gump:Fade (frame2, 0)

		--> button containers
		frame1.Lines = {}
		frame2.Lines = {}

----------------------------------------------------------------------
	--> Title Function 
----------------------------------------------------------------------

		function CoolTip:SetTitle (_f, text)
			if (_f == 1) then
				CoolTip.title1 = true
				CoolTip.title_text = text
			end
		end

		function CoolTip:SetTitleAnchor (_f, _anchor, ...)
			_anchor = string.lower (_anchor)
			if (_f == 1) then
				self.frame1.titleIcon:ClearAllPoints()
				self.frame1.titleText:ClearAllPoints()
				
				if (_anchor == "left") then
					self.frame1.titleIcon:SetPoint ("left", frame1, "left", ...)
					self.frame1.titleText:SetPoint ("left", frame1.titleIcon, "right")
					
				elseif (_anchor == "center") then
					self.frame1.titleIcon:SetPoint ("center", frame1, "center")
					self.frame1.titleIcon:SetPoint ("bottom", frame1, "top")
					self.frame1.titleText:SetPoint ("left", frame1.titleIcon, "right")
					self.frame1.titleText:SetText ("TESTE")
					
					self.frame1.titleText:Show()
					self.frame1.titleIcon:Show()
					
				elseif (_anchor == "right") then
					self.frame1.titleIcon:SetPoint ("right", frame1, "right", ...)
					self.frame1.titleText:SetPoint ("right", frame1.titleIcon, "left")
					
				end
			elseif (_f == 2) then
				self.frame2.titleIcon:ClearAllPoints()
				self.frame2.titleText:ClearAllPoints()
				if (_anchor == "left") then
					self.frame2.titleIcon:SetPoint ("left", frame2, "left", ...)
					self.frame2.titleText:SetPoint ("left", frame2.titleIcon, "right")
				elseif (_anchor == "center") then
					self.frame2.titleIcon:SetPoint ("center", frame2, "center", ...)
					self.frame2.titleText:SetPoint ("left", frame2.titleIcon, "right")
				elseif (_anchor == "right") then
					self.frame2.titleIcon:SetPoint ("right", frame2, "right", ...)
					self.frame2.titleText:SetPoint ("right", frame2.titleIcon, "left")
				end
			end
		end
		
----------------------------------------------------------------------
	--> Button Hide and Show Functions
----------------------------------------------------------------------

		local elapsedTime = 0
	
		CoolTip.mouseOver = false
		CoolTip.buttonClicked = false
		
		frame1:SetScript ("OnEnter", function (self)
			if (CoolTip.Type ~= 1 and CoolTip.Type ~= 2) then
				CoolTip.active = true
				CoolTip.mouseOver = true
				self:SetScript ("OnUpdate", nil)
				gump:Fade (self, 0)
				--rever
				if (CoolTip.sub_menus) then
					gump:Fade (frame2, 0)
				end
			end
		end)
		
		frame2:SetScript ("OnEnter", function (self)
			if (CoolTip.OptionsTable.SubMenuIsTooltip) then
				return CoolTip:Close()
			end
			if (CoolTip.Type ~= 1 and CoolTip.Type ~= 2) then
				CoolTip.active = true
				CoolTip.mouseOver = true
				self:SetScript ("OnUpdate", nil)
				gump:Fade (self, 0)
				gump:Fade (frame1, 0)
			end
		end)

		local OnLeaveUpdateFrame1 = function (self, elapsed)
					elapsedTime = elapsedTime+elapsed
					if (elapsedTime > 0.7) then
						if (not CoolTip.active and not CoolTip.buttonClicked and self == CoolTip.Host) then
							gump:Fade (self, 1)
							gump:Fade (frame2, 1)
						elseif (not CoolTip.active) then
							gump:Fade (self, 1)
							gump:Fade (frame2, 1)
						end
						self:SetScript ("OnUpdate", nil)
						frame2:SetScript ("OnUpdate", nil)
					end
				end
		
		frame1:SetScript ("OnLeave", function (self)
		
			if (CoolTip.Type ~= 1 and CoolTip.Type ~= 2) then
				CoolTip.active = false
				CoolTip.mouseOver = false
				elapsedTime = 0
				self:SetScript ("OnUpdate", OnLeaveUpdateFrame1)
			else
				CoolTip.active = false
				CoolTip.mouseOver = false
				elapsedTime = 0
				self:SetScript ("OnUpdate", OnLeaveUpdateFrame1)
			end
		end)
		
		local OnLeaveUpdateFrame2 = function (self, elapsed)
					elapsedTime = elapsedTime+elapsed
					if (elapsedTime > 0.7) then
						if (not CoolTip.active and not CoolTip.buttonClicked and self == CoolTip.Host) then
							gump:Fade (self, 1)
							gump:Fade (frame2, 1)
						elseif (not CoolTip.active) then
							gump:Fade (self, 1)
							gump:Fade (frame2, 1)
						end
						self:SetScript ("OnUpdate", nil)
						frame1:SetScript ("OnUpdate", nil)
					end
				end
		
		frame2:SetScript ("OnLeave", function (self)
			if (CoolTip.Type ~= 1 and CoolTip.Type ~= 2) then
				CoolTip.active = false
				CoolTip.mouseOver = false
				elapsedTime = 0
				self:SetScript ("OnUpdate", OnLeaveUpdateFrame2)
			else
				CoolTip.active = false
				CoolTip.mouseOver = false
				elapsedTime = 0
				self:SetScript ("OnUpdate", OnLeaveUpdateFrame2)
			
			end
		end)	

		frame1:SetScript ("OnHide", function (self)
			--[[ --> avoid taint errors
			if (not frame1.hidden) then --> significa que foi fechado com ESC
				frame1:Show()
				gump:Fade (frame1, 1)
			end
			if (not frame2.hidden) then --> significa que foi fechado com ESC
				frame2:Show()
				gump:Fade (frame2, 1)
			end
			--]]
			CoolTip.active = false
			CoolTip.buttonClicked = false
			CoolTip.mouseOver = false
		end)
	
	
----------------------------------------------------------------------
	--> Button Creation Functions
----------------------------------------------------------------------
	
		function GameCooltipButtonMouseDown (button)
			button.leftText:SetPoint ("center", button.leftIcon, "center", 0, 0)
			button.leftText:SetPoint ("left", button.leftIcon, "right", 4, -1)
		end
		
		function GameCooltipButtonMouseUp (button)
			button.leftText:SetPoint ("center", button.leftIcon, "center", 0, 0)
			button.leftText:SetPoint ("left", button.leftIcon, "right", 3, 0)
		end
	
		function CoolTip:CreateButton (index, frame, name)
			local new_button = CreateFrame ("Button", name, frame, "CooltipButtonTemplate")
			frame.Lines [index] = new_button
			return new_button
		end

		local OnEnterUpdateButton = function (self, elapsed)
									elapsedTime = elapsedTime+elapsed
									if (elapsedTime > 0.001) then
										--> search key: ~onenterupdatemain
										CoolTip:ShowSub (self.index)
										CoolTip.last_button = self.index
										self:SetScript ("OnUpdate", nil)
									end
								end
								
		local OnLeaveUpdateButton = function (self, elapsed)
								elapsedTime = elapsedTime+elapsed
								if (elapsedTime > 0.7) then
									if (not CoolTip.active and not CoolTip.buttonClicked) then
										gump:Fade (frame1, 1)
										gump:Fade (frame2, 1)
							
									elseif (not CoolTip.active) then
										gump:Fade (frame1, 1)
										gump:Fade (frame2, 1)
									end
									frame1:SetScript ("OnUpdate", nil)
								end
							end
		
		function CoolTip:NewMainButton (i)
			local botao = CoolTip:CreateButton (i, frame1, "CooltipMainButton"..i)
			
			--> serach key: ~onenter
			botao:SetScript ("OnEnter", function()
							if (CoolTip.Type ~= 1 and CoolTip.Type ~= 2) then
								CoolTip.active = true
								CoolTip.mouseOver = true

								frame1:SetScript ("OnUpdate", nil)
								frame2:SetScript ("OnUpdate", nil)

								botao.background:Show()

								if (CoolTip.IndexesSub [botao.index] and CoolTip.IndexesSub [botao.index] > 0) then
									if (CoolTip.OptionsTable.SubMenuIsTooltip) then
										CoolTip:ShowSub (botao.index)
										botao.index = i
									else
										if (CoolTip.last_button) then
											CoolTip:ShowSub (CoolTip.last_button)
										else
											CoolTip:ShowSub (botao.index)
										end
										elapsedTime = 0
										botao.index = i
										botao:SetScript ("OnUpdate", OnEnterUpdateButton)									
									end

								else
									--hide second frame
									gump:Fade (frame2, 1)
									CoolTip.last_button = nil
								end
							else
								CoolTip.mouseOver = true
							end
						end)
						
			botao:SetScript ("OnLeave", function()
							if (CoolTip.Type ~= 1 and CoolTip.Type ~= 2) then
								CoolTip.active = false
								CoolTip.mouseOver = false
								botao:SetScript ("OnUpdate", nil)
								
								botao.background:Hide()
								
								elapsedTime = 0
								frame1:SetScript ("OnUpdate", OnLeaveUpdateButton)
								--CoolTip:HideSub (i)
							else
								CoolTip.active = false
								elapsedTime = 0
								frame1:SetScript ("OnUpdate", OnLeaveUpdateButton)
								CoolTip.mouseOver = false
							end
			end)	
			
			return botao
		end
		
		local OnLeaveUpdateButtonSec = function (self, elapsed)
								elapsedTime = elapsedTime+elapsed
								if (elapsedTime > 0.7) then
									if (not CoolTip.active and not CoolTip.buttonClicked) then
										gump:Fade (frame1, 1)
										gump:Fade (frame2, 1)
									elseif (not CoolTip.active) then
										gump:Fade (frame1, 1)
										gump:Fade (frame2, 1)
									end
									frame2:SetScript ("OnUpdate", nil)
								end
							end
		
		function CoolTip:NewSecondaryButton (i)
			local botao = CoolTip:CreateButton (i, frame2, "CooltipSecButton"..i)
			
			botao:SetScript ("OnEnter", function()
							if (CoolTip.OptionsTable.SubMenuIsTooltip) then
								return CoolTip:Close()
							end
							if (CoolTip.Type ~= 1 and CoolTip.Type ~= 2) then
								CoolTip.active = true
								CoolTip.mouseOver = true
								
								botao.background:Show()
								
								frame1:SetScript ("OnUpdate", nil)
								frame2:SetScript ("OnUpdate", nil)
								
								gump:Fade (frame1, 0)
								gump:Fade (frame2, 0)
							else
								CoolTip.mouseOver = true
							end
						end)

			botao:SetScript ("OnLeave", function()
							if (CoolTip.Type ~= 1 and CoolTip.Type ~= 2) then
								CoolTip.active = false
								CoolTip.mouseOver = false
								
								botao.background:Hide()
								
								elapsedTime = 0
								frame2:SetScript ("OnUpdate", OnLeaveUpdateButtonSec)
							else
								CoolTip.active = false
								CoolTip.mouseOver = false
								elapsedTime = 0
								frame2:SetScript ("OnUpdate", OnLeaveUpdateButtonSec)
							end
			end)
			
			return botao
		end	
		
----------------------------------------------------------------------
	--> Button Click Functions
----------------------------------------------------------------------
		
		local OnClickFunctionButtonPrincipal = function (self)
					if (CoolTip.IndexesSub [self.index] and CoolTip.IndexesSub [self.index] > 0) then
						CoolTip:ShowSub (self.index)
						CoolTip.last_button = self.index
					end
					
					CoolTip.buttonClicked = true
					frame1.selected:SetPoint ("top", self, "top", 0, -1)
					frame1.selected:SetPoint ("bottom", self, "bottom")
					if (not CoolTip.OptionsTable.NoLastSelectedBar) then
						frame1.selected:Show()
					end
					CoolTip.SelectedIndexMain = self.index
					
					if (CoolTip.FunctionsTableMain [self.index]) then
						local parameterTable = CoolTip.ParametersTableMain [self.index]
						CoolTip.FunctionsTableMain [self.index] (_, CoolTip.FixedValue, parameterTable [1], parameterTable [2], parameterTable [3])
					end
				end
				
		local OnClickFunctionButtonSecundario = function (self)
					CoolTip.buttonClicked = true
					frame2.selected:SetPoint ("top", self, "top", 0, -1)
					frame2.selected:SetPoint ("bottom", self, "bottom")
					
					--UIFrameFlash (frame2.selected, 0.05, 0.05, 0.2, true, 0, 0)
					
					if (CoolTip.FunctionsTableSub [self.mainIndex] and CoolTip.FunctionsTableSub [self.mainIndex] [self.index]) then
						local parameterTable = CoolTip.ParametersTableSub [self.mainIndex] [self.index]
						CoolTip.FunctionsTableSub [self.mainIndex] [self.index] (_, CoolTip.FixedValue, parameterTable [1], parameterTable [2], parameterTable [3])
					end
					
					local botao_p = frame1.Lines [self.mainIndex]
					frame1.selected:SetPoint ("top", botao_p, "top", 0, -1)
					frame1.selected:SetPoint ("bottom", botao_p, "bottom")
					if (not CoolTip.OptionsTable.NoLastSelectedBar) then
						frame1.selected:Show()
					end
					
					CoolTip.SelectedIndexMain = self.mainIndex
					CoolTip.SelectedIndexSec [self.mainIndex] = self.index
					
				end
		
		function CoolTip:TextAndIcon (index, frame, menuButton, leftTextTable, rightTextTable, leftIconTable, rightIconTable, isSub)
		
			--> reset width
			menuButton.leftText:SetWidth (0)
			menuButton.leftText:SetHeight (0)
			menuButton.rightText:SetWidth (0)
			menuButton.rightText:SetHeight (0)

			--> set text
			if (leftTextTable) then
				menuButton.leftText:SetText (leftTextTable [1])
				menuButton.leftText:SetTextColor (leftTextTable [2], leftTextTable [3], leftTextTable [4], leftTextTable [5])

				if (CoolTip.OptionsTable.TextSize and not leftTextTable [6]) then
					_detalhes:SetFontSize (menuButton.leftText, CoolTip.OptionsTable.TextSize)
				end
				
				if (CoolTip.OptionsTable.TextFont and not leftTextTable [7]) then
					menuButton.leftText:SetFontObject (CoolTip.OptionsTable.TextFont)
				end
				
				local face, size, flags = menuButton.leftText:GetFont()
				size = leftTextTable [6] or CoolTip.OptionsTable.TextSize or 10
				face = leftTextTable [7] or [[Fonts\FRIZQT__.TTF]]
				flags = leftTextTable [8]
				menuButton.leftText:SetFont (face, size, flags)
			else
				menuButton.leftText:SetText ("")
			end

			if (rightTextTable) then
				menuButton.rightText:SetText (rightTextTable [1])
				menuButton.rightText:SetTextColor (rightTextTable [2], rightTextTable [3], rightTextTable [4], rightTextTable [5])
				
				if (CoolTip.OptionsTable.TextSize and not rightTextTable [6]) then
					_detalhes:SetFontSize (menuButton.rightText, CoolTip.OptionsTable.TextSize)
				end
				
				if (CoolTip.OptionsTable.TextFont and not rightTextTable [7]) then
					menuButton.rightText:SetFontObject (CoolTip.OptionsTable.TextFont)
				end
				
				local face, size, flags = menuButton.rightText:GetFont()
				size = rightTextTable [6] or 10
				face = rightTextTable [7] or [[Fonts\FRIZQT__.TTF]]
				flags = rightTextTable [8]
				menuButton.rightText:SetFont (face, size, flags)
			else
				menuButton.rightText:SetText ("")
			end

			--> left icon
			if (leftIconTable and leftIconTable [1]) then
				menuButton.leftIcon:SetTexture (leftIconTable [1])
				menuButton.leftIcon:SetWidth (leftIconTable [2])
				menuButton.leftIcon:SetHeight (leftIconTable [3])
				menuButton.leftIcon:SetTexCoord (leftIconTable [4], leftIconTable [5], leftIconTable [6], leftIconTable [7])
				local ColorR, ColorG, ColorB, ColorA = gump:ParseColors (leftIconTable [8])
				menuButton.leftIcon:SetVertexColor (ColorR, ColorG, ColorB, ColorA)
				--menuButton.leftText:SetPoint ("left", menuButton.leftIcon, "right", 3, 0)
			else
				menuButton.leftIcon:SetTexture (nil)
				menuButton.leftIcon:SetWidth (3)
				menuButton.leftIcon:SetHeight (3)
				--menuButton.leftText:SetPoint ("left", menuButton.leftIcon, "left", -5, 0)
			end
			
			--> right icon
			if (rightIconTable and rightIconTable [1]) then
				menuButton.rightIcon:SetTexture (rightIconTable [1])
				menuButton.rightIcon:SetWidth (rightIconTable [2])
				menuButton.rightIcon:SetHeight (rightIconTable [3])
				menuButton.rightIcon:SetTexCoord (rightIconTable [4], rightIconTable [5], rightIconTable [6], rightIconTable [7])
				local ColorR, ColorG, ColorB, ColorA = gump:ParseColors (rightIconTable [8])
				menuButton.rightIcon:SetVertexColor (ColorR, ColorG, ColorB, ColorA)
				--menuButton.rightText:SetPoint ("right", menuButton.rightIcon, "left", -3, 0)
			else
				menuButton.rightIcon:SetTexture (nil)
				menuButton.rightIcon:SetWidth (1)
				menuButton.rightIcon:SetHeight (1)
				--menuButton.rightText:SetPoint ("right", menuButton.rightIcon, "right", 5, 0)
			end
			
			--> overwrite icon size
			if (CoolTip.OptionsTable.IconSize) then
				menuButton.leftIcon:SetWidth (CoolTip.OptionsTable.IconSize)
				menuButton.leftIcon:SetHeight (CoolTip.OptionsTable.IconSize)
				menuButton.rightIcon:SetWidth (CoolTip.OptionsTable.IconSize)
				menuButton.rightIcon:SetHeight (CoolTip.OptionsTable.IconSize)
			end
			
			if (CoolTip.Type == 2) then
				CoolTip:LeftTextSpace (menuButton)
			end
			
			--> string length
			if (not isSub) then --> main frame
				if (not CoolTip.OptionsTable.FixedWidth) then
					if (CoolTip.Type == 1 or CoolTip.Type == 2) then
						local stringWidth = menuButton.leftText:GetStringWidth() + menuButton.rightText:GetStringWidth() + menuButton.leftIcon:GetWidth() + menuButton.rightIcon:GetWidth() + 10
						if (stringWidth > frame.w) then
							frame.w = stringWidth
						end
					end
				else
					menuButton.leftText:SetWidth (CoolTip.OptionsTable.FixedWidth - menuButton.leftIcon:GetWidth() - menuButton.rightText:GetStringWidth() - menuButton.rightIcon:GetWidth() - 30)
				end
			else
				if (not CoolTip.OptionsTable.FixedWidthSub) then
					if (CoolTip.Type == 1 or CoolTip.Type == 2) then
						local stringWidth = menuButton.leftText:GetStringWidth() + menuButton.rightText:GetStringWidth() + menuButton.leftIcon:GetWidth() + menuButton.rightIcon:GetWidth()
						if (stringWidth > frame.w) then
							frame.w = stringWidth
						end
					end
				else
					menuButton.leftText:SetWidth (CoolTip.OptionsTable.FixedWidthSub - menuButton.leftIcon:GetWidth() - 20)
				end
			end
			
			local height = _math_max ( menuButton.leftIcon:GetHeight(), menuButton.rightIcon:GetHeight(), menuButton.leftText:GetStringHeight(), menuButton.rightText:GetStringHeight() )
			if (height > frame.hHeight) then
				frame.hHeight = height
			end
			
		end
		
		function CoolTip:RefreshSpark (menuButton)
			menuButton.spark:ClearAllPoints()
			menuButton.spark:SetPoint ("LEFT", menuButton.statusbar, "LEFT", (menuButton.statusbar:GetValue() * (menuButton.statusbar:GetWidth() / 100)) - 3, 0)
			menuButton.spark2:ClearAllPoints()
			menuButton.spark2:SetPoint ("left", menuButton.statusbar, "left", menuButton.statusbar:GetValue() * (menuButton.statusbar:GetWidth()/100) - 16, 0)
		end
		
		function CoolTip:StatusBar (menuButton, StatusBar)
		
			if (StatusBar) then
			
				menuButton.statusbar:SetValue (StatusBar [1])
				menuButton.statusbar:SetStatusBarColor (StatusBar [2], StatusBar [3], StatusBar [4], StatusBar [5])
				menuButton.statusbar:SetHeight (20 + (CoolTip.OptionsTable.StatusBarHeightMod or 0))
				
				menuButton.spark2:Hide()
				if (StatusBar [6]) then
					menuButton.spark:Show()
					--menuButton.spark:ClearAllPoints()
					--menuButton.spark:SetPoint ("LEFT", menuButton.statusbar, "LEFT", (StatusBar [1] * (menuButton.statusbar:GetWidth() / 100)) - 3, 0)
				else
					menuButton.spark:Hide()
				end
				
				if (StatusBar [7]) then
					menuButton.statusbar2:SetValue (StatusBar[7].value)
					menuButton.statusbar2.texture:SetTexture (StatusBar[7].texture or [[Interface\AddOns\Details\images\bar4_reverse]])
					if (StatusBar[7].specialSpark) then
						menuButton.spark2:Show()
					end
					if (StatusBar[7].color) then
						local ColorR, ColorG, ColorB, ColorA = gump:ParseColors (StatusBar[7].color)
						menuButton.statusbar2:SetStatusBarColor (ColorR, ColorG, ColorB, ColorA)
					else
						menuButton.statusbar2:SetStatusBarColor (1, 1, 1, 1)
					end
				else
					menuButton.statusbar2:SetValue (0)
					menuButton.spark2:Hide()
				end
				
				if (CoolTip.OptionsTable.StatusBarTexture) then
					menuButton.statusbar.texture:SetTexture (CoolTip.OptionsTable.StatusBarTexture)
				else
					menuButton.statusbar.texture:SetTexture ("Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar")
				end

			else
				menuButton.statusbar:SetValue (0)
				menuButton.statusbar2:SetValue (0)
				menuButton.spark:Hide()
				menuButton.spark2:Hide()
			end

			if (CoolTip.OptionsTable.LeftBorderSize) then
				menuButton.statusbar:SetPoint ("left", menuButton, "left", 10 + CoolTip.OptionsTable.LeftBorderSize, 0)
			else
				menuButton.statusbar:SetPoint ("left", menuButton, "left", 10, 0)
			end
			
			if (CoolTip.OptionsTable.RightBorderSize) then
				menuButton.statusbar:SetPoint ("right", menuButton, "right", CoolTip.OptionsTable.RightBorderSize + (- 10), 0)
			else
				menuButton.statusbar:SetPoint ("right", menuButton, "right", -10, 0)
			end
		end
		
		function CoolTip:SetupMainButton (menuButton, index)
			menuButton.index = index
			
			--> setup texts and icons
			CoolTip:TextAndIcon (index, frame1, menuButton, CoolTip.LeftTextTable [index], CoolTip.RightTextTable [index], CoolTip.LeftIconTable [index], CoolTip.RightIconTable [index])
			--> setup statusbar
			CoolTip:StatusBar (menuButton, CoolTip.StatusBarTable [index])

			--> click
			menuButton:RegisterForClicks ("LeftButtonDown")
			
			--> string length
			if (not CoolTip.OptionsTable.FixedWidth) then
				local stringWidth = menuButton.leftText:GetStringWidth() + menuButton.rightText:GetStringWidth() + menuButton.leftIcon:GetWidth() + menuButton.rightIcon:GetWidth()
				if (stringWidth > frame1.w) then
					frame1.w = stringWidth
				end
			end
			
			--> register click function
			menuButton:SetScript ("OnClick", OnClickFunctionButtonPrincipal)
			menuButton:Show()
		end

		function CoolTip:SetupSecondaryButton (menuButton, index, mainMenuIndex)
			
			menuButton.index = index
			menuButton.mainIndex = mainMenuIndex
			
			--> setup texts and icons
			CoolTip:TextAndIcon (index, frame2, menuButton, CoolTip.LeftTextTableSub [mainMenuIndex] and CoolTip.LeftTextTableSub [mainMenuIndex] [index],
			CoolTip.RightTextTableSub [mainMenuIndex] and CoolTip.RightTextTableSub [mainMenuIndex] [index], 
			CoolTip.LeftIconTableSub [mainMenuIndex] and CoolTip.LeftIconTableSub [mainMenuIndex] [index], 
			CoolTip.RightIconTableSub [mainMenuIndex] and CoolTip.RightIconTableSub [mainMenuIndex] [index], true)
			--> setup statusbar
			CoolTip:StatusBar (menuButton, CoolTip.StatusBarTable [mainMenuIndex] and CoolTip.StatusBarTable [mainMenuIndex] [index])

			--> click
			menuButton:RegisterForClicks ("LeftButtonDown")
			
			menuButton:ClearAllPoints()
			menuButton:SetPoint ("center", frame2, "center")
			menuButton:SetPoint ("top", frame2, "top", 0, (((index-1)*20)*-1)-3)
			menuButton:SetPoint ("left", frame2, "left")
			menuButton:SetPoint ("right", frame2, "right")
			
			gump:Fade (menuButton, 0)
			
			--> string length
			local stringWidth = menuButton.leftText:GetStringWidth() + menuButton.rightText:GetStringWidth() + menuButton.leftIcon:GetWidth() + menuButton.rightIcon:GetWidth()
			if (stringWidth > frame2.w) then
				frame2.w = stringWidth
			end

			menuButton:SetScript ("OnClick", OnClickFunctionButtonSecundario)
			menuButton:Show()

			return true
		end
	
	-- -- --------------------------------------------------------------------------------------------------------------
	
	function CoolTip:ShowSub (index)
	
		if (CoolTip.OptionsTable.IgnoreSubMenu) then
			gump:Fade (frame2, 1)
			return
		end
	
		frame2:SetHeight (6)
		
		local amtIndexes = CoolTip.IndexesSub [index]
		if (not amtIndexes) then
			--print ("Sub menu called but sub menu indexes is nil")
			return
		end
		
		if (CoolTip.OptionsTable.FixedWidthSub) then
			frame2:SetWidth (CoolTip.OptionsTable.FixedWidthSub)
		end
		
		frame2.h = CoolTip.IndexesSub [index] * 20
		frame2.hHeight = 0
		frame2.w = 0
		
		--> pegar a fontsize da label principal
		local mainButton = frame1.Lines [index]
		local fontSize = _detalhes:GetFontSize (mainButton.leftText)
		
		local GotChecked = false
		
		for i = 1, CoolTip.IndexesSub [index] do
		
			local button = frame2.Lines [i]
			
			if (not button) then
				button = CoolTip:NewSecondaryButton (i)
			end
			
			local checked = CoolTip:SetupSecondaryButton (button, i, index)
			if (checked) then
				GotChecked = true
			end
		end
		
		local selected = CoolTip.SelectedIndexSec [index]
		if (selected) then
			frame2.selected:SetPoint ("top", frame2.Lines [selected], "top", 0, -1)
			frame2.selected:SetPoint ("bottom", frame2.Lines [selected], "bottom")
			if (not CoolTip.OptionsTable.NoLastSelectedBar) then
				frame2.selected:Show()
			end
		else
			frame2.selected:Hide()
		end
		
		for i = CoolTip.IndexesSub [index] + 1, #frame2.Lines do 
			gump:Fade (frame2.Lines[i], 1)
		end
		
		--[
			local spacing = 0
			if (CoolTip.OptionsTable.YSpacingModSub) then
				spacing = CoolTip.OptionsTable.YSpacingModSub
			end
			
			--> normalize height of all rows
			for i = 1, CoolTip.IndexesSub [index] do
				local menuButton = frame2.Lines [i]
				--> height
				menuButton:SetHeight (frame2.hHeight + (CoolTip.OptionsTable.ButtonHeightModSub or 0))
				--> points
				menuButton:ClearAllPoints()
				menuButton:SetPoint ("center", frame2, "center")
				menuButton:SetPoint ("top", frame2, "top", 0, ( ( (i-1) * frame2.hHeight) * -1) - 4 + (CoolTip.OptionsTable.ButtonsYModSub or 0) + spacing)
				if (CoolTip.OptionsTable.YSpacingModSub) then
					spacing = spacing + CoolTip.OptionsTable.YSpacingModSub
				end
				menuButton:SetPoint ("left", frame2, "left")
				menuButton:SetPoint ("right", frame2, "right")
			end
		--]]
		
		frame2:SetHeight ( (frame2.hHeight * CoolTip.IndexesSub [index]) + 12 + (-spacing))
		
		if (CoolTip.TopIconTableSub [index]) then
			local upperImageTable = CoolTip.TopIconTableSub [index]
			frame2.upperImage:SetTexture (upperImageTable [1])
			frame2.upperImage:SetWidth (upperImageTable [2])
			frame2.upperImage:SetHeight (upperImageTable [3])
			frame2.upperImage:SetTexCoord (upperImageTable[4], upperImageTable[5], upperImageTable[6], upperImageTable[7])
			frame2.upperImage:Show()
		else
			frame2.upperImage:Hide()
		end
		
		if (not CoolTip.OptionsTable.FixedWidthSub) then
			frame2:SetWidth (frame2.w + 44)
		end
		
		gump:Fade (frame2, 0)
		
	end
	
	function CoolTip:HideSub()
		gump:Fade (frame2, 1)
	end	
	

	function CoolTip:LeftTextSpace (row)
		row.leftText:SetWidth (row:GetWidth() - 30 - row.leftIcon:GetWidth() - row.rightIcon:GetWidth() - row.rightText:GetStringWidth())
		row.leftText:SetHeight (10)
	end

	function CoolTip:monta_tooltip()
		
		--> hide sub frame
		gump:Fade (frame2, 1)
		--> hide select bar
		gump:Fade (frame1.selected, 1)

		frame1:EnableMouse (false)
		
		--> elevator
		local yDown = 5
		--> width
		if (CoolTip.OptionsTable.FixedWidth) then
			frame1:SetWidth (CoolTip.OptionsTable.FixedWidth)
		end
		
		frame1.w = CoolTip.OptionsTable.FixedWidth or 0
		frame1.hHeight = 0
		frame2.hHeight = 0
		
		CoolTip.active = true

		for i = 1, CoolTip.Indexes do
		
			local button = frame1.Lines [i]
			if (not button) then
				button = CoolTip:NewMainButton (i)
			end
			
			button.index = i
			
			--> basic stuff
			button:Show()
			button.background:Hide()
			button:SetHeight (CoolTip.OptionsTable.ButtonHeightMod or CoolTip.default_height)
			button:RegisterForClicks()

			--> setup texts and icons
			CoolTip:TextAndIcon (i, frame1, button, CoolTip.LeftTextTable [i], CoolTip.RightTextTable [i], CoolTip.LeftIconTable [i], CoolTip.RightIconTable [i])
			--> setup statusbar
			CoolTip:StatusBar (button, CoolTip.StatusBarTable [i])
		end
		
		--> hide unused lines
		for i = CoolTip.Indexes+1, #frame1.Lines do 
			frame1.Lines[i]:Hide()
		end
		CoolTip.NumLines = CoolTip.Indexes

		local spacing = 0
		if (CoolTip.OptionsTable.YSpacingMod) then
			spacing = CoolTip.OptionsTable.YSpacingMod
		end
		
		--> normalize height of all rows
		for i = 1, CoolTip.Indexes do 
			local menuButton = frame1.Lines [i]
			--> height
			menuButton:SetHeight (frame1.hHeight + (CoolTip.OptionsTable.ButtonHeightMod or 0))
			--> points
			menuButton:ClearAllPoints()
			menuButton:SetPoint ("center", frame1, "center")
			menuButton:SetPoint ("left", frame1, "left")
			menuButton:SetPoint ("right", frame1, "right")
			menuButton:SetPoint ("top", frame1, "top", 0, ( ( (i-1) * frame1.hHeight) * -1) - 6 + (CoolTip.OptionsTable.ButtonsYMod or 0) + spacing)
			if (CoolTip.OptionsTable.YSpacingMod) then
				spacing = spacing + CoolTip.OptionsTable.YSpacingMod
			end
			
			menuButton:EnableMouse (false)
		end
		
		if (not CoolTip.OptionsTable.FixedWidth) then
			if (CoolTip.Type == 2) then --> with bars
				if (CoolTip.OptionsTable.MinWidth) then
					local w = frame1.w + 34
					frame1:SetWidth (math.max (w, CoolTip.OptionsTable.MinWidth))
				else
					frame1:SetWidth (frame1.w + 34)
				end
			else
				--> width stability check
				local width = frame1.w + 24
				if (width > CoolTip.LastSize-5 and width < CoolTip.LastSize+5) then
					width = CoolTip.LastSize
				else
					CoolTip.LastSize = width
				end
				
				if (CoolTip.OptionsTable.MinWidth) then
					frame1:SetWidth (math.max (width, CoolTip.OptionsTable.MinWidth))
				else
					frame1:SetWidth (width)
				end
			end
		end
		
		if (not CoolTip.OptionsTable.FixedHeight) then
			frame1:SetHeight ( _math_max ( (frame1.hHeight * CoolTip.Indexes) + 12, 22 ))
		else
			frame1:SetHeight (CoolTip.OptionsTable.FixedHeight)
		end

		--> unhide frame
		gump:Fade (frame1, 0)
		CoolTip:SetMyPoint (host)
		
		--> fix sparks
		for i = 1, CoolTip.Indexes do 
			local menuButton = frame1.Lines [i]
			if (menuButton.spark:IsShown() or menuButton.spark2:IsShown()) then
				CoolTip:RefreshSpark (menuButton)
			end
		end
	end

	function CoolTip:monta_cooltip (host, instancia, options, sub_menus, icones, tamanho1, tamanho2, font, fontsize)

		if (CoolTip.Indexes == 0) then
			CoolTip:Reset()
			CoolTip:SetType ("tooltip")
			CoolTip:AddLine (Loc ["STRING_COOLTIP_NOOPTIONS"])
			CoolTip:ShowCooltip()
			return
		end
		
		if (CoolTip.OptionsTable.FixedWidth) then
			frame1:SetWidth (CoolTip.OptionsTable.FixedWidth)
		end	
		
		frame1.w = CoolTip.OptionsTable.FixedWidth or 0
		frame1.hHeight = 0
		frame2.hHeight = 0
		
		frame1:EnableMouse (true)
		
		--CoolTip.IndexesSub [CoolTip.Indexes]
		
		if (CoolTip.HaveSubMenu) then --> zera o segundo frame
			frame2.w = 0
			frame2:SetHeight (6)
			if (CoolTip.SelectedIndexMain) then
				gump:Fade (frame2, 0)
			else
				gump:Fade (frame2, 1)
			end
		else
			gump:Fade (frame2, 1)
		end
		
		CoolTip.active = true
		
		for i = 1, CoolTip.Indexes do
		
			local menuButton = frame1.Lines [i]
			if (not menuButton) then
				menuButton = CoolTip:NewMainButton (i)
			end
			
			CoolTip:SetupMainButton (menuButton, i)
			
			if (CoolTip.SelectedIndexMain and CoolTip.SelectedIndexMain == i) then
				if (CoolTip.HaveSubMenu) then
					CoolTip:ShowSub (i)
				end
			end
			
			menuButton.background:Hide()
			
			--menuButton:SetHeight (CoolTip.OptionsTable.ButtonHeightMod or CoolTip.default_height)
		end

		--> selected texture
		if (CoolTip.SelectedIndexMain) then
			frame1.selected:SetPoint ("top", frame1.Lines [CoolTip.SelectedIndexMain], "top", 0, -1)
			frame1.selected:SetPoint ("bottom", frame1.Lines [CoolTip.SelectedIndexMain], "bottom")
			if (CoolTip.OptionsTable.NoLastSelectedBar) then
				gump:Fade (frame1.selected, 1)
			else
				gump:Fade (frame1.selected, 0)
			end
		else
			gump:Fade (frame1.selected, 1)
		end

		if (CoolTip.Indexes < #frame1.Lines) then
			for i = CoolTip.Indexes+1, #frame1.Lines do
				frame1.Lines[i]:Hide()
			end
		end
		
		CoolTip.NumLines = CoolTip.Indexes

		local spacing = 0
		if (CoolTip.OptionsTable.YSpacingMod) then
			spacing = CoolTip.OptionsTable.YSpacingMod
		end
		
		--> normalize height of all rows
		for i = 1, CoolTip.Indexes do 
			local menuButton = frame1.Lines [i]
			--> height
			menuButton:SetHeight (frame1.hHeight + (CoolTip.OptionsTable.ButtonHeightMod or 0))
			--> points
			menuButton:ClearAllPoints()
			menuButton:SetPoint ("center", frame1, "center")
			menuButton:SetPoint ("top", frame1, "top", 0, ( ( (i-1) * frame1.hHeight) * -1) - 4 + (CoolTip.OptionsTable.ButtonsYMod or 0) + spacing)
			if (CoolTip.OptionsTable.YSpacingMod) then
				spacing = spacing + CoolTip.OptionsTable.YSpacingMod
			end
			menuButton:SetPoint ("left", frame1, "left")
			menuButton:SetPoint ("right", frame1, "right")
			
			menuButton:EnableMouse (true)
		end
		
		if (not CoolTip.OptionsTable.FixedWidth) then
			if (CoolTip.OptionsTable.MinWidth) then
				local w = frame1.w + 24
				frame1:SetWidth (math.max (w, CoolTip.OptionsTable.MinWidth))
			else
				frame1:SetWidth (frame1.w + 24)
			end
		end
		
		if (CoolTip.OptionsTable.FixedHeight) then
			frame1:SetHeight (CoolTip.OptionsTable.FixedHeight)
		else
			frame1:SetHeight (_math_max ( (frame1.hHeight * CoolTip.Indexes) + 12 + (-spacing), 22 ))
		end
		
		frame1:ClearAllPoints()
		CoolTip:SetMyPoint (host)
		
		if (CoolTip.title1) then
			CoolTip.frame1.titleText:Show()
			CoolTip.frame1.titleIcon:Show()
			CoolTip.frame1.titleText:SetText (CoolTip.title_text)
			CoolTip.frame1.titleIcon:SetWidth (frame1:GetWidth())
			CoolTip.frame1.titleIcon:SetHeight (40)
		end
	
		gump:Fade (frame1, 0)

		return true
	end
	
	function CoolTip:SetMyPoint (host, x_mod, y_mod)
	
		local moveX = x_mod or 0
		local moveY = y_mod or 0
		
		--> clear all points
		frame1:ClearAllPoints()
		
		local anchor = CoolTip.OptionsTable.Anchor or CoolTip.Host
		frame1:SetPoint (CoolTip.OptionsTable.MyAnchor, anchor, CoolTip.OptionsTable.RelativeAnchor, 0 + moveX + CoolTip.OptionsTable.WidthAnchorMod, 10 + CoolTip.OptionsTable.HeightAnchorMod + moveY)
		
		if (not x_mod) then
			--> check if cooltip is out of screen bounds
			local center_x = frame1:GetCenter()
			
			if (center_x) then
				local screen_x_res = GetScreenWidth()
				local half_x = frame1:GetWidth() / 2
				
				if (center_x+half_x > screen_x_res) then
					--> out of right side
					local move_to_left = (center_x + half_x) - screen_x_res
					return CoolTip:SetMyPoint (host, -move_to_left, 0)
					
				elseif (center_x-half_x < 0) then
					--> out of left side
					local move_to_right = center_x - half_x
					return CoolTip:SetMyPoint (host, move_to_right*-1, 0)
				end
			end
		end
		
		if (not y_mod) then
			--> check if cooltip is out of screen bounds
			local _, center_y = frame1:GetCenter()
			local screen_y_res = GetScreenHeight()
			local half_y = frame1:GetHeight() / 2
			
			if (center_y) then
				if (center_y+half_y > screen_y_res) then
					--> out of top side
					local move_to_down = (center_y + half_y) - screen_y_res
					return CoolTip:SetMyPoint (host, 0, -move_to_down)
				
				elseif (center_y-half_y < 0) then
					--> out of bottom side
					local move_to_up = center_y - half_y
					return CoolTip:SetMyPoint (host, 0, move_to_up*-1)
					
				end
			end
		end
	end	
	
	function CoolTip:GetText (buttonIndex)
		local button1 = frame1.Lines [buttonIndex]
		if (not button1) then
			return "", ""
		else
			return button1.leftText:GetText(), button1.rightText:GetText()
		end
	end
	
----------------------------------------------------------------------
	--> Get the number of lines current shown on cooltip
	
	function CoolTip:GetNumLines()
		return CoolTip.NumLines or 0
	end

----------------------------------------------------------------------
	--> Remove all options actived
	--> Set a option on current cooltip
	
		function CoolTip:ClearAllOptions()
			for option, _ in pairs (CoolTip.OptionsTable) do 
				CoolTip.OptionsTable [option] = nil
			end
			
			CoolTip:SetOption ("MyAnchor", "bottom")
			CoolTip:SetOption ("RelativeAnchor", "top")
			CoolTip:SetOption ("WidthAnchorMod", 0)
			CoolTip:SetOption ("HeightAnchorMod", 0)
		end
		
		function CoolTip:SetOption (option, value)
			--> check if this options exists
			if (not CoolTip.OptionsList [option]) then
				return --> error
			end
			
			--> set options
			CoolTip.OptionsTable [option] = value
		end

----------------------------------------------------------------------
	--> set the anchor of cooltip
	--> parameters: frame  [, cooltip anchor point, frame anchor point [, x mod, y mod]]
	--> frame [, x mod, y mod]
	
		--> alias
		function CoolTip:SetOwner (frame, myPoint, hisPoint, x, y)
			return CoolTip:SetHost (frame, myPoint, hisPoint, x, y)
		end
	
		function CoolTip:SetHost (frame, myPoint, hisPoint, x, y)
			--> check data integrity
			if (type (frame) ~= "table" or not frame.GetObjectType) then
				print ("host need to be a frame")
				return --> error
			end
			
			CoolTip.Host = frame
			
			--> defaults
			myPoint = myPoint or CoolTip.OptionsTable.MyAnchor or "bottom"
			hisPoint = hisPoint or CoolTip.OptionsTable.hisPoint or "top"

			x = x or CoolTip.OptionsTable.WidthAnchorMod or 0
			y = y or CoolTip.OptionsTable.HeightAnchorMod or 0
			
			--> check options
			if (type (myPoint) == "string") then
				CoolTip:SetOption ("MyAnchor", myPoint)
				CoolTip:SetOption ("WidthAnchorMod", x)
			elseif (type (myPoint) == "number") then
				CoolTip:SetOption ("HeightAnchorMod", myPoint)
			end
			
			if (type (hisPoint) == "string") then
				CoolTip:SetOption ("RelativeAnchor", hisPoint)
				CoolTip:SetOption ("HeightAnchorMod", y)
			elseif (type (hisPoint) == "number") then
				CoolTip:SetOption ("WidthAnchorMod", hisPoint)
			end
		end

----------------------------------------------------------------------
	--> set cooltip type
	--> parameters: type (1 = tooltip | 2 = tooltip with bars | 3 = menu)
	
		function CoolTip:SetType (newType)
			if (type (newType) == "string") then
				if (newType == "tooltip") then
					CoolTip.Type = 1
				elseif (newType == "tooltipbar") then
					CoolTip.Type = 2
				elseif (newType == "menu") then
					CoolTip.Type = 3
				else
					--> error
				end
			elseif (type (newType) == "number") then
				if (newType == 1) then
					CoolTip.Type = 1
				elseif (newType == 2) then
					CoolTip.Type = 2
				elseif (newType == 3) then
					CoolTip.Type = 3
				else
					--> error
				end
			else
				--> error
			end
		end
	
	--> Set a fixed value for menu
		function CoolTip:SetFixedParameter (value, injected)
			if (injected ~= nil) then
				local frame = value
				if (frame.dframework) then
					frame = frame.widget
				end
				if (frame.CoolTip) then
					frame.CoolTip.FixedValue = injected
				else
					--debug
				end
			end
			CoolTip.FixedValue = value
		end
		
		function CoolTip:SetColor (menuType, ...)
			local ColorR, ColorG, ColorB, ColorA = gump:ParseColors (...)
			if ((type (menuType) == "string" and menuType == "main") or (type (menuType) == "number" and menuType == 1)) then
				frame1.framebackground:SetVertexColor (ColorR, ColorG, ColorB, ColorA)
			elseif ((type (menuType) == "string" and menuType == "sec") or (type (menuType) == "number" and menuType == 2)) then
				frame2.framebackground:SetVertexColor (ColorR, ColorG, ColorB, ColorA)
			else
				return --> error
			end
		end
		
	--> Set last selected option
		function CoolTip:SetLastSelected (menuType, index, index2)
		
			if (CoolTip.Type == 3) then
				if ((type (menuType) == "string" and menuType == "main") or (type (menuType) == "number" and menuType == 1)) then
					CoolTip.SelectedIndexMain = index
				elseif ((type (menuType) == "string" and menuType == "sec") or (type (menuType) == "number" and menuType == 2)) then
					CoolTip.SelectedIndexSec [index] = index2
				else
					return --> error
				end
			else
				return --> error
			end
		end

		--> serack key: ~select
		function CoolTip:Select (menuType, option, mainIndex)
			if (menuType == 1) then --main menu
				local botao = frame1.Lines [option]
				CoolTip.buttonClicked = true
				frame1.selected:SetPoint ("top", botao, "top", 0, -1)
				frame1.selected:SetPoint ("bottom", botao, "bottom")
				--UIFrameFlash (frame1.selected, 0.05, 0.05, 0.2, true, 0, 0)
				
			elseif (menuType == 2) then --sub menu
				CoolTip:ShowSub (mainIndex)
				local botao = frame2.Lines [option]
				CoolTip.buttonClicked = true
				frame2.selected:SetPoint ("top", botao, "top", 0, -1)
				frame2.selected:SetPoint ("bottom", botao, "bottom")	
				--UIFrameFlash (frame2.selected, 0.05, 0.05, 0.2, true, 0, 0)
			end
		end
	
----------------------------------------------------------------------
	--> Reset cooltip
	
		--> wipe all data
		function CoolTip:Reset()
		
			CoolTip.FixedValue = nil
			CoolTip.HaveSubMenu = false
			
			CoolTip.SelectedIndexMain = nil
			_table_wipe (CoolTip.SelectedIndexSec)
			
			CoolTip.Indexes =  0
			CoolTip.SubIndexes = 0
			_table_wipe (CoolTip.IndexesSub)
			
			--> 
			
			--[
			_table_wipe (CoolTip.LeftTextTable)
			_table_wipe (CoolTip.LeftTextTableSub)
			_table_wipe (CoolTip.RightTextTable)
			_table_wipe (CoolTip.RightTextTableSub)
			
			_table_wipe (CoolTip.LeftIconTable)
			_table_wipe (CoolTip.LeftIconTableSub)
			_table_wipe (CoolTip.RightIconTable)
			_table_wipe (CoolTip.RightIconTableSub)

			_table_wipe (CoolTip.StatusBarTable)
			_table_wipe (CoolTip.StatusBarTableSub)
			
			_table_wipe (CoolTip.FunctionsTableMain)
			_table_wipe (CoolTip.FunctionsTableSub)
			
			_table_wipe (CoolTip.ParametersTableMain)
			_table_wipe (CoolTip.ParametersTableSub)
			--]]
			
			_table_wipe (CoolTip.TopIconTableSub)
			CoolTip.Banner [1] = false
			CoolTip.Banner [2] = false
			CoolTip.Banner [3] = false
			
			frame1.upperImage:Hide()
			frame1.upperImage2:Hide()
			frame1.upperImageText:Hide()
			frame1.upperImageText2:Hide()
			
			frame2.upperImage:Hide()

			CoolTip.title1 = nil
			CoolTip.title_text = nil
			
			CoolTip.frame1.titleText:Hide()
			CoolTip.frame1.titleIcon:Hide()
			
			CoolTip:ClearAllOptions()
			CoolTip:SetColor (1, "transparent")
			CoolTip:SetColor (2, "transparent")
		end

----------------------------------------------------------------------
	--> Menu functions
	
		local _default_color = {1, 1, 1}
		local _default_point = {"center", "center", 0, -3}
		
		function CoolTip:AddMenu (menuType, func, param1, param2, param3, leftText, leftIcon, indexUp)
		
			if (leftText and indexUp and ((type (menuType) == "string" and menuType == "main") or (type (menuType) == "number" and menuType == 1))) then
				CoolTip.Indexes = CoolTip.Indexes + 1
				
				if (not CoolTip.IndexesSub [CoolTip.Indexes]) then
					CoolTip.IndexesSub [CoolTip.Indexes] = 0
				end
				
				CoolTip.SubIndexes = 0
			end
		
			--> need a previous line
			if (CoolTip.Indexes == 0) then
				print ("Indexes are 0")
				return --> return error
			end
			
			--> check data integrity
			if (type (func) ~= "function") then
				print ("No function")
				return --> erroe
			end
			
			--> add
			
				if ((type (menuType) == "string" and menuType == "main") or (type (menuType) == "number" and menuType == 1)) then

					local parameterTable
					if (CoolTip.isSpecial) then
						parameterTable = {}
						_table_insert (CoolTip.FunctionsTableMain, CoolTip.Indexes, func)
						_table_insert (CoolTip.ParametersTableMain, CoolTip.Indexes, parameterTable)
					else
					
						CoolTip.FunctionsTableMain [CoolTip.Indexes] = func
						
						parameterTable = CoolTip.ParametersTableMain [CoolTip.Indexes]
						if (not parameterTable) then
							parameterTable = {}
							CoolTip.ParametersTableMain [CoolTip.Indexes] = parameterTable
						end
					end
					
					parameterTable [1] = param1
					parameterTable [2] = param2
					parameterTable [3] = param3
					
					if (leftIcon) then
						local iconTable = CoolTip.LeftIconTable [CoolTip.Indexes]
						
						if (not iconTable or CoolTip.isSpecial) then
							iconTable = {}
							CoolTip.LeftIconTable [CoolTip.Indexes] = iconTable
						end
						
						iconTable [1] = leftIcon
						iconTable [2] = 16 --> default 16
						iconTable [3] = 16 --> default 16
						iconTable [4] = 0 --> default 0
						iconTable [5] = 1 --> default 1
						iconTable [6] = 0 --> default 0
						iconTable [7] = 1 --> default 1
						iconTable [8] = _default_color
					end
					
					if (leftText) then
						local lineTable_left = CoolTip.LeftTextTable [CoolTip.Indexes]

						if (not lineTable_left or CoolTip.isSpecial) then
							lineTable_left = {}
							CoolTip.LeftTextTable [CoolTip.Indexes] = lineTable_left
						end

						lineTable_left [1] = leftText --> line text
						lineTable_left [2] = 1
						lineTable_left [3] = 1
						lineTable_left [4] = 1
						lineTable_left [5] = 1
						lineTable_left [6] = false
						lineTable_left [7] = false
						lineTable_left [8] = false

					end
					
				elseif ((type (menuType) == "string" and menuType == "sec") or (type (menuType) == "number" and menuType == 2)) then
					
					if (CoolTip.SubIndexes == 0) then
						if (not indexUp or not leftText) then
							print ("not indexUp or not leftText")
							return --> error
						end
					end
					
					if (indexUp and leftText) then
						CoolTip.SubIndexes = CoolTip.SubIndexes + 1
						CoolTip.IndexesSub [CoolTip.Indexes] = CoolTip.IndexesSub [CoolTip.Indexes] + 1
					elseif (indexUp and not leftText) then
						print ("indexUp and not leftText")
						return --> error [leftText can't be nil if indexUp are true]
					end
					
					--> menu container
					local subMenuContainerParameters = CoolTip.ParametersTableSub [CoolTip.Indexes]
					if (not subMenuContainerParameters) then
						subMenuContainerParameters = {}
						CoolTip.ParametersTableSub [CoolTip.Indexes] = subMenuContainerParameters
					end
					
					local subMenuContainerFunctions = CoolTip.FunctionsTableSub [CoolTip.Indexes]
					if (not subMenuContainerFunctions or CoolTip.isSpecial) then
						subMenuContainerFunctions = {}
						CoolTip.FunctionsTableSub [CoolTip.Indexes] = subMenuContainerFunctions
					end
					
					--> menu table
					local subMenuTablesParameters = subMenuContainerParameters [CoolTip.SubIndexes]
					if (not subMenuTablesParameters or CoolTip.isSpecial) then
						subMenuTablesParameters = {}
						subMenuContainerParameters [CoolTip.SubIndexes] = subMenuTablesParameters
					end

					--> add
					subMenuContainerFunctions [CoolTip.SubIndexes] = func
					
					subMenuTablesParameters [1] = param1
					subMenuTablesParameters [2] = param2
					subMenuTablesParameters [3] = param3
					
					--> text and icon
					if (leftIcon) then
					
						local subMenuContainerIcons = CoolTip.LeftIconTableSub [CoolTip.Indexes]
						if (not subMenuContainerIcons) then
							subMenuContainerIcons = {}
							CoolTip.LeftIconTableSub [CoolTip.Indexes] = subMenuContainerIcons
						end
						local subMenuTablesIcons = subMenuContainerIcons [CoolTip.SubIndexes]
						if (not subMenuTablesIcons or CoolTip.isSpecial) then
							subMenuTablesIcons = {}
							subMenuContainerIcons [CoolTip.SubIndexes] = subMenuTablesIcons
						end
					
						subMenuTablesIcons [1] = leftIcon
						subMenuTablesIcons [2] = 16 --> default 16
						subMenuTablesIcons [3] = 16 --> default 16
						subMenuTablesIcons [4] = 0 --> default 0
						subMenuTablesIcons [5] = 1 --> default 1
						subMenuTablesIcons [6] = 0 --> default 0
						subMenuTablesIcons [7] = 1 --> default 1
						subMenuTablesIcons [8] = _default_color
					end
					
					if (leftText) then
					
						local subMenuContainerTexts = CoolTip.LeftTextTableSub [CoolTip.Indexes]
						if (not subMenuContainerTexts) then
							subMenuContainerTexts = {}
							CoolTip.LeftTextTableSub [CoolTip.Indexes] = subMenuContainerTexts
						end
						local subMenuTablesTexts = subMenuContainerTexts [CoolTip.SubIndexes]
						if (not subMenuTablesTexts or CoolTip.isSpecial) then
							subMenuTablesTexts = {}
							subMenuContainerTexts [CoolTip.SubIndexes] = subMenuTablesTexts
						end
						
						subMenuTablesTexts [1] = leftText --> line text
						subMenuTablesTexts [2] = 1
						subMenuTablesTexts [3] = 1
						subMenuTablesTexts [4] = 1
						subMenuTablesTexts [5] = 1
						subMenuTablesTexts [6] = false
						subMenuTablesTexts [7] = false
						subMenuTablesTexts [8] = false
						
					end
					
					CoolTip.HaveSubMenu = true

				else
					return --> error
				end
		end

----------------------------------------------------------------------
	--> adds a statusbar to the last line added.
	--> only works with cooltip type 2 (tooltip with bars)
	--> parameters: value [, color red, color green, color blue, color alpha [, glow]]
	--> can also use a table or html color name in color red and send glow in color green
	
		function CoolTip:AddStatusBar (statusbarValue, frame, ColorR, ColorG, ColorB, ColorA, statusbarGlow, backgroundBar)
		
			--> need a previous line
			if (CoolTip.Indexes == 0) then
				return --> return error
			end
		
			--> check data integrity
			if (type (statusbarValue) ~= "number") then
				return --> error
			end
		
			if (type (ColorR) == "table" or type (ColorR) == "string") then
				statusbarGlow, backgroundBar, ColorR, ColorG, ColorB, ColorA = ColorG, ColorB, gump:ParseColors (ColorR)
			elseif (type (ColorR) == "boolean") then
				backgroundBar = ColorG
				statusbarGlow = ColorR
				ColorR, ColorG, ColorB, ColorA = 1, 1, 1, 1
			else
				--> error
			end
			
			--> add
			local frameTable
			local statusbarTable
			
			if (not frame or (type (frame) == "string" and frame == "main") or (type (frame) == "number" and frame == 1)) then
				frameTable = CoolTip.StatusBarTable
				
				if (CoolTip.isSpecial) then
					statusbarTable = {}
					_table_insert (frameTable, CoolTip.Indexes, statusbarTable)
				else
					statusbarTable = frameTable [CoolTip.Indexes]
					if (not statusbarTable) then
						statusbarTable = {}
						_table_insert (frameTable, CoolTip.Indexes, statusbarTable)
						--frameTable [CoolTip.Indexes] = statusbarTable
					end
				end
				
			elseif ((type (frame) == "string" and frame == "sub") or (type (frame) == "number" and frame == 2)) then
			
				frameTable = CoolTip.StatusBarTableSub
				
				local subMenuContainerStatusBar = frameTable [CoolTip.Indexes]
				if (not subMenuContainerStatusBar) then
					subMenuContainerStatusBar = {}
					frameTable [CoolTip.Indexes] = subMenuContainerStatusBar
				end
				
				if (CoolTip.isSpecial) then
					statusbarTable = {}
					_table_insert (subMenuContainerStatusBar, CoolTip.SubIndexes, statusbarTable)
				else
					statusbarTable = subMenuContainerStatusBar [CoolTip.SubIndexes]
					if (not statusbarTable) then
						statusbarTable = {}
						_table_insert (subMenuContainerStatusBar, CoolTip.SubIndexes, statusbarTable)
					end
				end
			else
				print ("unknow frame")
				return --> error
			end

			statusbarTable [1] = statusbarValue
			statusbarTable [2] = ColorR
			statusbarTable [3] = ColorG
			statusbarTable [4] = ColorB
			statusbarTable [5] = ColorA
			statusbarTable [6] = statusbarGlow
			statusbarTable [7] = backgroundBar
			
		end

		function CoolTip:SetBannerText (index, text, anchor, color, fontsize, fontface, fontflag)
			local fontstring
			
			if (index == 1) then
				fontstring = frame1.upperImageText
			elseif (index == 2) then
				fontstring = frame1.upperImageText2
			end
			
			fontstring:SetText (text or "")
			
			if (anchor and index == 1) then
				local myAnchor, hisAnchor, x, y = unpack (anchor)
				fontstring:SetPoint (myAnchor, frame1.upperImage, hisAnchor or myAnchor, x or 0, y or 0)
			elseif (anchor and index == 2) then
				local myAnchor, hisAnchor, x, y = unpack (anchor)
				fontstring:SetPoint (myAnchor, frame1, hisAnchor or myAnchor, x or 0, y or 0)
			end
			
			if (color) then
				fontstring:SetTextColor (unpack (color))
			end
			
			local face, size, flags = fontstring:GetFont()
			face = fontface or [[Fonts\FRIZQT__.TTF]]
			size = fontsize or 13
			flags = fontflag or nil
			fontstring:SetFont (face, size, flags)
			fontstring:Show()
		end
		
		function CoolTip:SetBannerImage (index, texturepath, width, height, anchor, texcoord, overlay)
			
			local texture
		
			if (index == 1) then
				texture = frame1.upperImage
			elseif (index == 2) then
				texture = frame1.upperImage2
			end
			
			if (texturepath) then
				texture:SetTexture (texturepath)
			end
			
			if (width) then
				texture:SetWidth (width)
			end
			if (height) then
				texture:SetHeight (height)
			end
			
			if (anchor) then
				if (type (anchor[1]) == "table") then
					for _, t in _ipairs (anchor) do
						local myAnchor, hisAnchor, x, y = unpack (t)
						texture:SetPoint (myAnchor, frame1, hisAnchor or myAnchor, x or 0, y or 0)
					end
				else
					local myAnchor, hisAnchor, x, y = unpack (anchor)
					texture:SetPoint (myAnchor, frame1, hisAnchor or myAnchor, x or 0, y or 0)
				end
			end
			
			if (texcoord) then
				local L, R, T, B = unpack (texcoord)
				texture:SetTexCoord (L, R, T, B)
			end
			
			if (overlay) then
				texture:SetVertexColor (unpack (overlay))
			end
			
			CoolTip.Banner [index] = true
			texture:Show()

		end
		
----------------------------------------------------------------------
	--> adds a icon to the last line added.
	--> only works with cooltip type 1 and 2 (tooltip and tooltip with bars)
	--> parameters: icon [, width [, height [, TexCoords L R T B ]]]
	--> texture support string path or texture object
	
		function CoolTip:AddTexture (iconTexture, frame, side, iconWidth, iconHeight, L, R, T, B, overlayColor, point)
			return CoolTip:AddIcon (iconTexture, frame, side, iconWidth, iconHeight, L, R, T, B, overlayColor, point)
		end
		function CoolTip:AddIcon (iconTexture, frame, side, iconWidth, iconHeight, L, R, T, B, overlayColor, point)

			--> need a previous line
			if (CoolTip.Indexes == 0) then
				return --> return error
			end
			
			--> check data integrity
			if (type (iconTexture) ~= "string" and (type (iconTexture) ~= "table" or not iconTexture.GetObjectType or iconTexture:GetObjectType() ~= "Texture") ) then
				return --> return error
			end
			
			side = side or 1

			local frameTable
			local iconTable

			if (not frame or (type (frame) == "string" and frame == "main") or (type (frame) == "number" and frame == 1)) then
			
				if (not side or (type (side) == "string" and side == "left") or (type (side) == "number" and side == 1)) then
					frameTable = CoolTip.LeftIconTable
					
				elseif ((type (side) == "string" and side == "right") or (type (side) == "number" and side == 2)) then
					frameTable = CoolTip.RightIconTable
					
				end
				
				if (CoolTip.isSpecial) then
					iconTable = {}
					_table_insert (frameTable, CoolTip.Indexes, iconTable)
				else
					iconTable = frameTable [CoolTip.Indexes]
					if (not iconTable) then
						iconTable = {}
						_table_insert (frameTable, CoolTip.Indexes, iconTable)
						--frameTable [CoolTip.Indexes] = iconTable
					end
				end
				
			elseif ((type (frame) == "string" and frame == "sub") or (type (frame) == "number" and frame == 2)) then
			
				if ((type (side) == "string" and side == "left") or (type (side) == "number" and side == 1)) then
					frameTable = CoolTip.LeftIconTableSub
				elseif ((type (side) == "string" and side == "right") or (type (side) == "number" and side == 2)) then
					frameTable = CoolTip.RightIconTableSub
				elseif ((type (side) == "string" and side == "top") or (type (side) == "number" and side == 3)) then
					CoolTip.TopIconTableSub [CoolTip.Indexes] = CoolTip.TopIconTableSub [CoolTip.Indexes] or {}
					CoolTip.TopIconTableSub [CoolTip.Indexes] [1] = iconTexture
					CoolTip.TopIconTableSub [CoolTip.Indexes] [2] = iconWidth or 16
					CoolTip.TopIconTableSub [CoolTip.Indexes] [3] = iconHeight or 16
					CoolTip.TopIconTableSub [CoolTip.Indexes] [4] = L or 0 
					CoolTip.TopIconTableSub [CoolTip.Indexes] [5] = R or 1 
					CoolTip.TopIconTableSub [CoolTip.Indexes] [6] = T or 0 
					CoolTip.TopIconTableSub [CoolTip.Indexes] [7] = B or 1
					CoolTip.TopIconTableSub [CoolTip.Indexes] [8] = overlayColor or _default_color
					return
				end
				
				local subMenuContainerIcons = frameTable [CoolTip.Indexes]
				if (not subMenuContainerIcons) then
					subMenuContainerIcons = {}
					frameTable [CoolTip.Indexes] = subMenuContainerIcons
				end
				
				if (CoolTip.isSpecial) then
					iconTable = {}
					subMenuContainerIcons [CoolTip.SubIndexes] = iconTable
				else
					iconTable = subMenuContainerIcons [CoolTip.SubIndexes]
					if (not iconTable) then
						iconTable = {}
						subMenuContainerIcons [CoolTip.SubIndexes] = iconTable
					end
				end
				
			else
				return --> error
			end

			iconTable [1] = iconTexture
			iconTable [2] = iconWidth or 16 --> default 16
			iconTable [3] = iconHeight or 16 --> default 16
			iconTable [4] = L or 0 --> default 0
			iconTable [5] = R or 1 --> default 1
			iconTable [6] = T or 0 --> default 0
			iconTable [7] = B or 1 --> default 1
			iconTable [8] = overlayColor or _default_color --> default 1, 1, 1
			
			return true
		end
	
----------------------------------------------------------------------
	--> adds a line.
	--> only works with cooltip type 1 and 2 (tooltip and tooltip with bars)
	--> parameters: left text, right text [, L color R, L color G, L color B, L color A [, R color R, R color G, R color B, R color A [, wrap]]] 
	
		--> alias
		function CoolTip:AddDoubleLine (leftText, rightText, frame, ColorR1, ColorG1, ColorB1, ColorA1, ColorR2, ColorG2, ColorB2, ColorA2, fontSize, fontFace, fontFlag)
			return CoolTip:AddLine (leftText, rightText, frame, ColorR1, ColorG1, ColorB1, ColorA1, ColorR2, ColorG2, ColorB2, ColorA2, fontSize, fontFace, fontFlag)
		end
		
		--> adds a line for tooltips
		function CoolTip:AddLine (leftText, rightText, frame, ColorR1, ColorG1, ColorB1, ColorA1, ColorR2, ColorG2, ColorB2, ColorA2, fontSize, fontFace, fontFlag)
			
			--> check data integrity
			local t = type (leftText)
			if (t ~= "string") then
				if (t == "number") then
					leftText = tostring (leftText)
				else
					leftText = ""
				end
			end
			
			local t = type (rightText)
			if (t ~= "string") then
				if (t == "number") then
					rightText = tostring (rightText)
				else
					rightText = ""
				end
			end
			
			if (type (ColorR1) ~= "number") then
				ColorR2, ColorG2, ColorB2, ColorA2, fontSize, fontFace, fontFlag = ColorG1, ColorB1, ColorA1, ColorR2, ColorG2, ColorB2, ColorA2
				
				if (type (ColorR1) == "boolean" or not ColorR1) then
					ColorR1, ColorG1, ColorB1, ColorA1 = 1, 1, 1, 1
				else
					ColorR1, ColorG1, ColorB1, ColorA1 = gump:ParseColors (ColorR1)
				end
			end
			
			if (type (ColorR2) ~= "number") then
				fontSize, fontFace, fontFlag = ColorG2, ColorB2, ColorA2
				
				if (type (ColorR2) == "boolean" or not ColorR2) then
					ColorR2, ColorG2, ColorB2, ColorA2 = 1, 1, 1, 1
				else
					ColorR2, ColorG2, ColorB2, ColorA2 = gump:ParseColors (ColorR2)
				end
			end
			
			local frameTableLeft
			local frameTableRight
			local lineTable_left
			local lineTable_right
			
			if (not frame or (type (frame) == "string" and frame == "main") or (type (frame) == "number" and frame == 1)) then
			
				CoolTip.Indexes = CoolTip.Indexes + 1
			
				if (not CoolTip.IndexesSub [CoolTip.Indexes]) then
					CoolTip.IndexesSub [CoolTip.Indexes] = 0
				end
			
				CoolTip.SubIndexes = 0
			
				frameTableLeft = CoolTip.LeftTextTable
				frameTableRight = CoolTip.RightTextTable
				
				if (CoolTip.isSpecial) then
					lineTable_left = {}
					_table_insert (frameTableLeft, CoolTip.Indexes, lineTable_left)
					lineTable_right = {}
					_table_insert (frameTableRight, CoolTip.Indexes, lineTable_right)
				else
					lineTable_left = frameTableLeft [CoolTip.Indexes]
					lineTable_right = frameTableRight [CoolTip.Indexes]
					
					if (not lineTable_left) then
						lineTable_left = {}
						_table_insert (frameTableLeft, CoolTip.Indexes, lineTable_left)
						--frameTableLeft [CoolTip.Indexes] = lineTable_left
					end
					if (not lineTable_right) then
						lineTable_right = {}
						_table_insert (frameTableRight, CoolTip.Indexes, lineTable_right)
						--frameTableRight [CoolTip.Indexes] = lineTable_right
					end
				end

			elseif ((type (frame) == "string" and frame == "sub") or (type (frame) == "number" and frame == 2)) then
			
				CoolTip.SubIndexes = CoolTip.SubIndexes + 1
				CoolTip.IndexesSub [CoolTip.Indexes] = CoolTip.IndexesSub [CoolTip.Indexes] + 1
				CoolTip.HaveSubMenu = true
				
				frameTableLeft = CoolTip.LeftTextTableSub
				frameTableRight = CoolTip.RightTextTableSub
				
				local subMenuContainerTexts = frameTableLeft [CoolTip.Indexes]
				if (not subMenuContainerTexts) then
					subMenuContainerTexts = {}
					_table_insert (frameTableLeft, CoolTip.Indexes, subMenuContainerTexts)
				end
				
				if (CoolTip.isSpecial) then
					lineTable_left = {}
					_table_insert (subMenuContainerTexts, CoolTip.SubIndexes, lineTable_left)
				else
					lineTable_left = subMenuContainerTexts [CoolTip.SubIndexes]
					if (not lineTable_left) then
						lineTable_left = {}
						--subMenuContainerTexts [CoolTip.SubIndexes] = lineTable_left
						_table_insert (subMenuContainerTexts, CoolTip.SubIndexes, lineTable_left)
					end
				end

				local subMenuContainerTexts = frameTableRight [CoolTip.Indexes]
				if (not subMenuContainerTexts) then
					subMenuContainerTexts = {}
					_table_insert (frameTableRight, CoolTip.Indexes, subMenuContainerTexts)
					--frameTableRight [CoolTip.Indexes] = subMenuContainerTexts
				end
				
				if (CoolTip.isSpecial) then
					lineTable_right = {}
					_table_insert (subMenuContainerTexts, CoolTip.SubIndexes, lineTable_right)
				else
					lineTable_right = subMenuContainerTexts [CoolTip.SubIndexes]
					if (not lineTable_right) then
						lineTable_right = {}
						_table_insert (subMenuContainerTexts, CoolTip.SubIndexes, lineTable_right)
						--subMenuContainerTexts [CoolTip.SubIndexes] = lineTable_right
					end
				end
			else
				return --> error
			end

			lineTable_left [1] = leftText --> line text
			lineTable_left [2] = ColorR1
			lineTable_left [3] = ColorG1
			lineTable_left [4] = ColorB1
			lineTable_left [5] = ColorA1
			lineTable_left [6] = fontSize
			lineTable_left [7] = fontFace
			lineTable_left [8] = fontFlag
			
			lineTable_right [1] = rightText --> line text
			lineTable_right [2] = ColorR2
			lineTable_right [3] = ColorG2
			lineTable_right [4] = ColorB2
			lineTable_right [5] = ColorA2
			lineTable_right [6] = fontSize
			lineTable_right [7] = fontFace
			lineTable_right [8] = fontFlag
		end
		
		function CoolTip:AddSpecial (widgetType, index, subIndex, ...)
		
			local currentIndex = CoolTip.Indexes
			local currentSubIndex = CoolTip.SubIndexes
			CoolTip.isSpecial = true
		
			widgetType = string.lower (widgetType)
			
			if (widgetType == "line") then

				if (subIndex) then
					CoolTip.Indexes = index
					CoolTip.SubIndexes = subIndex-1
				else
					CoolTip.Indexes = index-1
				end
				
				CoolTip:AddLine (...)

				if (subIndex) then
					CoolTip.Indexes = currentIndex
					CoolTip.SubIndexes = currentSubIndex+1
				else
					CoolTip.Indexes = currentIndex+1
				end
				
			elseif (widgetType == "icon") then
			
				CoolTip.Indexes = index
				if (subIndex) then
					CoolTip.SubIndexes = subIndex
				end		
				
				CoolTip:AddIcon (...)

				CoolTip.Indexes = currentIndex
				if (subIndex) then
					CoolTip.SubIndexes = currentSubIndex
				end
				
			elseif (widgetType == "statusbar") then
			
				CoolTip.Indexes = index
				if (subIndex) then
					CoolTip.SubIndexes = subIndex
				end	
				
				CoolTip:AddStatusBar (...)
				
				CoolTip.Indexes = currentIndex
				if (subIndex) then
					CoolTip.SubIndexes = currentSubIndex
				end
				
			elseif (widgetType == "menu") then
			
				CoolTip.Indexes = index
				if (subIndex) then
					CoolTip.SubIndexes = subIndex
				end
				
				CoolTip:AddMenu (...)
				
				CoolTip.Indexes = currentIndex
				if (subIndex) then
					CoolTip.SubIndexes = currentSubIndex
				end
				
			end
			
			CoolTip.isSpecial = false
			
		end
		
		--> search key: ~fromline
		function CoolTip:AddFromTable (_table)
			for index, menu in _ipairs (_table) do 
				if (menu.func) then
					CoolTip:AddMenu (menu.type or 1, menu.func, menu.param1, menu.param2, menu.param3, nil, menu.icon)
				elseif (menu.statusbar) then
					CoolTip:AddStatusBar (menu.value, menu.type or 1, menu.color, true)
				elseif (menu.icon) then
					CoolTip:AddIcon (menu.icon, menu.type or 1, menu.side or 1, menu.width, menu.height, menu.l, menu.r, menu.t, menu.b)
				elseif (menu.textleft or menu.textright or menu.text) then
					CoolTip:AddLine (menu.text, "", menu.type, menu.color, menu.color)
				end
			end
		end

----------------------------------------------------------------------
	--> show cooltip
	
		--> serach key: ~start
		function CoolTip:Show (frame, menuType, color)
			return CoolTip:ShowCooltip (frame, menuType, color)
		end
		
		function CoolTip:ShowCooltip (frame, menuType, color)

			if (frame) then
				--> details framework
				if (frame.dframework) then
					frame = frame.widget
				end
				CoolTip:SetHost (frame)
			end
			if (menuType) then
				CoolTip:SetType (menuType)
			end
			if (color) then
				CoolTip:SetColor (1, color)
				CoolTip:SetColor (2, color)
			end
		
			if (CoolTip.Type == 1 or CoolTip.Type == 2) then
				return CoolTip:monta_tooltip()
				
			elseif (CoolTip.Type == 3) then
				return CoolTip:monta_cooltip()
				
			end
		end
	
	local emptyOptions = {}
	
	function CoolTip:Hide()
		return CoolTip:Close()
	end
	
	function CoolTip:Close()
		CoolTip.active = false
		gump:Fade (frame1, 1)
		gump:Fade (frame2, 1)
	end
	
	--> old function call
	function CoolTip:ShowMe (host, arg2)
	
		--> ignore if mouse is up me
		if (CoolTip.mouseOver) then
			return
		end
	
		if (not host or not arg2) then --> hideme
			CoolTip.active = false
			gump:Fade (frame1, 1)
			gump:Fade (frame2, 1)
		end
	end
	
	--> search key: ~inject
	function CoolTip:ExecFunc (host, fromClick)
	
		if (host.dframework) then
			if (not host.widget.CoolTip) then
				host.widget.CoolTip = host.CoolTip
			end
			host = host.widget
		end
	
		CoolTip:Reset()
		CoolTip:SetType (host.CoolTip.Type)
		CoolTip:SetFixedParameter (host.CoolTip.FixedValue)
		CoolTip:SetColor ("main", host.CoolTip.MainColor or "transparent")
		CoolTip:SetColor ("sec", host.CoolTip.SubColor or "transparent")
		
		CoolTip:SetOwner (host, host.CoolTip.MyAnchor, host.CoolTip.HisAnchor, host.CoolTip.X, host.CoolTip.Y)
		
		local options = host.CoolTip.Options
		if (type (options) == "function") then
			options = options()
		end
		if (options) then
			for optionName, optionValue in pairs (options) do 
				CoolTip:SetOption (optionName, optionValue)
			end
		end
		
		host.CoolTip.BuildFunc()
		
		if (CoolTip.Indexes == 0) then
			if (host.CoolTip.Default) then
				CoolTip:SetType ("tooltip")
				CoolTip:AddLine (host.CoolTip.Default, nil, 1, "white")
			end
		end
		
		CoolTip:ShowCooltip()
		
		if (fromClick) then
			--UIFrameFlash (frame1, )
			frame1:Flash (0.05, 0.05, 0.2, true, 0, 0)
		end
	end
	
	local wait = 0.2
	
	local InjectOnUpdateEnter = function (self, elapsed)  
		elapsedTime = elapsedTime+elapsed
		if (elapsedTime > wait) then
			self:SetScript ("OnUpdate", nil)
			CoolTip:ExecFunc (self)
		end
	end

	local InjectOnUpdateLeave = function (self, elapsed)  
		elapsedTime = elapsedTime+elapsed
		if (elapsedTime > 0.2) then
			if (not CoolTip.mouseOver and not CoolTip.buttonOver and self == CoolTip.Host) then
				CoolTip:ShowMe (false)
			end
			self:SetScript ("OnUpdate", nil)
		end
	end
	
	local InjectOnLeave = function (self) 	
		CoolTip.buttonOver = false
		
		if (CoolTip.active) then
			elapsedTime = 0
			self:SetScript ("OnUpdate", InjectOnUpdateLeave)
		else
			self:SetScript ("OnUpdate", nil)
		end
	
		if (self.CoolTip.OnLeaveFunc) then
			self.CoolTip.OnLeaveFunc()
		end
		
		if (self.OldOnLeaveScript) then
			self:OldOnLeaveScript()
		end		
	end

	local InjectOnEnter = function (self) 
		CoolTip.buttonOver = true
		if (CoolTip.active) then
			CoolTip:ExecFunc (self)
		else
			elapsedTime = 0
			wait = self.CoolTip.ShowSpeed or 0.2
			self:SetScript ("OnUpdate", InjectOnUpdateEnter)
		end

		if (self.CoolTip.OnEnterFunc) then
			self.CoolTip.OnEnterFunc()
		end
		
		if (self.OldOnEnterScript) then
			self:OldOnEnterScript()
		end
	end
	
	function CoolTip:CoolTipInject (host, openOnClick)
		if (host.dframework) then
			if (not host.widget.CoolTip) then
				host.widget.CoolTip = host.CoolTip
			end
			host = host.widget
		end
		
		local coolTable = host.CoolTip
		if (not coolTable) then
			print ("Host nao tem uma CoolTable.")
			return false
		end

		host.OldOnEnterScript = host:GetScript ("OnEnter")
		host.OldOnLeaveScript = host:GetScript ("OnLeave")
		
		host:SetScript ("OnEnter", InjectOnEnter)
		host:SetScript ("OnLeave", InjectOnLeave)
		
		if (openOnClick) then
			if (host:GetObjectType() == "Button") then
				host:SetScript ("OnClick", function() CoolTip:ExecFunc (host, true) end)
			end
		end
		
		return ture
	end
	
	--> all done
	CoolTip:ClearAllOptions()

	return CoolTip
end