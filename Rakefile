require 'pg'

 task :test_database_setup do
   p "Cleaning database..."

   connection = PG.connect(dbname: 'bookmark_manager_test')
   connection.exec("TRUNCATE comments, bookmarks, tags, bookmarks_tags;")

 end

 task :setup do
   p "Creating databases..."

   ['bookmark_manager', 'bookmark_manager_test'].each do |database|
     connection = PG.connect
     connection.exec("CREATE DATABASE #{ database };")

     connection = PG.connect(dbname: database)
     connection.exec("CREATE TABLE bookmarks (id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));")
     connection.exec("CREATE TABLE tags (id SERIAL PRIMARY KEY, content VARCHAR(60))")
     connection.exec("CREATE TABLE bookmark_tags(id SERIAL PRIMARY KEY, bookmark_id INTEGER REFERENCES bookmarks (id), tag_id INTEGER REFERENCES tags(id));")
     connection.exec("CREATE TABLE comments(id SERIAL PRIMARY KEY, bookmark_id INTEGER REFERENCES bookmarks (id), text VARCHAR(240));")
   end
end

  task :teardown do
    p "Destroying databases...type 'y' to confirm that you want to destroy the Bookmark Manager databases. This will remove all data in those databases!"

    confirm = STDIN.gets.chomp

    return unless confirm == 'y'

  ['bookmark_manager', 'bookmark_manager_test'].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{ database }")
   end
 end
