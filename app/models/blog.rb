class Blog < ApplicationRecord
    validates :title, presence: true
    validates :audio, presence: true
    belongs_to :user
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user
    mount_uploader :image, ImageUploader
    mount_uploader :audio, AudioUploader
end
