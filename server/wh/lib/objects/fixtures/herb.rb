require 'objects/fixtures/fixture.rb'


class Herb < Fixture
    def unit
        "株"
    end
    def use(context)
        context[:msg] = "めちゃくちゃに食べないでよ！"
    end
end