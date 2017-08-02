module SessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end #Envoie un cookie temporaire sur la page de l'utilisateur et dès que la personne ferme la fenêtre, lecookie est désactivé automatiquement

	# Remembers a user in a persistent session.
	def remember(user)
	    user.remember
	    cookies.permanent.signed[:user_id] = user.id
	    cookies.permanent[:remember_token] = user.remember_token
    end

	 #Returns the user corresponding to the remember token cookie.
  	def current_user
    	if (user_id = session[:user_id])
      		@current_user ||= User.find_by(id: user_id)
    	elsif (user_id = cookies.signed[:user_id])
      		user = User.find_by(id: user_id)
      		if user && user.authenticated?(:remember, cookies[:remember_token])
        		log_in user
        		@current_user = user
      		end
    	end
  	end

    def current_user?(user)
      user == current_user
    end

	def logged_in? #Est-ce que l'uitlisateur est login
    	!current_user.nil? #La fonction checke le current user. s'il y a un current user alors il est login, sinon pas login.
  	end

  	# Forgets a persistent session.
  	def forget(user)
	    user.forget
	    cookies.delete(:user_id)
	    cookies.delete(:remember_token)
  	end

  	def log_out
  		forget(current_user)
    	session.delete(:user_id)
    	@current_user = nil
  	end

    # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
