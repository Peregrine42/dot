class Link < ActiveRecord::Base
  belongs_to :node
  belongs_to :tag
end