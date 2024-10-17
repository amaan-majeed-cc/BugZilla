class TicketController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  def index
    @tickets = Ticket.all
  end

  def new
    # @tickets = Ticket.new
    @project = Project.find(params[:project_id])
    @tickets = @project.tickets.new
    @users = User.all
    @current_user = current_user
    @my_ticket_type = @tickets.ticket_type || "bug"
    @statuses = set_statuses(@my_ticket_type)
  end

  def create
    @current_user = current_user
    @project = Project.find(params[:project_id])
    @ticket = @project.tickets.new(params.require(:ticket).permit(:title, :description, :deadline, :ticket_type, :status, :creator_id, :developer_id, :project_id, :image))
    @my_ticket_type = @ticket.ticket_type || "bug"
    @statuses = set_statuses(@my_ticket_type)
    @users = User.all
    # @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to project_path(id: @project), notice: "Ticket was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @project = Project.find(params[:project_id])
    @tickets = @project.tickets.new(ticket_params)
  end

  def edit
    @project = Project.find(params[:project_id])
    @tickets = @project.tickets.new
    @users = User.all
    @current_user = current_user
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
    @ticket.destroy!

    respond_to do |format|
      format.html { redirect_to project_path, status: :see_other, notice: "ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.permit(:title, :description, :deadline, :ticket_type, :status, :creator_id, :developer_id, :project_id, :image)
    end

    def set_statuses(my_ticket_type)
      if @my_ticket_type == "feature"
        Ticket::FEATURE_STATUS
      else
        Ticket::BUG_STATUS
      end
    end
end
