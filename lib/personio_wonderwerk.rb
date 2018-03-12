require 'personio_wonderwerk/api/employees_api'

# Personio entry point
module PersonioWonderwerk
  # Personio configuration
  class Configuration
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :auth_token

    def initialize
      @client_id = ENV['PERSONIO_CLIENT_ID'] || nil
      @client_secret = ENV['PERSONIO_CLIENT_SECRET'] || nil
      @auth_token = nil
    end
  end

  # Retrieve the configation object
  #
  # @return [{PersonioWonderwerk::Configuration configuration}]
  #    the configuration object
  def self.configuration
    @configuration ||= Configuration.new
  end

  # Reset the configuration
  def self.reset
    @configuration = Configuration.new
  end

  # Configure the personio module
  #
  # @param client_id [String] the client id given by the personio credentials
  # @param client_secret [String] the client secret given by the personio
  #     credentials
  # @param auth_token [String] the auth token retrieved by authenticating with
  #     personio. Can be pre-populated and always contains the latest auth token
  #     provided by the api
  def self.configure
    yield configuration
  end

  # Gets an instance of the personio employees api to query employees
  #
  # @return [{EmployeesApi api}] the personio employees api
  def self.employees
    @employees_api ||= EmployeesApi.new(configuration)
  end
end
