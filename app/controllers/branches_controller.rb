class BranchesController < ApplicationController
  before_action :set_branch, only: %i[show staffs edit update destroy]
  before_action :set_staffs, only: %i[show staffs]

  # GET /branches
  def index
    @branches = Branch.order(:id)
  end

  # GET /branches/1
  def show
  end

  # GET /branches/new
  def new
    @branch = Branch.new
  end

  # GET /branches/1/edit
  def edit
  end

  # POST /branches
  def create
    @branch = Branch.new(branch_params)

    if @branch.save
      redirect_to @branch, success: '成功创建支行'
    else
      render :new
    end
  end

  # PATCH/PUT /branches/1
  def update
    if @branch.update(branch_params)
      redirect_to @branch, success: '成功更新支行'
    else
      render :edit
    end
  end

  # DELETE /branches/1
  def destroy
    if @branch.destroy
      redirect_to branches_url, success: '支行已删除'
    else
      redirect_back fallback_location: branches_url, alert: '支行删除失败'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch
      @branch = Branch.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branch_params
      params.fetch(:branch, {}).permit(%i[name city assets])
    end

    def set_staffs
      @staffs = Staff.where(branch: @branch)
    end
end
