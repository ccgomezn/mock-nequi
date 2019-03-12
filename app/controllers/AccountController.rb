require_relative '../db_manager/account_manager'

class AccountController
  include AccountManager

  attr_accessor :id, :avaiable_balance, :total_balance, :creation_date

  def initialize(params)
    @id = params[:id]
    @avaiable_balance = params[:avaiable_balance]
    @total_balance = params[:total_balance]
    @creation_date = params[:creation_date]
  end

  def create_account(*data)

  end

  def show_account(id)

  end

  def update_account(id, *data)

  end

  def delete_account(id, *data)

  end

  def find_account(id)

  end

  def list_accounts

  end

end
