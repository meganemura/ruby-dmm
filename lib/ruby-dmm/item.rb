# vim: ts=2 sts=2 et sw=2 ft=ruby
module DMM
  class Item
  end
  
  class << self
    attr_accessor :keywords
  end
  @keywords = {}

  class Keyword
    class << self
      def [](id)
        DMM.keywords[id] ||= :a
      end
    end
    def initialize(id, name)
      @id = id
      @name = name
      DMM.keywords << self
    end
  end
  # DMM.keywords
end
