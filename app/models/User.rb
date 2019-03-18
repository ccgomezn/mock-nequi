class User
    attr_accessor :name, :email, :password_digest, :account_id

    def initialize(params)
      @name = params[:name]
      @email = params[:email]
      @password_digest = params[:password_digest]
      @account_id = params[:account_id]
      end
end
