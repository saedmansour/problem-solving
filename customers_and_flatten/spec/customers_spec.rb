require 'spec_helper'
require 'benchmark'
require 'customers'

include IntercomInterview
 
describe Customer do
  context "distance" do
    it "should return correct geo distance in kms" do
      customer_example = Customer.new(12, "Christina McArdle", 52.986375, -6.043701)
      location_example = { latitude: 53.3381985, longitude: -6.2592576 } 

      # helpers:
      # calculator 1: http://www.nhc.noaa.gov/gccalc.shtml
      # calculator 2: http://boulter.com/gps/distance/
      expect(customer_example.distance(location_example).distance).to be_within(1).of(41.72)
    end
  end
end

describe Company do
  before(:each) do
    @company = Company.new(OFFICE_COORDINATES)
  end

  context "get_customers_from file" do
    it "should return customers as long as te file" do
      customers = @company.get_customers_from(CUSTOMERS_FILE_JSON)
      customers_expected_size = File.read(CUSTOMERS_FILE_JSON).lines.size
      expect(customers.size).to eq(customers_expected_size)
    end
  end

  context "get_nearby_customers" do
    before(:each) do
      @nearby_customers = @company.get_nearby_customers(MAX_DESIRED_DISTANCE_KM, CUSTOMERS_FILE_JSON)
    end

    it "should return them sorted by user ascending" do
      customers_ids = @nearby_customers.map {|c| c.user_id}
      expect(customers_ids.sorted?).to be true 
    end

    it "should return them within range MAX_DESIRED_DISTANCE_KM (100km) " do
      @nearby_customers.each do |customer|
        expect(customer.distance(OFFICE_COORDINATES).kms).to be <= MAX_DESIRED_DISTANCE_KM 
      end
    end

    it "should return closeby customers within the specified range for specific example" do
      customers_ids = @nearby_customers.map {|c| c.user_id}
      expected_result = [4, 5, 6, 8, 11, 12, 13, 15, 17, 23, 24, 26, 29, 30 ,31, 39]
      expect(customers_ids).to match_array(expected_result)
    end
  end
end


# helpers

module Enumerable
  def sorted?
    each_cons(2).all? { |a, b| (a <=> b) <= 0 }
  end
end

