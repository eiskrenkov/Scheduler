import telebot
from telebot import types
import requests
import datetime
import time
import os

token = '536301920:AAEZQ-_4mF2adGGWcSj2AF4XqHKGLKt2W6A'
skaffer = telebot.TeleBot(token)

@skaffer.message_handler(commands=['start'])
def start(message):
	help(message)

@skaffer.message_handler(commands=['help'])
def help(message):
	skaffer.send_message(message.chat.id, text = 'Что я могу: \n\n/tt - Получить полное расписание занятий \n/next - Какая же у меня следующая пара? \n/weather - Информация о погоде')

@skaffer.message_handler(commands=['weather'])
def weather(message):

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

	    skaffer.send_message(message.chat.id, weather_message)

	except Exception as e:
	    print("Exception while getting the weather", e)
	    pass

@skaffer.message_handler(commands=['tt'])
def timetable(message):
	skaffer.send_message(message.chat.id, 'Хорошо, сейчас я скину тебе расписание :)')
	with open('/Users/MrBlazOn/Desktop/SkafferBot/timetable.txt') as tt:
		temp = tt.read()
		skaffer.send_message(message.chat.id, temp)

@skaffer.message_handler(commands=['next'])
def next(message):
	current_time = list((str(datetime.datetime.now().time())).split(':'))
	hours = int(current_time[0])

	day = list(time.ctime().split())
	week_day = day[0]
	# week_day = 'Tue'
	week_day += '.txt'

	path = '/Users/MrBlazOn/Desktop/SkafferBot/days/'
	path += week_day

	with open(path) as week_day_file:
		pair = list(str(i) for i in week_day_file.readline().strip().split())
		
		if pair[0] != 'Сегодня':

			min_hours = 24
			next_pair = []
			while pair != []:
				pair_time = pair[0].split(':')

				pair_hour = int(pair_time[0])

				if pair_hour - hours <= min_hours:
					if pair_hour - hours > 0:

						next_pair = pair
						min_hours = pair_hour - hours

				pair = list(str(i) for i in week_day_file.readline().strip().split())

			if next_pair == []:
				skaffer.send_message(message.chat.id, 'На сегодня все пары закончились')
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

				skaffer.send_message(message.chat.id, pair_message)

		else:
			pair_message = ''
			for word in pair:
				pair_message += word
				pair_message += ' '

			skaffer.send_message(message.chat.id, pair_message)

skaffer.polling()