# Description: Superclass for all models, creates RAILS active records
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
