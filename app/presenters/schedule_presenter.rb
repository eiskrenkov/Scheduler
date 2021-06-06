class SchedulePresenter < BasePresenter
  attr_reader :groups

  def initialize(groups)
    @groups = groups
  end

  def present
    {
      groups: present_groups
    }
  end

  private

  def present_groups
    groups.map do |group|
      GroupPresenter.new(group).present
    end
  end
end
