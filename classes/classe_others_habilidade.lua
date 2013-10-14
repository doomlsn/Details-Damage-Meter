local _detalhes = 		_G._detalhes
--local gump = 			_detalhes.gump

local alvo_da_habilidade = 	_detalhes.alvo_da_habilidade
local habilidade_misc = 		_detalhes.habilidade_misc
local container_combatentes =	_detalhes.container_combatentes
local container_misc_target = 	_detalhes.container_type.CONTAINER_MISCTARGET_CLASS

--lua locals
local _
local _setmetatable = setmetatable
local _ipairs = ipairs
--api locals
local _UnitAura = UnitAura

local container_playernpc = _detalhes.container_type.CONTAINER_PLAYERNPC

function habilidade_misc:NovaTabela (id, link, token) --aqui eu n�o sei que par�metros passar

	local _newMiscSpell = {

		id = id,
		counter = 0,
		targets = container_combatentes:NovoContainer (container_misc_target)
	}
	
	if (token == "SPELL_INTERRUPT") then
		_newMiscSpell.interrompeu_oque = {}
	elseif (token == "SPELL_DISPEL" or token == "SPELL_STOLEN") then
		_newMiscSpell.dispell_oque = {}
	elseif (token == "SPELL_AURA_BROKEN" or token == "SPELL_AURA_BROKEN_SPELL") then
		_newMiscSpell.cc_break_oque = {}
	end	

	_setmetatable (_newMiscSpell, habilidade_misc)
	
	if (link) then
		_newMiscSpell.targets.shadow = link.targets
	end
	
	return _newMiscSpell
end

function habilidade_misc:Add (serial, nome, flag, who_nome, token, spellID, spellName)

	--local alvo = self.targets:PegarCombatente (serial, nome, flag, true)
	local alvo = self.targets._NameIndexTable [nome]
	if (not alvo) then
		alvo = self.targets:PegarCombatente (serial, nome, flag, true)
	else
		alvo = self.targets._ActorTable [alvo]
	end

	alvo.total = alvo.total + 1
	
	--alvo:AddQuantidade (1)
	if (spellID == "BUFF") then
		if (spellName == "COOLDOWN") then
			self.counter = self.counter + 1
		end
		
	elseif (token == "SPELL_INTERRUPT") then
		self.counter = self.counter + 1

		if (not self.interrompeu_oque [spellID]) then --> interrompeu_oque a NIL value
			self.interrompeu_oque [spellID] = 1
		else
			self.interrompeu_oque [spellID] = self.interrompeu_oque [spellID] + 1
		end
	
	elseif (token == "SPELL_RESURRECT") then
		if (not self.ress) then
			self.ress = 1
		else
			self.ress = self.ress + 1
		end
		
	elseif (token == "SPELL_DISPEL" or token == "SPELL_STOLEN") then
		if (not self.dispell) then
			self.dispell = 1
		else
			self.dispell = self.dispell + 1
		end
		
		if (not self.dispell_oque [spellID]) then
			self.dispell_oque [spellID] = 1
		else
			self.dispell_oque [spellID] = self.dispell_oque [spellID] + 1
		end
		
	elseif (token == "SPELL_AURA_BROKEN_SPELL" or token == "SPELL_AURA_BROKEN") then
	
		if (not self.cc_break) then
			self.cc_break = 1
		else
			self.cc_break = self.cc_break + 1
		end
		
		if (not self.cc_break_oque [spellID]) then
			self.cc_break_oque [spellID] = 1
		else
			self.cc_break_oque [spellID] = self.cc_break_oque [spellID] + 1
		end
	end

	if (self.shadow) then
		return self.shadow:Add (serial, nome, flag, who_nome, token, spellID, spellName)
	end
	
end

--> habilidade atual e o container de habilidades da shadow
function _detalhes.refresh:r_habilidade_misc (habilidade, shadow) --recebeu o container shadow
	_setmetatable (habilidade, habilidade_misc)
	habilidade.__index = habilidade_misc
	
	if (shadow ~= -1) then
		habilidade.shadow = shadow._ActorTable[habilidade.id]
		_detalhes.refresh:r_container_combatentes (habilidade.targets, habilidade.shadow.targets)
	else
		_detalhes.refresh:r_container_combatentes (habilidade.targets, -1)
	end
end

function _detalhes.clear:c_habilidade_misc (habilidade)
	habilidade.__index = {}
	habilidade.shadow = nil
	
	_detalhes.clear:c_container_combatentes (habilidade.targets)
end

habilidade_misc.__sub = function (tabela1, tabela2)

	--interrupts
	tabela1.counter = tabela1.counter - tabela2.counter
	
	--ressesrs
	if (tabela1.ress and tabela2.ress) then
		tabela1.ress = tabela1.ress - tabela2.ress
	end
	
	--dispells
	if (tabela1.dispell and tabela2.dispell) then
		tabela1.dispell = tabela1.dispell - tabela2.dispell
	end
	
	--cc_breaks
	if (tabela1.cc_break and tabela2.cc_break) then
		tabela1.cc_break = tabela1.cc_break - tabela2.cc_break
	end
	
	return tabela1
end