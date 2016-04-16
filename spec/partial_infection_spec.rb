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

    h.add_student(g)
    h.add_student(j)
    h.add_student(i)
    [g, h, i, j]
  }
  describe '#infect' do

  end
  it 'returns an array of people' do
    partial_infection = PartialInfection.new(i_graph, 2.0, 2, 2)
    infected = partial_infection.infect(0, 1)
    expect(infected).to be_kind_of(Array)
    expect(infected.first).to be_kind_of(Person)
  end

  #might ask for more people that we have total
  it 'throws error if it can not infect enough people' do
    partial_infection = PartialInfection.new(i_graph, 2.0, 4, 5)
    expect {partial_infection.infect(10, 10)}.to raise_error(ArgumentError)
  end

  it 'can merge exploration groups that belong to the same graph'
  it 'it infects number of people with in range if possible' do
    partial_infection = PartialInfection.new(i_graph + tri_graph + t_graph, 2.0, 10, 3)
    infected = partial_infection.infect(2, 2)
    expect(infected).to include(*i_graph)
  end

  #
  it 'throws error if it can only infect too many people'

end