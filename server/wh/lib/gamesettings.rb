#==============================#
#           Title system       #
#==============================#
def default_male_title_list
    [
        {
            :level=>0,
            :name=>"新人"
        },
        {
            :level=>5,
            :name=>"武者"
        },
        {
            :level=>10,
            :name=>"少侠"
        },
        {
            :level=>20,
            :name=>"侠客"
        }
    ]
end
def default_female_title_list
    [
        {
            :level=>0,
            :name=>"新人"
        },
        {
            :level=>5,
            :name=>"女武者"
        },
        {
            :level=>10,
            :name=>"女少侠"
        },
        {
            :level=>20,
            :name=>"女侠"
        }
    ]
end
def titleForLevel(level, gender)
    
    if gender == 0
        list = default_female_title_list
    # elsif gender == 1
    else
        list = default_male_title_list
    end
    
    p "===>update_title5 level=#{level}, gender=#{gender}, list=#{list.inspect}"
    for i in 0..list.size-1
        if list[i][:level] >=level
            return list[i][:name]
        end
    end
    
    return ""
        
end

# # set first title
# def setTitle1(c)
#     title = c.tmp[:title]
#     t = titleForLevel(c.tmp[:level], c.tmp[:sex])
#     if title!= nil and title.size>0
#         titles = title.split(" ")
#         if titles.size>1 and title2[1]!=nil and title2[1].size>0
#             t += " "+ titles[1]
#         end
#     end
# end


#==============================#
#           LEVEL BOSS         #
#==============================#

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