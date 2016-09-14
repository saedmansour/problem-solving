class Subject < ActiveRecord::Base

	has_many :posts
	has_many :chapters
	has_many :flows
	has_one :root_question, :class_name => "Question"

  has_many :tags_contexts, :class_name => "TagContext"

	validates :name, uniqueness: true
	#validates :short_name, uniqueness: true

	attr_accessor :sample

	def as_json(options={})
    result = super({ except: [] }.merge(options || {}))
    puts "*"*10
    puts result.inspect
    puts "*"*10
    #todo: save sample
    #todo: optimize - to O(1)
    result["sample"] = Subject.find(result["id"].to_i).posts.where("points is not null").order(points: :desc).first
    result
  end

	# def to_json(options={})
 #    options[:methods] ||= []
 #    options[:methods] << :event_oid
 #    super(options)
 #  end


  # after_save :event_oid

  # attr_accessor :event_oid

  # def event_oid
  #   @event_oid = @attributes["event_oid"] = 11 
  # end       

  # def after_initialize
  #   event_oid
  # end

end
