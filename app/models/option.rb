class Option < ActiveRecord::Base
  # belongs_to :word, validate: true
  belongs_to :word
  validates_presence_of :content

  scope :is_answer, -> {where correct: true}
end
