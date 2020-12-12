module Web::PageWrapperSupport
  extend ActiveSupport::Concern

  included do
    helper_method :page_wrapper_options
  end

  def page_wrapper_options
    { class: 'container-fluid' }
  end
end
