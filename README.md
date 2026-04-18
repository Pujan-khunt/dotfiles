# Pujan's NixOS Setup

## Bluetooth
Enable bluetooth hardware using

```nix
hardware.bluetooth = {
    enable = true; # Enable bluetooth daemon
    powerOnBoot = true; # Automatically starts daemon on boot
    settings.General.Experimental = true; # Enables experimental feature to view battery information
}
```

By enabling this module, `bluetoothctl` is automatically installed.
To connect devices, run
```sh
bluetoothctl
power on # Turns on controller
scan on # Starts scanning for devices

# Shows device names instead of MAC Addresses
agent on
default agent

connect <MAC-Address> # Pro tip: Autocomplete works using TAB

# After connection is established
trust

# Show information and state for the connected device (including battery)
info
```

### Handling Errors

#### Failed to set power on: org.bluez.Error.failed
Check if BLE (Bluetooth Low Energy) radio transmitter is blocked, if it is then unblock it.
Linux includes a CLI (`rfkill`) for controlling the blocking behavior of these radio transmitters.

```sh
# Removes soft and hard blocks on the transmitters
rfkill unblock bluetooth
```
