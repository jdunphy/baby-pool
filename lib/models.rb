class Guess < Sequel::Model
  plugin 'validation_class_methods'

  validates do
    presence_of :name, :pounds, :ounces
    numericality_of :pounds, :ounces, :message => ' must be a number'
  end

  validates_each :pounds do |o, a, v|
    o.errors.add(a, ' must be a positive number') if v.to_i < 0
  end

  validates_each :ounces do |o,a,v|
    o.errors.add(a, " must be between 0 and 15") if v.to_i < 0 || v.to_i > 15
  end
  
end
