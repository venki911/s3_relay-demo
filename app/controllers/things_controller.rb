class ThingsController < ApplicationController

  before_action :find_thing, only: [:show, :edit, :update]
  before_action :find_files, only: [:new, :create, :show, :edit, :update]

  def index
    @things = Thing.all.order("created_at DESC")
  end

  def new
    @thing = Thing.new
    render "form"
  end

  def create
    @thing = Thing.new(thing_params)

    if @thing.save
      redirect_to thing_path(@thing)
    else
      render "form"
    end
  end

  def show
  end

  def edit
    render "form"
  end

  def update
    if @thing.update(thing_params)
      redirect_to thing_path(@thing)
    else
      render "form"
    end
  end

  private

  def find_thing
    @thing = Thing.find(params[:id])
  end

  def find_files
    if @thing.try(:persisted?)
      @imported_files  = []  # TODO: Use something like @thing.photos
      @pending_uploads = @thing.photo_uploads.pending
    else
      @imported_files  = []
      @pending_uploads = []
    end
  end

  def thing_params
    params.require(:thing).permit(:name, new_photo_uploads_uuids: [])
  end

end
