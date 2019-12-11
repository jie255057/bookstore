class Admin::PublishersController < Admin::BaseController
  
  def index
    @publishers = Publisher.all
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(publisher_params)
    if @publisher.save
      redirect_to admin_publishers_path, notice: '新增成功'
    else
      render :new
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])
    if @publisher.update(publisher_params)
      redirect_to admin_publishers_path, notice: '編輯成功'
    else
      render :edit
    end
  end

  def destroy
    @publisher = Publisher.find(params[:id])
    @publisher.destroy
    redirect_to admin_publishers_path, notice: '已刪除'
  end
  private

  def publisher_params
    params.require(:publisher).permit(:name, :tel, :address, :note, :online)
  end
end
