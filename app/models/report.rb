class Report < ApplicationRecord
  belongs_to :reporter, class_name: "Customer"
  belongs_to :reported, class_name: "Customer"
  
  validates :reason, presence: true
  
  enum status: { waiting: 0, keep: 1, finish: 2 } 
end
