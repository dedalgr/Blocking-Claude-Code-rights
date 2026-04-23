#!/bin/bash

CURRENT_DIR="$(pwd)"
ALLOWED_FILE="$HOME/.claude_allowed_paths"

if [ ! -f "$ALLOWED_FILE" ]; then
    echo "Грешка: Файлът $ALLOWED_FILE не съществува."
    exit 1
fi

if ! grep -Fxq "$CURRENT_DIR" "$ALLOWED_FILE"; then
    echo "ДОСТЪПЪТ Е ОТКАЗАН!"
    echo "Папката '$CURRENT_DIR' не е в списъка с разрешени."
    exit 1
fi
if [ -f "$CURRENT_DIR/venv/bin/python" ]; then                                                                                                                                            
      export PYTHON="./venv/bin/python"
  else                                                                                                                                                                                        
      export PYTHON="python3"
  fi

exec firejail \
    --noprofile \
    --private="$CURRENT_DIR" \
    --private-tmp \
    --private-dev \
    --private-etc=ssl,ca-certificates.conf,ca-certificates,\
resolv.conf,hosts,hostname,nsswitch.conf,\
ld.so.conf,ld.so.conf.d,ld.so.cache,\
localtime,timezone \
    --read-only=/usr \
    --read-only=/bin \
    --read-only=/sbin \
    --read-only=/lib \
    --read-only=/lib32 \
    --read-only=/lib64 \
    --read-only=/libx32 \
    --blacklist=/boot \
    --blacklist=/media \
    --blacklist=/mnt \
    --blacklist=/srv \
    --blacklist=/opt \
    --blacklist=/snap \
    --blacklist=/root \
    --blacklist=*.svn \
    --blacklist=/run/user \
    --blacklist=/var/log \
    --blacklist=/var/lib \
    --blacklist=/var/cache \
    --blacklist=/var/spool \
    --blacklist=/var/mail \
    --blacklist=/var/backups \
    --blacklist=/proc/sysrq-trigger \
    --nosound \
    --no3d \
    --nodvd \
    --notv \
    --novideo \
    --noroot \
    --caps.drop=all \
    --nonewprivs \
    --seccomp \
    /usr/bin/claude "$@"
