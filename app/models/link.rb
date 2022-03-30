class Link < ApplicationRecord
  acts_as_taggable_on :tags
  has_many :questions
  accepts_nested_attributes_for :questions
end
