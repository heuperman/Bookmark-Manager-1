require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'
require './lib/comment'
require './lib/tag'
require './lib/bookmark_tag'

class BookmarkManager < Sinatra::Base
  set :method_override, true

  get '/' do
    @url_invalid = params[:url_invalid]
    @bookmarks = Bookmark.all
    @comments = Comment.all
    @tags = Tag.all
    @bookmark_tag = BookmarkTag.all
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

  get '/bookmarks/:id/comments' do
    @bookmark_id = params[:id]
      erb :comments
  end

  post '/bookmarks/:id/comments' do
    Comment.create(params[:id], params[:comment])
    redirect '/'
  end

  get '/bookmarks/:id/tags' do
    @bookmark_id = params[:id]
    erb :tags
  end

  post '/bookmarks/:id/tags' do
    Tag.create(params[:id], params[:tag])
    erb :tags
  end

  run! if app_file == $PROGRAM_NAME
end
