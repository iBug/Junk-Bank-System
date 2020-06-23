class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[show staffs edit update destroy]
  before_action :set_staffs, only: %i[show staffs]

  # GET /departments
  def index
    @departments = Department.order(:id)
  end

  # GET /departments/1
  def show
  end

  # GET /departments/new
  def new
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
  end

  # POST /departments
  def create
    @department = Department.new(department_params)

    if @department.save
      redirect_to @department, success: '成功创建部门'
    else
      render :new
    end
  end

  # PATCH/PUT /departments/1
  def update
    if @department.update(department_params)
      redirect_to @department, success: '成功更新部门'
    else
      render :edit
    end
  end

  # DELETE /departments/1
  def destroy
    if @department.destroy
      redirect_to departments_url, success: '部门已删除'
    else
      redirect_back fallback_location: departments_url, alert: '部门删除失败'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def department_params
      params.require(:department).permit(%i[name kind])
    end

    def set_staffs
      @staffs = Staff.where(department: @department)
    end
end
