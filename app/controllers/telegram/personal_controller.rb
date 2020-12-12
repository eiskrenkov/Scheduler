class Telegram::PersonalController < Telegram::BaseController
  include Telegram::ScheduleSupport

  before_action :check_user_existence, except: UNAUTHORIZED_COMMANDS

  # Common
  def start!(*)
    send_message t('telegram.common.start', username: referrer_name)
  end

  def help!(*)
    send_message t('telegram.common.help')
  end

  def ping!(*)
    send_message 'pong'
  end

  # Personal
  def yes!(*)
    send_message present_schedule_for(Time.now.prev_day.wday)
  end

  def tod!(*)
    send_message present_schedule_for(Time.now.wday)
  end

  def tom!(*)
    send_message present_schedule_for(Time.now.next_day.wday)
  end

  def tt!(*)
    send_message present_schedule
  end

  def current_group!(*)
    send_message t('telegram.schedule.current_group', group: current_user.group.name)
  end

  def set_group!(group_name = nil, *)
    group = Group.find_by(name: group_name)
    return send_message t('telegram.errors.no_schedule_for_group') unless group

    current_user.group = group
    current_user.save!

    send_message t('telegram.schedule.success.group_assigned')
  end

  private

  def check_user_group
    raise Exceptions::NoGroupAssigned unless telegram_user.group
  end
end
