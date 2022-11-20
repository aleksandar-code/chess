# frozen_string_literal: true

class Player
  def initialize(id, name)
    @id = id
    @name = name
  end
  attr_accessor :name, :id
end
