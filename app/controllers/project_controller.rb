class ProjectController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :check_user!, only: :index

  def index
    @projects = current_user.projects
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        UserProject.create(user: current_user, project: @project)
        format.html { redirect_to project_index_path, notice: "Project was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @project = Project.find(params[:id])
    @tickets = @project.tickets
    @current_project = current_user.projects.find(params[:id])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_index_path, notice: "Project was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @current_project = current_user.projects.find(params[:id])

    if @current_project.tickets.any?

      redirect_to @project, alert: "Cannot Delete the Project with Tickets inside it: Delete the Tickets then delete the project"
    else
      @project.destroy!

      respond_to do |format|
        format.html { redirect_to project_index_path, status: :see_other, notice: "Project was successfully destroyed." }
      end
    end
  end

  

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.permit(:name, :description)
    end

    def check_user!
      redirect_to new_user_session_path unless current_user
    end
end
