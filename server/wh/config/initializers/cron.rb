require "utility.rb"
require 'memcache.rb'
    mcd_default_options = {
            :namespace => 'game:user',
            :memcache_server => 'localhost:11211'
    }

if (!$memcached)  
$memcached= MemCache.new(mcd_default_options[:memcache_server], mcd_default_options)
end
 Dir["#{File.dirname(__FILE__)}/../../lib/**/*.rb"].each { |f| 
            load(f)
             p "load #{f}"
         }
Process.detach fork{
    while(1)
        sleep (3600) # per hour
        p "."
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

    end
}