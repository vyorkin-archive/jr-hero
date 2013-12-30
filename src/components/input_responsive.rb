class InputResponsive < Component
  attr_reader :keys

  def initialize(keys)
    @keys = keys
    super()
  end
end
