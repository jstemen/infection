class Person
  attr_accessor :version, :name, :exploration

  def ==(other)
    @name == other.name
  end

  def to_s
    @name
  end

  def inspect
    to_s
  end

  def initialize(name=nil)
    @name = name
    @version = nil
    @students_arry = []
    @coaches_arry = []
  end

  # My algorithms treat edges a bidirectional. I added a distinction between
  # students and coaches to more accurately reflect the data model you guys/gals
  # probably use in the real world
  def associates
    students + coaches
  end

  def students
    #freeze to ensure that outside world must use add_* methods
    @students_arry.dup.freeze
  end

  def coaches
    @coaches_arry.dup.freeze
  end

  def add_student(student)
    @students_arry << student
    student.instance_variable_get(:@coaches_arry) << self
  end

  def add_coach(coach)
    @coaches_arry << coach
    coach.instance_variable_get(:@students_arry) << self
  end

end
