# Импорт локального файла с настройками
import config

#Импорт класса для обработки изменений на сервере
from bothandler import BotHandler as handler

# Создание бота с заданным токеном
skaffer = handler(config.token)

subscribedUsers = []

def subscribe(last_chat_id):
	subscribedUsers.append(last_chat_id)

	confirmationMsg = 'Вы успешно подписались на рассылку новостей!'
	skaffer.send_message(last_chat_id, confirmationMsg)

def send_news(last_chat_id, last_chat_text):
	if last_chat_id == '':

		newMsg = 'last_chat_text'

		for id in subscribedUsers:
			skaffer.send_message(id, confirmationMsg)

