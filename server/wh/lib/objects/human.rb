require 'objects/livingobject.rb'


class Human < LivingObject
    
    def limbs
    [
        "头部", "颈部", "胸口", "后心", "左肩", "右肩", "左臂",
        "右臂", "左手", "右手", "腰间", "小腹", "左腿", "右腿",
        "左脚", "右脚"
    ]
    end
    
end