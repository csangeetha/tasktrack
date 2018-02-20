$ mix deps.get --only prod
$ MIX_ENV=prod mix compile

# Compile assets
$ brunch build --production

$ mix phx.digest

# Custom tasks (like DB migrations)
$ MIX_ENV=prod mix ecto.migrate

# Finally run the server
$ MIX_ENV=prod PORT=4000 elixir --detached -S mix do compile, phx.server
