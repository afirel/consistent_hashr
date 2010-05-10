require 'zlib'

class ConsistentHashr
  
  ##
  # Creates a new Hasher. Servers should be a hash.
  def initialize(_servers = {}, _number_of_replicas = 50)
    @circle = {}
    @number_of_replicas = _number_of_replicas
    _servers.each do |name, server|
      add_server(name, server)
    end
  end
  
  def hash_key(key)
    Zlib.crc32("#{key}")
  end

  def add_server(_name, _server)
    @number_of_replicas.times do |t|
      @circle[hash_key("#{_name}+#{t}")] = _server
    end
  end
  
  def get(key)
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