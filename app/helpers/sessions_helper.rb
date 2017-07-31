module SessionsHelper

	def log_in(user)
		session[:user_id] = user.id
	end #Envoie un cookie temporaire sur la page de l'utilisateur et dès que la personne ferme la fenêtre, lecookie est désactivé automatiquement

	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end

	def logged_in? #Est-ce que l'uitlisateur est login
    	!current_user.nil? #La fonction checke le current user. s'il y a un current user alors il est login, sinon pas login.
  	end

  	def log_out
    	session.delete(:user_id)
    	@current_user = nil
  	end

end
