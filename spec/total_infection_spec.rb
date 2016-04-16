require_relative 'spec_helper'

describe TotalInfection do

  it 'should infect the network' do
    test_version = 2.0
    coach = Person.new('tom')
    student_a = Person.new('underling 1')
    student_a.version= 2.0
    student_b = Person.new('underling 2')
    coach.add_student(student_a)
    coach.add_student(student_b)


    TotalInfection.new.infect(student_a)
    expect(coach.version).to eq(test_version)
    expect(student_b.version).to eq(test_version)

  end

end