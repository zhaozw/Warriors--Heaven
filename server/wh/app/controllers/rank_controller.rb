class RankController < ApplicationController
    def index
        if !check_session
            render :text=>"session not exist"
            return
        end
        
    end
    def rankmoney
    end
end
