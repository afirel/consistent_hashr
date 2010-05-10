require File.dirname(__FILE__) + "/spec_helper"

describe ConsistentHashr do
  before(:each) do
    @servers = {:s1 => "s1", :s2 => "s2", :s3 => "s3", :s4 => "s4", :s5 => "s5", :s6 => "s6"}
    @servers.each do |n, s|
      ConsistentHashr.add_server(n,s)
    end
  end

  it "should not change more than 75% of keys" do
    keys = []
    1000.times do |idx|
      keys << rand(100000).to_s
    end
    before = keys.map() { |k|  ConsistentHashr.get(k)}
    
    ConsistentHashr.add_server(:s7, "s7")
    
    after = keys.map() { |k|  ConsistentHashr.get(k)}
    
    diff = before.zip(after).find_all {|a| a[0] == a[1] }.size
    diff.should > keys.size*0.7
  end

  it "should distribute keys evenly accross servers" do
    keys = []
    10000.times do |idx|
      keys << rand(100000).to_s
    end
    servers = keys.map() { |k|  ConsistentHashr.get(k)}
    
    count_by_server = {}
    servers.each do |s|
      count_by_server[s] ||= 0
      count_by_server[s] += 1
    end
    
    min = count_by_server.invert.sort.first.first
    max = count_by_server.invert.sort.last.first
    
    max.should < min * 2
    
  end

end