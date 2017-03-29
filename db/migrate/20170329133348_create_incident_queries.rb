class CreateIncidentQueries < ActiveRecord::Migration[5.0]
  def change
    create_table :incident_queries do |t|
      t.integer  :total_count, null: false, default: 0
      t.integer  :negative_count, null: false, default: 0
      t.integer  :positive_count, null: false, default: 0
      t.integer  :population, null: false, default: 0
      t.boolean  :completed
      t.string   :reactions
      t.string   :tags
      t.string   :ratings
      t.integer  :incident_type_id
      t.integer  :place_id
      t.datetime :start_time
      t.datetime :end_time


      t.timestamps
    end

    add_index :incident_queries, :incident_type_id
    add_index :incident_queries, :place_id
  end
end
