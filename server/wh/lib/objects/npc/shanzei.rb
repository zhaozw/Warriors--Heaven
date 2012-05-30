require 'objects/npc/npchuman.rb'


class Shanzei < Npchuman
    
   def name
       "山贼"
   end
   
   def desc
        "这是一个破衣烂山的山贼，眼睛里露着凶狠的目光."
   end
      
     
   def setup_temp
        
       @temp ={
           :exp =>0,
           :level => 5,
           :hp => 100,
           :maxhp =>100,
           :stam    =>100,
           :maxst   =>100,
           :str     =>30,
           :dext    =>20,
           :luck    =>40,
           :fame    =>0,
           :race    =>"human",
           :pot     =>0,
           :it      =>10
       }
    end
    
    def setup_skill  
        set_skill("unarmed", 20, 0)
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
        eq = create_equipment("objects/equipments/blade")
        # set_equipment("handleft", eq)
        wear("handleft", eq)
        eq = create_equipment("objects/equipments/blade")
        # set_equipment("handright", eq)
        wear("handright", eq)
    end
    
end