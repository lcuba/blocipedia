class Wiki < ApplicationRecord
  belongs_to :user
  
  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :user, presence: true
  
  scope :visible_to, -> (user) {user ? all : where(private: false)}
  
  def make_public
    update_attributes(private: false)
  end
end
