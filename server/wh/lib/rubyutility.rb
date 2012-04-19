def generate_password(length=6)  
  chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'  
  password = ''  
  length.downto(1) { |i| password << chars[rand(chars.length - 1)] }  
  password  
end  
  