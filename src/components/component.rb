class Component
  include Utils

  attr_reader :id

  def initialize
    @id = generate_id
  end

  def to_s
    "Component {#{id}: #{self.class.name}}"
  end
end
