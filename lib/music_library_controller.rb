class MusicLibraryController
  attr_reader :new_importer

  def initialize(path="./db/mp3s")
    @new_importer = MusicImporter.new(path)
    new_importer.import
  end

  def call
    loop do
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      input = gets.strip
      case input
      when "exit"
         break
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end
  end

  def list_songs
    sorted_songs = Song.all.sort {|song_one, song_two| song_one.name <=> song_two.name}
    sorted_songs.each_with_index do |song, index|
      index += 1
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    sorted_artists = Artist.all.sort {|artist_one, artist_two| artist_one.name <=> artist_two.name}
    sorted_artists.each_with_index do |artist, index|
      index += 1
      puts "#{index}. #{artist.name}"
    end
  end

  def list_genres
    sorted_genres = Genre.all.sort {|genre_one, genre_two| genre_one.name <=> genre_two.name}
    sorted_genres.each_with_index do |genre, index|
      index += 1
      puts "#{index}. #{genre.name}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    input = gets.strip
    if artist = Artist.find_by_name(input)
      artist.songs.sort {|song_one, song_two| song_one.name <=> song_two.name}.each_with_index do |song, index|
        puts "#{index + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    input = gets.strip
    if genre = Genre.find_by_name(input)
      genre.songs.sort {|song_one, song_two| song_one.name <=> song_two.name}.each_with_index do |song, index|
        puts "#{index + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts "Which song number would you like to play?"
    input = gets.strip.to_i
    if (1..Song.all.length).include?(input)
      song = Song.all.sort {|song_one, song_two| song_one.name <=> song_two.name}[input - 1]
    end
    puts "Playing #{song.name} by #{song.artist.name}" if song
  end

end
