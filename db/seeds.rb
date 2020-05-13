PAIRS_START_TIME = ['9:00', '10:30', '12:00', '13:20', '15:20', '16:50'].freeze

# Creating new group with schedule
(4..6).each do |group_number|
  Group.create(name: group_number.to_s).tap do |group|
    group.schedule.working_days.each do |weekday|
      weekday.pairs = 0.upto(rand(3...6)).map do |pair_index|
        Pair.create(
          name: "Пара ##{SecureRandom.uuid.to_s.first(4).upcase}",
          kind: PairKinds.list.sample,
          place: rand(100...200).to_s,
          start_time: PAIRS_START_TIME[pair_index]
        )
      end

      weekday.save!
    end
  end
end
