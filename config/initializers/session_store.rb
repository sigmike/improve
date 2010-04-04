# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_improve_session',
  :secret      => '4e0b4f76f2e6b62bfd74f31beebd518d0e9a91174adedd5d9787d687f083a9102cf503b481238d135e69b61cc66072aa64a6e54ea08f73009e4d2f0a9bd888be'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
