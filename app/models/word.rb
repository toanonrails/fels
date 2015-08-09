class Word < ActiveRecord::Base
  belongs_to :category
  has_many :options
  accepts_nested_attributes_for :options, allow_destroy: true,
                                reject_if: lambda {|option| option['content'].blank?}
  validates_presence_of :content, :category

  validate :has_at_least_two_options,
           :has_unique_options,
           :has_only_one_correct_option

  private
  def has_at_least_two_options
    errors[:base] << "Must have at least 2 options" if options.length < 2
  end

  def has_only_one_correct_option
    number_of_correct_options = options.select{|option| option.correct}.count
    unless number_of_correct_options == 1
      errors[:base] << "Must have one and only one correct option"
    end
  end

  def has_unique_options
    contents = []
    options.each{|option| contents << option.content}
    unless contents.length == contents.uniq.length
      errors[:base] << "Must have unique options"
    end
  end
end
