module UsersHelper

  def genderer(gender)
    case gender
    when 1
      return "Male"
    when 2
      return "Female"
    when 3
      return "Other"
    end
  end

end
