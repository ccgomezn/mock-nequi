require_relative '../db_managers/account_manager'
require_relative '../../db/db_handler'
require_relative '../models/Account'

class AccountController
  include AccountManager

  def initialize(db_handler)
    @db_handler = db_handler
  end

    accountManager = AccountManager.new(db_handler)

  def insert(avaiable_balance, total_balance, creation_date)
    account_map = {:avaiable_balance => avaiable_balance, :total_balance => total_balance, :creation_date => creation_date}
    accountManager.insert(account_map)
  end

  def find(id)
    accountManager.find(id)
  end

  def update(id, avaiable_balance, total_balance, creation_date, creation_date)
    account_map = {:avaiable_balance => avaiable_balance, :total_balance => total_balance, :creation_date => creation_date}
    accountManager.update(id, account_map)
  end

  def delete(id)
    accountManager.delete(id)
  end
end
