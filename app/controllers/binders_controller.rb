class BindersController < ApplicationController
  def index
    @binders = Binder.all
  end

  def new
    @binder = Binder.new
  end

  def create
    binder = Binder.create(params[:binder])
    redirect_to(root_path)
  end

  def show
    @binder = Binder.find(params[:id])
    @demographics = @binder.demographics
  end

  def edit
    @binder = Binder.find(params[:id])
  end

  def update
    binder = Binder.find(params[:id])
    binder.update_attributes(params[:binder])
    redirect_to(binder)
  end

  def destroy
    binder = Binder.find(params[:id])
    binder.delete
    redirect_to(binders_path)
  end


  def add_to_binder
    binder = Binder.find(params[:id])
    demographic = params[:demographic_id]
    binder.demographics << demographic
    redirect_to(binder)
  end
end