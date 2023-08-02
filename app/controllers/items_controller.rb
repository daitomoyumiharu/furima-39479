class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index]
  def index
  end
end
