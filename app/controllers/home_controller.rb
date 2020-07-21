require "graphql/client"
require "graphql/client/http"

class HomeController < ApplicationController


  #Recupère la liste des user ayant un nom proche de celui cherché
  GetUser = GitHub::Client.parse <<-'GRAPHQL'
    query {
      search(query:$searchName, type:USER, first:100) {
        nodes {
          ... on User {
            name
            login
            id
          }
        }
      }
    }
  GRAPHQL

  #Récupère les repo public du user, ainsi que les langages utilisé dans ces repo
  GetRepo = GitHub::Client.parse <<-'GRAPHQL'
    query {
      search(query:$selectedUser, type:USER, first:100) {
        nodes {
          ... on User {
            repositories(first: 100) {
              nodes {
                name
                languages(first: 10) {
                  nodes {
                    name
                  }
                }
              }
            }
        		
          }
        }
      }
    }
  GRAPHQL

  #Permet de récupérer les languages le plus utilisé dans chaque projet afin de faire une moyenne
  getPrimaryLanguage = GitHub::Client.parse <<-'GRAPHQL'
    query {
      search(query:$selectedUser, type:USER, first:100) {
        nodes {
          ... on User {
            repositories(first: 100) {
              nodes {
                primaryLanguage {
                  name
                }
              }
            }
          }
        }
      }
    }
  GRAPHQL



  before_action :authenticate_user!, only: [:search]


  def home

  end

  def mysearch
    @data = TrackingSearch.where(:user => current_user.id)
  end

  def search

    @name = params[:name]

    # Create tracking

    tracking = TrackingSearch.new()

    tracking.user = current_user.id
    tracking.search = @name

    tracking.save()

    # Create graphql request to the GITHUB api
    #
    data = query GetUser

    # --------------------------




  end

end