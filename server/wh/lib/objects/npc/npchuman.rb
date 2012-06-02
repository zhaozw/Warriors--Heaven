require 'objects/human.rb'
require 'objects/npc/npc.rb'

class Npchuman < Human
    include Npc
    def unit
        "个"
    end
end