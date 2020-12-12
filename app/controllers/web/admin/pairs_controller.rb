class Web::Admin::PairsController < Web::Admin::BaseController
  inherit_resources
  defaults resource_class: Pair
end
