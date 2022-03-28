class Question < ApplicationRecord
  belongs_to :link
  before_validation :to_ascii
  before_validation :linked

  include PgSearch::Model
  pg_search_scope :search_by_query,
  against: [ :query ],
  using: {
    tsearch: { prefix: true }
  }

  def to_ascii
    self.query = ActiveSupport::Inflector.transliterate(query).to_s
  end

  def linked
    link0 = Link.where(url: nil).first
    if self.link == nil
      self.link = link0
      self.linked = false
    else
      self.linked = true
    end
  end
end
