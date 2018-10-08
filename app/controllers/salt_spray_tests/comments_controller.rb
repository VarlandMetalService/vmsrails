class SaltSprayTests::CommentsController < CommentsController
  before_action :set_commentable

      private
      def set_commentable
          @commentable = SaltSprayTest.find(params[:salt_spray_test_id])
      end
end
