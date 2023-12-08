class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  

  
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'は半角英数字混合で入力してください' }

  with_options presence: true do
    validates :nickname 
    validates :name_last, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は全角ひらがな、全角カタカナ、漢字で入力してください' }
    validates :name_first, format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/, message: 'は全角ひらがな、全角カタカナ、漢字で入力してください' }
    validates :katakana_last, format: { with: /\A[ァ-ン]+\z/, message: 'は全角カタカナで入力してください' }
    validates :katakana_first, format: { with: /\A[ァ-ン]+\z/, message: 'は全角カタカナで入力してください' }
    validates :birthday
  end

  has_many :items
  has_many :orders
end