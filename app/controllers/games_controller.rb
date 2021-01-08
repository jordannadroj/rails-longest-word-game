require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    def generate_grid
      array = []
      alphabet = ('a'..'z').to_a
      10.times do
        array << alphabet.sample
      end
      array
    end
    @new_game = generate_grid
  end

  def score
    # raise
    @attempt = params[:attempt]
    @game = params[:game]
    attempt_array = @attempt.chars
    game_array = @game.chars
    @result = ''
    @score = 0

    # check to see if the word is made of letters in the grid
    in_grid = attempt_array.all? { |letter| attempt_array.count(letter) <= game_array.count(letter) }

    # check to see if it is a valid english word
    def english?
      url = open("https://wagon-dictionary.herokuapp.com/#{@attempt}")
      dictionary_hash = JSON.parse(url.read)
      dictionary_hash['found']
    end

    @gamechars = @game.chars.join(', ').upcase

    if !in_grid
      @result = "Sorry but <b>#{@attempt}</b> cannot be built of #{@gamechars}".html_safe
    elsif !english?
      @result = "Sorry but <b>#{@attempt}</b> does not seem to be a valid English word..".html_safe
    elsif in_grid && english?
      @score += @attempt.length
      @result = "Congratulations! <b>#{@attempt}</b> is a valid English word".html_safe
    end
  end
end
