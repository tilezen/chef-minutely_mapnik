def create_lvm_volume_group(group)
  ChefSpec::Matchers::ResourceMatcher.new(:lvm_volume_group, :create, group)
end
