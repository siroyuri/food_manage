class Form::ItemCollection < Form::Base
  FORM_COUNT = 1
  attr_accessor :informations

  def initialize(attributes = {})
    super attributes
    self.informations = FORM_COUNT.times.map { ItemWithInformation.new() } unless self.informations.present?
  end

  def informations_attributes=(attributes)
    self.informations = attributes.map { |_, v| ItemWithInformation.new(v) }
  end

  def save(purchase_date, user_id)
    ActiveRecord::Base.transaction do
      self.informations.map do |information|
        if information.name.present? && information.quantity.present?
          information.purchase_date = purchase_date
          information.user_id = user_id
          information.save
        end
      end
    end
      return true
    rescue => e
      return false
  end
end