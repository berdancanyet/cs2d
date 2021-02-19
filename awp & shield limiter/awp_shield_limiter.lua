if sample==nil then sample={} end
sample.lm={}

local tbought = false
local ctbought = false
local shield = false
local m = msg2
local p = parse


addhook("startround","sample.lm.startround")
function sample.lm.startround()
	tbought = false
	ctbought = false
	shield = false
end

addhook("buy","sample.lm.buy")
function sample.lm.buy(id,weapon)
	if player(id,"team") == 1 and weapon == 35 and tbought then
		p("sv_sound2 "..id.." env/click2.wav")
		m(id,"Only one AWP per team allowed@C")
		return 1 
	elseif player(id,"team") == 1 and weapon == 35 and tbought == false then
		tbought = true
		return 0
	end
	if player(id,"team") == 2 and weapon == 35 and ctbought then
		p("sv_sound2 "..id.." env/click2.wav")
		m(id,"Only one AWP per team allowed@C")
		return 1 
	elseif player(id,"team") == 2 and weapon == 35 and ctbought == false then
		ctbought = true
		return 0
	end
	if player(id,"team") == 2 and weapon == 41 and shield then --make sure Tactical Shield is not in mp_unbuyable list
		p("sv_sound2 "..id.." env/click2.wav")
		m(id,"Only one Tactical shield can be bought per round.@C")
		return 1
	elseif player(id,"team") == 2 and weapon == 41 and shield == false then
		shield = true
		return 0
	end
end