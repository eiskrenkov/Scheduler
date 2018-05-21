# This file contains all the commands that could be processed by Skaffer

# Импорт системных модулей
import requests
import datetime
import time
import os

# Импорт локального файла с настройками
import config

#Импорт класса для обработки изменений на сервере
from bothandler import BotHandler as handler

# Создание бота с заданным токеном
skaffer = handler(config.token)

def start(last_chat_id, last_chat_name):
	greet_msg = 'Привет, '
	greet_msg += last_chat_name
	greet_msg += '! Меня зовут Skaffer и я полностью в твоем распоряжении :)\nP.S Используй /help, чтобы узнать, что я умею'
	skaffer.send_message(last_chat_id, greet_msg)

# Функция отправляет в чат сообщение с полезной для пользователя информацией
def help(last_chat_id):
	skaffer.send_message(last_chat_id, text = 'Что я могу:\n\n/tt - Получить полное расписание занятий\n/next - Какая же у меня следующая пара?\n/weather - Информация о погоде\n/tod - Расписание на сегодня\n/tom - Расписание на завтра\n/bus47 - Время прибытия 47-го автобуса на остановку "Курчатова"')

# Функция отправляет в чат список изменений в последней версии бота
def changelog(last_chat_id):
	with open('changelog.txt') as changelog_file:
		changelog_text = changelog_file.read()

	skaffer.send_message(last_chat_id, changelog_text)

# Функция отправляет в чат все расписание занятий
def timetable(last_chat_id):
	with open('database/timetable.txt') as tt_file:
		tt_text = tt_file.read()

	skaffer.send_message(last_chat_id, 'Ваше расписание на второй семестр 1 курса:')
	skaffer.send_message(last_chat_id, tt_text)

# Функция отправляет в чат расписание занятий на сегодня
def today_timetable(last_chat_id):
	day = list(time.ctime().split())
	week_day = day[0]

	path = 'database/'
	path += week_day
	path += '.txt'

	with open(path) as tt_today_file:
		tt_today_text = tt_today_file.read()

	if week_day == 'Sat' or week_day == 'Sun':
		skaffer.send_message(last_chat_id, 'Сегодня выходной, какая учеба?')
	else:
		skaffer.send_message(last_chat_id, 'Ваше расписание на сегодня:')
		skaffer.send_message(last_chat_id, tt_today_text)

# Функция отправляет в чат расписание занятий на завтра
def tomorrow_timetable(last_chat_id):
	week_days_list = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']
	day = list(time.ctime().split())
	week_day = day[0]

	if week_day == 'Fri' or week_day == 'Sat':
		skaffer.send_message(last_chat_id, 'Завтра выходной, какая учеба?')
	else:
		if week_day == 'Sun':
			week_day = 'Mon'
		else:
			week_day_number = week_days_list.index(week_day)
			week_day = week_days_list[week_day_number + 1]

		path = 'database/'
		path += week_day
		path += '.txt'

		with open(path) as tt_tomorrow_file:
			tt_tomorrow_text = tt_tomorrow_file.read()

		skaffer.send_message(last_chat_id, 'Ваше расписание на завтра:')
		skaffer.send_message(last_chat_id, tt_tomorrow_text)

# Функция отправляет в чат сообщение с информацией о текущей погоде
def weather(last_chat_id):
	city = "Minsk,BY"
	city_id = 625144
	appid = "0e3ef2e80ad4ea15b7ee3bd7c701569f"

	try:
		weather_request = requests.get("http://api.openweathermap.org/data/2.5/weather",
					params={'id': city_id, 'units': 'metric', 'lang': 'ru', 'APPID': appid})
		weather_data = weather_request.json()

		weather_conditions = weather_data['weather'][0]['description']
		weather_temp = str(weather_data['main']['temp'])

		weather_message = 'Сейчас за окном '
		weather_message += weather_temp
		weather_message += ' градусов, '
		weather_message += weather_conditions

		skaffer.send_message(last_chat_id, weather_message)

	except Exception as error_message:
		print("Exception while getting the weather", error_message)
		pass

# Функция отправляет в чат сообщение с местом и временем следующей пары
def next(last_chat_id):
	current_time = list((str(datetime.datetime.now().time())).split(':'))
	hours = int(current_time[0]) + 3
	minutes = int(current_time[1])

	day = list(time.ctime().split())
	week_day = day[0]
	# week_day = 'Tue'

	path = 'database/'
	path += week_day
	path += '.txt'

	with open(path) as week_day_file:
		pair = list(str(i) for i in week_day_file.readline().strip().split())
		
		if pair[0] != 'Сегодня':

			min_hours = 24
			next_pair = []
			while pair != []:
				pair_time = pair[0].split(':')

				pair_hour = int(pair_time[0])
				pair_minute = int(pair_time[1])

				if pair_hour - hours <= 1 and pair_hour - hours >= 0:
					print(pair_hour, hours, pair_minute, minutes)

					if pair_hour - hours == 0:
						if pair_minute - minutes > 0:
							next_pair = pair
							break
					else:
						next_pair = pair
						break

				pair = list(str(i) for i in week_day_file.readline().strip().split())

			if next_pair == []:
				skaffer.send_message(last_chat_id, 'На сегодня все пары закончились')
			else:
				pair_message = 'Следующей парой у вас '
				pair_message += next_pair[2]
				pair_message += ' ('
				pair_message += next_pair[1]
				pair_message += ')'
				pair_message += ' в '
				pair_message += next_pair[0]
				pair_message += ' в кабинете '
				pair_message += next_pair[3]

				skaffer.send_message(last_chat_id, pair_message)

				next_pair_time = next_pair[0].split(':')
				if int(next_pair_time[0]) == 9:
					weather(last_chat_id)

		else:
			pair_message = ''
			for word in pair:
				pair_message += word
				pair_message += ' '

			skaffer.send_message(last_chat_id, pair_message)

def bus47(last_chat_id):
	current_time = list((str(datetime.datetime.now().time())).split(':'))
	hour = int(current_time[0])
	minute = int(current_time[1])

	day_bus = list(time.ctime().split())
	day_now = day_bus[0]

	if day_now != 'Sat' and day_now != 'Sun':
		with open('database/47_bus_timetable.txt') as bus_timetable:
			time_leave = list(str(i) for i in day_now_time.readline().strip().split(':'))
			time_bus = []
		
			while time_leave != ['']:
				min_hour = 24
				min_minute = 60

				true_time = []
				minute_table = int(time_leave[1])
				hour_table = int(time_leave[0])

				if hour_table - hour == 0:
					if minute_table - minute <= min_minute and minute_table - minute >= 0:
						time_bus = time_leave
						
						min_minute = minute_table - minute
						break
					elif hour_table - hour >= 0:
						time_bus = time_leave
						break

					time_leave = list(str(i) for i in day_now_time.readline().strip().split(':'))

				if time_bus == []:
					skaffer.send_message(last_chat_id, 'Автобус больше не приедет')
				else:
					message_time = 'Следующий автобус в '
					message_time += time_bus[0]
					message_time += ':'
					message_time += time_bus[1]
					message_time += ' на остановке "Курчатова"'
					skaffer.send_message(last_chat_id, message_time)
	else:
		skaffer.send_message(last_chat_id, 'По выходным 47с автобус не ходит')