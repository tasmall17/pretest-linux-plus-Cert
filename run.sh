#!/usr/bin/env bash
# Launch the CompTIA Linux+ (XK0-006) readiness pretest in your browser.
#
# Serves app/ on 127.0.0.1 with Python's built-in web server and opens it.
# Without Python 3 it opens app/index.html directly as a file instead.
set -euo pipefail

cd "$(dirname "$0")"
APP_DIR="$PWD/app"
PORT="${PORT:-8765}"
OPEN_BROWSER=1

usage() {
  cat <<EOF
Usage: ./run.sh [--port N] [--no-browser]

  -p, --port N     Port to serve on (default 8765; the next free port is used if it's taken)
      --no-browser Start the server and print the URL without opening a browser
  -h, --help       Show this help
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    -p|--port) PORT="${2:?--port needs a number}"; shift 2 ;;
    --no-browser) OPEN_BROWSER=0; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
  esac
done

if [ ! -f "$APP_DIR/index.html" ]; then
  echo "Can't find $APP_DIR/index.html. Run this script from a full clone of the repo." >&2
  exit 1
fi

open_target() {
  local target="$1"
  if [ "$OPEN_BROWSER" != 1 ]; then return 0; fi
  if [ "$(uname -s)" = "Darwin" ]; then
    open "$target"
  elif grep -qi microsoft /proc/version 2>/dev/null; then
    # WSL: hand the URL to the Windows browser.
    if command -v wslview >/dev/null 2>&1; then wslview "$target"; else explorer.exe "$target" || true; fi
  elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$target" >/dev/null 2>&1 &
  else
    echo "No browser opener found. Open this yourself: $target"
  fi
}

PY=""
for candidate in python3 python; do
  if command -v "$candidate" >/dev/null 2>&1 && "$candidate" -c 'import sys; sys.exit(sys.version_info < (3, 6))' 2>/dev/null; then
    PY="$candidate"
    break
  fi
done

if [ -z "$PY" ]; then
  echo "Python 3 not found, so opening the pretest as a local file."
  echo "File: $APP_DIR/index.html"
  open_target "$APP_DIR/index.html"
  exit 0
fi

port_free() {
  "$PY" - "$1" <<'EOF'
import socket, sys
s = socket.socket()
try:
    s.bind(("127.0.0.1", int(sys.argv[1])))
except OSError:
    sys.exit(1)
finally:
    s.close()
EOF
}

port_up() {
  "$PY" - "$1" <<'EOF'
import socket, sys
s = socket.socket()
s.settimeout(0.2)
try:
    s.connect(("127.0.0.1", int(sys.argv[1])))
except OSError:
    sys.exit(1)
finally:
    s.close()
EOF
}

start_port="$PORT"
until port_free "$PORT"; do
  PORT=$((PORT + 1))
  if [ "$PORT" -gt $((start_port + 20)) ]; then
    echo "No free port between $start_port and $((start_port + 20)). Try ./run.sh --port <number>." >&2
    exit 1
  fi
done

(cd "$APP_DIR" && exec "$PY" -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1) &
SERVER_PID=$!
trap 'kill "$SERVER_PID" 2>/dev/null || true' EXIT
trap 'echo; echo "Stopped."; exit 0' INT TERM

for _ in $(seq 1 50); do
  if port_up "$PORT"; then break; fi
  if ! kill -0 "$SERVER_PID" 2>/dev/null; then
    echo "The web server failed to start on port $PORT." >&2
    exit 1
  fi
  sleep 0.1
done

URL="http://127.0.0.1:$PORT/"
echo "Linux+ readiness pretest is running at $URL"
echo "Your progress and past attempts are saved in this browser."
echo "Press Ctrl+C to stop."
open_target "$URL"
wait "$SERVER_PID"
