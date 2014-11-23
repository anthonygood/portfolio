module BaseHelper
  def silence(model)
    allow_any_instance_of(model).to receive(:puts)  # suppress console output
  end
end
