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

  def create(*data)

  end

  def show(id)

  end

  def updatet(id, *data)

  end

  def delete(id, *data)

  end

  def find(id)

  end

  def list

  end

end
