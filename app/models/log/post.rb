class Log::Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  acts_as_taggable

  validates :title, presence: true, length: { maximum: 100 }
  validates :body,  presence: true

  has_attached_file :poster, styles: { large: "720x300>", medium: "360x150>", thumbnail: "60x25>" }
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/
end
