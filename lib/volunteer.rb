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
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers  
  end
  
  def ==(volunteer_to_compare)
    if volunteer_to_compare != nil
      (self.name() == volunteer_to_compare.name()) && (self.id() == volunteer_to_compare.id())
    else
      false
    end
  end 
    
  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    name = volunteer.fetch('name')
    project_id = volunteer.fetch('project_id').to_i
    id = volunteer.fetch('id').to_i
    Volunteer.new({:name => name, :project_id => project_id, :id => id})
  end
  
  def self.clear
    DB.exec("DELETE FROM volunteers *;")
  end  

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i
  end

  # def project
  #   Project.find(@project_id)
  # end
  
  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end
  
  def update(name, project_id)
    @name = name
    @project_id = project_id
    DB.exec("UPDATE volunteers SET name = '#{name}', project_id = #{project_id} WHERE id = #{@id};")
  end  

end  