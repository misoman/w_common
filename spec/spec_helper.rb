require 'chefspec'
require 'chefspec/berkshelf'
require 'mymatchers'

ChefSpec::Coverage.start! do
  add_filter(%r{/ntp/})
  add_filter(%r{/sudo/})
  add_filter(%r{/timezone-ii/})
  add_filter(%r{/apt/})
  add_filter(%r{/monit/})
  add_filter(%r{/build-essential/})
  add_filter(%r{/git/})
  add_filter(%r{/apt-repo/})
 end

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '12.04'
  config.filter_run_excluding skip: true
end