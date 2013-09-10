class AddHtmlCodeToCurrency < ActiveRecord::Migration
  def change
    add_column :currencies, :html_code, :string
  end
end
