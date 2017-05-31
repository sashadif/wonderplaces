class Place < ActiveRecord::Base
  belongs_to :category
  has_and_belongs_to_many :users
  mount_uploaders :avatars, AvatarUploader
  serialize :avatars, JSON
  
  scope :filter_with, ->(name) { where('lower(name) LIKE ?', "%#{name.downcase}%") }
end
