class Collection < ApplicationRecord
  enum status: { wait_approve: 0, approved_y: 1, approved_n: 2 }

  belongs_to :user, counter_cache: true
  has_many :posts

  validates :title,
            :presence => true,
            :length => {:within => 5..20}

  validates :content,
            :presence => true,
            :length => {:within => 10..200}


  scope :available, -> { where(status: :approved_y)}



end
