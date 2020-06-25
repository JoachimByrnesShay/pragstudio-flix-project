module UsersHelper

def profile_image(user, size=80)
  url = "https://secure.gravatar.com/avatar/#{user.gravatar_id}?s=#{size}"
  image_tag(url, alt: user.name, :style => "float :left;border 1px solid #00000;")
end

	def confirm_delete_when_login
	end
end
