# Tmux
https://leanpub.com/the-tao-of-tmux/read#leanpub-auto-log-tailing

## switch between sessions
prefix + ( - previous
prefix + ) - next
prefix + L - last
prefix + s - menu
tmux switch-client -t <name>

## renaming sessions
prefix + $
tmux rename-session -t <name> <to>

## windows

### creating windows
prefix + c

### renaming windows
prefix + ,

### navigating windows
prefix + p - previous
prefix + n - next
prefix + <number>
prefix + '<number > 9 >'
prefix + f - search window by string
prefix + l - last window
prefix + w - list of windows

### moving windows
tmux move-window -s -t
tmux movew -t2 -> moves current window to 2
tmux movew -s2 -t1 -> move window 1 to window 1
prefix + .

### windows layouts
prefix + space - switcher window layouts
prefix + m - reset

### kill windows
prefix + & - kill the window
prefix + x - kill pane one by one
ctrl + d - kill pane if in shell
tmux kill-window

## Panes

### creating panes
prefix + % - split-window -h
prefix + " - split-window -v

<--! create pane h, $HOME directory, 50% width of current pane -->
tmux split-window -h -c $HOME -p 50 vim

### navigating panes
prefix + <vim motion>

### resize panes
prefix m-up     - resize-pane -U 5
prefix m-down   - resize-pane -D 5
prefix m-left   - resize-pane -L 5
prefix m-right  - resize-pane -R 5
prefix c-up     - resize-pane -U
prefix c-down   - resize-pane -D
prefix c-left   - resize-pane -L
prefix c-right  - resize-pane -R

## Configs

### reloading configs
prefix + :
tmux source-file /path/to/config.conf

set-option -s = server options
set-option -g = global session
set-window-option = window options

# Time
prefix + t

# Others

## Pager
most

## tail -F - checks for renaming of file

## file watching
entr
https://eradman.com/entrproject/

run tests on file changes
ls -d *.go | entr -c go test ./...
recursively
`find . -print | grep -i '.*[.]go' | entr -c go test ./...`

$ if command -v entr > /dev/null; then find . -print | grep -i '.*[.]go' | \
  entr -c go test ./...; else go test ./...; fi

```bash
watch_test:
  if command -v entr > /dev/null; then find . -print | grep -i '.*[.]go' | en\
      tr -c go test ./...; else go test ./...; echo "\nInstall entr(1) to run tasks w\
      hen files change. \nSee https://eradman.com/entrproject/"; fi
```

better
```
WATCH_FILES= find . -type f -not -path '*/\.*' | \
     grep -i '.*[.]go$$' 2> /dev/null

 test:
     go test $(test) ./...

 entr_warn:
     @echo "-------------------------------------------------"
     @echo " ! File watching functionality non-operational ! "
     @echo "                                                 "
     @echo " Install entr(1) to run tasks on file change.    "
     @echo " See https://eradman.com/entrproject/            "
     @echo "-------------------------------------------------"

 watch_test:
     if command -v entr > /dev/null; then ${WATCH_FILES} | \
         entr -c $(MAKE) test; else $(MAKE) test entr_warn; fi
         ```

## Session Managers

https://github.com/tmux-python/tmuxp
tmux install --user tmuxp
tmuxp -v
tmuxp load ~/.tmuxp/test.yaml

