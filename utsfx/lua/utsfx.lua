local parse = parse
local msg = msg

if sample==nil then sample={} end
sample.ut={}

function initArray(m)
	local array = {}
	for i = 1, m do
		array[i]=0
	end
	return array
end

levels = {}
levels[2] = {"173255047","made a Doublekill!","kgb2d/utsfx/doublekill.wav"}
levels[3] = {"026255525","made a Triplekill!","kgb2d/utsfx/triplekill.wav"}
levels[4] = {"000206209","made a Multikill!","kgb2d/utsfx/multikill.wav"}
levels[5] = {"132112255","made a Killingspree!@C","kgb2d/utsfx/killingspree.wav"}
levels[6] = {"138043226","is Dominating!@C","kgb2d/utsfx/dominating.wav"}
levels[7] = {"138043226","is UNSTOPPABLE!@C","kgb2d/utsfx/unstoppable.wav"}
levels[8] = {"138043226","OWNS!@C","kgb2d/utsfx/ownage.wav"}
levels[9] = {"138043226","made a MO-O-O-O-ONSTERKILL-ILL-ILL!@C","kgb2d/utsfx/monsterkill.wav"}
levels[10] = {"138043226","GOT ANOTHER ONE@C","kgb2d/utsfx/holyshit.wav"}

sample.ut.timer=initArray(32)
sample.ut.level=initArray(32)
sample.ut.fblood=0

addhook("second","sample.ut.second")
function sample.ut.second()
	for _, id in pairs(player(0, "table")) do
		if sample.ut.timer[id] ~= 4 then
			sample.ut.timer[id] = sample.ut.timer[id] + 1
		end
	end
end

addhook("startround","sample.ut.startround")
function sample.ut.startround()
	sample.ut.fblood=0
end

addhook("kill","sample.ut.kill")
function sample.ut.kill(killer,victim,weapon)
	if sample.ut.timer[killer]>3 then
		sample.ut.level[killer]=0
	end
		level=sample.ut.level[killer]
		level=level+1
		sample.ut.level[killer]=level
		sample.ut.timer[killer]=0
	if (sample.ut.fblood==0) then
		sample.ut.fblood=1
		parse("sv_sound \"kgb2d/utsfx/firstblood.wav\"")
		msg("\169200000000"..player(killer,"name").. " sheds FIRST BLOOD!@C")
	end
	if (weapon==50) then
		parse("sv_sound \"kgb2d/utsfx/humiliation.wav\"")
		msg("\169255069000"..player(killer,"name").." humiliated "..player(victim,"name").."!")
	else
		if levels[level] then
			parse("sv_sound \""..levels[level][3].."\"")
			msg("\169"..levels[level][1]..""..player(killer,"name").." "..levels[level][2])
		elseif (level > #levels) then
			parse("sv_sound \"kgb2d/utsfx/godlike.wav\"")
			msg("\169000255000"..player(killer,"name").." IS G O D L I K E! "..level.." KILLS!@C")
		end
	end
end