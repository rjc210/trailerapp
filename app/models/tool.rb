class Tool < ActiveRecord::Base
  attr_accessible :barcode, :description, :name, :checkouts, :participants, :organizations
  validates :barcode, :uniqueness => true
  validates :name, :presence => true

  has_many :checkouts
  has_many :participants, :through => :checkouts
  has_many :organizations, :through => :checkouts

  scope :hardhats, where('NAME LIKE "%hardhat"')
  scope :radios, where('NAME LIKE "%radio"')
  scope :just_tools, where('NAME NOT LIKE "%radio" AND NAME NOT LIKE "%hardhat"')

  def current_organization
    if not self.checkouts.current.empty?
      return self.checkouts.current[0].organization
    end
  end

  def current_participant
    if not self.checkouts.current.empty?
      return self.checkouts.current[0].participant
    end
  end

  def is_checked_out?
    return not(self.checkouts.current.empty?)
  end

  def self.checked_out_by_organization(organization)
    joins(:checkouts).where(:checkouts => {:organization_id => organization }).merge(Checkout.current)
  end
end
