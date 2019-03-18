class User


    attr_accessor :id, :name, :email, :account_id



    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @email = params[:email]
      @account_id = params[:account_id]
    end

end

