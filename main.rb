require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'
require 'json'
require 'httparty'

get '/' do
  erb :home
end

get '/movies/:movie' do
  movie_name = params[:movie].split.join('+')
  url = "http://www.omdbapi.com/?t=#{movie_name}"
  html = HTTParty.get(url)
  @result = JSON(html)
  erb :movie
end

post '/movie_search' do
  url = '/movies/'+params[:title].split.join('+')
  redirect to(url)
end

get '/movie_search' do
  erb :home
end

def get_rating_img(rating_string)
  suffix = case rating_string
  when 'G' then 'g_full'
  when 'NC-17' then 'nc_17_full'
  when 'NR' then 'nr_full'
  when 'PG-13' then 'pg_13_full'
  when 'PG' then 'pg_full'
  when 'R' then 'r_full'
  when 'TV-14' then 'tv_14'
  when 'TV-G' then 'tv_g'
  when 'TV-MA' then 'tv_ma'
  when 'TV-PG' then 'tv_pg'
  when 'TV-Y' then 'tv_y'
  when 'TV-Y7' then 'tv_y7'
  when 'TV-Y7-FV' then 'tv_y7_fv'
  else 'unrated'
  end
  "/ratings/rated_#{suffix}.png"
end