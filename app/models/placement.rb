class Placement < ApplicationRecord
    validates :placement_id, uniqueness: true
end
