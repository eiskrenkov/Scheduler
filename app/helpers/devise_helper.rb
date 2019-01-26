module DeviseHelper
  def login_form(&block)
    form_for(resource, as: resource_name, url: session_path(resource_name), &block)
  end
end
