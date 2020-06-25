class Release < ApplicationRecord
  belongs_to :artist
  belongs_to :label
end
