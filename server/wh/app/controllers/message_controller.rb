require 'utility.rb'
class MessageController < ApplicationController
    def get
        return if !check_session or !user_data
        type = params[:type]
        if !type 
            type = "text"
        end
        
        ret = take_msg(user_data[:id])
    
        if (type == "text")
            ret = ret.gsub(/<.*?>/,"")
        end
        
        ret.strip!
        
        render :text=>ret
    end
end
