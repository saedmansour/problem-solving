module AbstractInterface

  class InterfaceNotImplementedError < NoMethodError
  end

  def self.included(klass)
    klass.send(:include, AbstractInterface::Methods)
    klass.send(:extend, AbstractInterface::Methods)
  end

  module Methods

    def api_not_implemented(klass)
      caller.first.match(/in \`(.+)\'/)
      method_name = $1
      raise AbstractInterface::InterfaceNotImplementedError.new("#{klass.class.\ 
        name} needs to implement '#{method_name}' for interface #{self.name}!")
    end

  end

end



#---------------------------------------------------
#  AbstractInterface: example
#---------------------------------------------------
#
#
# class Bicycle
#   include AbstractInterface

#   # Some documentation on the change_gear method
#   def change_gear(new_value)
#     Bicycle.api_not_implemented(self)
#   end

#   # Some documentation on the speed_up method
#   def speed_up(increment)
#     Bicycle.api_not_implemented(self)
#   end

#   # Some documentation on the apply_brakes method
#   def apply_brakes(decrement)
#     # do some work here
#   end

# end

# class AcmeBicycle < Bicycle
# end

# bike = AcmeBicycle.new
# bike.change_gear(1) # AbstractInterface::InterfaceNotImplementedError: \
# AcmeBicycle needs to implement 'change_gear' for interface Bicycle!




#---------------------------------------------------
#  Interfaces: other implementations.
#---------------------------------------------------

# gem: github.com/djberg96/interface
