class Admin::PairsController < Admin::AuthorizedController
  defaults resource_class: Pair
end
