FROM elixir:latest


ENV HOME ./tilanne
WORKDIR $HOME

# Configure required environment
ENV MIX_ENV prod

# Set and expose PORT environmental variable
ENV PORT ${PORT:-4000}
EXPOSE $PORT

# Install hex (Elixir package manager)
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies
RUN mix deps.get --only prod

# Compile all dependencies
RUN mix deps.compile

# Copy all application files
COPY . .

# Compile the entire project
RUN mix compile
