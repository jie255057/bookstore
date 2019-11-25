class AddPublisherToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :publisher
  end
end
