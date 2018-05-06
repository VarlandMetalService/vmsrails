class CreateDeptInfoDocuments < ActiveRecord::Migration[5.1]
  def change
    create_table :dept_info_documents do |t|
      t.bigint  :folder_id
      t.string  :name
      t.string  :google_id
      t.boolean :is_starred
      t.text    :description
      t.text    :contents
      t.string  :content_type
      t.string  :url
      t.timestamps
    end
  end
end
