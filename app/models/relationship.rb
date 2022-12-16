class Relationship < ApplicationRecord
  belongs_to :member
  belongs_to :follow, class_name: "Member"
end
