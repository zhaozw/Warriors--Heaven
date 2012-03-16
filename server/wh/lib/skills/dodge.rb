class Dodge < Skill
    
   def type
       return "unarmed"
   end
   
   def for
       "dodge"
   end
   
   def damage(context)
       0
      
   end
    
    
    def speed (context)
        context[:user].ext[:dext].to_i+@skill[:level]
    end
    
    def dodge_actions
        [
            "但是和$N身体偏了几寸。\n",
            "但是被$N机灵地躲开了。\n",
            "但是$N身子一侧，闪了开去。\n",
            "但是被$N及时避开。\n",
            "但是$N已有准备，不慌不忙的躲开。\n",
        ]
    end
    def doDodge(context)
        srand Time.now.tv_usec.to_i
        a = dodge_actions
        context[:msg] += a[rand(a.length)]
        
    end
    
    
end