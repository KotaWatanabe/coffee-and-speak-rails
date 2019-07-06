class Teacher < ApplicationRecord
    has_many :lessons, dependent: :destroy
    belongs_to :user
    
    has_many :favourites, dependent: :destroy
    has_many :favoriters, through: :favourites, source: :user
    has_many :users, through: :favourites
   
    has_many :reviews, dependent: :destroy

    has_many :teacher_languages, dependent: :destroy
    has_many :languages, through: :teacher_languages

    has_many :teacher_timeslots, dependent: :destroy
    has_many :timeslots, through: :teacher_timeslots

    has_many :payments, dependent: :destroy

    has_many :availabilities, dependent: :destroy
    # accepts_nested_attributes_for :timeslots

    def calculate_rating
        rating = 0
        count = 0
        if reviews.length == 0 
            return 0
        else
            reviews.each do |r|
                rating += r.rating
                count +=1
            end
            return rating / count
        end
    end

  def language_names
    self.languages.map{ |l| l.name }.join(",")
  end

    def language_names=(rhs)
            self.languages = rhs.strip.split(/\s*,\s*/).map do |language_name|
            Language.find_or_initialize_by(name: language_name)
        end
    end

  def teacher_timeslots
    self.timeslots.map{ |t| t.day }.join(",")
  end

    def teacher_timeslots=(rhs)
            self.timeslots = rhs.strip.split(/\s*,\s*/).map do |timeslot|
            Timeslot.find_or_initialize_by(day: timeslot)
        end
    end

#   def teacher_timeslot_time
#     self.timeslots.map{ |t| t.time }.join(",")
#   end

#     def teacher_timeslot_time=(rhs)
#             self.timeslots = rhs.strip.split(/\s*,\s*/).map do |timeslot|
#             Timeslot.find_or_initialize_by(time: timeslot)
#         end
#     end

    geocoded_by :address
    after_validation :geocode

    private

    def set_default_price
        self.price ||= 1
    end
end
