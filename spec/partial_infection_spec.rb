require 'spec_helper'

def t_graph
  @t_graph ||= begin
    a = Person.new('a')
    b = Person.new('b')
    c = Person.new('c')
    d = Person.new('d')

    d.add_student(c)
    a.add_student(b)
    a.add_student(c)
    [a, b, c, d].freeze
  end
end

def i_graph
  @i_graph ||= begin
    e = Person.new('e')
    f = Person.new('f')
    e.add_coach(f)
    [e, f].freeze
  end
end

def tri_graph
  @tri_graph ||= begin
    g = Person.new('g')
    h = Person.new('h')
    i = Person.new('i')
    j = Person.new('j')
    k = Person.new('k')

    h.add_student(g)
    h.add_student(j)
    h.add_student(i)
    k.add_student(h)
    [g, h, i, j, k].freeze
  end
end

describe PartialInfection do

  it 'returns an array of people' do
    partial_infection = PartialInfection.new(i_graph, 2.0, 2, 2)
    infected = partial_infection.infect(2, 2)
    expect(infected).to be_kind_of(Array)
    expect(infected.first).to be_kind_of(Person)
  end

  it 'throws error if it can not infect enough people' do
    partial_infection = PartialInfection.new(i_graph, 2.0, 4, 5)
    expect { partial_infection.infect(10, 10) }.to raise_error(PartialInfection::CanNotFindEnoughPeople)
  end

  it 'can merge exploration groups that belong to the same graph' do
    partial_infection = PartialInfection.new(t_graph, 2.0, t_graph.size, 1)
    infected = partial_infection.infect(t_graph.size, t_graph.size)
    expect(infected.size).to eq(t_graph.size)
    expect(infected).to include(*t_graph)
  end

  it 'infects number of people with in range if possible' do
    partial_infection = PartialInfection.new(i_graph + tri_graph + t_graph, 2.0, 10, 3)
    infected = partial_infection.infect(2, 2)
    expect(infected).to include(*i_graph)
    expect(infected.size).to eq(2)
  end

  it 'changes the infected people to the target version' do
    target_version = 2.0
    partial_infection = PartialInfection.new(i_graph, target_version, 1, 2)
    infected = partial_infection.infect(2, 2)
    infected.each { |i| expect(i.version).to eq(target_version) }
  end

  context 'when processing all three example graphs' do
    PERMUTATION_COUNT = 100
    (tri_graph + i_graph + t_graph).permutation.take(PERMUTATION_COUNT).each do |people|
      it "returns tri_graph when asking for 5 people, with following order #{people.join(', ')} " do
        partial_infection = PartialInfection.new(people, 2.0, 10, 10)
        infected = partial_infection.infect(5, 5)
        expect(infected.size).to eq(tri_graph.size)
        expect(infected).to include(*tri_graph)
      end
      it "returns t_graph when asking for 4 people, with following order #{people.join(', ')} " do
        partial_infection = PartialInfection.new(people, 2.0, 10, 10)
        infected = partial_infection.infect(4, 4)
        expect(infected.size).to eq(t_graph.size)
        expect(infected).to include(*t_graph)
      end
      it "returns i_graph when asking for 2 people, with following order #{people.join(', ')} " do
        partial_infection = PartialInfection.new(people, 2.0, 10, 10)
        infected = partial_infection.infect(2, 2)
        expect(infected.size).to eq(i_graph.size)
        expect(infected).to include(*i_graph)
      end
    end
  end

end