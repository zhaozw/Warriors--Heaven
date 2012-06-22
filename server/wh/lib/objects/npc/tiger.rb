require 'objects/npc/npc.rb'


class Tiger < Npcorc
    def name
       "白虎"
   end
   
   def unit
       "只"
   end
   
   def title
       "猛兽" 
   end
   
   def race
       "orc"
   end
   
   def desc
        "一只吊睛白额大虎"
   end
      
       def setup_temp
        
       @temp ={
           :exp =>0,
           :level => 5,
           :hp => 200,
           :maxhp =>200,
           :stam    =>200,
           :maxst   =>200,
           :jingli => 200,
           :max_jl =>200,
           :str     =>30,
           :dext    =>20,
           :luck    =>50,
           :fame    =>0,
           :race    =>"human",
           :pot     =>0,
           :it      =>20
       }
    end
    
    def setup_skill  
        set_skill("beastunarmed", 60, 0)
        set_skill("parry", 60, 0)
        set_skill("dodge", 60, 0)
  
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
      carry("objects/fixtures/tigerskin")
    end
    
    def image
        "obj/npc/yezhu.jpg"
    end
    
    def homeImage
        "obj/npc/weizhangtianxin_home.gif"
    end
    
    def legendImage
        "obj/npc/yezhu_legend.jpg"
    end

    
end