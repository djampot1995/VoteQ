class Api::V1::User::UserVotesController < UserController
	before_action :authenticate_with_token!, only: [:create, :update, :index, :show, :destroy]
	def create
		user_vote = current_user.user_votes.build(user_votes_params)
		if user_vote.save
			render json: {
				status: "success", 
				data: {
					user_vote: user_vote
				}
			}, status: 201
		else
			render json: {
				status: "fail", 
				messages: user_vote.errors
			}, status: 422
		end
	end
		
	def update
		user_vote = current_user.user_votes.where(:vote_id => params[:vote_id]).first
		if user_vote.update(vote_option_id: params[:vote_option_id])
			render json: {
				status: "success",
				data: {
					user_vote: user_vote
				}
			}, status: 200
		else
			render json: {
				status: "fail", 
				messages: user_vote.errors
			}, status: 422
		end
	end

	def destroy
		user_vote = current_user.user_votes.where(vote_id: user_votes_params[:vote_id]).first
		if user_vote.destroy 
			render json:{
				status: "deleted",
				messages: "a data has been deleted"
			}, status: 204
		else
			render json:{
				status: "fail",
				messages: "delete failed"
			}, status: 422
		end
	end

	def user_votes_params
		params.permit(:vote_id, :vote_option_id)
	end	
end
