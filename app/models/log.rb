class Log < ActiveRecord::Base
  belongs_to :loggable, :polymorphic => true
end
