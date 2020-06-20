class BranchesController < ApplicationController
  before_action :set_branch, only: [:show, :edit, :update, :destroy]

  # GET /branches
  def index
    @branches = Branch.all
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
    @branch.destroy
    redirect_to branches_url, success: '支行已删除'
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
end
