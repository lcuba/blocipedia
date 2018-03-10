class Collaborator < ApplicationRecord
  belongs_to :user
  belongs_to :wiki
=begin
  def self.assign_collaborators(collab_info)
    if collab_info.blank?
      return Collaborator.none
    end
    collab_info.split(",").map do |collab|
      Collaborator.find_or_create_by(email: collab.strip)
    end
  end
=end
end
