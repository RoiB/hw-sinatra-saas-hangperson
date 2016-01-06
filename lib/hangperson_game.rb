class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_reader :word
  attr_accessor :guesses, :wrong_guesses
  
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letters)
    raise ArgumentError if letters.nil?
    raise ArgumentError if letters.empty?
    letters.split('').each do |letter|
      letter = letter.downcase
      raise ArgumentError unless letter =~ /[a-z]/ 
      
      if @word.include? letter 
        if @guesses.include? letter
          return false
        else
          @guesses << letter 
        end
      else
        if @wrong_guesses.include? letter
          return false
        else
          @wrong_guesses << letter 
        end
      end
    end
    return true
  end
  
  def word_with_guesses
    result = ''
    @word.split('').each do |x|
      if @guesses.include? x
        result << x
      else
        result << '-'
      end
    end
    result
  end
  
  def check_win_or_lose
    if word.split('').uniq.sort == guesses.split('').sort; return :win; end
    if wrong_guesses.length == 7; return :lose; end
    :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
