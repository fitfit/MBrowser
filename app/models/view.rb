class View < ActiveRecord::Base
  has_and_belongs_to_many :movies
  has_many :conditions
  acts_as_taggable
  accepts_nested_attributes_for :conditions

  def get_movies
    unless self.tag_list.empty?
      unless self.conditions.find_by_kind('order').nil?
        m = Movie.order(self.conditions.find_by_kind('order').attr).tagged_with(self.tag_list , :any=>true)
      else
        m = Movie.tagged_with(self.tag_list , :any=>true)
      end
    else
      unless self.conditions.find_by_kind('order').nil?
        m = Movie.order(self.conditions.find_by_kind('order').attr).all
      else
        m = Movie.all
      end
      
    end
    m
  end
end
