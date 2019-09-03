# Creating new group with schedule
Group.create(name: Time.now.to_i.to_s.last(2).split('').join('+')).tap do |group|
  group.schedule.weekdays.each do |weekday|
    next if weekday.weekend?

    weekday.pairs = [
      Pair.create(name: 'Some Pair 1', kind: PairKinds::LECTION, place: '115', start_time: '9:00'),
      Pair.create(name: 'Some Pair 2', kind: PairKinds::LECTION, place: '119', start_time: '10:30'),
      Pair.create(name: 'Some Pair 3', kind: PairKinds::PRACTICE, place: '717', start_time: '12:00'),
      Pair.create(name: 'Some Pair 4', kind: PairKinds::LABORATORY, start_time: '13:50'),
      Pair.create(name: 'Some Pair 5', start_time: '15:20'),
      Pair.create(name: 'Some Pair 6', kind: PairKinds::LABORATORY, start_time: '16:50')
    ]
  end
end
