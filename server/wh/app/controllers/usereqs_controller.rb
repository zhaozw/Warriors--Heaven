#require "objects/equipments/equipment.rb"
require 'utility.rb'
class UsereqsController < ApplicationController
    self.allow_forgery_protection = false
    def index
        return if !check_session or !user_data
=begin        
        sid = cookies[:_wh_session]    
      # for test
      if (params[:sid])
          sid = params[:sid]
      end
        
        # eqs = Usereq.find_by_sql(" select * from usereqs, equipment where usereqs.eqid=equipment.id and sid='#{sid}'")
        
        eqs = Equipment.find_by_sql("select * from equipment where owner=#{user_data[:id]}")
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
=end
        render :text=>user_data.query_all_obj.to_json
    end
    
    def save
        #p request
     # p "===>"+request.body.read
      #  p "--->"+request.raw_post
       # p request.content_type
        p params[:data]
        return if !check_session or !user_data
        player.recover
        prop = JSON.parse(user_data.ext[:prop])
        prop["eqslot"] = JSON.parse(params[:data])
        user_data.ext[:prop]= prop.to_json
        # user_data.ext.save!
        # update_session_data(nil)
        user_data.check_save
      #  p request_origin
        # render :text=>user_data.ext.to_json
        success("成功に保存!", {:userext=>user_data.ext})
    end
    
    def sell
        return if !check_session or !user_data
         player.recover
         user_data.ext[:lastact] = "sell"
         eqs = Equipment.find(params[:id])
         eq = eqs
         if eq[:owner] != user_data[:id]
            user_data.invalidate_all_obj(true)
            user_data.check_save
            error ("取引失敗！この品物はあなたに属しない", {:usereqs=>user_data.query_all_obj})
             return
         end
         obj = load_obj(eq[:eqname], eq)
         user_data.remove_obj(obj)
        
        # eq.delete
         # eq[:owner] = nil
         eq.save!
         
         user_data.ext[:gold] += obj.price.to_i / 2
         p "-->#{user_data.ext.inspect}"

         user_data.check_save
         
         ret = {
             :id=>params[:id],
             :gold=>user_data.ext[:gold],
             :msg=>"取引成功. \nGold +#{obj.price.to_i / 2}"
         }
         render :text=>ret.to_json
         # success("Trade is successful")
    end
    
    def use
        return if !check_session or !user_data
        player.recover
        eqs = Equipment.find(params[:id])
        eq = eqs
        p "==>use eq #{eq.inspect}"
        obj = load_obj(eq[:eqname], eq)

        context= {
            :player => player,
            :msg =>"成功に使用"
        }
        obj.use(context)
        
        user_data.check_save
        p "==>use eq2 #{context.inspect}"
        
        success(context[:msg], {:id=>params[:id], :userext=>(user_data.ext)})
    end

end
