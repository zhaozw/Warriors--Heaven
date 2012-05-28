require 'objects/npc/npc.rb'


class Yeren < Npc
      def name
       "野人"
   end
   
   
   def title
       "大力王" 
   end
   
   def race
       "human"
   end
   
   def desc
        "战败他可以完成第5级的修炼，成为‘初级侠客’"
   end
      
       def setup_temp
        
       @temp ={
           :exp =>0,
           :level => 15,
           :hp => 200,
           :maxhp =>200,
           :stam    =>200,
           :maxst   =>200,
           :str     =>60,
           :dext    =>20,
           :luck    =>50,
           :fame    =>0,
           :race    =>"human",
           :pot     =>0,
           :it      =>20
       }
    end
    
    def setup_skill  
              fullskill = cacl_fullskill(tmp[:level])
        set_skill("unarmed", fullskill, 0)
        set_skill("parry", fullskill, 0)
        set_skill("dodge", fullskill, 0)
        set_skill("fencing", fullskill, 0)
        set_skill("daofa", fullskill, 0)
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
        "obj/npc/yeren.png"
    end
    
    def homeImage
        "obj/npc/weizhangtianxin_home.gif"
    end
    
    def legendImage
        "obj/npc/yeren_legend.jpg"
    end

    
end