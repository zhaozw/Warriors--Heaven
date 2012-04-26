#require "objects/equipments/equipment.rb"
require 'utility.rb'
class UsereqsController < ApplicationController
    self.allow_forgery_protection = false
    def index
        sid = cookies[:_wh_session]    
      # for test
      if (params[:sid])
          sid = params[:sid]
      end
        
        eqs = Usereq.find_by_sql(" select * from usereqs, equipment where usereqs.eqid=equipment.id and sid='#{sid}'")
        if !eqs || eqs.size == 0
            render :text=>"{}"
            return
        end
        
        for eq in eqs
            _eq = nil
            p "eqtype=#{eq[:eqtype]}"
            if eq[:eqtype].to_i == 1
                _eq = Equipment.load_equipment(eq[:eqname], eq)
                eq[:pos] = _eq.wearOn
               
                eq[:damage] = _eq.damage
                eq[:defense] = _eq.defense
                
            else
                _eq = load_obj(eq[:eqname], eq)
            end
            eq[:dname] = _eq.dname
            eq[:desc] = _eq.desc
            eq[:weight] = _eq.weight
            eq[:rank] = _eq.rank
            eq[:effect] = _eq.effect
            eq[:price] = _eq.price
            eq[:image] = _eq.image
        end
        
        render :text=>eqs.to_json
        
    end
    
    def save
        #p request
     # p "===>"+request.body.read
      #  p "--->"+request.raw_post
       # p request.content_type
        p params[:data]
        check_session
        prop = JSON.parse(user_data.ext[:prop])
        prop["eqslot"] = JSON.parse(params[:data])
        user_data.ext[:prop]= prop.to_json
        user_data.ext.save!
        # update_session_data(nil)
        user_data.check_save
      #  p request_origin
        render :text=>user_data.ext.to_json
    end
    
    def sell
         check_session
         eqs = Usereq.find_by_sql("select * from usereqs where eqid=#{params[:id]}" )
         eq = eqs[0]
         obj = load_obj(eq[:eqname], eq)
             
        max_eq = user_data.ext[:max_eq].to_i
        eqslot = user_data.ext[:eqslot]
        p eqslot
   
        if eqslot
            bFound = false
            if (eqslot.class == String)
                eqslots = JSON.parse(eqslot)
            else
                eqslots = eqslot
            end
            
            eqslots.each{|k,v|
                if (v.to_i == params[:id].to_i)
                    eqslots.delete(k)
                    bFound = true
                    break
                end
            }
            
            if bFound
                user_data.ext.set_prop("eqslot", eqslots)
            end
            
        end
         
         user_data.ext[:gold] += obj.price.to_i / 2
         
         eq.delete
         
         user_data.check_save
         success("Trade is successful")
    end

end
