class Author < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  has_many :books

  def display_name
    # Rowling, J.K
    self.last_name + ", " + self.first_name
  end
end