require 'objects/human.rb'
require 'objects/npc/npc.rb'

class Npcorc < Human
    include Npc
    def unit
       "只"
   end
end