module Web::InheritedResourcesSupport
  extend ActiveSupport::Concern

  included do
    helper_method :after_save_location
  end

  def create
    create! { after_save_location }
  end

  def update
    update! { after_save_location }
  end

  def destroy
    destroy! do |success, failure|
      success.html { redirect_to after_destroy_location }
      failure.html { redirect_to after_destroy_location, resource_failure_details }
    end
  end

  def after_save_location
    collection_path
  end

  def after_destroy_location
    collection_path
  end

  def resource_failure_details
    resource.errors.present? ? { alert: resource_errors_sentence } : {}
  end

  def resource_errors_sentence
    resource.errors.full_messages.to_sentence
  end
end
