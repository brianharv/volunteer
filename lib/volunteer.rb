class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attributes) 
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
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

end  