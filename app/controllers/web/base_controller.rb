class Web::BaseController < ApplicationController
  include Web::NavigationSupport
  include Web::PageWrapperSupport

  def self.inherit_resources!
    inherit_resources

    send(:include, Web::InheritedResourcesSupport)
  end
end
