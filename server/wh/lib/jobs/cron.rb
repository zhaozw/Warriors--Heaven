require "utility.rb"
require 'memcache.rb'

def launch_jobs
    p "===>launching cron jobs"
    # create memcached manually
    mcd_default_options = {
            :namespace => 'game:user',
            :memcache_server => 'localhost:11211'
    }

    if (!$memcached)  
        $memcached= MemCache.new(mcd_default_options[:memcache_server], mcd_default_options)
    end

    # load lib class manually
    # Dir["#{File.dirname(__FILE__)}/../../lib/**/*.rb"].each { |f| 
    #           load(f)
    #           p "load #{f}"
    #      }
         
    # monitor global quest
    Process.detach fork{
        while(1)

            # p "."
            Process.detach fork{
                Globalquest.connection.reconnect! 

                rs = Globalquest.find_by_sql("select * from globalquests where stat=0")

                p "==============>#{rs.size} globalquest<============="

                rs.each {|q|
                    team_zhongyuan = q.get_prop("zhongyuan")
                    team_wudu =q.get_prop("wudu")
                    quest = load_obj("quests/wudujiao")
                    time_span = Time.now - q[:created_at]
                    p "===>time span #{time_span.inspect}, timeup #{quest.timeup}, wudu_team #{team_wudu.size} team_zhongyuan #{team_zhongyuan.size} full #{quest.full}"
                    if (team_zhongyuan.size>= quest.full && team_wudu.size>=quest.full && time_span > quest.timeup)
                        q[:stat] = 1 # fighting
                        q.save!
                        quest.doBattle(q)
                    end
                }

            }
            sleep (1800) # per hour
        end
    }

    Process.detach fork{
        # recover rails db environment
        Userext.connection.reconnect! 
        while(1)
      
            # richers
            rs = Userext.find_by_sql("select * from users, userexts where users.id=userexts.uid order by gold desc limit 10")
            view = ActionView::Base.new(Rails::Configuration.new.view_path)
            page = view.render(:file=>"rank/rankmoney", :locals=>{:rs=>rs})
            begin
                 aFile = File.new("public/rank_money.html","w+")
                 aFile.puts page
                 aFile.close
            rescue Exception=>e
                 # logger.error e
                 p e.inspect
            end
        
        
            # highthand
            rs = Userext.find_by_sql("select * from users, userexts where users.id=userexts.uid order by level desc limit 10")
            view = ActionView::Base.new(Rails::Configuration.new.view_path)
            page = view.render(:file=>"rank/ranklevel", :locals=>{:rs=>rs})
            begin
                 aFile = File.new("public/rank_level.html","w+")
                 aFile.puts page
                 aFile.close
            rescue Exception=>e
                 # logger.error e
                 p e.inspect
            end
        
            sleep (3600*24) # per day
        end
    }

end