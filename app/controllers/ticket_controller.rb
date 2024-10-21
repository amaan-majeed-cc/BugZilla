class TicketController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  include UserCheckable
  def index
    @tickets = Ticket.all
  end

  def new
    @project = Project.find(params[:project_id])
    @tickets = @project.tickets.new
    @users = @project.user
    @current_user = current_user
    @my_ticket_type = @tickets.ticket_type
    @statuses = set_statuses(@my_ticket_type)
  end

  def create
    @current_user = current_user
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.new(params.require(:ticket).permit(:title, :description, :deadline, :ticket_type, :status, :creator_id, :developer_id, :project_id, :image))
    @my_ticket_type = @ticket.ticket_type || "bug"
    @statuses = set_statuses(@my_ticket_type)
    @users = @project.user

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to project_path(id: @project), notice: "Ticket was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    # @project = Project.find(params[:project_id])
    # @tickets = @project.tickets.new(ticket_params)
    # only show ticket if its ticket show page
  end

  def edit
    @project = Project.find(params[:project_id])
    @tickets = @project.tickets.new
    @users = User.all
    @current_user = current_user
    @my_ticket_type = @ticket.ticket_type || "bug"
    @statuses = set_statuses(@my_ticket_type)
  end

  def update
    @project = Project.find(params[:project_id])
    @current_user = current_user
    @users = User.all
    respond_to do |format|
      if @ticket.update(params.require(:ticket).permit(:title, :description, :deadline, :ticket_type, :status, :creator_id, :developer_id, :project_id, :image))
        format.html { redirect_to project_ticket_path(project_id: @project, id: @ticket), notice: "Ticket was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @ticket.destroy!
    respond_to do |format|
      redirect_to project_path(@project), status: :see_other, notice: "ticket was successfully destroyed."
    end
  end

  private
    def set_ticket
      @project = Project.find(params[:project_id])
      @ticket_found = Ticket.find_by(id: params[:id])

      if @ticket_found
        @ticket = Ticket.find(params[:id])
      else
        redirect_to project_path(@project)
      end
    end

    def ticket_params
      params.permit(:title, :description, :deadline, :ticket_type, :status, :creator_id, :developer_id, :project_id, :image, :id)
    end

    def set_statuses(my_ticket_type)
      if my_ticket_type == "feature"
        Ticket::FEATURE_STATUS
      else
        Ticket::BUG_STATUS
      end
    end
end
