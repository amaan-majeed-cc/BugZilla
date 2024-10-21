class ProjectController < ApplicationController
  include UserCheckable
  before_action :set_project, only: %i[ show edit update destroy ]

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
    @team = @project.user
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
    @project.destroy!
    respond_to do |format|
      format.html { redirect_to project_index_path, status: :see_other, notice: "Project was successfully destroyed." }
    end
  end

  def add_user
    @project = Project.find(params[:id])
    @users = User.all
    @team = @project.user
  end

  def add_user_to_project
    @project = Project.find(params[:id])
    @user_id = params.permit(:user_id)[:user_id]
    @user = User.find(params[:user_id])

    if @user.projects.include?(@project)
      redirect_to project_path(@project), alert: "User Already assigned to the Project"
    else
      UserProject.create(
        user_id: @user_id,
        project: @project
      )
      redirect_to project_path(@project), notice: "Assigned User to the Project"
    end
  end

  def remove_user
    @project = Project.find(params[:id])
    @users = @project.user
    @team = @project.user
  end

  def remove_user_to_project
    @project = Project.find(params[:id])
    @user = User.find(params[:user_id])

    @tickets_of_project = @project.user.find(params[:user_id]).tickets_assigned.update_all(developer_id: nil)

    if @project.user.include?(@user)
      UserProject.find_by(user_id: @user.id, project_id: @project.id).destroy
      redirect_to project_path(@project), notice: "Removed User from the Project"
    else
      redirect_to project_path(@project), alert: "User not assigned to the Project"
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
