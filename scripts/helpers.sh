get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value="$(tmux show-option -gqv "$option")"
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

command_exists() {
  local command="$1"
  type "$command" >/dev/null 2>&1
}

battery_status() {
  if command_exists "termux-battery-status"; then
    termux-battery-status | jq -r '.status' | awk '{printf("%s%", tolower($1))}'
  fi
}
