class Picture < ActiveRecord::Base
  validates :content, presence: true
end
