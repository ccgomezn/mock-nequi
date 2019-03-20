require 'sqlite3'
require 'singleton'

class DbHandler
  include Singleton

  attr_reader :db

  def initialize
    db_folder_path = './db/'
    db_name = 'mock_nequi_db.db'
    @db = connect(db_folder_path, db_name)

    create
    ObjectSpace.define_finalizer(self, proc { close_connection(@db) })
  end

  # Creation of all db tables and its relations using foreign keys
  def create
    @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS accounts(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                available_balance DECIMAL(10, 0) NOT NULL,
                total_balance DECIMAL(10, 0) NOT NULL,
                creation_date DATETIME NOT NULL
            );
    SQL

    @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS users(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name VARCHAR(45) NOT NULL,
                email VARCHAR(45) NOT NULL,
                password_digest VARCHAR NOT NULL,
                account_id INT NOT NULL,
                UNIQUE(email)
                FOREIGN KEY(account_id) REFERENCES accounts(id)
            );
    SQL

    @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS transactions(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                date DATETIME NOT NULL,
                amount DECIMAL(10, 0) NOT NULL
            );
    SQL

    @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS goals(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name VARCHAR(45) NOT NULL,
                goal DECIMAL(10,0) NOT NULL,
                balance DECIMAL(10,0) NOT NULL,
                state VARCHAR(45) NULL,
                deadline DATETIME NOT NULL,
                creation_date DATETIME NOT NULL,
                account_id INT NOT NULL,
                FOREIGN KEY(account_id) REFERENCES accounts(id)
            );
    SQL

    @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS pockets(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name VARCHAR(45) NOT NULL,
                balance DECIMAL(10,0) NOT NULL,
                creation_date DATETIME NOT NULL,
                account_id INT NOT NULL,
                FOREIGN KEY(account_id) REFERENCES accounts(id)
            );
    SQL

    @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS mattresses(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                balance DECIMAL(10,0) NOT NULL,
                account_id INT NOT NULL,
                FOREIGN KEY(account_id) REFERENCES accounts(id)
            );
    SQL

    @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS individual_transactions(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                product VARCHAR(45) NULL,
                product_id INT NOT NULL,
                location VARCHAR(45) NOT NULL,
                transaction_id INT NOT NULL,
                account_id INT NOT NULL,
                FOREIGN KEY(transaction_id) REFERENCES transactions(id)
                FOREIGN KEY(account_id) REFERENCES accounts(id)
            );
    SQL

    @db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS mutual_transactions(
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                transaction_id INT NOT NULL,
                origin_account_id INT NOT NULL,
                origin_id INT NOT NULL,
                origin_product_type VARCHAR(20) NOT NULL,
                final_account_id INT NOT NULL,
                FOREIGN KEY(transaction_id) REFERENCES transactions(id)
                FOREIGN KEY(final_account_id) REFERENCES accounts(id)
            );
    SQL
  end

  # method to connect to the db
  def connect(db_folder_path, db_name)
    db = SQLite3::Database.open(db_folder_path + db_name)
    db
  end

  def close_connection(db)
    if db
      db.close
      puts 'db connection closed!'
    end
  end
end
