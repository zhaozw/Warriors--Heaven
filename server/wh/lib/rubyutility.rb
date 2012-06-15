def generate_password(length=6)  
  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ123456789'  
  password = ''  
  length.downto(1) { |i| password << chars[rand(chars.length - 1)] }  
  password  
end  
  
  
def i_to_ch(i)
    list = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
    s = i.to_s
    ret = ""
   
    for k in 0..s.size-1
        n = s[k]-48
        next if n == 0
       str=""
        d = list[n]
        l = s.size-k-1
        case l
        when 0: str=d
        when 1: 
            begin
            if n != 1
                str += d
            end
            str +="十"
            end
        when 2: str += d+"百"
        when 3: str += d+"千"
        when 3: str += d+"万"
        when 3: str += d+"十万"
        when 3: str += d+"百万"
        when 3: str += d+"千万"
        when 3: str += d+"十亿"
        when 3: str += d+"百亿"
        when 3: str += d+"千亿"
        when 3: str += d+"万亿"
        end
        ret += str
    end
    return ret
end
# p i_to_ch(3)