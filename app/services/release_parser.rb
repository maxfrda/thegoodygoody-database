class ReleaseParser < Nokogiri::XML::SAX::Document
  def initialize(tag)
    @tag = tag
    @vinyl = false
    @label = true
    @first = true
    @title = true
    @style = false
    @songs = []
    @release_titles = []
    @descriptions = []
  end

  def start_element(name, attrs = [])
    @element = name

    case @element
    when @tag
      @tag_status = true
    when 'format'
      if attrs[0][1] == 'Vinyl'
        @vinyl = true
        @description = true
      end
    when 'label'
      if @label
        @label_name = attrs[1][1]
       # puts attrs[1][1]

        @label = false
      end
    when 'id'
      @id = true
    when 'tracklist'
      @titles = []
      @tracklist = true
    when 'title'
      if @title
        @element = 'release-title'
      end
    end

  end

  def end_element(name)
    if name == @tag
      @label = true
      @tag_status = false
      @first = true
      @title = true
      release_title = @release_titles.join("")

      if @vinyl
        # puts "#{@count} #{@artist_id}"
      # puts @artist_id
        new_release = Release.new(id: @count, year: @year, genre: @genre,
        title: release_title, tracklist: @songs, format: @descriptions)
        new_release.artist = Artist.find_by(discogs_id: @discogs_id)
        new_release.label = Label.find_by(name: @label_name)
        new_release.save
      end

      @vinyl = false
      @descriptions = []
      @release_titles = []
      @songs = []
    elsif name == 'tracklist'
      @tracklist = nil
    elsif name == 'format'
      @description = nil
    end
  end

  def preserve(item, tag)
    @last_item = "#{@last_item} & #{item}"
    @concat = nil
    @songs.pop[-1]
    @songs << @last_item
  end

  def characters(string)
    if @tag_status
      if @element == 'id' && @first
        @discogs_id = string.to_i
        # puts "#{@count} #{@discogs_id}"
        @first = false
      elsif @element == 'title' && @tracklist
        if @concat
          preserve(string, 'song')
        elsif string == '&'
          @concat = true
        else
          @last_item = string
          @songs << string
        end
      elsif @element == 'release-title'
          @release_titles << string
          @title = false
      elsif @element == 'released'
        @year  = string[0..3]
      elsif @element == 'genre'
        @genre = string
      elsif @element == 'description' && @description
        if !string.gsub(/\s+/, '').empty?
          @descriptions << string
        end
      end
    end
  end
end
