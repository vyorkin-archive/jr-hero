class System
  def tick
    raise RuntimeError, 'system should override #tick method'
  end
end
