class Post < ActiveRecord::Base
  validates_presence_of :title, :content
  scope :active, :conditions => {:deleted => false}

  def to_param
    "#{self.id}-#{self.title.downcase.gsub(' ','-').gsub(/[^\w-]/,'')}"
  end

  def delete
    self.update_attribute(:deleted, true)
  end

  def restore
    self.update_attribute(:deleted, false)
  end

  def self.all_on_month(month, year)
    fromDate = Date.parse(year + "-" + month + "-01")
    toDate = fromDate.advance(:months => 1)
    
    fromDateString = fromDate.strftime("%Y-%m-%d")
    toDateString = toDate.strftime("%Y-%m-%d")

    all_in_range(fromDateString, toDateString)
  end

  def self.all_in_range(fromDate, toDate)
    active.all(:conditions => "`created_at` >= '#{fromDate}' AND
                               `created_at` < '#{toDate}'",
               :order => "created_at DESC")
  end

  def self.recent(count)
    active.all(:order => "created_at DESC", :limit => count)
  end

  def self.featured
    active.all(:conditions => {:featured => true})
  end

  def self.archive
    active.count(:all, :group => "DATE_FORMAT(created_at, '%Y %m')")
  end
end
