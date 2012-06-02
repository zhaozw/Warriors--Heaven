#level =  43
level = $*[0].to_i
p level
a = 0
for i in 0..level
	a += i*i*i
end
exp = a
fullskill=((exp*10)**(1/3.0)).to_i
p "level=#{level}, exp=#{exp}, fullskill=#{fullskill}"
p "exp for skill level #{fullskill} is #{fullskill**3/10}"
