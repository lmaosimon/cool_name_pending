require 'mail'

options = { :address              => "smtp.gmail.com",
	    :port                 => 587,
	    :user_name            => 'osulibfor3901@gmail.com',
	    :password             => 'GoBucks!',
	    :authentication       => 'plain',
	    :enable_starttls_auto => true  }

Mail.defaults do
	delivery_method :smtp, options
end

Mail.deliver do
	to 'hubbell.64@osu.edu'
	from 'osulibfor3901@gmail.com'
	subject 'Test'
	body 'Hurray!!! Test email!'
end
