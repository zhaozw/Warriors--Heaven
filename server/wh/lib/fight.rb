
def damage_msg( damage,  type)

	 str="";
	return "造成 " + damage + " 点" + type + "。\n";
=begin
	if( damage == 0 ) return "结果没有造成任何伤害。\n";

	switch( type ) {
	case "擦伤":
	case "割伤":
		if( damage < 10 ) return "结果只是轻轻地划破$p的皮肉。\n";
		elseif( damage < 20 ) return "结果在$p$l划出一道细长血痕。\n";
		elseif( damage < 40 ) return "结果「嗤」一声划出一道伤口！\n";
		elseif( damage < 80 ) return "结果「嗤」地一声划出一道血淋淋的伤口！\n";
		elseif( damage < 160 ) return "结果「嗤」地一声划出一道又长又深的伤口，溅得$N满脸鲜血！\n";
		else return "结果只听见$n一声惨嚎，$w已在$p$l划出一道深及见骨的可怕伤口！！\n";
	    end
		break;
	case "刺伤":
		if( damage < 10 ) return "结果只是轻轻地刺破$p的皮肉。\n";
		elseif( damage < 20 ) return "结果在$p$l刺出一个创口。\n";
		elseif( damage < 40 ) return "结果「噗」地一声刺入了$n$l寸许！\n";
		elseif( damage < 80 ) return "结果「噗」地一声刺进$n的$l，使$p不由自主地退了几步！\n";
		elseif( damage < 160 ) return "结果「噗嗤」地一声，$w已在$p$l刺出一个血肉□糊的血窟窿！\n";
		else return "结果只听见$n一声惨嚎，$w已在$p的$l对穿而出，鲜血溅得满地！！\n";
		break;
	case "瘀伤":
		if( damage < 10 ) return "结果只是轻轻地碰到，比拍苍蝇稍微重了点。\n";
		elseif( damage < 20 ) return "结果在$p的$l造成一处瘀青。\n";
		elseif( damage < 40 ) return "结果一击命中，$n的$l登时肿了一块老高！\n";
		elseif( damage < 80 ) return "结果一击命中，$n闷哼了一声显然吃了不小的亏！\n";
		elseif( damage < 120 ) return "结果「砰」地一声，$n退了两步！\n";
		elseif( damage < 160 ) return "结果这一下「砰」地一声打得$n连退了好几步，差一点摔倒！\n";
		elseif( damage < 240 ) return "结果重重地击中，$n「哇」地一声吐出一口鲜血！\n";
		else return "结果只听见「砰」地一声巨响，$n像一捆稻草般飞了出去！！\n";
	    end
		break;
	case "内伤":
		if( damage < 10 ) return "结果只是把$n打得退了半步，毫发无损。\n";
		elseif( damage < 20 ) return "结果$n痛哼一声，在$p的$l造成一处瘀伤。\n";
		elseif( damage < 40 ) return "结果一击命中，把$n打得痛得弯下腰去！\n";
		elseif( damage < 80 ) return "结果$n闷哼了一声，脸上一阵青一阵白，显然受了点内伤！\n";
		elseif( damage < 120 ) return "结果$n脸色一下变得惨白，昏昏沉沉接连退了好几步！\n";
		elseif( damage < 160 ) return "结果重重地击中，$n「哇」地一声吐出一口鲜血！\n";
		elseif( damage < 240 ) return "结果「轰」地一声，$n全身气血倒流，口中鲜血狂喷而出！\n";
		else return "结果只听见几声喀喀轻响，$n一声惨叫，像滩软泥般塌了下去！！\n";
		end
		break;
	default:
		if( !type ) type = "伤害";
		if( damage < 10 ) str =  "结果只是勉强造成一处轻微";
		elseif( damage < 20 ) str = "结果造成轻微的";
		elseif( damage < 30 ) str = "结果造成一处";
		elseif( damage < 50 ) str = "结果造成一处严重";
		elseif( damage < 80 ) str = "结果造成颇为严重的";
		elseif( damage < 120 ) str = "结果造成相当严重的";
		elseif( damage < 170 ) str = "结果造成十分严重的";
		elseif( damage < 230 ) str = "结果造成极其严重的";
		else str =  "结果造成非常可怕的严重";
		end
		return str + type + "！\n";
	end
=end
end
