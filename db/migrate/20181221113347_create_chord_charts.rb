class CreateChordCharts < ActiveRecord::Migration[5.2]
  def change
    create_table :chord_charts do |t|

      t.timestamps
    end
  end
end
