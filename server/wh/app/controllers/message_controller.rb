require 'utility.rb'
class MessageController < ApplicationController
    def get
        return if !check_session or !user_data
        @t = params[:t]
        if !@t
            @t = Time.at(0)
        else
            @t = Time.at(t.to_i)
        end
        
        @ch = params[:ch]
        if !@ch
            @ch = "public_user"
        
        @type = params[:type]
        if !@type 
            @type = "plain"
        end
        
        @type2 = params[:type2]
        if !@type 
            @type = "text"
        end
        c = {:time = @t}
        ret = take_msg(public_channel.merge[user_data[:id]], c)
    
        if (@type == "plain")
            @msg = ret.gsub(/<.*?>/,"")
        end
        
        @msg.strip!
        
        if @type2 == "text"        
            render :text=>@msg
        elsif @type == "josn"
            ar = @msg.split("\n")
            ret = {
                :t =>c[:time].to_i,
                :msg => ar
            }
            render :text=>ar.to_json
        end
    end
    
    
end
