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
from data_storage import *

# Импорт класса для обработки изменений на сервере
from bothandler import BotHandler as handler

# Создание бота с заданным токеном
skaffer = handler(config.token)

def main():

	new_offset = None

	while True:
		# Получение информации с сервера
		skaffer.get_updates(new_offset)
		last_update = skaffer.get_last_update()

		# При получении непустого ответа с сервера
		if last_update != {}:

			try:
				last_update_id = last_update['update_id']
				last_chat_text = last_update['message']['text'].lower()
				last_chat_id = last_update['message']['chat']['id']
				last_chat_name = last_update['message']['chat']['first_name']
			except KeyError as key_error_message:
				print("Exception while obtaining data from server", key_error_message)

			if last_chat_text in start_dict:
				commands.start(last_chat_id, last_chat_name)
			elif last_chat_text in weather_dict:
				commands.weather(last_chat_id)
			elif last_chat_text in next_dict:
				commands.next(last_chat_id)
			elif last_chat_text in help_dict:
				commands.help(last_chat_id)
			elif last_chat_text in tt_dict:
				commands.timetable(last_chat_id)
			elif last_chat_text in tod_dict:
				commands.today_timetable(last_chat_id)
			elif last_chat_text in tom_dict:
				commands.tomorrow_timetable(last_chat_id)
			elif last_chat_text in bus47_dict:
				bus_command.bus(last_chat_id)
			elif last_chat_text == 'курчатова':
				bus_command.kurch(last_chat_id)
			elif last_chat_text == 'факультет радиофизики':
				bus_command.raf(last_chat_id)
			elif last_chat_text in alt_dict:
				commands.alt(last_chat_id)
			elif last_chat_text in greet_dict:
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
			
			log = ''
			log += str(last_chat_id)
			log += ' typed '
			log += '['
			log += last_chat_text
			log += ']'
			print(log)

			new_offset = last_update_id + 1

if __name__ == '__main__':
	try:
		main()
	except KeyboardInterrupt:
		exit()
