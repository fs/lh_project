%w(lighthouse-api addressable-2.1.0 activeresource-2.3.2 activesupport-2.3.2).each do |lib|
  $:.unshift(File.expand_path(File.dirname(__FILE__) + "/vendor/#{lib}/lib"))
end

require 'lighthouse'
require 'activesupport'
