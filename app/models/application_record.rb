# frozen_string_literal: true

# Provide active record features to all the other models
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
