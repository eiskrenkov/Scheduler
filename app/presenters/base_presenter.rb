class BasePresenter
  def present
    raise NotImplementedError
  end

  def as_json(*)
    present
  end
end
