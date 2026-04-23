# Blocking-Claude-Code-rights
It limits Cloud Code's access by encapsulating it only in the current directory.
It has full rights to do whatever it wants in a given directory, but it doesn't see the whole picture and doesn't have access to other information.
The databases need to be checked. The parts of /etc should be in RAM.
Without these folders from /etc access does not work at all

# Install
```
sudo apt-get install firejail
```

Create a list of allowed directories
```
cat >> ~/.claude_allowed_paths
```

In .bashrc add the function from cloud_block.sh

Add the folders you give Claude Code access to in .claude_allowed_paths

To easily add new directors to the whitelist, you can put in .bashrc
```
alias claude-allow-pwd='pwd >> ~/.claude_allowed_paths'
```
```
sudo reboot
```


install Claude Code 

# Enjoi

