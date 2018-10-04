##############
# FUNCTIONS
##############
# Define functions for error messages and displaying command line help.
function displayusage {
  echo "Usage:$0 [-h | --help] [-n] [-o]"
}
function errormessage {
  echo "$@" >&2
}

##################
# CLI Processing
##################
# Process the command line options, saving the results in variables for later use.
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      displayusage
      exit 0
      ;;
    *)
      errormessage "I don't know what '$1' is. Sorry."
      errormessage "$(displayusage)"
      exit 1
      ;;
  esac
  shift
done
