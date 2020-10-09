class Project
  attr_reader :id
  attr_accessor :title

  def initialize(attributes) 
    @id = attributes.fetch(:id)
    @title = attributes.fetch(:title)
  end

  def title
    project = DB.exec("SELECT * FROM projects WHERE id= #{@id};").first
    title = project.fetch('title')
    id = project.fetch('id').to_i
    Project.new({:title => title, :id => id})
  end  

  def self.all
   returned_projects = DB.exec("SELECT * FROM projects;")
   results = []
   returned_projects.each() do |project|
    title = project.fetch('title')
    id = project.fetch('id').to_i
    results.push(Project.new({:title => title, :id => id}))
   end
   results
  end

  def ==(project_to_compare)
    if project_to_compare != nil
      (self.title() == project_to_compare.title()) && (self.id() == project_to_compare.id())
    else
      false
    end
  end    
  
  def self.find
    project = DB.exec("SELECT * FROM projects WHERE id =#{@id};").first
    title = project.fetch('title')
    id = project.fetch('id').to_i
    Project.new({:title => title, :id => id})
  end
  
  def self.clear
    DB.exec("DELETE FROM projects *;")
  end  

   def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
   end
  
   def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
    DB.exec("DELETE FROM projects_volunteers WHERE project_id = #{@id};")
   end
  
  # def update

  # end  

end  