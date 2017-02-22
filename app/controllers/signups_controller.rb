class SignupsController < ApplicationController

  def create
    signup = Signup.find_or_initialize_by(signup_params)
    new_record = signup.new_record?

    if signup.save
      if new_record
        render js: flash_message("Thanks! 💪 Let's make filing expenses and getting reimbursed easy!<br>You'll hear from us later today!")
      else
        render js: flash_message("Already got your email! Thanks for the enthusiasm :D We'll get back to you soon, bestie.")
      end
    else
      render js: flash_message("Something went wrong!")
    end
  end

  private

  def signup_params
    params.require(:signup).permit(:email)
  end

  def flash_message(message)
    "$('.flash-message').html(\"#{message}\");"
  end
end
