require File.dirname(__FILE__) + "/spec_helper"

describe ConsistentHashr do
  before(:each) do
    @servers = {:s1 => "s1", :s2 => "s2", :s3 => "s3", :s4 => "s4", :s5 => "s5", :s6 => "s6"}
    @hashr = ConsistentHashr.new(@servers)
  end

  it "should not change more than 75% of keys" do
    keys = []
    1000.times do |idx|
      keys << rand(100000).to_s
    end
    before = keys.map() { |k|  @hashr.get(k)}
    
    @hashr.add_server(:s7, "s7")
    
    after = keys.map() { |k|  @hashr.get(k)}
    
    diff = before.zip(after).find_all {|a| a[0] == a[1] }.size
    diff.should > keys.size*0.7
  end

end