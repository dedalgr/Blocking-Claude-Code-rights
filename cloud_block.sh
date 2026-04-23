claude() {
    local CURRENT_DIR="$(pwd)"
    local ALLOWED_FILE="$HOME/.claude_allowed_paths"
    # Checking if the list file exists
    if [ ! -f "$ALLOWED_FILE" ]; then
        echo "Error: The file $ALLOWED_FILE does not exist. Create it and list the allowed folders."
        return 1
    fi
    # Check if the current folder is allowed
    if ! grep -Fxq "$CURRENT_DIR" "$ALLOWED_FILE"; then
        echo "ACCESS DENIED!"
        echo "The folder '$CURRENT_DIR' is not in the allowed list."
        return 1
    fi
    echo "The folder is allowed. I'm starting Claude in an isolated environment..."
    # Full isolation – only sees the current folder
    firejail --noprofile \
             --private="$CURRENT_DIR" \
             claude
}
