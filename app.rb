require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  set :method_override, true

  get '/' do
    @url_invalid = params[:url_invalid]
    @bookmarks = Bookmark.all
    erb :index
  end

  get '/bookmarks/:id/edit' do
    @bookmark = params[:id]
    erb :update
  end

  post '/bookmarks' do
    if Bookmark.valid_url(params[:url])
      Bookmark.add(params[:title], params[:url])
      redirect '/'
    else
      redirect '/?url_invalid=true'
    end
  end

  delete '/bookmarks/:id/delete' do
    Bookmark.delete(params[:id])
    redirect '/'
  end

  patch '/bookmarks/:id/edit' do
    Bookmark.update(params[:id], params[:title], params[:url])
    redirect '/'
  end

  run! if app_file == $PROGRAM_NAME
end
