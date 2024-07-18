class CreateUsers < ActiveRecord::Migration[6.1]
    def change
      create_table :users, id: false do |t|
        t.string :id, primary_key: true, null: false, default: -> { 'uuid()' }
        t.string :email, null: false, index: { unique: true }
        t.string :password_digest, null: false
          
        t.timestamps
      end
    end
  end
  