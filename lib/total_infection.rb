
# Infects all people connected to the input person
class TotalInfection

  def infect(patient_zero)
    to_explore = []
    to_explore << patient_zero

    test_version = patient_zero.version
    until to_explore.empty?
      person = to_explore.pop
      puts "Infecting: '#{person.to_s}'"
      person.version = test_version

      person.associates.each do |associate|
        if associate.version != test_version
          puts "adding #{associate} to 'to_infect' list"
          to_explore << associate
        else
         puts "#{associate} already infected "
        end
      end

    end

    puts "infect list size is: #{to_explore.size}"

  end
end
