require 'net/http'
require 'uri'
require 'json'

class HomeController < ApplicationController

  before_action :authenticate_user!, only: [:search]


  def home

  end

  def mysearch
    @data = TrackingSearch.where(:user => current_user.id)

    puts("mes data", @data)
  end

  def search

    @name = params[:name]

    tracking = TrackingSearch.new()

    tracking.user = current_user.id
    tracking.search = @name

    tracking.save()


    # Debut curl request

    # myjson = "{query {search(query: "+@name+", type: USER, first: 100){nodes{... on USER {name,id}}}}}"
    #
    # uri = URI.parse("https://api.github.com/graphql")
    # request = Net::HTTP::Post.new(uri)
    # request["Authorization"] = "bearer 6121f9785deb5f96d3e95e135698cbee262395ea"
    # request.body = myjson
    #
    # req_options = {
    #     use_ssl: uri.scheme == "https",
    # }
    #
    # response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    #   http.request(request)
    # end

    # FIn curl request



    # query {
    #   search(query: "var", type: USER, first: 100) {
    #     nodes {
    #       ... on User {
    #         name
    #         login
    #         repositories(first:10) {
    #           nodes {
    #             nameWithOwner
    #           }
    #         }
    #       }
    #     }
    #   }
    # }

  end

end