class LruCache
  def initialize(max_size)
    @max_size = max_size
    @data = {}
  end

  def each
    @data.to_a.reverse.each { |pair| yield pair }
  end

  def [](key)
    found = true
    value = @data.delete(key) { found = false }
    found ? @data[key] = value : nil
  end

  def []=(key, value)
    @data.delete(key)
    @data[key] = value
    @data.delete(@data.first[0]) if @data.length > @max_size
    value
  end

  def max_size=(size)
    raise ArgumentError.new(:max_size) if @max_size < 1

    @max_size = size
    if @max_size < @data.size
      @data.keys[0..@max_size - @data.size].each do |k|
        @data.delete(k)
      end
    end
  end

  def delete(k)
    @data.delete(k)
  end

  def clear
    @data.clear
  end

  def count
    @data.count
  end

  def to_a
    array = @data.to_a
    array.reverse!
  end

  def getset(key)
    found = true
    value = @data.delete(key) { found = false }
    if found
      @data[key] = value
    else
      result = @data[key] = yield
      @data.delete(@data.first[0]) if @data.length > @max_size
      result
    end
  end

  def fetch(key, value = nil)
    found = true
    value = @data.delete(key) { found = false }
    if found
      @data[key] = value
    else
      block_given? ? yield : value
    end
  end
end
