require 'spec_helper'

describe PartialInfection do
  let(:t_graph) {
    a = Person.new('a')
    b = Person.new('b')
    c = Person.new('c')
    d = Person.new('d')

    d.add_student(c)
    a.add_student(b)
    a.add_student(c)
    [a, b, c, d]
  }

  let(:i_graph) {
    e = Person.new('e')
    f = Person.new('f')
    e.add_coach(f)
    [e, f]
  }

  let(:tri_graph) {
    g = Person.new('g')
    h = Person.new('h')
    i = Person.new('i')
    j = Person.new('j')
    k = Person.new('k')

    h.add_student(g)
    h.add_student(j)
    h.add_student(i)
    k.add_student(h)
    [g, h, i, j, k]
  }
  describe '#infect' do

  end
  it 'returns an array of people' do
    partial_infection = PartialInfection.new(i_graph, 2.0, 2, 2)
    infected = partial_infection.infect(2, 2)
    expect(infected).to be_kind_of(Array)
    expect(infected.first).to be_kind_of(Person)
  end

  #might ask for more people that we have total
  it 'throws error if it can not infect enough people' do
    partial_infection = PartialInfection.new(i_graph, 2.0, 4, 5)
    expect {partial_infection.infect(10, 10)}.to raise_error(ArgumentError)
  end

  it 'can merge exploration groups that belong to the same graph' do
    partial_infection = PartialInfection.new( t_graph, 2.0, t_graph.size, 1)
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
    partial_infection = PartialInfection.new(i_graph , target_version, 1, 2)
    infected = partial_infection.infect(2, 2)
    infected.each{|i| expect(i.version).to eq(target_version)}
  end

  context 'when processing all three example graphs' do
=begin
    (tri_graph + i_graph + t_graph).combinations.each do |people|


    end
=end
    it 'returns tri_grap when asking for 4 people' do
      partial_infection = PartialInfection.new( tri_graph + i_graph + t_graph , 2.0, 10, 10)
      infected = partial_infection.infect(5, 5)
      expect(infected.size).to eq(tri_graph.size)
      expect(infected).to include(*tri_graph)
    end
  end

  #
  it 'throws error if it can only infect too many people'

end