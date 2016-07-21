class Vote < ActiveRecord::Base	
	belongs_to :user
	has_many :vote_options
	has_many :user_votes
	has_many :users, through: :user_votes
	validates :title, presence: true
	validates :user_id, presence:true
	validates :status, :inclusion => {:in => [true, false]}
	scope :desc, -> {order(created_at: :desc)}
	scope :open, -> {where(status: true)}
	scope :closed, -> {where(status: false)}

	def generate_vote_options(options)
		options.each do |option|
			vote_option = self.vote_options.build(title: option[1])
			vote_option.save
		end 
	end

	def voter_count
		user_votes.count
	end

	def as_voted_vote     
	    {
	      id: id,
	      title: title,
	      voter_count: voter_count,
	      user: user,
	      status: status,
	      options: vote_options,
	      created_at: created_at, 
	      updated_at: updated_at,   
	      voted: true
	    }
  end
	def as_json(options={})     
	    {
	      id: id,
	      title: title,
	      voter_count: voter_count,
	      user: user,
	      status: status,
	      options: vote_options,
	      created_at: created_at, 
	      updated_at: updated_at,   
	      
	    }
  end
end
