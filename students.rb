require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'students.sqlite'
)

class Student < ActiveRecord::Base
  # we have name, surnames, birthday, website, number_of_dogs
  # and first_programming_experience

  AGE_MINIMUM = 16

  validates_presence_of :name, :surnames
  validates_format_of :website, with: /\Ahttp:/
  validates_numericality_of :number_of_dogs, greater_than: 0
  validate :not_xavier
  validate :not_nick
  validate :proper_age

  def complete_name
    name.to_s + ' ' + surnames.to_s
  end

  private

  def proper_age
    unless birthday < AGE_MINIMUM.years.ago
      errors.add(:birthday, 'is too young')
    end
  end

  def not_xavier
    if name =~ /Xavier/i
      errors.add(name, 'not allowed to be called Xavier')
    end
  end

  def not_nick
    if name =~ /Nick/i
      errors.add(name, 'not allowed to be called Nick')
    end
  end

end
