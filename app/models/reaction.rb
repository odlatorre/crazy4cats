class Reaction < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :user
  belongs_to :comment, optional: true 
end
