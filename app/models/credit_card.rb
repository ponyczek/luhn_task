class CreditCard < ActiveRecord::Base
	validates :number, presence:true, length: { maximum: 16}

#Methods for luhn validation

#First checking the type of card
	def self.find_type(credit_card)
		# Making sure that the card number is passed as a string
		credit_card = credit_card.to_s
		# Set of statements to return the appropriate card type
		# Firstly the code checks the cards's length
		# Secondly regexp, returns 0 which signals validation
		return "AMEX"	if credit_card.length == 15 && (credit_card =~ /^(34|37)/) == 0
		return "Discover"	if credit_card.length == 16 && (credit_card =~ /^6011/) == 0
		return "MasterCard"	if credit_card.length == 16 && (credit_card =~ /^(5[1-5])/) == 0
		return "VISA"	if [13,16].include?(credit_card.length) && (credit_card =~ /^4/) == 0
		return "Unknown"
	end

#Secondly applying the Luhn algorithm on the number to check is the number valid or not
	def self.luhn(cc_number)
    result = 0
    nums = cc_number.to_s.split("")
    nums.each_with_index do |item, index|
      if index.even?
        result += item.to_i * 2 >9 ? item.to_i*2-9 : item.to_i*2
      else
        result +=item.to_i
    	end
  	end
  	if (result % 10) == 0
      return "valid"
  	else
      return "invalid"
    end
  end



end
