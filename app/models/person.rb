class Person < ApplicationRecord
    belongs_to :user, optional: true
end
