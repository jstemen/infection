class PartialInfection

  def initialize(all_people, new_version, max_seeds=100, max_depth=100)
    @all_people = all_people
    @new_version = new_version
    @max_seeds = max_seeds
    @max_depth = max_depth
  end

  # returns Array of the infected with new version
  def infect(min_to_infect, max_to_infect)
    fail ArgumentError.new("Not enough people in system") if @all_people.size < min_to_infect
    Exploration.remove_all
    people = @all_people.dup
    (1..@max_seeds).each do |exploration_count|
      patient_zero = people.pop

      #breakout if we ran out of people
      break unless patient_zero

      to_explore = [patient_zero]

      exploration = Exploration.new

      depth = 0
      until to_explore.empty? || depth > @max_depth
        person = to_explore.pop
        puts "Visiting: '#{person.to_s}'"

        existing_exp = person.exploration
        if existing_exp.nil?
          #not part of any other exploration
          exploration.add_person(person)
        else
          if existing_exp == exploration
            raise "already merged it,  This shouldn't happen"
          else
            #need to merge old exploration to new one
            existing_exp.people.each do |person_to_mo|
              exploration.add_person(person_to_mo)
            end
            Exploration.remove(existing_exp)
          end
        end

        person.associates.each do |associate|
          if exploration.people.include?(associate)
            puts "#{associate} already visited"
          else
            puts "adding #{associate} to 'to_infect' list"
            to_explore << associate
          end
        end

        depth +=1
      end

      puts "infect list size is: #{to_explore.size}"

    end

    # largest to smallest
    exps = Exploration.all.sort.reverse!
    accu = []
    exps.each do |exploration|
      if exploration.people.size <= (max_to_infect - accu.size)
        accu += exploration.people
      end
    end
    accu.each { |p| p.version = @new_version }
    accu
  end
end
