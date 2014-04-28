module ArgumentPostsHelper
	def get_argument_post_header_form(type)
		return "New Argument" if type == "OriginalPost"
		return "Contribution" if type == "ContributionPost"
		return "Correction" if type == "CorrectionPost"
		return "Counterargument" if type == "CounterArgumentPost"
	end

end
