class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  post '/figures' do
    binding.pry
    @figure = Figure.create(params[:figure])
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each do |title_id|
        @figure.titles << Title.find(title_id)
      end
    end
    if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
    end
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each do |landmark|
        @figure.landmarks << Landmark.find(landmark)
      end
    end
    if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    params[:figure][:title_ids].each do |title_id|
      @figure.titles << Title.find(title_id)
    end
    if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
    end
    params[:figure][:landmark_ids].each do |landmark|
      @figure.landmarks << Landmark.find(landmark)
    end
    if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end
end
