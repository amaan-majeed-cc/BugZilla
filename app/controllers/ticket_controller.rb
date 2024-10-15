class TicketController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  def index
    @tickets = Ticket.all
  end

  def new
    @tickets = Ticket.new
  end

  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to tickets_path, notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tickets = Ticket.find(params[:id])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to tickets_path, notice: "Ticket was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ticket.destroy!

    respond_to do |format|
      format.html { redirect_to tickets_path, status: :see_other, notice: "ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:title, :description, :deadline, :ticket_type, :status, :creator, :developer, :project_id)
    end
end
