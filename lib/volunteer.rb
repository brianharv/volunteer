class Volunteer
  attr_reader :id
  attr_accessor :name

  def initialize(attributes) do
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    
  end

  def self.all
   
  end
  
  def self.find

  end
  
  def self.clear
   
  end  

  def save
    
  end
  
  def delete

  end
  
  def update

  end  