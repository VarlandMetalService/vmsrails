class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    belongs_to :user, class_name: '::User', foreign_key: 'user_id', optional: true

    mount_uploader :attachment, AttachmentUploader

    validates_presence_of :body
end
