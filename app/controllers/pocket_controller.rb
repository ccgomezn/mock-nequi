require_relative '../db_managers/pocket_manager'
require_relative '../../db/db_handler'
require_relative '../models/Pocket'

class PocketController
  include PocketManager

  def initialize(db_handler)
    @db_handler = db_handler
  end

  def insert(name, balance, creation_date, account_id)
    pocketManager = PocketManager.new(@db_handler)
    pocket_map = {:name => name, :balance => balance, :creation_date => creation_date, :account_id => account_id}
    pocketManager.insert(pocket_map)
  end

  def find(id)
    pocketManager.find(id)
  end

  def update(id, name, balance, creation_date, account_id)
    pocketManager = PocketManager.new(@db_handler)
    pocket_map = {:name => name, :balance => balance, :creation_date => creation_date, :account_id => account_id}
    pocketManager.update(id, pocket_map)
  end

  def delete(id)
    pocketManager.delete(id)
  end
end
