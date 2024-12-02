class Url < ApplicationRecord
  validates :original_url, presence: true, format: URI::DEFAULT_PARSER.make_regexp

  before_create :generate_short_url

  private

  def generate_short_url
    self.short_url = SecureRandom.hex(3)
  end
end
