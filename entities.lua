troop={}
function new_troop()
    table.insert(troop,{
        x=5,
        y=5,
        z=3,
        type=1,
        update=function(self)

        end,
        draw=function(self)
            local x,y= vec(self.x,self.y)
            print(80+x-8,-10+y+self.z*9)
            love.graphics.draw(monkey_images[3],troop_quads[1],80+x-7,-12+y+self.z*9,0,1,1)
        end,
        rotate_left=function(self)
            --m[-(x-4)+4][y]=map[n][y][x]
            local x = self.x
            local y = self.y
            self.y = -(x-4)+4
            self.x = y
        end
    })
end

enemy={}
function new_enemy()
    table.insert(enemy,{
        
    })
end

function update_people()
    for i=#troop,1,-1 do
        troop[i]:update()
    end
end

function draw_people(x,y,z)
    for i=#troop,1,-1 do
        if x==troop[i].x and y==troop[i].y and z==troop[i].z then
            troop[i]:draw()
        end
    end
end