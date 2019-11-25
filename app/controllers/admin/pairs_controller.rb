class Admin::PairsController < Admin::PermissionController
  defaults resource_class: Pair
end
