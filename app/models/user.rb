class User < ActiveRecord::Base
  ratyrate_rater
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items, as: :created_by, foreign_key: :created_by_id, dependent: :nullify
  belongs_to :created_by, :class_name => "User"

  before_save :set_admin_to_true

  def set_admin_to_true
    self.admin = true
  end
end
