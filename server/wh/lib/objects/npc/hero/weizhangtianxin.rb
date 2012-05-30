require 'objects/npc/Npchuman.rb'


class Weizhangtianxin < Npchuman
    
   def name
       "尾张天心"
   end
   
   
   def title
       "狂浪人" 
   end
   
   
   
   def desc
        "尾张天心古流拳法的创始人，战败他可以完成第10级的修炼，成为‘武士’"
   end
      
     
   def setup_temp
        
       @temp ={
           :exp =>0,
           :level => 10,
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
        eq = create_equipment("objects/equipments/sword")
        # set_equipment("handleft", eq)
        wear("handleft", eq)
        eq = create_equipment("objects/equipments/xuezou")
        # set_equipment("handright", eq)
        wear("handright", eq)
        
        eq = create_equipment("objects/equipments/armo")
        # set_equipment("handright", eq)
        wear("body", eq)
        
        eq = create_equipment("objects/equipments/cap")
        # set_equipment("handright", eq)
        wear("head", eq)
        
        eq = create_equipment("objects/equipments/boots")
        # set_equipment("handright", eq)
        wear("foot", eq)

    end
    
    def image
        "obj/npc/weizhangtianxin.jpg"
    end
    
    def homeImage
        "obj/npc/weizhangtianxin_home.gif"
    end
    
    def legendImage
        "obj/npc/weizhangtianxin_legend.jpg"
    end
end