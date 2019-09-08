module Concerns::Findable

  def find_by_name(name)
    self.all.detect {|instance| instance.name == name}
  end

  def find_or_create_by_name(name)
    if find_by_name(name)
    find_by_name(name)
    else
      new_song = self.create(name)
      new_song
    end
  end

end
