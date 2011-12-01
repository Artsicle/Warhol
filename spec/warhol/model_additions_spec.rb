require 'spec_helper'

class Address < SuperModel::Base
  extend Warhol::ModelAdditions
  what_changed
  attributes :first_name
end

describe Warhol::ModelAdditions do 

    before(:each) do
      @address = Address.create!
      @redis = Redis.new
    end
    
    # it "before saving, model should receive check_changed" do
    #   Warhol.should_receive(:check_changed)
    #   Warhol.save
    # end

    it "after saving with changes, redis should have most recent change" do
      @address.first_name = "Andy"
      @address.save
      JSON.parse(@redis.get("Address_#{@address.id}")).should eq(["first_name"])
    end

    # it "before saving without changes, check_changed should be called and not save changes" do
    # 
    #   @address.update_attribute(:first_name, @address.first_name)
    #   @redis.get("Address_#{@address.id}").should be_nil
    # end
      
    it "after create, was_changed? should return false" do
      @address1 = Address.create!
      @address1.was_changed?.should be(false)
    end

    it "after save with changes, was_changed? should return true" do
      @address.update_attribute(:first_name, "Andy")
      @address.was_changed?.should be(true)
    end

    it "after save with no changes, was_changed? should return false" do
      @address.save
      @address.was_changed?.should be(false)
    end

    it "after save with changes, what_changed should list changes" do
      @address.update_attribute(:first_name, "Andy")
      @address.what_changed.should eq(["first_name"])
    end

    it "after save without changes, what_changed should be empty" do
      @address.save
      @address.what_changed.should be_empty
    end

    it "should clear changes when clear_warhol is called" do
      @address.update_attribute(:first_name, "Andy")
      @address.what_changed.should eq(["first_name"])
      @address.clear_warhol
      @address.what_changed.should be_empty
    end

end