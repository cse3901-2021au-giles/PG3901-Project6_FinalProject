class Evaluation < ApplicationRecord
  belongs_to :project
  belongs_to :team
  belongs_to :student
end