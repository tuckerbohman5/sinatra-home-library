class Author < ActiveRecord::Base
  has_many :books

  def display_name
    # Rowling, J.K
    self.last_name + ", " + self.first_name
  end
end