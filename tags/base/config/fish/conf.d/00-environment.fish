# Load environment vars from ~/.config/environment.d/*.conf files
# This gives us a sinlge place to define our environment variables
eval (~/.local/bin/environment-helper fish)

# path-helper is an alternative way to add paths to the environment
eval (~/.local/bin/path-helper fish)

