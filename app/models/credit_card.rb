class CreditCard < ActiveRecord::Base
  after_validation :find_type
  after_validation :luhn

#Methods for luhn validation

#First checking the type of card

	private

	def find_type
		# Making sure that the card number is passed as a string
		credit_card = self.number.to_s
		# Set of statements to return the appropriate card type
		# Firstly the code checks the cards's length
		# Secondly regexp, returns 0 which signals validation
		self.provider = "Unknown"
		self.provider = "AMEX"	if credit_card.length == 15 && (credit_card =~ /^(34|37)/) == 0
		self.provider = "Discover"	if credit_card.length == 16 && (credit_card =~ /^6011/) == 0
		self.provider = "MasterCard"	if credit_card.length == 16 && (credit_card =~ /^(5[1-5])/) == 0
		self.provider = "VISA"	if [13,16].include?(credit_card.length) && (credit_card =~ /^4/) == 0
	end

#Secondly applying the Luhn algorithm on the number to check is the number valid or not


	def luhn
    result = 0
    nums = self.number.to_s.split("")
    nums.each_with_index do |item, index|
      if index.even?
      	if item.to_i*2>9
      		result+= item.to_i*2-9
        else 
        	result+= item.to_i*2
        end
      else
        result +=item.to_i
    	end
  	end
  	if (result % 10) == 0
      self.validation = "valid"
  	else
      self.validation = "invalid"
    end
  end

end
