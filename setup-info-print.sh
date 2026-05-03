#!/bin/bash

echo "Installing info-print..."

SCRIPT_PATH="/usr/local/bin/info-print"

sudo tee "$SCRIPT_PATH" > /dev/null << 'EOF'
#!/bin/bash

LOGFILE="$HOME/.info_print.log"

mkdir -p "$(dirname "$LOGFILE")"
touch "$LOGFILE"

confirm_clear() {
    echo "⚠️  This will permanently delete all logs."
    read -p "Type YES to continue: " first

    if [[ "$first" != "YES" ]]; then
        echo "Cancelled."
        exit 0
    fi

    read -p "Are you absolutely sure? Type DELETE to confirm: " second

    if [[ "$second" != "DELETE" ]]; then
        echo "Cancelled."
        exit 0
    fi

    > "$LOGFILE"
    echo "Logs cleared."
}

case "$1" in
  add)
    shift
    echo "$(date '+%Y-%m-%d %H:%M:%S') | $*" >> "$LOGFILE"
    ;;

  show)
    cat "$LOGFILE"
    ;;

  clear)
    confirm_clear
    ;;

  *)
    echo "Usage:"
    echo "  info-print add \"text\""
    echo "  info-print show"
    echo "  info-print clear"
    ;;
esac
EOF

sudo chmod +x "$SCRIPT_PATH"

echo "Done. You can now use: info-print"
