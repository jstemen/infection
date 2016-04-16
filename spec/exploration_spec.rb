require 'spec_helper'

describe Exploration do

  it 'include all explorations in Exploration.all' do
    exp = Exploration.new
    expect(Exploration.all).to include(exp)

  end
end