# Ported from https://github.com/cloudcastle/cucumber_in_groups
require 'active_support/core_ext/array/grouping'

if ENV['TEST_GROUP']
  ENV['TEST_GROUP'] =~ /^(\d+)of(\d+)$/
  group = $1.to_i
  groups_no = $2.to_i
  specs = (Dir['./**/*_spec.rb']).sort.in_groups(groups_no, false)
  specs_to_run = specs[group - 1]
else
  specs_to_run = Dir['./**/*_spec.rb']
end

specs_to_run.each do |file|
  require file
end
