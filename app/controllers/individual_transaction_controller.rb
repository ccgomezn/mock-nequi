require_relative '../db_managers/transaction_manager'
require_relative '../db_managers/individual_tansaction_manager'
require_relative '../db_managers/account_manager'
require_relative '../db_managers/goal_manager'
require_relative '../db_managers/mattress_manager'
require_relative '../db_managers/pocket_manager'
require_relative '../../db/db_handler'


class IndividualTransactionController

  def initialize(db_handler)
    @db_handler = db_handler
  end

  def transaction_on_account(amount, account_id, product, product_id, location)
    transaction = create_transaction(amount)
    create_individual_transaction(product, product_id, location, transaction.id,
                                  account_id)
    update_balance(amount, account_id, product, product_id)
  end

  private

  def update_balance(amount, account_id, product, product_id)
    case product
    when 'account'
      update_balance_account(amount, account_id)
    when 'goal'
      update_balance_goal(amount, account_id, product_id)
    when 'mattress'
      update_balace_mattress(amount, account_id, product_id)
    when 'pocket'
      update_balance_pocket(amount, account_id, product_id)
    end
  end

  def update_balance_account(amount, account_id)
    account_manager = AccountManager.new(@db_handler)
    account = account_manager.find(account_id)
    data_account = { available_balance: account.avaiable_balance +
                                        amount,
                     total_balance: account.total_balance +
                                    amount }
    account_manager.update(account_id, data_account)
  end

  def update_balance_goal(amount, account_id, product_id)
    account_manager = AccountManager.new(@db_handler)
    goal_manager = GoalManager.new(@db_handler)
    account = account_manager.find(account_id)
    data_account = { available_balance: account.avaiable_balance -
                                        amount }
    goal = goal_manager.find(product_id)
    data_goal = { balance: goal.balance + amount }
    goal_manager.update(product_id, data_goal)
    account_manager.update(account_id, data_account)
  end

  def update_balace_mattress(amount, account_id, product_id)
    account_manager = AccountManager.new(@db_handler)
    mattress_manager = MattressManager.new(@db_handler)
    account = account_manager.find(account_id)
    data_account = { available_balance: account.avaiable_balance -
                                        amount }
    mattress = mattress_manager.find(product_id)
    data_mattress = { balance: mattress.balance + amount }
    mattress_manager.update(product_id, data_mattress)
    account_manager.update(account_id, data_account)
  end

  def update_balance_pocket(amount, account_id, product_id)
    account_manager = AccountManager.new(@db_handler)
    pocket_manager = PocketManager.new(@db_handler)
    account = account_manager.find(account_id)
    data_account = { available_balance: account.avaiable_balance -
                                        amount }
    pocket = pocket_manager.find(product_id)
    data_pocket = { balance: pocket.balance + amount }
    pocket_manager.update(product_id, data_pocket)
    account_manager.update(account_id, data_account)
  end

  def create_transaction(amount)
    transaction_manager = TransactionManager.new(@db_handler)
    date = DateTime.now
    data_transaction = { date: date.strftime('%Y-%m-%d %H:%M:%S'), amount: amount }
    transaction_manager.insert data_transaction
  end

  def create_individual_transaction(product, product_id, location,
                                    transaction_id, account_id)

    individual_transaction_manager = IndividualTransactionManager.new(@db_handler)
    data_individual_transaction = { transaction_id: transaction_id,
                                    product: product,
                                    product_id: product_id,
                                    location: location,
                                    account_id: account_id }
    individual_transaction_manager.insert(data_individual_transaction)
  end
end
