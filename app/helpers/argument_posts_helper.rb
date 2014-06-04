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

	def add_contribution(parent_post, contribution)
		contribution_section = "#{contribution.user.name}: #{contribution.content}"
		new_content = "#{parent_post.content}\n#{contribution_section}"
	end

	def add_correction(parent_post, correction)
		corrected_conted = "#{correction.content}"
		credit_text = "Corrected by: #{correction.user.name}"
		new_content = "#{corrected_conted}\n#{credit_text}"
	end
end
