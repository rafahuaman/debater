module ArgumentPostsHelper
	def get_argument_post_header_form(type)
		return "New Argument" if type == "OriginalPost"
		return "Contribution" if type == "ContributionPost"
		return "Correction" if type == "CorrectionPost"
		return "Counterargument" if type == "CounterArgumentPost"
	end

	def get_parent_post_user(argument_post)
		parent_post = argument_post.parent

		if parent_post.nil? then
			nil
		else
			parent_post.user
		end

		
	end


end
