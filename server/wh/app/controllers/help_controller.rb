require 'utility.rb'

class HelpController < ApplicationController
    def index
       cat = params[:cat]
       name = params[:name]
       if (!cat || !name)
           render :text=>"Help Object not exist"
           return
       end
       
       if cat == "badge"
         @o = loadGameObject("badges/#{name}")
        end
        
        
    end
end
