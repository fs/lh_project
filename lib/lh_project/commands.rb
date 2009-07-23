$:.unshift(File.expand_path(File.dirname(__FILE__) + '/..'))

require 'optparse'
require 'lh_project'

options = {
  'verbose' => false,
  'project' => {},
  'lighthouse' => {}
}

opts = OptionParser.new do |opts|
  opts.banner = 'Usage: lh_project [options] --config config/config.yml --project-name name'
  [
    [['-n', '--project-name name', 'LH project name'], 'project/name'],
    [['-c', '--config config.yml', 'With configuration file'], 'config'],
    [['-v', '--[no-]verbose', 'Run verbosely'], 'verbose'],
  ].each do |option|
    opts.on(*option[0]) do |value|
      options.path[option[1]] = value
    end
  end

  opts.on_tail('--version', 'Show version') do
    puts "lh_project version: #{LhProject::VERSION::STRING}"
    exit
  end
end

opts.parse!

if options['config'].blank? || !File.readable?(options['config'])
  puts 'Required parameter --config is missing or config file is not readable'
  puts opts.to_s
  exit 1
end

if options['project']['name'].blank?
  puts 'Required parameter --project-name is missing'
  puts opts.to_s
  exit 1
end

options = options.deep_merge(YAML.load(File.read(options['config'])))

LhProject::Base.logger.level = options['verbose'] ? Logger::DEBUG : Logger::INFO
LhProject::Base.new(options).create
