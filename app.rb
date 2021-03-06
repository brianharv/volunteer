#!/usr/bin/evn ruby
require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})



get('/') do
  @projects = Project.all
  redirect to('/projects')
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

get('/projects/new') do
  erb(:new_project)
end 

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.volunteers
  erb(:project)
end

post('/projects') do
  title = params[:project_title]
  project = Project.new({:title => title, :id => nil})
  project.save()
  redirect to('/projects')
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  title = params[:project_title] 
  @project.update(title)
  redirect to("/projects/#{params[:id].to_i()}")
end

post('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  title = params[:project_title]
  volunteer_name = params[:volunteer_name]
  @project.update({:title => title})
  @volunteers = @project.volunteers
  erb(:project)
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  redirect to('/projects')
end

#### Volunteers ####

get('/projects/:id/volunteers/:volunteer_id') do
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  erb(:volunteer)
end

post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i())
  name = params[:volunteer_name]
  project_id = @project.id
  @volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  @volunteer.save()
  erb(:project)
end

patch('/projects/:id/volunteers/:volunteer_id') do
  @project = Project.find(params[:id].to_i())
  @volunteer = Volunteer.find(params[:volunteer_id].to_i())
  name = params[:volunteer_name]
  @volunteer.update(name, @project.id)
  erb(:project)
end

delete('/projects/:id/volunteers/:volunteer_id') do
  volunteer = Volunteer.find(params[:volunteer_id].to_i())
  volunteer.delete
  @project = Project.find(params[:id].to_i())
  erb(:project)
end