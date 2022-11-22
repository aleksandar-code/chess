# frozen_string_literal: true

class Player
  def initialize(id, name= nil)
    @id = id
    @name = name
  end
  attr_accessor :name, :id
end
