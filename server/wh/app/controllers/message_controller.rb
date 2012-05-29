require 'utility.rb'
class MessageController < ApplicationController
    def get
        return if !check_session or !user_data
        
        @delete = params[:delete]
        if !@delete
            @delete = 0
        else
            @delete = @delete.to_i
        end
        
        # @t = params[:t]
        # if !@t || @t.to_i == 0
        #     data = query_filedata(user_data[:id])
        #     if !data || data[:lastreadmsg] == nil 
        #         @t = Time.at(1)
        #     else
        #         @t = Time.at(data[:lastreadmsg])
        #     end
        # else
        #     @t = Time.at(t.to_i)
        # end
        
        @ch = params[:ch]
        if !@ch
            @ch = "public_user"
        end
        
        @type = params[:type]
        if !@type 
            @type = "plain"
        end
        
        @type2 = params[:type2]
        if !@type 
            @type = "text"
        end
        # c = {:time => @t}
        # p "==>lastreadtime=#{@t.inspect}"
        @msg = query_msg(user_data.id, public_channel+[user_data[:id]], @delete ==1)
        # p "msg=#{@msg}"
        if (@type == "plain")
            @msg = ret.gsub(/<.*?>/,"")
        end
        
        @msg.strip!
        
        if @type2 == "text"        
            # p "msg2=#{@msg}"
            render :text=>@msg
        elsif @type2 == "json"
            ar = @msg.split("\n")
            ret = {
                # :t =>c[:time].to_i,
                :msg => ar
            }
            p "==>11#{ret.to_json}"
            render :text=>ret.to_json
        end
        # if !data
        #          data = {}
        #      end
        # data[:lastreadmsg] = c[:time].to_i
        # save_filedata(user_data[:id], data)
    end
    
    
end
