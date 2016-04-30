class Post < ActiveRecord::Base
  belongs_to :postable, polymorphic: true

  default_scope { order('updated_at DESC') }

  def location
    if (postable_type == "Location")
      postable
    else
      nil
    end
  end

  def interest
    if (postable_type == "Interest")
      postable
    else
      nil
    end
  end
end
