class Admin::TestsController < Admin::BaseController
  before_action :set_test, only: %i[show edit update destroy]

  def index
    @tests = current_user.created_tests
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.created_tests.build(test_params)

    if @test.save
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def edit
    @author = @test.author
  end

  def update
    if @test.update(test_params)
      redirect_to [:admin, @test]
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def rescue_with_test_not_found
    render plain: 'Test was not found'
  end
end
