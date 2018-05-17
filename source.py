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

# Функция отправляет в чат сообщение с полезной для пользователя информацией
def help(last_chat_id):
	skaffer.send_message(last_chat_id, text = 'Что я могу: \n\n/tt - Получить полное расписание занятий\n/next - Какая же у меня следующая пара? \n/weather - Информация о погоде')

# Функция отправляет в чат расписание занятий
def timetable(last_chat_id):
	with open('timetable.txt') as tt_file:
		tt_text = tt_file.read()

	skaffer.send_message(last_chat_id, 'Ваше расписание на второй семестр 1 курса:')
	skaffer.send_message(last_chat_id, tt_text)

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
	week_day += '.txt'

	path = 'week_days/'
	path += week_day

	with open(path) as week_day_file:
		pair = list(str(i) for i in week_day_file.readline().strip().split())
		
		if pair[0] != 'Сегодня':

			min_hours = 24
			next_pair = []
			while pair != []:
				pair_time = pair[0].split(':')

				pair_hour = int(pair_time[0])
				pair_minute = int(pair_time[1])

				if pair_hour - hours <= min_hours:
					if pair_hour - hours >= 0:
						if pair_minute - minutes > 0:
							next_pair = pair
							min_hours = pair_hour - hours

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

		else:
			pair_message = ''
			for word in pair:
				pair_message += word
				pair_message += ' '

			skaffer.send_message(last_chat_id, pair_message)

skaffer = BotHandler(config.token) # Создание бота с заданным токеном

def main():
	new_offset = None

	weather_dict = ['/weather', 'погода', 'прогноз']
	tt_dict = ['/tt', '/timetable', 'расписание']

	while True:
		skaffer.get_updates(new_offset)

		last_update = skaffer.get_last_update()

		if last_update != {}:
			last_update_id = last_update['update_id']
			last_chat_text = last_update['message']['text']
			last_chat_id = last_update['message']['chat']['id']
			last_chat_name = last_update['message']['chat']['first_name']

			if last_chat_text.lower() in weather_dict:
				weather(last_chat_id)
			elif last_chat_text.lower() == '/next':
				next(last_chat_id)
			elif last_chat_text.lower() == '/help' or last_chat_text.lower() == 'помощь':
				help(last_chat_id)
			elif last_chat_text.lower() in tt_dict:
				timetable(last_chat_id)

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
