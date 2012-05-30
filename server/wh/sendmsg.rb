require "fileutils"
require "lib/utility.rb"

#p $*.inspect
if $*.size >0
a = $*[1..$*.size-1].join(" ")
send_msg($*[0].to_i, a)
else
    p "no message specified"
end
