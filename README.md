# SensuEvent
A Chef report handler to trigger an event in Sensu given a failed Chef run

## Usage
The Chef docs [1] lay out a pretty simple way to use handlers by leveraging the
chef\_handler resource. Just ship the chef-handler-sensu-event.rb file to
your handlers location and declare a new handler:

```ruby
cookbook_file "#{node[:chef_handler][:handler_path]}/chef-handler-sensu-event.rb" do
  source 'chef-handler-sensu-event.rb'
  mode 00600
end

chef_handler 'SensuEvent' do
  source "#{node[:chef_handler][:handler_path]}/chef-handler-sensu-event.rb"
  action :enable
end
```

Obviously make sure to copy the ruby file into the `/files/default` directory
of your cookbook as well. Alternatively, install it as a Rubygem and source it that way:

```ruby
chef_gem 'chef-handler-sensu-event' do
  action :install
end

chef_handler 'Chef::Handler::SensuEvent' do
  source ::File.join(Gem.all_load_paths.grep(/chef-handler-sensu-event/).first,
                     'chef-handler-sensu-event.rb')
  action :enable
end
```

[1] http://docs.opscode.com/resource_chef_handler.html
## License
Apache License, Version 2.0

## Author
Simple Finance <ops@simple.com>

