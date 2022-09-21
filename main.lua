--iso
map={
    {
        {0,0,0,0,0},
        {0,0,0,0,0},
        {0,0,0,4,0},
        {0,0,0,0,0},
        {0,0,0,0,0}
    },
    {
        {0,0,0,0,0},
        {0,0,0,4,0},
        {0,0,4,3,4},
        {0,0,0,4,0},
        {0,0,0,0,0}
    },
    {
        {2,2,0,0,0},
        {2,0,0,0,0},
        {0,0,0,3,0},
        {0,0,0,0,0},
        {0,0,0,0,0}
    },
    {
        {1,1,2,2,2},
        {1,2,2,2,2},
        {2,2,2,2,2},
        {2,2,2,2,2},
        {2,2,2,2,2}
    },
    {
        {1,1,1,1,1},
        {1,1,1,1,1},
        {1,1,1,1,1},
        {1,1,1,1,1},
        {1,1,1,1,1}
    },
}

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    tiles=love.graphics.newImage("images/tiles.png")
	selected={x=1,y=1}
	sine=0
    tile_quads=load_quads()
end

function love.update(dt)
	sine=sine+3*dt
end

function love.draw()
	--print("x "..selected.x)
	--print("y "..selected.y)
	--print("e "..sine)
    love.graphics.push()
	    love.graphics.scale(5)
        draw_grid()
    love.graphics.pop()
end


function draw_grid()
    for n=5,1,-1 do
        for x=1,5 do
            for y=1,5 do
                local _x,_y = vec(x,y)
                if map[n][y][x]~=0 then

                    local q = tile_quads[1][1]
                    if map[n][y][x]==1 then
                        q = tile_quads[1][7]
                    elseif map[n][y][x]==2 then
                        q = tile_quads[2][1]
                    elseif map[n][y][x]==3 then
                        q = tile_quads[4][1]
                    elseif map[n][y][x]==4 then
                        q = tile_quads[5][2]
                    end
                    love.graphics.draw(tiles,q,math.floor(80+_x-8),math.floor(_y+n*9+math.sin(sine+x/10)*2),0,1,1)
                end
            end
        end
    end
end

function vec(x,y)
    local width = 16
    local height = 18
	local _x= x*(1*width/2)+y*(-1*width/2)
	local _y= x*(0.5*height/2)+y*(0.5*height/2)
	return _x,_y
end

function load_quads()
    local q = {}
    for y=0,9 do
        local t = {}
        for x=0,9 do
            table.insert(t,love.graphics.newQuad(x*18,y*18,18,18,tiles))
        end
        table.insert(q,t)
    end
    return q
end

function rotate_map()
    
    for n=5,1,-1 do
        local m = {{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0}}
        for y=1,5 do
            for x=1,5 do
                m[-(x-3)+3][y]=map[n][y][x]
            end
        end
        map[n] = m
    end

    
end

function love.keypressed()
    rotate_map()
end