#!/usr/bin/env bash

# Per-workspace updater. Triggered on aerospace_workspace_change and
# front_app_switched. Updates the active-workspace highlight and renders
# the apps in this workspace as a row of glyphs (using sketchybar-app-font).

source "$CONFIG_DIR/plugins/icon_map.sh"

SPACE_ID="${NAME#space.}"

if [ "$SENDER" = "aerospace_workspace_change" ] && [ -n "$FOCUSED_WORKSPACE" ]; then
    FOCUSED="$FOCUSED_WORKSPACE"
else
    FOCUSED=$(aerospace list-workspaces --focused)
fi

ICON_STRIP=""
while IFS= read -r app; do
    [ -z "$app" ] && continue
    __icon_map "$app"
    ICON_STRIP+="$icon_result"
done < <(aerospace list-windows --workspace "$SPACE_ID" --format "%{app-name}" 2>/dev/null)

# Resolve which monitor this workspace currently lives on. AeroSpace orders
# monitors left-to-right, while sketchybar's `display=` uses macOS NSScreen
# IDs (1 = main). Use AeroSpace's nsscreen-id format key to bridge the two.
MONITOR=
while IFS=$'\t' read -r mid nsid; do
    if aerospace list-workspaces --monitor "$mid" --format "%{workspace}" \
        | grep -qx "$SPACE_ID"; then
        MONITOR="$nsid"
        break
    fi
done < <(aerospace list-monitors --format "%{monitor-id}%{tab}%{monitor-appkit-nsscreen-screens-id}")
[ -z "$MONITOR" ] && MONITOR=all

if [ "$SPACE_ID" = "$FOCUSED" ]; then
    sketchybar --set "$NAME" display="$MONITOR" background.drawing=on label="$ICON_STRIP"
else
    sketchybar --set "$NAME" display="$MONITOR" background.drawing=off label="$ICON_STRIP"
fi
