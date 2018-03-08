class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end
  
  get '/figures/new' do
    erb :'/figures/new'
  end
  
  post '/figures' do
    @figure = Figure.create(params["figure"])
    if params["title"]
      title = Title.create(name: params[:title][:name])
      @figure.figure_titles.create(title_id: title.id)
      title.save
    end
    if params["landmark"]
      landmark = Landmark.create(name: params[:landmark][:name])
      landmark.figure = @figure
      landmark.save
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
  
  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end
  
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end
  
  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params["figure"])
    if params["title"]
      title = Title.create(name: params[:title][:name])
      @figure.figure_titles.create(title_id: title.id)
      title.save
    end
    if params["landmark"]
      landmark = Landmark.create(name: params[:landmark][:name])
      landmark.figure = @figure
      landmark.save
    end
    @figure.save
    erb :'/figures/show'
  end
end
