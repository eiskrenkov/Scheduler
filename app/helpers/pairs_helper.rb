module PairsHelper
  def pair_content(pair)
    ["#{pair.start_time} - #{pair.name}", pair.kind_humanize].compact.join(', ')
  end
end
