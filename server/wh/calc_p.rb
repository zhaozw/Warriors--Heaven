a = {}
m = 11
ar = [0,1,2,3,4,5,6,7,8,9]
#ar =[0,1]
p "size #{ar.size}"
luck = 50
srand(Time.now.tv_usec.to_i)

for i in 0..10000
    # b  = rand(m*2)+rand(m*2) +m/2
     # b = (rand(m*2)+rand(m*2))/2
     #    if b > m-1
     #       b = m-b %m
     #   end
       #a = rand(100-luck)/((100.0)/7).to_i
    # a = rand(7)-rand(luck)*7/100

#   b = rand(9)
    #b = 9 if b > 9
#   next if b > 9
#   while b >m
#       b = (rand(m*2)+rand(m*2))/2
#   end
#   b = b/2 if b > m
    # b = rand(ar.size)-rand(luck)*ar.size/100
    
                    index = (rand(ar.size*2) + rand(ar.size*2))/2
                if index >= ar.size
                    index = ar.size - index%ar.size
                    #index = ar.size-1 if index == ar.size
                    index = 0  if index == ar.size
                end
                p "!!!" if index <0 or index > ar.size
                b= index
    
    if !a[b.to_s]
        a[b.to_s] = 0
    end
    a[b.to_s] += 1
end

a.sort()
t = 0
for k in a.keys.sort
# a.each{|k,v|
p "#{k}=#{a[k]*100.0/10000.0}"
t += a[k]*100.0/10000.0
# }
end
p "total #{t}"
