class MoviesController < ApplicationController
  wrap_parameters false
  rescue_from ActiveRecord::RecordInvalid, with: :test_method
  
  def index
    movies = Movie.all
    render json: movies
  end

  def create
    movie = Movie.create!(movie_params)
    render json: movie, status: :created
  end

  private

  def test_method e
    render json: e.record.errors.full_messages, status: :unprocessable_entity
  end

  def movie_params
    params.permit(:title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director)
  end
  
end
