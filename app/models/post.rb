class Post < ActiveRecord::Base
  belongs_to :postable, polymorphic: true

  default_scope { order('updated_at DESC') }
end
