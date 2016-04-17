# Represents the people found during a exploration of a person graph
class Exploration

  class << self
    @@explorations = Set.new

    def all
      @@explorations
    end

    def remove(exp)
      @@explorations.delete(exp)
    end

    def remove_all
      @@explorations = Set.new
    end

  end

  attr_reader :people

  def initialize
    @@explorations << self
    @people = []
  end

  def add_person(person)
    @people << person
    person.exploration = self
  end

  def <=>(o)
    people.size <=> o.people.size
  end

end