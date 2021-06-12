# frozen_string_literal: true

Devise.setup do |config|
  # Load and configure the ORM.
  require 'devise/orm/active_record'

  # Configure which authentication keys should be case-insensitive.
  # These keys will be downcased upon creating or modifying a user and
  # when used to authenticate or find a user.
  config.case_insensitive_keys = [:username]

  # Configure which authentication keys should have whitespace stripped.
  # These keys will have whitespace before and after removed upon creating or
  # modifying a user and when used to authenticate or find a user.
  config.strip_whitespace_keys = [:username]

  # By default Devise will store the user in session. Skip storage for
  # particular strategies by setting this option.
  config.skip_session_storage = [:http_auth]

  # For bcrypt, this is the cost for hashing the password.
  config.stretches = Rails.env.test? ? 1 : 11

  # Invalidates all the remember me tokens when the user signs out.
  config.expire_all_remember_me_on_sign_out = true

  # Range for password length.
  config.password_length = 6..128

  # Email regex used to validate email formats.
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # The default HTTP method used to sign out a resource. Default is :delete.
  config.sign_out_via = :delete
end
