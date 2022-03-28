class Question < ApplicationRecord
  belongs_to :link
  before_validation :to_ascii

  include PgSearch::Model
  pg_search_scope :search_by_query,
  against: [ :query ],
  using: {
    tsearch: { prefix: true }
  }

  def to_ascii
    self.query = ActiveSupport::Inflector.transliterate(query).to_s
  end
end
