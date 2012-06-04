require 'objects/npc/npcorc.rb'


class Yezhu < Npcorc
      def name
       "野猪"
   end
   
   
   def title
       "猛兽" 
   end
   
   def race
       "orc"
   end
   
   def desc
        "一只凶猛的野猪，必须战败它才可以完成第5级的修炼。"
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
        full_skill = cacl_fullskill(tmp[:level])
        
        set_skill("beastunarmed", full_skill, 0)
        set_skill("parry", full_skill, 0)
        set_skill("dodge", full_skill, 0)
        # set_skill("fencing", full_skill, 0)
        # set_skill("daofa", full_skill, 0)
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