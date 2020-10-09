class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attributes) 
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch('name')
      project_id = volunteer.fetch('project_id').to_i
      id = volunteer.fetch('id').to_i
      volunteers.puch(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers  
  end
  
  # def self.find
    
  # end
  
  # def self.clear
   
  # end  

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i
  end
  
  # def delete

  # end
  
  # def update

  # end  

end  