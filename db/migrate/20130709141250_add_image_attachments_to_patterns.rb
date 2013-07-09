class AddImageAttachmentsToPatterns < ActiveRecord::Migration
  def change
  	add_attachment :patterns, :diagram
  	add_attachment :patterns, :photo
  end
end
