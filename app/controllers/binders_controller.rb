class BindersController < ApplicationController
  def index
    @binders = Binder.all
  end

  def new
    @binder = Binder.new
  end

  def create
    binder = Binder.create(params[:binder])
    redirect_to(binder)
  end

  def show
    @binder = Binder.find(params[:id])
  end
end