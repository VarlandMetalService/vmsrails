class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    belongs_to :user, class_name: '::User', foreign_key: 'user_id', optional: true, counter_cache: true

    mount_uploaders :attachment, AttachmentUploader
    serialize :attachment, JSON

    validates_presence_of :body
end
