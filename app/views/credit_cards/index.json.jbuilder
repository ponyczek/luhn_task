json.array!(@credit_cards) do |credit_card|
  json.extract! credit_card, :id, :number, :provider, :validation
  json.url credit_card_url(credit_card, format: :json)
end
