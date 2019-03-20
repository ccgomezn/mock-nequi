require_relative './individual_transaction_controller'
require_relative '../db_managers/pocket_manager'
require_relative 'mutual_transaction_controller'
require_relative 'account_controller'

class PocketController
  def initialize
    @individual_transaction = IndividualTransactionController.new
    @pocket_manager = PocketManager.new
    @account_controller = AccountController.new
    @mutual_transaction = MutualTransactionController.new
  end

  def consign_to_another_account(amount, pocket_id, final_account_email)
    final_account_id = @account_controller.find_by_email(final_account_email)
    return false if final_account_id.nil? || final_account_id.length.zero?

    @mutual_transaction.consign_to_another_account(
      amount,
      pocket_id,
      'pocket',
      final_account_id
    )
  end

  def debit(amount, product_id, location = 'virtual-virtual')
    @individual_transaction.transaction_on_account(
      amount,
      $session[:account_id],
      'pocket',
      product_id,
      location
    )
  end

  def withdraw(amount, product_id, location = 'virtual-virtual')
    @individual_transaction.transaction_on_account(
      - amount,
      $session[:account_id],
      'pocket',
      product_id,
      location
    )
  end

  def create(name)
    creation_date = DateTime.now
    pocket_map = { name: name, balance: 0,
                   creation_date: creation_date.strftime('%Y-%m-%d %H:%M:%S'),
                   account_id: $session[:account_id] }
    @pocket_manager.insert(pocket_map)
  end

  def get_balance(product_id)
    @pocket_manager.find(product_id).balance
  end

  def find(id)
    @pocket_manager.find(id)
  end

  def find_all
    @pocket_manager.find_all($session[:account_id])
  end

  def delete(id)
    balance = get_balance(id)
    withdraw(balance, id) if balance > 0

    @pocket_manager.delete(id)
  end
end
