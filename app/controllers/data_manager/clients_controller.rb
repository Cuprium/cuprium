class DataManager::ClientsController < DataManager::CommonController
  respond_to :html
  def index
    @clients = Client.all
  end
  def new
    @client = Client.new
  end
  def create
    @client = Client.create(params[:client])
    respond_with :data_manager,@client
  end
  def show
    @client = Client.find params[:id]
  end
end
