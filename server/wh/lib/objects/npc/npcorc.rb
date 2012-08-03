require 'objects/orc.rb'
require 'objects/npc/npc.rb'

class Npcorc < Orc
    include Npc
    def unit
       "只"
   end
end