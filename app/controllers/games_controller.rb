require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = %w(Y Z D U Q E Z Y Q A).shuffle
  end

  def score
    @letterarray = params[:array]
    @answer = params[:answer]
    if included?(@answer.upcase, @letterarray)
      if english_word?(@answer)
        @result = `<strong>Congratulations!</strong>#{@answer} is a valid English word!`
      else
        @result = `Loser`
      end
    else
      @result = `Loser loser`
    end
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
