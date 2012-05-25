require 'objects/npc/npc.rb'


class Yezhu < Npc
      def name
       "野猪"
   end
   
   
   def title
       "猛兽" 
   end
   
   def race
       "org"
   end
   
   def desc
        "战败他可以完成第5级的修炼，成为‘初级侠客’"
   end
      
       def setup_temp
        
       @temp ={
           :exp =>0,
           :level => 5,
           :hp => 200,
           :maxhp =>200,
           :stam    =>200,
           :maxst   =>200,
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
        set_skill("unarmed", 20, 0)
        set_skill("parry", 20, 0)
        set_skill("dodge", 20, 0)
        set_skill("fencing", 20, 0)
        set_skill("daofa", 20, 0)
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
    
    def lengendImage
        "obj/npc/yezhu_legend.jpg"
    end

    
end