class User < ApplicationRecord
    has_one_attached :avatar
    has_secure_password

    has_one :teacher, dependent: :destroy
    has_many :favourites, dependent: :destroy
    has_many :favourited_teachers, through: :favourites, source: :teacher
    
    has_many :teachers, through: :favourites
    

    has_many :reviews, dependent: :nullify

    
    has_many :lessons, dependent: :destroy

    has_many :payments, dependent: :destroy
   
    validates(:email, presence: true, uniqueness: true, format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)

    def full_name
        "#{first_name} #{last_name}".strip
    end

    # def thumbnail input
    #     return self.avatar[input].variant(resize: '300x300!').processed
    #   end
end
