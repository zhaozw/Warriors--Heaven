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
            :name=>  "objects/npc/hero/guiwuzhe",
            :level=>15,
        }
    ]
end
def BossForLevelupTo(level)
    ar = []
    HeroesList.each {|h|
        if h[:level] <= level
            ar.push h
        end
    }
    # lb = levelBosses[level.to_s]
    return ar
end