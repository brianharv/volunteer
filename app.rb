require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')

DB = PG.({dbname => "volunteer_tracker"})

also_reload('lib/**/*.rb')

get('/') do
  @projects = Project.all
  redirect to('/projects')
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

get('/projects/:id') do
  @project = Project.find(params[:id]).to_i
  @project.volunteers
  erb(:project)
end

get('/projects/new') do
  erb(:new_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  title = params[:project_title] 
  @project.update({:title => title})
  redirect to('/projects/#{params[:id].to_i()}')
end

post('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  title = params[:project_title]
  volunteer_name = params[:volunteer_name]
  @project.update({:title = title})
  @volunteers = @project.volunteers
  erb(:project)
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  project.delete
  redirect to('/projects')
end




