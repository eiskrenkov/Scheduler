# The main source code file

# Импорт системных модулей
import requests
import datetime
import time
import os

# Импорт локальных файлов с настройками и коммандами
import config
import commands
import bus_command

#Импорт класса для обработки изменений на сервере
from bothandler import BotHandler as handler

# Создание бота с заданным токеном
skaffer = handler(config.token)

def main():
	new_offset = None

	# Словари для вызова комманд разными способами
	start_dict = ['/start', 'start']
	next_dict = ['/next', 'next', 'след', 'следующая', 'дальше']
	help_dict = ['/help', 'help', 'помощь', 'памагити']
	weather_dict = ['/weather', 'weather', 'погода', 'прогноз']
	tt_dict = ['/tt', 'tt', '/timetable', 'timetable', 'расписание']
	tod_tt_dict = ['/tod', 'tod', 'сегодня', 'пары']
	tom_tt_dict = ['/tom', 'tom', 'завтра']
	changelog_dict = ['/changelog', 'changelog', 'что нового', 'что нового?']
	greet_dict = ['привет', 'дорова', 'дарова', 'здарова', 'йоу']
	bus47_dict = ['/bus', 'bus']
	alt_dict = ['/alt', 'alt']

	while True:
		# Получение информации с сервера
		skaffer.get_updates(new_offset)
		last_update = skaffer.get_last_update()

		# При получении непустого ответа с сервера
		if last_update != {}:

			try:
				last_update_id = last_update['update_id']
				last_chat_text = last_update['message']['text']
				last_chat_id = last_update['message']['chat']['id']
				last_chat_name = last_update['message']['chat']['first_name']
			except KeyError as key_error_message:
				print("Exception while obtaining data from server", key_error_message)

			if last_chat_text.lower() in start_dict:
				commands.start(last_chat_id, last_chat_name)
			elif last_chat_text.lower() in weather_dict:
				commands.weather(last_chat_id)
			elif last_chat_text.lower() in next_dict:
				commands.next(last_chat_id)
			elif last_chat_text.lower() in help_dict:
				commands.help(last_chat_id)
			elif last_chat_text.lower() in tt_dict:
				commands.timetable(last_chat_id)
			elif last_chat_text.lower() in tod_tt_dict:
				commands.today_timetable(last_chat_id)
			elif last_chat_text.lower() in tom_tt_dict:
				commands.tomorrow_timetable(last_chat_id)
			elif last_chat_text.lower() in changelog_dict:
				commands.changelog(last_chat_id)
			elif last_chat_text.lower() in bus47_dict:
				bus_command.bus(last_chat_id)
			elif last_chat_text.lower() == 'Курчатова':
				bus_command.kurch(last_chat_id)
			elif last_chat_text.lower() == 'Факультет Радиофизики':
				bus_command.raf(last_chat_id)
			elif last_chat_text.lower() in alt_dict:
				commands.alt(last_chat_id)
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