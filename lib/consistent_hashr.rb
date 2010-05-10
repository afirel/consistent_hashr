require 'zlib'
module ConsistentHashr

  @circle = {}
  @number_of_replicas = 20
  
  ##
  # Computes a key
  def self.hash_key(key)
    Zlib.crc32("#{key}")
  end

  ##
  # Adds a server to the circle
  def self.add_server(_name, _server)
    @number_of_replicas.times do |t|
      @circle[hash_key("#{_name}+#{t}")] = _server
    end
  end
  
  ##
  # Returns the server for the provided key
  def self.get(key)
    return nil if @circle.empty?
    return @circle.first.last if @circle.size == 1
    
    hash = hash_key(key)
    
    # If the key is there, let's return it.
    return @circle[hash] if @circle[hash]
    
    # If not, we need to find the next closest from it!
    hash = @circle.keys.select() { |k| k > hash }.sort.first
    
    return @circle.first.last if hash.nil?
    return @circle[hash]
  end
  
end