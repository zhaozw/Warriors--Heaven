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

# the level means user level must be >= level of all heroes whose level is less than users level.
# for example: user level is 5, then all heroes whose level <5 should be passed.
# if user levelup to 6, then he need to pass all heroes whose level < 6, yezhu here.
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
# return 6, 11, 16, 21 ...
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
    return h_level+1
end

def BossForLevel(level)
    h_level = getNextStageLevel(level)
    BossForLevelupTo(h_level)
end

# boss needed to pass when up level to n
# e.g. 5->6, yezhu
# 10->11, yezhu & weizhangtianxin
def BossForLevelupTo(level)
    ar = []
    hero_list.each {|h|
        if h[:level] < level
            ar.push h
        end
    }
    # lb = levelBosses[level.to_s]
    return ar
end