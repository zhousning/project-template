# == Schema Information
#
# Table name: buyers
#
#  id             :integer          not null, primary key
#  alias          :string           default(""), not null
#  name           :string           default(""), not null
#  duty_paragraph :string           default(""), not null
#  account        :string           default(""), not null
#  phone          :string           default(""), not null
#  remark         :string           default(""), not null
#  checker        :string           default(""), not null
#  payee          :string           default(""), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Buyer < ActiveRecord::Base
  has_many :enclosures, :dependent => :destroy


  #validates :name,     :presence => true, :uniqueness => true

  accepts_nested_attributes_for :enclosures, reject_if: :all_blank, allow_destroy: true


  #before_save :store_unique_number
  #def store_unique_number
  #  if self.number == ""
  #    self.number = Time.now.to_i.to_s + "%04d" % [rand(10000)]
  #  end
  #end
end
