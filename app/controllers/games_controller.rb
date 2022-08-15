require "json"
require "open-uri"


class GamesController < ApplicationController
    
    def new
        @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
    end
    
    def score
        # @score = params[:word]
        # raise
        url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
        answer_serialized = URI.open(url).read
        answer = JSON.parse(answer_serialized)

        if verificacao?
            if answer[:found]
                @results = "PALAVRA EXISTE!"
            else
                @results = "Palavra não é da lingua inglesa"
            end
        else
            @results = "Letra não esta dentro do grid ou usuou mais do que deveria"
        end
    end

    def verificacao?
        @letters_array = params[:letter].split
        @word_letters = params[:word].split

        @word_letters.all? do |letra|
            @word_letters.count(letra) <=  @letters_array.count(letra)
        end
    end

end
