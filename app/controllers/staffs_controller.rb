class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  def index
    @staffs = staffs.order(:id)
  end

  # GET /staffs/1
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  def create
    @staff = Staff.new(staff_params)

    if @staff.save
      redirect_to @staff, success: '成功创建员工'
    else
      render :new
    end
  end

  # PATCH/PUT /staffs/1
  def update
    if @staff.update(staff_params)
      redirect_to @staff, success: '成功更新员工'
    else
      render :edit
    end
  end

  # DELETE /staffs/1
  def destroy
    if @staff.destroy
      redirect_to staffs_url, success: '员工已删除'
    else
      redirect_back fallback_location: departments_url, alert: '员工删除失败'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def staffs
      @staffs ||= Staff.joins(:branch, :department).select('staffs.*', 'branches.name AS branch_name', 'departments.name AS department_name')
    end

    def set_staff
      @staff = staffs.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def staff_params
      params.require(:staff).permit(:person_id, :name, :phone, :address, :start_date, :manager, :branch_id, :department_id)
    end
end
