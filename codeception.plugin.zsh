# Codeception command completion

# Functions
_codeception_get_command_list () {
    /usr/local/bin/codecept list --no-ansi \
      | sed "1,/Available commands/d" \
      | awk '/^  [a-ziA-Z-:]+/ { print $1 }'
}

_codeception () {
  local curcontext="$curcontext" state line
  typeset -A opt_args

  _arguments \
    '1: :->commands'\
    '2: :->args'\
    '*: :->opts'

  if [ -f /usr/local/bin/codecept ]; then
    case $state in
        commands)
          compadd `_codeception_get_command_list`
          ;;
        args)
      case $words[2] in
        generate:cept|generate:cest|generate:pageobject|generate:phpunit|generate:scenarios|generate:stepobject|generate:suite|generate:test)
          compadd functional acceptance unit
          ;;
      esac
      ;;
        *)
      #compadd `/usr/local/bin/codecept $words[2] -h --no-ansi | sed "1,/Options:/d" | sed '/^$/d' | awk '{ print $1 }'`
      ;;
    esac
  fi
}

# Completion setup
#compdef _codeception /usr/local/bin/codecept
compdef _codeception codecept

# Alias
#alias codecept='/usr/local/bin/codecept'
