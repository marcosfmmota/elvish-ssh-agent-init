# Elvish script to initalize ssh-agent
use str
# Run ssh-agent and capture Bourne shell like commands
var agent-output = (ssh-agent -s | slurp)

# Split the output string by ';' to get individual sh-style commands
var commands = [(str:split ';' $agent-output)]

# Process each command to find the variable assignments
each {|cmd|
  set cmd = (str:trim-space $cmd)
  if (str:contains $cmd '=') {
    # The '-n 2' flag split *at most 2 times*, handling potention '=' caracthers in the value itself 
    var parts = [(str:split &max=2 '=' $cmd)]

    if (== (count $parts) 2) {
      var key = $parts[0]
      var val = $parts[1]

      # Set the variables necessary for ssh-agent in the Elvish environment namespace ($E:)
      if (eq $key 'SSH_AUTH_SOCK') {
        set-env SSH_AUTH_SOCK $val
      }
      if (eq $key 'SSH_AGENT_PID') {
        set-env SSH_AGENT_PID $val
      }
    }
  }
} $commands
