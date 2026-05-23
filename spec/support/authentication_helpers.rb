RSpec.shared_context "authentication helpers" do
  def sign_in_as(user)
    # Prefer Devise sign_in for controller specs so user_signed_in? works
    if respond_to?(:sign_in)
      @request.env['devise.mapping'] = Devise.mappings[:user] if defined?(@request) && @request
      sign_in(user)
    end

    # If legacy Current/session system exists in app, also populate it (guarded)
    if defined?(Current) && user.respond_to?(:sessions)
      Current.session = user.sessions.create!

      ActionDispatch::TestRequest.create.cookie_jar.tap do |cookie_jar|
        cookie_jar.signed[:session_id] = Current.session.id
        cookies[:session_id] = cookie_jar[:session_id]
      end
    end
  end

  def sign_out
    Current.session&.destroy!
    cookies.delete(:session_id)
  end
end

RSpec.configure { |config| config.include_context "authentication helpers" }