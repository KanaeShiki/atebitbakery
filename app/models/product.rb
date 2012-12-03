class Product < ActiveRecord::Base
  attr_accessible :name, :description, :price, :stock_quantity, :picture
  validates :name, :presence => true
  
  default_scope :order => 'name'
  
  has_many :line_items
  has_many :orders, :through => :line_items
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  # ensure that there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
      else
        errors.add(:base, 'Line Items present')
      return false
    end
  end
end
