class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators, source: :user
  accepts_nested_attributes_for :collaborators
  
  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :user, presence: true
  
  after_initialize :initialize_privacy
  
  def make_public
    update_attributes(private: false)
  end
  
  private
  
  def initialize_privacy
    if self.private.nil?
      self.private = false
    end
  end
end
