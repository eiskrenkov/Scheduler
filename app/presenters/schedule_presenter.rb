class SchedulePresenter < BasePresenter
  def present
    {
      groups: present_groups
    }
  end

  private

  def present_groups
    Group.all.map do |group|
      GroupPresenter.new(group).present
    end
  end
end
