# Klasa wylacznie do testow rubiego, z zabawy z hello world
class SayController < ApplicationController
  def hello
    @time = Time.now
  end

  def goodbye
    @files = Dir.glob('*')
  end

  def jquery
  end
end
