Gem::Specification.new do |s|
  s.name = 'chef-handler-sensu-event'
  s.version = '0.2.0'
  s.author = 'Simple Finance'
  s.email = 'ops@simple.com'
  s.homepage = 'http://github.com/SimpleFinance/chef-handler-sensu-event'
  s.summary = 'Triggers a Sensu event if Chef fails to complete'
  s.description = 'Triggers a Sensu event if Chef fails to complete'
  s.files = ::Dir.glob('**/*')
  s.require_paths = ['lib']
end

