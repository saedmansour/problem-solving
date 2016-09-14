module SubjectsHelper
	#include Twitter::Autolink

	# convert post titles such as: title example by @twitterUser
	# to title example by <div data-user="@twitterUser">@twitterUser</div>
	# so that a modal box will show the @twitterUser info.
	# depends on some JS code
	
	def link_to_twitter_user(post_text)
		return post_text.gsub( /(?<twitter_username>@[a-zA-z0-9]*)/, '<span class="twitter-user" data-x="\k<twitter_username>"> \k<twitter_username> </span> ')
	end
end
