#!/usr/bin/env bash
# Installs notify-on-packetloss.sh
# Author @0xADADA

mkdir -p "${HOME}/bin"
mkdir -p "${HOME}/Library/LaunchAgents"
cp \
  "pub.0xadada.notify-on-packetloss.plist" \
  "${HOME}/Library/LaunchAgents/pub.0xadada.notify-on-packetloss.plist"
cp \
  "notify-on-packetloss.sh" \
  "${HOME}/bin/notify-on-packetloss.sh"

# edit path in the ProgramArguments value
sed -i -e "s/USER/$USER/g" \
  ~/Library/LaunchAgents/pub.0xadada.notify-on-packetloss.plist

# install it
launchctl remove pub.0xadada.notify-on-packetloss
launchctl load \
  "/Users/${USER}/Library/LaunchAgents/pub.0xadada.notify-on-packetloss.plist"
result=$?

if (( result != 0 )); then
  echo "Failed to install with code: ${result}"
else
  pid=$(launchctl list | rg 'pub.0xadada.notify-on-packetloss' | awk '{print $1}')
  echo "Installed launchd service 'pub.0xadada.notify-on-packetloss' with PID ${pid}"
fi