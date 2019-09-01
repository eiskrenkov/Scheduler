class Admin::PairsController < InheritedResources::Base
  defaults resource_class: Pair
end
