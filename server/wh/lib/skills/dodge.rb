class Dodge
    
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
        context[:userext][:dext].to_i+1
    end
    
    def dodge_actions
        [
            "但是和$n身体偏了几寸。\n",
            "但是被$n机灵地躲开了。\n",
            "但是$n身子一侧，闪了开去。\n",
            "但是被$n及时避开。\n",
            "但是$n已有准备，不慌不忙的躲开。\n",
        ]
    end
    def render(context)
        srand Time.now.to_i
        a = dodge_actions
        context[:msg] += a[rand(a.length)]
        
    end
    
    
end