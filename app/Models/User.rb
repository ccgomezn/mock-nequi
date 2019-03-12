class User
    attr_accessor :name, :password_digest, :account_id

    def initialize(params)
      @name = params[:name]
      @password_digest = params[:password_digest]
      @account_id = params[:account_id]
      end

end
