# Creating new group with schedule
Group.create(name: Time.now.to_i.to_s.last(2).split('').join('+')).tap do |group|
  group.schedule.working_days.each do |weekday|
    weekday.pairs = Array.new(
      rand(4..6),
      Pair.create(
        name: "Pair ##{SecureRandom.uuid.to_s.first(4).upcase}",
        kind: PairKinds.list.sample,
        place: rand(100...200).to_s,
        start_time: [rand(1..24), %w[20 30 50].sample].join(':')
      )
    )

    weekday.save!
  end
end
