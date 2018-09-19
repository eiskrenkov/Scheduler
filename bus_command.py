import requests
import datetime
import time

import config

import telebot
from telebot import types

skaffer = telebot.TeleBot(config.token)

def bus(last_chat_id):
	keyboard = types.ReplyKeyboardMarkup(resize_keyboard=True)
	keyboard.add(*[types.KeyboardButton(button) for button in ['Курчатова', 'Факультет Радиофизики']])
	skaffer.send_message(last_chat_id, 'Время прибытия ближайшего автобуса к какой остановке вам нужно?', reply_markup = keyboard)

def kurch(last_chat_id):
	current_time = list((str(datetime.datetime.now().time())).split(':'))
	hour = int(current_time[0]) + 3
	minute = int(current_time[1])

	day_bus = list(time.ctime().split())
	day_now = day_bus[0]

	# Вычисление ближайшего времени прибытия 47-го автобуса
	if day_now != 'Sat' and day_now != 'Sun':
		with open('database/buses/kurch/47.txt') as bus_timetable:
			time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))
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

				time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))

			if time_bus == []:
				skaffer.send_message(last_chat_id, 'На сегодня втобус 47с окончил движение', reply_markup = types.ReplyKeyboardRemove())
			else:
				message_time = 'Следующий автобус 47с прибудет в '
				message_time += time_bus[0]
				message_time += ':'
				message_time += time_bus[1]
				skaffer.send_message(last_chat_id, message_time, reply_markup = types.ReplyKeyboardRemove())
	else:
		skaffer.send_message(last_chat_id, 'По выходным автобус 47с не ходит', reply_markup = types.ReplyKeyboardRemove())

	if day_now != 'Sat' and day_now != 'Sun':
		with open('database/buses/kurch/96_weekdays.txt') as bus_timetable:
			time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))
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

				time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))

			if time_bus == []:
				skaffer.send_message(last_chat_id, 'На сегодня втобус 96 окончил движение', reply_markup = types.ReplyKeyboardRemove())
			else:
				message_time = 'Следующий автобус 96 прибудет в '
				message_time += time_bus[0]
				message_time += ':'
				message_time += time_bus[1]
				skaffer.send_message(last_chat_id, message_time, reply_markup = types.ReplyKeyboardRemove())
	else:
		with open('database/buses/kurch/96_weekends.txt') as bus_timetable:
			time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))
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

				time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))

			if time_bus == []:
				skaffer.send_message(last_chat_id, 'На сегодня втобус 96 окончил движение', reply_markup = types.ReplyKeyboardRemove())
			else:
				message_time = 'Следующий автобус 96 прибудет в '
				message_time += time_bus[0]
				message_time += ':'
				message_time += time_bus[1]
				skaffer.send_message(last_chat_id, message_time, reply_markup = types.ReplyKeyboardRemove())

def raf(last_chat_id):
	current_time = list((str(datetime.datetime.now().time())).split(':'))
	hour = int(current_time[0]) + 3
	minute = int(current_time[1])

	day_bus = list(time.ctime().split())
	day_now = day_bus[0]

	# Вычисление ближайшего времени прибытия 47-го автобуса
	if day_now != 'Sat' and day_now != 'Sun':
		with open('database/buses/rpact/47.txt') as bus_timetable:
			time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))
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

				time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))

			if time_bus == []:
				skaffer.send_message(last_chat_id, 'На сегодня втобус 47с окончил движение', reply_markup = types.ReplyKeyboardRemove())
			else:
				message_time = 'Следующий автобус 47с прибудет в '
				message_time += time_bus[0]
				message_time += ':'
				message_time += time_bus[1]
				skaffer.send_message(last_chat_id, message_time, reply_markup = types.ReplyKeyboardRemove())
	else:
		skaffer.send_message(last_chat_id, 'По выходным автобус 47с не ходит', reply_markup = types.ReplyKeyboardRemove())

	if day_now != 'Sat' and day_now != 'Sun':
		with open('database/buses/rpact/96_weekdays.txt') as bus_timetable:
			time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))
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

				time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))

			if time_bus == []:
				skaffer.send_message(last_chat_id, 'На сегодня втобус 96 окончил движение', reply_markup = types.ReplyKeyboardRemove())
			else:
				message_time = 'Следующий автобус 96 прибудет в '
				message_time += time_bus[0]
				message_time += ':'
				message_time += time_bus[1]
				skaffer.send_message(last_chat_id, message_time, reply_markup = types.ReplyKeyboardRemove())
	else:
		with open('database/buses/rpact/96_weekends.txt') as bus_timetable:
			time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))
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

				time_leave = list(str(i) for i in bus_timetable.readline().strip().split(':'))

			if time_bus == []:
				skaffer.send_message(last_chat_id, 'На сегодня втобус 96 окончил движение', reply_markup = types.ReplyKeyboardRemove())
			else:
				message_time = 'Следующий автобус 96 прибудет в '
				message_time += time_bus[0]
				message_time += ':'
				message_time += time_bus[1]
				skaffer.send_message(last_chat_id, message_time, reply_markup = types.ReplyKeyboardRemove())