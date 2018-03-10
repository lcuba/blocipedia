class User < ApplicationRecord
  
  has_many :wikis
  has_many :collaborators
  has_many :wiki_collaborations, through: :collaborators, source: :wiki
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  after_initialize {self.role ||= :standard}
  
  enum role: [:standard, :premium, :admin]
  
  def reset_to_public
    self.wikis.each {|wiki| puts wiki.make_public}
  end
end
