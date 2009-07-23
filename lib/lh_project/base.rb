module LhProject
  class ProjectCreateError < StandardError; end

  class Base
    cattr_accessor :logger
    self.logger = Logger.new(STDOUT)

    cattr_accessor :project
    self.project = {
      'public' => false,
    }

    cattr_accessor :lh
    self.lh = {
      'account' => 'test',
      'token' => 'test'
    }

    cattr_accessor :users
    self.users = {}

    def initialize(options = {})
      self.project = project.update(options['project']) unless options['project'].blank?
      self.lh = lh.update(options['lighthouse']) unless options['lighthouse'].blank?

      establish_lh_connection
    end

    def create
      create_project
      create_ticket_bin
    end

    private

    def establish_lh_connection
      Lighthouse.account = lh['account']
      Lighthouse.token = lh['token']
      logger.debug "* Initialize LH: #{lh.inspect}"
      logger.debug "* Initialize project: #{project.inspect}"
    end

    def create_project
      @lh_project = Lighthouse::Project.new(
        :name => project['name'],
        :public => project['public']
      )

      unless @lh_project.save
        logger.error "* Error while project create #{@lh_project.errors.inspect}"
        raise ProjectCreateError
      else
        logger.debug "* Created new project #{@lh_project.inspect}"
      end
    end

    def create_ticket_bin
      project['ticket_bins'].each do |name, query|
        bin = Lighthouse::Bin.create(
          :project_id => @lh_project.id,
          :name => name,
          :query => query,
          :shared => true
        )

        logger.debug "* Created new ticket bin: #{bin.inspect}"
      end
    end
  end
end