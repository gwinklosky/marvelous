class WelcomeController < ApplicationController

  # GET /welcome
  def index
    @apps = [["Turkey Words", "Thanksgiving hangman app", "https://itunes.apple.com/us/app/turkey-words/id399213583?mt=8"],
      ["Haunted Hangman", "Halloween hangman app", "https://itunes.apple.com/us/app/haunted-hangman/id466821342?mt=8"],
      ["MathManSquares", "Math puzzle app", "https://itunes.apple.com/us/app/mathman-squares/id427785017?mt=8"]
    ]
  end

end
