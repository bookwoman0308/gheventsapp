require 'net/http'
require 'json'
require 'uri'

class Githubcall < ActiveRecord::Base

  include ActiveModel::Model

  attr_accessor :response

  # @return [String] Address of the GitHub API page for user events, minus the username and suffix
  class_attribute :source_url, default: 'https://api.github.com/users/'

  class << self
    # @param [String] GitHub username
    # @return [Object]
    def retrieve(username)
      uri = URI.parse(self.source_url + username + "/events")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      get_response = http.request(Net::HTTP::Get.new(uri.request_uri))

      #If the API is inaccessible or the GitHub user does not exist, raise an error.
      raise Error::CallError if not get_response.is_a?(Net::HTTPSuccess)

      response = Hash.new
      response = {
        data: JSON.parse(get_response.body)
      }
    end
  end
end
