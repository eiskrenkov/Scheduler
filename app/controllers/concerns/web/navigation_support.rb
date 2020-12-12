module Web::NavigationSupport
  extend ActiveSupport::Concern

  included do
    helper_method :belongs_to_navigation_section?
  end

  def belongs_to_navigation_section?(section)
    self.class.belongs_to_navigation_section?(section)
  end

  module ClassMethods
    attr_accessor :navigation_section_name

    def navigation_section(section)
      self.navigation_section_name = section
    end

    def belongs_to_navigation_section?(section)
      navigation_section_name == section
    end
  end
end
