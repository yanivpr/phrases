module Api
  module V1
    class PhrasesController < ApplicationController
      http_basic_authenticate_with name: 'babbel', password: 'ruby'
      respond_to :json

      def random
        phrase_file = PhraseFile.new
        random_phrase = phrase_file.random

        render json: random_phrase
      end

      def append
        text = params[:text]

        phrase_file = PhraseFile.new
        phrase_file.append text

        head :no_content
      end

    end
  end
end