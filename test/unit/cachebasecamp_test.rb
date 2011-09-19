class CachebasecampTest < ActiveSupport::TestCase

  def setup
    @cachebasecamp_object = Cachebasecamp.new
  end

  test "I get prpject list" do
    projects = @cachebasecamp_object.get_projects
    projects.size > 0
  end

end