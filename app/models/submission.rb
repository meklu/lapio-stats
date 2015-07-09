class Submission < ActiveRecord::Base
  belongs_to :week

  validates :student_id, presence: true, length: {is: 9}
  validate :points_is_less_than_max

  def self.search(search)
    where("student_id LIKE ?", "%#{search}%")
  end

  def percentage
    ((self.points.to_f / self.week.max_points) * 100).round(2)
  end

  private
    def points_is_less_than_max
      errors.add(:points, "should be less than max points") if points > self.week.max_points
    end
end
