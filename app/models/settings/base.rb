class Settings::Base < ApplicationRecord
  before_create :confirm_singularity

  def self.instance
    first_or_create!
  end

  private

  def confirm_singularity
    errors.add(:base, 'There should be only one Settings instance') if self.class.exists?
  end
end
