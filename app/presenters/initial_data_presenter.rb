class InitialDataPresenter < BasePresenter
  include Singleton

  def present
    {
      groups: present_groups,
      telegram_bot_url: Settings::Application.instance.telegram_bot_url
    }
  end

  private

  def present_groups
    Group.all.map do |group|
      {
        id: group.id,
        name: group.name
      }
    end
  end
end
