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
    @english = ''
    @in_grid = ''
    @win = ''
    @score = 0

    # check to see if the word is made of letters in the grid
    in_grid = attempt_array.all? { |letter| attempt_array.count(letter) <= game_array.count(letter) }

    # check to see if it is a valid english word
    def english?
      url = open("https://wagon-dictionary.herokuapp.com/#{@attempt}")
      dictionary_hash = JSON.parse(url.read)
      dictionary_hash['found']
    end

    if !in_grid
      @in_grid = "Sorry but <b>#{@attempt}</b> cannot be built of of #{@game.chars.join(', ').upcase}".html_safe
    elsif !english?
      @english = "Sorry but <b>#{@attempt}</b> does not seem to be a valid English word..".html_safe
    elsif in_grid && english?
      @score += @attempt.length
      @win = "Congratulations! <b>#{@attempt}</b> is a valid English word".html_safe
    end
  end
end
