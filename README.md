# info-print
Linux CLI command and text storage

* full setup script

---

# Full setup script (one-time install)

Save this as:

```bash id="ip2"
setup-info-print.sh
```

Then paste:

```bash id="ip3"
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
```

---

# Run setup

```bash id="ip4"
chmod +x setup-info-print.sh
./setup-info-print.sh
```

---

# What you now have

### Add logs:

```bash id="ip5"
info-print add "test command"
```

### View logs:

```bash id="ip6"
info-print show
```

### Clear logs (safe now):

```bash id="ip7"
info-print clear
```

It will require:

1. Type `YES`
2. Then type `DELETE`

---
