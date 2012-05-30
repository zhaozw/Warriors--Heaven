require 'objects/npc/npc.rb'


class Yetu < Npcorc
      def name
       "野兔"
   end
   
   
   def title
       "猛兽" 
   end
   
   def race
       "orc"
   end
   
   def desc
        "一只山里常见的野兔。"
   end
      
       def setup_temp
        
       @temp ={
           :exp =>0,
           :level => 5,
           :hp => 50,
           :maxhp =>50,
           :stam    =>200,
           :maxst   =>200,
           :str     =>10,
           :dext    =>30,
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