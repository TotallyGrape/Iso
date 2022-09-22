--iso
require('entities')
map={
    {
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,4,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0}
    },
    {
        {2,2,0,0,0,0,0},
        {0,0,0,4,0,0,0},
        {0,0,4,3,4,0,0},
        {0,0,0,4,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0}
    },
    {
        {1,1,0,0,0,0,0},
        {2,0,0,0,0,0,0},
        {0,0,0,3,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0}
    },
    {
        {1,1,2,2,2,0,0},
        {1,2,2,2,2,0,0},
        {2,2,2,2,2,0,0},
        {2,2,2,2,2,0,0},
        {2,2,2,2,2,0,0},
        {0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0}
    },
    {
        {1,1,1,1,1,2,2},
        {1,1,1,1,1,2,2},
        {1,1,1,1,1,2,2},
        {1,1,1,1,1,2,2},
        {1,1,1,1,1,2,2},
        {2,2,2,2,2,2,2},
        {2,2,2,2,2,2,2}
    },
}

function love.load()

    love.graphics.setBackgroundColor(0.6,0.6,1,1)
    love.graphics.setDefaultFilter("nearest", "nearest")
    mx, my = love.mouse.getPosition()
    troop_quads={}
    monkey_images={love.graphics.newImage('images/monkey/up-left.png'),love.graphics.newImage('images/monkey/down-left.png'),love.graphics.newImage('images/monkey/down-right.png'),love.graphics.newImage('images/monkey/up-right.png')}
    for x=0,3 do
        table.insert(troop_quads,love.graphics.newQuad(x*16,0,16,16,monkey_images[1]))
    end 
    
    tiles=love.graphics.newImage("images/tiles.png")
	selected={x=1,y=1}
    tile_quads=load_quads()
    new_troop(5,5,3)
    new_troop(7,6,4)
end

function love.update(dt)
    global_dt = dt
    update_people()
end

function love.draw()
    love.graphics.push()
	    love.graphics.scale(5)
        draw_grid()

    love.graphics.pop()
end


function draw_grid()
    for n=5,1,-1 do
        for x=1,7 do
            for y=1,7 do
                local _x,_y = vec(x,y)
                draw_people(x,y,n,80+_x-8,-10+_y+n*9)
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
                    --q=tile_quads[9][9]
                    local col =(x+y)/10
                    --love.graphics.setColor(col,col,col,1)
                    love.graphics.setColor(1,1,1,1)
                    love.graphics.draw(tiles,q,80+_x-8,-10+_y+n*9,0,1,1)
                    
                end
            end
        end
    end
end

function vec(x,y)
    local width = 16
    local height = 18
	local _x = x*(1*width/2)+y*(-1*width/2)
	local _y = x*(0.5*height/2)+y*(0.5*height/2)
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
        local m = {{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0},{0,0,0,0,0,0,0}}
        for y=1,7 do
            for x=1,7 do
                    m[-(x-4)+4][y]=map[n][y][x]
            end
        end
        map[n] = m
    end
end

function love.keypressed( key, scancode, isrepeat )
    rotate_map()
    for i=#troop,1,-1 do
        troop[i]:rotate_left()
    end
end

function love.mousepressed(x,y,button)
    if button ~= 1 then return end
    for i=#troop,1,-1 do
        local coords = {troop[i]:coords()}
        
        if CheckCollision(x/5,y/5,1,1,coords[1],coords[2],16,18) then
            print(i)
            print('clicked')
        end
    end
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
        x2 < x1+w1 and
        y1 < y2+h2 and
        y2 < y1+h1
end