require 'rubygems'
require 'activesupport'

class Hash
  class Path
    def initialize(hash)
      @hash = hash
    end

    def [](path)
      key, item = last_item(path)
      item[symbolize_key(key)]
    end

    def []=(path, value)
      key, item = last_item(path)
      item[symbolize_key(key)] = value
    end

    private

    def last_item(path)
      path = path.split('/')
      return path.pop, path.inject(@hash) { |hash, key| hash[symbolize_key(key)] }
    end

    def symbolize_key(key)
      key.start_with?(':') ? eval(key) : key
    end
  end

  def path
    Path.new(self)
  end
end

class Lighthouse::Project
  def inspect
    "#<#{self.class} id: #{id}, name: #{name}>"
  end
end

class Lighthouse::Ticket
  def inspect
    "#<#{self.class} id: #{id}, title: #{title}, state: #{state}, user: #{attributes['assigned_user_id']}>"
  end
end
