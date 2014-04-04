def create_sensu_check(check)
  ChefSpec::Matchers::ResourceMatcher.new(:sensu_check, :create, check)
end
