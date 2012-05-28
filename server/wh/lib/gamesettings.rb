def levelBosses
    {
        "5" => [
            "objects/npc/hero/yezhu"
            ],
        "10" => [
            "objects/npc/hero/weizhangtianxin"
            ],
        "15" =>[
            "objects/npc/hero/guiwuzhe"
            ],
        "20" =>[]
    }
end

def hero_list
    [
        {
            :name=> "objects/npc/hero/yezhu",
            :level=>5,
        },
        {
            :name=>"objects/npc/hero/weizhangtianxin",
            :level=>10,
        },
        {
            :name=>  "objects/npc/hero/yeren",
            :level=>15,
        },
       {
            :name=>  "objects/npc/hero/guiwuzhe",
            :level=>20,
        },
       {
            :name=>  "objects/npc/hero/lanfenghuang",
            :level=>25,
        },
       {
            :name=>  "objects/npc/hero/blackknight",
            :level=>30,
        },
       {
            :name=>  "objects/npc/hero/guiwuzhe",
            :level=>35,
        },
       {
            :name=>  "objects/npc/hero/guiwuzhe",
            :level=>40,
        },
       {
            :name=>  "objects/npc/hero/guiwuzhe",
            :level=>45,
        },
       {
            :name=>  "objects/npc/hero/guiwuzhe",
            :level=>50,
        }
    ]
end
    def getNextStageLevel(level)
        if level==0
            h_level = 5
        else
            if level/5*5 == level
               h_level =  level
            else
                h_level = (level+5)/5*5
            end
        end
        return h_level
    end
def BossForLevelupTo(level)
    h_level = getNextStageLevel(level)
    ar = []
    hero_list.each {|h|
        if h[:level] <= h_level
            ar.push h
        end
    }
    # lb = levelBosses[level.to_s]
    return ar
end