# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  deadline   :date             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :content, uniqueness: true
  validates :deadline, presence: true

  has_one_attached :eyecatch

  belongs_to :board

  belongs_to :user

  has_many :comments, dependent: :destroy

  def day
    return '不明' unless deadline.present?
    days = deadline.yday - Time.zone.now.yday
  end
end
