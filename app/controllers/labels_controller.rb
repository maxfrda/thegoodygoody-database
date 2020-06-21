class LabelsController < ApplicationController

  def create
    @label = Label.new(label_params)
    @label.save
  end

  def index
    @labels = Label.all
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

end
