module Utils
  def generate_id
    java.util.UUID.randomUUID().to_s
  end
end
