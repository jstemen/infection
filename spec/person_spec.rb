require_relative '../spec/spec_helper'

describe Person do
  let(:person) {
    p = Person.new()
    p.version = 1.0
    p
  }

  it 'should have associates' do
    expect(person.associates).to respond_to(:<<)
  end

  describe '#students' do
    it 'should have students' do
      expect(person.students).to respond_to(:<<)
    end

    it 'should be immutable' do
      expect(person.students).to be_frozen
    end

  end

  describe '#coaches' do

    it 'should have coaches' do
      expect(person.coaches).to respond_to(:<<)
    end
    it 'should be immutable' do
      expect(person.coaches).to be_frozen
    end

  end

  describe '#add_student' do
    it 'should add the current person to the student\'s  coaches' do
      coach = Person.new
      student = Person.new
      coach.add_student(student)
      expect(student.coaches).to include(coach)
    end
  end

  describe '#add_coach' do
    it 'should add the current person to the coache\'s  students' do
      coach = Person.new
      student = Person.new
      student.add_coach(coach)
      expect(coach.students).to include(student)
    end
  end


  it 'should have a version' do
    expect(person.version).to be_kind_of(Float)
  end

end
