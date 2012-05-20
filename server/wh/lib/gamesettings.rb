def levelBosses
    {
        "5" => [
            "objects/npc/hero/weizhangtianxin"
            ],
        "10" => [
            "objects/npc/hero/weizhangtianxin"
            ],
        "20" =>[]
    }
end
def BossForLevelup(level)
    lb = levelBosses[level.to_s]
    return lb
end