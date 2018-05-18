import config # Файл содержит настройки бота

import requests
import datetime
import time
import os

# Класс для обработки изменений на сервере
class BotHandler:

	def __init__(self, token):
		self.token = token
		self.api_url = "https://api.telegram.org/bot{}/".format(token)

	def get_updates(self, offset = None, timeout = 30):
		method = 'getUpdates'
		params = {'timeout': timeout, 'offset': offset}
		resp = requests.get(self.api_url + method, params)
		result_json = resp.json()['result']
		return result_json

	def send_message(self, chat_id, text):
		params = {'chat_id': chat_id, 'text': text}
		method = 'sendMessage'
		resp = requests.post(self.api_url + method, params)
		return resp

	def get_last_update(self):
		get_result = self.get_updates()
		last_update = {}

		if len(get_result) > 0:
			last_update = get_result[-1]

		return last_update

def start(last_chat_id, last_chat_name):
	greet_msg = 'Привет, '
	greet_msg += last_chat_name
	greet_msg += '! Меня зовут Skaffer и я полностью в твоем распоряжении :)\nP.S Используй /help, чтобы узнать, что я умею'
	skaffer.send_message(last_chat_id, greet_msg)

# Функция отправляет в чат сообщение с полезной для пользователя информацией
def help(last_chat_id):
	skaffer.send_message(last_chat_id, text = 'Что я могу:\n\n/tt - Получить полное расписание занятий\n/next - Какая же у меня следующая пара?\n/weather - Информация о погоде\n/tod - Расписание на сегодня\n/tom - Расписание на завтра')

# Функция отправляет в чат список изменений в последней версии бота
def changelog(last_chat_id):
	with open('changelog.txt') as changelog_file:
		changelog_text = changelog_file.read()

	skaffer.send_message(last_chat_id, changelog_text)

# Функция отправляет в чат все расписание занятий
def timetable(last_chat_id):
	with open('timetable.txt') as tt_file:
		tt_text = tt_file.read()

	skaffer.send_message(last_chat_id, 'Ваше расписание на второй семестр 1 курса:')
	skaffer.send_message(last_chat_id, tt_text)

# Функция отправляет в чат расписание занятий на сегодня
def today_timetable(last_chat_id):
	day = list(time.ctime().split())
	week_day = day[0]

	path = 'week_days/'
	path += week_day
	path += '.txt'

	with open(path) as tt_today_file:
		tt_today_text = tt_today_file.read()

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

		path = 'week_days/'
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
	hours = int(current_time[0])
	minutes = int(current_time[1])

	day = list(time.ctime().split())
	week_day = day[0]
	# week_day = 'Tue'

	path = 'week_days/'
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
				"""
				if pair_hour - hours <= min_hours:
					if pair_hour - hours >= 0:
						if pair_minute - minutes > 0:
							next_pair = pair
							min_hours = pair_hour - hours
				"""

				if pair_hour - hours <= 1 and pair_hour - hours >= 0:
					print(pair_hour, hours, pair_minute, minutes)
					if pair_minute - minutes > 0:
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

# Создание бота с заданным токеном
skaffer = BotHandler(config.token)

def main():
	new_offset = None

	# Словари для вызова комманд разными способами
	start_dict = ['/start', 'start']
	next_dict = ['/next', 'next', 'след', 'следующая', 'дальше']
	help_dict = ['/help', 'help', 'помощь', 'памагити']
	weather_dict = ['/weather', 'weather', 'погода', 'прогноз']
	tt_dict = ['/tt', 'tt', '/timetable', 'timetable', 'расписание']
	tod_tt_dict = ['/tod', 'tod', 'сегодня', 'расписос']
	tom_tt_dict = ['/tom', 'tom', 'завтра']
	changelog_dict = ['/changelog', 'changelog', 'что нового', 'что нового?']
	greet_dict = ['привет', 'дорова', 'дарова', 'йоу']

	while True:
		# Получение информации с сервера
		skaffer.get_updates(new_offset)
		last_update = skaffer.get_last_update()

		# При получении непустого ответа с сервера
		if last_update != {}:
			last_update_id = last_update['update_id']
			last_chat_text = last_update['message']['text']
			last_chat_id = last_update['message']['chat']['id']
			last_chat_name = last_update['message']['chat']['first_name']

			if last_chat_text.lower() in start_dict:
				start(last_chat_id, last_chat_name)
			elif last_chat_text.lower() in weather_dict:
				weather(last_chat_id)
			elif last_chat_text.lower() in next_dict:
				next(last_chat_id)
			elif last_chat_text.lower() in help_dict:
				help(last_chat_id)
			elif last_chat_text.lower() in tt_dict:
				timetable(last_chat_id)
			elif last_chat_text.lower() in tod_tt_dict:
				today_timetable(last_chat_id)
			elif last_chat_text.lower() in tom_tt_dict:
				tomorrow_timetable(last_chat_id)
			elif last_chat_text.lower() in changelog_dict:
				changelog(last_chat_id)
			elif last_chat_text.lower() in greet_dict:
				greet_msg = last_chat_text
				greet_msg += ', '
				greet_msg += last_chat_name
				greet_msg += ' :)'
				skaffer.send_message(last_chat_id, greet_msg)
			else:
				err_msg = 'Я тебя не понял, '
				err_msg += last_chat_name
				err_msg += ' :(\nИспользуй /help, чтобы узнать, что я умею'
				skaffer.send_message(last_chat_id, err_msg)


			last_chat_message = '['
			last_chat_message += last_chat_text
			last_chat_message += ']'
			print(datetime.datetime.now(), 'User', last_chat_name, 'typed', last_chat_message)

			new_offset = last_update_id + 1

if __name__ == '__main__':
	try:
		main()
	except KeyboardInterrupt:
		exit()
