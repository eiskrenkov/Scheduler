# 0 - Lection
# 1 - Practice
# 2 - Laboratory
# 3 - Seminar
# 4 - Other

# Cleaning current DB
Schedule.delete_all
Weekday.delete_all
Pair.delete_all

# Weekdays
Weekdays.list.each_with_index do |weekday, index|
  Weekday.create(id: index, name: Weekdays.t(weekday))
end

# Schedule
Schedule.create(id: 1, semester: 4)
Schedule.first.weekdays = Weekday.all

# Monday
Pair.create(id: 0, name: 'Военная Кафедра', kind: '', place: '', start_time: '9:00', end_time: '13:50')
Weekday.find(1).pairs = [Pair.find(0)]

# Tuesday
Pair.create(id: 1, name: 'Исследование Операций', kind: PairKinds::LECTION, place: '115', start_time: '9:00', end_time: '10:20')
Pair.create(id: 2, name: 'Основы Радиоэлектроники', kind: PairKinds::LECTION, place: '119', start_time: '10:30', end_time: '11:50')
Pair.create(id: 3, name: 'Общая Физика', kind: PairKinds::PRACTICE, place: '717', start_time: '12:00', end_time: '13:20')
Pair.create(id: 4, name: 'Общая Физика', kind: PairKinds::LABORATORY, place: '', start_time: '13:50', end_time: '15:10')
Pair.create(id: 5, name: 'Общая Физика', kind: PairKinds::LABORATORY, place: '', start_time: '15:20', end_time: '16:40')
Pair.create(id: 6, name: 'Общая Физика', kind: PairKinds::LABORATORY, place: '', start_time: '16:50', end_time: '18:10')
(1..6).each { |number| Weekday.find(2).pairs << Pair.find(number) }

# Wednesday
Pair.create(id: 7, name: 'Общая Физика', kind: PairKinds::LECTION, place: '117', start_time: '9:00', end_time: '10:20')
Pair.create(id: 8, name: 'Экономика', kind: PairKinds::LECTION, place: '115', start_time: '10:30', end_time: '11:50')
Pair.create(id: 9, name: 'Физкультура', kind: '', place: 'спортзал', start_time: '12:00', end_time: '13:20')
Pair.create(id: 10, name: 'Экономика', kind: PairKinds::SEMINAR, place: '609', start_time: '13:50', end_time: '15:10')
Pair.create(id: 11, name: 'БЖЧ', kind: '', place: '705', start_time: '15:20', end_time: '16:40')
(7..11).each { |number| Weekday.find(3).pairs << Pair.find(number) }

# Thursday
Pair.create(id: 12, name: 'Основы Радиоэлектроники', kind: PairKinds::LABORATORY, place: '73', start_time: '9:00', end_time: '10:20')
Pair.create(id: 13, name: 'Основы Радиоэлектроники', kind: PairKinds::LABORATORY, place: '73', start_time: '10:30', end_time: '11:50')
Pair.create(id: 14, name: 'Основы Радиоэлектроники', kind: PairKinds::LABORATORY, place: '73', start_time: '12:00', end_time: '13:20')
Pair.create(id: 15, name: 'Прикладное программирование', kind: PairKinds::LECTION, place: '115', start_time: '13:50', end_time: '15:10')
Pair.create(id: 16, name: 'Физкультура', kind: '', place: 'спортзал', start_time: '15:20', end_time: '16:40')
(12..16).each { |number| Weekday.find(4).pairs << Pair.find(number) }

# Friday
Pair.create(id: 17, name: 'Философия', kind: PairKinds::SEMINAR, place: '612', start_time: '9:00', end_time: '10:20')
Pair.create(id: 18, name: 'Прикладное Программирование', kind: PairKinds::LABORATORY, place: '124-3', start_time: '10:30', end_time: '11:50')
Pair.create(id: 19, name: 'Прикладное Программирование', kind: PairKinds::LABORATORY, place: '124-3', start_time: '12:00', end_time: '13:20')
(17..19).each { |number| Weekday.find(5).pairs << Pair.find(number) }

# Saturday
Pair.create(id: 20, name: 'Философия', kind: PairKinds::LECTION, place: '119', start_time: '9:00', end_time: '10:20')
Pair.create(id: 21, name: 'Философия', kind: PairKinds::LECTION, place: '119', start_time: '10:30', end_time: '11:50')
Pair.create(id: 22, name: 'БЖЧ', kind: PairKinds::LECTION, place: '115', start_time: '12:00', end_time: '13:20')
Pair.create(id: 23, name: 'БЖЧ', kind: PairKinds::LECTION, place: '115', start_time: '13:50', end_time: '15:10')
(20..23).each { |number| Weekday.find(6).pairs << Pair.find(number) }
