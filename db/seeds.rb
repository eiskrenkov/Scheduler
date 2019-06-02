# rubocop:disable Metrics/LineLength

# Cleaning current DB
Schedule.delete_all
Weekday.delete_all
Pair.delete_all

# Weekdays
Weekdays.list.each_with_index do |weekday, index|
  Weekday.create(id: index, name: Weekdays.t(weekday))
end

# Schedule
Schedule.create(semester: 4)
Schedule.last.weekdays = Weekday.all

# Monday
Weekday.find(1).pairs = [Pair.create(id: 0, name: 'Военная Кафедра', kind: '', place: '', start_time: '9:00', end_time: '13:50')]

[ # Tuesday
  Pair.create(name: 'Исследование Операций', kind: PairKinds::LECTION, place: '115', start_time: '9:00', end_time: '10:20'),
  Pair.create(name: 'Основы Радиоэлектроники', kind: PairKinds::LECTION, place: '119', start_time: '10:30', end_time: '11:50'),
  Pair.create(name: 'Общая Физика', kind: PairKinds::PRACTICE, place: '717', start_time: '12:00', end_time: '13:20'),
  Pair.create(name: 'Общая Физика', kind: PairKinds::LABORATORY, place: '', start_time: '13:50', end_time: '15:10'),
  Pair.create(name: 'Общая Физика', kind: PairKinds::LABORATORY, place: '', start_time: '15:20', end_time: '16:40'),
  Pair.create(name: 'Общая Физика', kind: PairKinds::LABORATORY, place: '', start_time: '16:50', end_time: '18:10')
].each { |pair| Weekday.find(2).pairs << pair }

[ # Wednesday
  Pair.create(name: 'Общая Физика', kind: PairKinds::LECTION, place: '117', start_time: '9:00', end_time: '10:20'),
  Pair.create(name: 'Экономика', kind: PairKinds::LECTION, place: '115', start_time: '10:30', end_time: '11:50'),
  Pair.create(name: 'Физкультура', kind: '', place: 'спортзал', start_time: '12:00', end_time: '13:20'),
  Pair.create(name: 'Экономика', kind: PairKinds::SEMINAR, place: '609', start_time: '13:50', end_time: '15:10'),
  Pair.create(name: 'БЖЧ', kind: '', place: '705', start_time: '15:20', end_time: '16:40')
].each { |pair| Weekday.find(3).pairs << pair }

[ # Thursday
  Pair.create(name: 'Основы Радиоэлектроники', kind: PairKinds::LABORATORY, place: '73', start_time: '9:00', end_time: '10:20'),
  Pair.create(name: 'Основы Радиоэлектроники', kind: PairKinds::LABORATORY, place: '73', start_time: '10:30', end_time: '11:50'),
  Pair.create(name: 'Основы Радиоэлектроники', kind: PairKinds::LABORATORY, place: '73', start_time: '12:00', end_time: '13:20'),
  Pair.create(name: 'Прикладное программирование', kind: PairKinds::LECTION, place: '115', start_time: '13:50', end_time: '15:10'),
  Pair.create(name: 'Физкультура', kind: '', place: 'спортзал', start_time: '15:20', end_time: '16:40')
].each { |pair| Weekday.find(4).pairs << pair }

[ # Friday
  Pair.create(name: 'Философия', kind: PairKinds::SEMINAR, place: '612', start_time: '9:00', end_time: '10:20'),
  Pair.create(name: 'Прикладное Программирование', kind: PairKinds::LABORATORY, place: '124-3', start_time: '10:30', end_time: '11:50'),
  Pair.create(name: 'Прикладное Программирование', kind: PairKinds::LABORATORY, place: '124-3', start_time: '12:00', end_time: '13:20'),
].each { |pair| Weekday.find(5).pairs << pair }

[ # Saturday
  Pair.create(id: 20, name: 'Философия', kind: PairKinds::LECTION, place: '119', start_time: '9:00', end_time: '10:20'),
  Pair.create(id: 21, name: 'Философия', kind: PairKinds::LECTION, place: '119', start_time: '10:30', end_time: '11:50'),
  Pair.create(id: 22, name: 'БЖЧ', kind: PairKinds::LECTION, place: '115', start_time: '12:00', end_time: '13:20'),
  Pair.create(id: 23, name: 'БЖЧ', kind: PairKinds::LECTION, place: '115', start_time: '13:50', end_time: '15:10')
].each { |pair| Weekday.find(6).pairs << pair }

# rubocop:enable Metrics/LineLength
