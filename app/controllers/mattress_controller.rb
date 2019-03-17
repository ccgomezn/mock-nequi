require_relative '../db_managers/mattress_manager'
require_relative '../../db/db_handler'
require_relative '../models/Mattress'

class MatressController
  include MattressesManager

  def initialize(db_handler)
    @db_handler = db_handler
  end

  mattressesManager = MattressesManager.new(db_managers)

  def insert(balance, account_id)
    mattress_map = {:balance => balance, :account_id => account_id}
    mattressesManager.insert(mattress_map)
  end

  def find(id)
    mattressesManager.find(id)
  end

  def update(id, balance)
    mattress_map = {:balance => balance, :account_id => account_id}
    mattressesManager.update(id, mattress_map)
  end

  def delete(id)
    mattressesManager.delete(id)
  end
end
