require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pg')

get('/') do
  @tasks = Task.all()
  erb(:index)
end

get('/tasks/:id/edit') do
  @task = Task.find(params.fetch('id').to_i())
  erb(:task_edit)
end

post('/tasks') do
  description = params.fetch('description')
  Task.create({:description => description })
  #@tasks = Task.all()
  #erb(:index)
  redirect to('/')
end

patch('/tasks/:id') do
  @task = Task.find(params.fetch('id').to_i())
  description = params.fetch('description')
  @task.update({:description => description})
  #@tasks = Task.all()
  #erb(:index)
  redirect to('/')
end
