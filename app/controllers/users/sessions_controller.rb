class Users::SessionsController < Devise::SessionsController
  include Web::NavigationSupport
  include Web::PageWrapperSupport
end
