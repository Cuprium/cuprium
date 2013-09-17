class Question < ActiveRecord::Base
  Kinds = ['yesno','list','date']
  KindList = Kinds.map { |kind| [I18n.t(kind,scope: [:models,:question]), kind] }
  attr_accessible :loan_product_id, :page, :text, :display_order, :kind
  validates_presence_of :loan_product_id, :page, :text, :display_order, :kind
  belongs_to :loan_product
  validate :kind, :kind_must_belong_to_kinds
  scope :in_order, order: 'page, display_order'
  def response_attributes
    self.attributes.dup.tap do |attribs|
      attribs.delete(:created_at)
      attribs.delete(:updated_at)
      attribs[:answer] = ""
    end
  end
  private
  def kind_must_belong_to_kinds
    errors.add(:kind,"must be one of '#{Kinds.join("','")}'") unless Kinds.include?(kind)
  end
end
