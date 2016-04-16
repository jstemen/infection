class PartialInfection

  def initialize(all_people, new_version, max_seeds=100, max_depth=100)
    @all_people = all_people
    @new_version = new_version
    @max_seeds = max_depth
    @max_depth = max_depth
  end

  #returns the infected
  def infect(min_to_infect, max_to_infect)

    person_to_exploration = {}
    exploration_to_people = {}
    people = @all_people.dup

    (1..@max_seeds).each do |exploration_count|
      patient_zero = people.pop

      to_explore = []
      to_explore << patient_zero

      depth = 0

      exploration_to_people[exploration_count] = []

      until to_explore.empty? || depth > @max_depth
        person = to_explore.pop
        puts "Visiting: '#{person.to_s}'"

        existing_exp = person_to_exploration[person]
        if (existing_exp) == nil
          #not part of any other exploration
          exploration_to_people[exploration_count] << person
          person_to_exploration[person] = exploration_count
        else
          if existing_exp == exploration_count
            #already meregd it, skip it
          else
            #need to merge explorations to one
            exploration_to_people[exploration_count] ||= []
            people_to_move = exploration_to_people[existing_exp]
            people_to_move.each do |person_to_mo|
              person_to_exploration[person_to_mo] = exploration_count
              exploration_to_people[exploration_count] <<  person_to_mo
            end
          end

        end


        person.associates.each do |associate|
          if vistied_in_exp.includes?(associate)
            puts "#{associate} already visited"
          else
            puts "adding #{associate} to 'to_infect' list"
            to_explore << associate
          end
        end

      end

      puts "infect list size is: #{to_explore.size}"

    end

  end
end
