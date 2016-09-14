require 'geo-distance'
require 'json'

module IntercomInterview
	
	#--------------------
	# Constants
	#--------------------
	CUSTOMERS_FILE_JSON 		= 'data/customers.json'
	OFFICE_COORDINATES 			= { latitude: 53.3381985, longitude: -6.2592576 }
	MAX_DESIRED_DISTANCE_KM = 100

	#--------------------
	# Models
	#--------------------
	class Customer
		attr_accessor :user_id, :name, :latitude, :longitude

		def initialize(user_id, name, latitude, longitude)
  		@user_id, @name, @latitude, @longitude = user_id, name, latitude, longitude
		end

		def distance(location)
			GeoDistance.distance(location[:latitude], location[:longitude], self.latitude, self.longitude).kms
		end
	end

	class Company

		attr_accessor :office_coordinates

		def initialize(office_coordinates)
			@office_coordinates = office_coordinates
		end
		
		def get_customers_from(file_path)
			file = File.read(file_path)

			customers = []

			file.each_line do |line|
				json_row = JSON.parse(line)
				customer = Customer.new(json_row["user_id"], json_row["name"], 
																json_row["latitude"], json_row["longitude"])
				customers << customer
			end

			customers
		end

		def get_nearby_customers(max_distance, file_path)
			customers = get_customers_from(file_path)

			customers = customers.select  {|customer| customer.distance(office_coordinates).kms <= max_distance}
			customers = customers.sort_by {|customer| customer.user_id}
		end
	end

	#--------------------
	# Main
	#--------------------
	def self.get_matching_customers
		company = Company.new(OFFICE_COORDINATES)
		customers = company.get_nearby_customers(MAX_DESIRED_DISTANCE_KM, CUSTOMERS_FILE_JSON)

		customers.each do |customer|
			puts customer.inspect
		end
	end
	
end 
