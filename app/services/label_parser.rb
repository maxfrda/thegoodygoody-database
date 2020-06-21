class LabelParser < XMLParser
    def characters(string)
      if @element == 'name' && @tag_status && @first
        Label.create(name: string)
        @first = false
    end
  end
end
