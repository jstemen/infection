require 'spec_helper'

describe Exploration do

  it 'include all explorations in Exploration.all' do
    exp = Exploration.new
    expect(Exploration.all).to include(exp)
  end

  it 'removes all explorations' do
    exp = Exploration.new
    expect(Exploration.all).to include(exp)
    Exploration.remove_all
    expect(Exploration.all.size).to eq(0)
  end

  it 'removes a single exploration' do
    exp = Exploration.new
    expect(Exploration.all).to include(exp)
    Exploration.remove(exp)
    expect(Exploration.all.size).to eq(0)
  end

end