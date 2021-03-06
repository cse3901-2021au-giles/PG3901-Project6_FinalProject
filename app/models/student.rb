# frozen_string_literal: true

class Student < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :team, optional: true

  has_many :evaluations, through: :team
end
