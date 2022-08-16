require "json"
require "open-uri"

class GamesController < ApplicationController
    before_action :new

    def new
        @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
    end
    
    def score
        # @score = params[:word]
        # raise
        @letters_array = params[:letter].split
        @word_letters = params[:word].upcase

        @included = @word_letters.chars.all? { |letra| @word_letters.count(letra) <= @letters_array.count(letra) }

        url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
        answer_serialized = URI.open(url).read
        answer = JSON.parse(answer_serialized)
        @english_word = answer["found"]

        if @included
            if @english_word
                @result = "Congratulations! #{@word} is a valid English word!"
            else
                @result = "Sorry but #{@word} does not seem to be a valid English word..."
            end
        else
            @result = "Sorry but #{@word} can't be built out of the letters given"
        end

        # if verificacao?()
        #     if answer[:found]
        #         @results = "PALAVRA EXISTE!"
        #     else
        #         @results = "Palavra não é da lingua inglesa"
        #     end
        # else
        #     @results = "Letra não esta dentro do grid ou usuou mais do que deveria"
        #     end
        # end

        def included?(word, letters)
            word.split.all? do |letra|
                word.count(letra) <= letters.count(letra)
            end
        end
        
        def english_word?(word)
            url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
            answer_serialized = URI.open(url).read
            answer = JSON.parse(answer_serialized)
            answer[:found]
        end
    end
end
