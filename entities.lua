troop={}
function new_troop(x,y,z)
    table.insert(troop,{
        x=y,
        y=x,
        z=z,
        type=1,
        sine=0,
        sprite=math.floor(math.random(1,4)),
        update=function(self)
            self.sine = self.sine + 0.1 + global_dt
        end,
        draw=function(self)
            local x,y= vec(self.x,self.y)
            love.graphics.setColor(1.5-math.sin(self.sine),1.5-math.sin(self.sine),1.5-math.sin(self.sine),1)
            love.graphics.draw(monkey_images[self.sprite],troop_quads[1],80+x-7,-12+y+self.z*9,0,1,1)
        end,
        rotate_left=function(self)
            --m[-(x-4)+4][y]=map[n][y][x]
            local x = self.x
            local y = self.y
            self.y = -(x-4)+4
            self.x = y
            self.sprite = self.sprite + 1
            if self.sprite < 1 then
                self.sprite = 4
            end
            if self.sprite > 4 then
                self.sprite = 1
            end
        end,
        coords=function(self)
            local x,y= vec(self.x,self.y)
            return 80+x-7,-12+y+self.z*9
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