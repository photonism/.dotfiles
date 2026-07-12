termux-wake-lock

# ┌─────────┐
# │ searxng │
# └─────────┘

SEARX_DIR="${HOME}/.opt/searxng"

source ${SEARX_DIR}/venv/bin/activate
python ${SEARX_DIR}/searx/webapp.py >/dev/null 2>&1 &

# ┌────────────┐
# │ pulseaudio │
# └────────────┘

pulseaudio -k 2>/dev/null
killall -9 pulseaudio 2>/dev/null
rm -rf ~/.config/pulse/*-runtime/pid 2>/dev/null

pulseaudio --exit-idle-time=-1 --realtime=false >/dev/null 2>&1 &

# ┌────────────┐
# │ termux-x11 │
# └────────────┘

kill -9 $(pgrep -f "termux.x11") 2>/dev/null

export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

# ┌──────────────┐
# │ proot-distro │
# └──────────────┘

proot-distro login ubuntu --user nora --shared-tmp
