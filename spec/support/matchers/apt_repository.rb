def add_apt_repository(repo)
  ChefSpec::Matchers::ResourceMatcher.new(:apt_repository, :add, repo)
end
