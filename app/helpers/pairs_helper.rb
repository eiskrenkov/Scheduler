module PairsHelper
  def pair_content(pair)
    ["#{pair.start_time} - #{pair.name}", pair.teacher, pair.kind_humanize]
      .reject(&:blank?).join(', ') # Do not present empty fields
  end
end
