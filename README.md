# Skipper

A captain for your fleet.

## Basic Usage

### REPL Commands

```
> help
Skipper Help

help    - this message
servers - list the servers that commands will be executed on
exit    - bye, bye
```

### Command Line Options

```
Usage:
  skipper

Options:
  [--servers=one two three]
  [--region=REGION]
                                         # Default: us-east-1
  [--tags=key:value]
  [--auto-scaling-groups=one two three]
  [--auto-scaling-roles=one two three]
  [--identity-file=IDENTITY_FILE]
  [--forward-agent=FORWARD_AGENT]
  [--user=USER]
                                         # Default: `whoami`
  [--run-in=RUN_IN]
  [--wait=N]
  [--limit=N]
  [--output], [--no-output]
                                         # Default: true
  [--file=FILE]

Run a command on remote servers
```

```
  # Get a SSH for multiple servers
  skipper --servers server-1.example.com server-2.example.com

  # Use a SSH identity file other than your default
  skipper --identity-file path/to/id_rsa.pub

  # Enable SSH forward agent
  skipper --forward-agent

  # Set the SSH username (defaults to `whoami`)
  skipper --user myusername

  # Limit output (do no display the output of commands)
  skipper --no-output

  # Run commands from STDIN
  echo 'pwd' | skipper

  # Run commands from a file
  skipper --file myscript.sh
```

#### Running Commands in Sequence or Parallel

By default, commands will run on all servers in parallel.

```
  # Only run on two instances at one
  skipper --limit 2

  # Run on only one server at a time
  skipper --run-in sequence # or
  skipper --limit 1

  # Wait 5 seconds between server groups (default group size is 1)
  skipper --wait 5
```

#### Search AWS EC2 Instances

```
  # Skipper can only run in the context of one region (default is `us-east-1`)
  skipper --region us-west-1

  # By tag(s)
  skipper --tags name:value

  # By auto scaling group name
  skipper --auto-scaling-group groupname

  # By auto scaling role
  skipper --auto-scaling-role rolename
```
