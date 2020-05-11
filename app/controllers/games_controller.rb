require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer =  params[:answer]
    if included?(params[:answer].upcase, params[:letters])
      if english_word?(params[:answer])
        @answer = "Congratulations! #{params[:answer]} is a valid English Word"
      else
        @answer = "Sorry but #{params[:answer]} does not seem to be a valid English Word"
      end
    else 
      @answer = "Sorry but #{params[:answer]} cannot be build with the grid."
    end
  end


  def included?(guess, grid)
    new_grid = grid.split(" ")
    guess.chars.all? do |letter| 
      guess.count(letter) <= grid.count(letter) 
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    return json['found']
  end
  
end
