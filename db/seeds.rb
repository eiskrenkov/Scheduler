# 0 - Lection
# 1 - Practice
# 2 - Laboratory
# 3 - Seminar
# 4 - Other

Schedule.delete_all
Weekday.delete_all
Pair.delete_all

Weekday.create(id: 0, name: 'Воскресенье')
Weekday.create(id: 1, name: 'Понедельник')
Weekday.create(id: 2, name: 'Вторник')
Weekday.create(id: 3, name: 'Среда')
Weekday.create(id: 4, name: 'Четверг')
Weekday.create(id: 5, name: 'Пятница')
Weekday.create(id: 6, name: 'Суббота')

Schedule.create(id: 1, semester: 4)
Schedule.first.weekdays = Weekday.all

# Monday
Pair.create(id: 0, name: 'Военная Кафедра', kind: 4, place: nil, start_time: '9:00', end_time: '13:50')
Weekday.find(1).pairs = [Pair.find(0)]

# Tuesday
Pair.create(id: 1, name: 'Исследование Операций', kind: 0, place: '115', start_time: '9:00', end_time: '10:20')
Pair.create(id: 2, name: 'Основы Радиоэлектроники', kind: 0, place: '119', start_time: '10:30', end_time: '11:50')
Pair.create(id: 3, name: 'Общая Физика', kind: 1, place: '717', start_time: '12:00', end_time: '13:20')
Pair.create(id: 4, name: 'Общая Физика', kind: 2, place: nil, start_time: '13:50', end_time: '15:10')
Pair.create(id: 5, name: 'Общая Физика', kind: 2, place: nil, start_time: '15:20', end_time: '16:40')
Pair.create(id: 6, name: 'Общая Физика', kind: 2, place: nil, start_time: '16:50', end_time: '18:10')
(1..6).each { |number| Weekday.find(2).pairs << Pair.find(number) }

# Wednesday
Pair.create(id: 7, name: 'Общая Физика', kind: 0, place: '117', start_time: '9:00', end_time: '10:20')
Pair.create(id: 8, name: 'Экономика', kind: 0, place: '115', start_time: '10:30', end_time: '11:50')
Pair.create(id: 9, name: 'Физкультура', kind: 4, place: 'спортзал', start_time: '12:00', end_time: '13:20')
Pair.create(id: 10, name: 'Экономика', kind: 3, place: '609', start_time: '13:50', end_time: '15:10')
Pair.create(id: 11, name: 'БЖЧ', kind: 4, place: '705', start_time: '15:20', end_time: '16:40')
(7..11).each { |number| Weekday.find(3).pairs << Pair.find(number) }

# Thursday
Pair.create(id: 12, name: 'Основы Радиоэлектроники', kind: 2, place: '73', start_time: '9:00', end_time: '10:20')
Pair.create(id: 13, name: 'Основы Радиоэлектроники', kind: 2, place: '73', start_time: '10:30', end_time: '11:50')
Pair.create(id: 14, name: 'Основы Радиоэлектроники', kind: 2, place: '73', start_time: '12:00', end_time: '13:20')
Pair.create(id: 15, name: 'Прикладное программирование', kind: 0, place: '115', start_time: '13:50', end_time: '15:10')
Pair.create(id: 16, name: 'Физкультура', kind: 4, place: 'спортзал', start_time: '15:20', end_time: '16:40')
(12..16).each { |number| Weekday.find(4).pairs << Pair.find(number) }

# Friday
Pair.create(id: 17, name: 'Философия', kind: 3, place: '612', start_time: '9:00', end_time: '10:20')
Pair.create(id: 18, name: 'Прикладное Программирование', kind: 2, place: '124-3', start_time: '10:30', end_time: '11:50')
Pair.create(id: 19, name: 'Прикладное Программирование', kind: 2, place: '124-3', start_time: '12:00', end_time: '13:20')
(17..19).each { |number| Weekday.find(5).pairs << Pair.find(number) }

# Saturday
Pair.create(id: 20, name: 'Философия', kind: 0, place: '119', start_time: '9:00', end_time: '10:20')
Pair.create(id: 21, name: 'Философия', kind: 0, place: '119', start_time: '10:30', end_time: '11:50')
Pair.create(id: 22, name: 'БЖЧ', kind: 0, place: '115', start_time: '12:00', end_time: '13:20')
Pair.create(id: 23, name: 'БЖЧ', kind: 0, place: '115', start_time: '13:50', end_time: '15:10')
(20..23).each { |number| Weekday.find(6).pairs << Pair.find(number) }
