def translate_msg msg, context
    userext = context[:userext]
    target = context[:target]
    msg.gsub(/\$N/m, "你").gsub("/\$n/m", target[:name])
end