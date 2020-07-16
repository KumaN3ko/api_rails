class HomeController < ApplicationController

  def home

  end

  def search

    @name = params[:name]



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