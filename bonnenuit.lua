--title: bonne nuit
--author: theawesomerazz
--[[desc: a young girl searches her
dreams for the memories she has lost--]]
--script: lua

--VARIABLES
--[[game and player state kept separate
makes it easy to restart levels--]]
Plr={
	lives=3,
	x=30,y=15,
	vx=0,vy=0,
	grounded=false,
	WALK1L=260,
	WALK2L=261,
	WALK1R=257,
	WALK2R=258}

Game={
	state="start",
	lvlNo=0,
	scr=0}

PLAYER_SPRITE=256
SPEED=1

solids={[0]=false,[1]=true,[2]=true,[3]=true,
									[4]=true,[6]=true,[7]=true,
									[8]=true,[9]=true,[10]=true}

function init()

end

function solid(x, y)
	return solids[mget((x)//8,(y)//8)]
end

--put all game functions in here
--[[function testCollisionX()
	if solid(Plr.x+Plr.vx, Plr.y+Plr.vy)
	or solid(Plr.x+7+Plr.vx, Plr.y+Plr.vy)
	or solid(Plr.x+Plr.vx, Plr.y+7+Plr.vy)
	or solid(Plr.x+7+Plr.vx, Plr.y+7+Plr.vy) then
		Plr.vx=0

	end
end

function testCollisionY()
	if solid(Plr.x+Plr.vx, Plr.y+8+Plr.vy)
	or solid(Plr.x+7+Plr.vx, Plr.y+8+Plr.vy) then
		Plr.vy=0
	elseif Plr.vy<0 and (solid(Plr.x+Plr.vx,Plr.y+Plr.vy)
	or solid(Plr.x+7+Plr.vx,Plr.y+Plr.vy)) then
		Plr.vy=0
	else
		Plr.vy=Plr.vy+0.2
	end
end--]]

function updatePlr()
	if btn(2) then Plr.vx=-SPEED PLAYER_SPRITE=Plr.WALK1L+time()%2
		elseif btn(3) then Plr.vx=SPEED PLAYER_SPRITE=Plr.WALK1R+time()%2
		else Plr.vx=0 PLAYER_SPRITE=256
	end

	if Plr.vy==0 and btn(4) then
		Plr.vy=-2.5
	end

 if solid(Plr.x+Plr.vx,Plr.y+Plr.vy) or solid(Plr.x+7+Plr.vx,Plr.y+Plr.vy) or solid(Plr.x+Plr.vx,Plr.y+7+Plr.vy) or solid(Plr.x+7+Plr.vx,Plr.y+7+Plr.vy) then
  Plr.vx=0
 end

 if solid(Plr.x,Plr.y+8+Plr.vy) or solid(Plr.x+7,Plr.y+8+Plr.vy) then
  Plr.vy=0
 else
  Plr.vy=Plr.vy+0.2
 end

 if Plr.vy==0 and btnp(4) then Plr.vy=-2.5 end

 if Plr.vy<0 and (solid(Plr.x+Plr.vx,Plr.y+Plr.vy) or solid(Plr.x+7+Plr.vx,Plr.y+Plr.vy)) then
  Plr.vy=0
 end

	Plr.x=Plr.x+Plr.vx
	Plr.y=Plr.y+Plr.vy
end

function gameLoop()
	updatePlr()
	cls()
	map(30,0)
	spr(PLAYER_SPRITE,Plr.x, Plr.y,0)
	print("there's nothing here?", 50,60)
	print("try again tomorrow night!",50,70)
end

init()

function TIC() --update and draw here
	if Game.state=="start" then

		cls()
		map()
		print("press [z] to start!",80,102)

		if btn(4) then
			Game.state="play"
		else
			Game.state="start"
		end

	elseif Game.state=="play" then
		--game loop goes here
		cls()
		gameLoop()

	else
		cls()
		map(90,0)
	end
end
