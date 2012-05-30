require 'objects/npc/npc.rb'


class Snake < Npcorc
      def name
       "毒蛇"
   end
   
   
   def title
       "猛兽" 
   end
   
   def race
       "orc"
   end
   
   def desc
        "一条绿幽幽的毒蛇，吐着红信"
   end
      
       def setup_temp
        
       @temp ={
           :exp =>0,
           :level => 5,
           :hp => 50,
           :maxhp =>100,
           :stam    =>200,
           :maxst   =>200,
           :str     =>10,
           :dext    =>50,
           :luck    =>30,
           :fame    =>0,
           :race    =>"orc",
           :pot     =>0,
           :it      =>20
       }
    end
    
    def setup_skill  
        set_skill("beastunarmed", 20, 0)
        set_skill("parry", 20, 0)
        set_skill("dodge", 20, 0)
    
=begin
       @skills =[
       #    "unarmed" =>
            {
               :skname    => "unarmed",
               :level    => 20,
               :tp => 0,
               :enabled => 1
           },
         #   "parry" => 
         {
               :skname    => "parry",
               :level    => 20,
               :tp => 0,
               :enabled => 1
           },
        #    "dodge" => 
            {
               :skname    => "dodge",
               :level    => 20,
               :tp => 0,
               :enabled => 1
           }
   
       ]
=end        
    end
    
    
    def setup_equipment
              carry("objects/fixtures/shedan")
    end
    
    def image
        "obj/npc/snake.jpg"
    end
    
    def homeImage
        "obj/npc/weizhangtianxin_home.gif"
    end
    
    def legendImage
        "obj/npc/yezhu_legend.jpg"
    end

    
end