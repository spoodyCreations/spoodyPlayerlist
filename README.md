# spoodyPlayerlist
Simple, advanced player-list UI for in-game voice chat control.
A clean, lightweight player list that lets your players see who's connected and adjust each other's voice chat volume on the fly — mute someone entirely or fine-tune their volume with a slider. Built on `ox_lib` and native Mumble voice.
---
## Preview
![spoodyPlayerlist – player list](https://r2.fivemanage.com/CWDuI3yLS4av0OWnTLNNl/Screenshot_2.png)
![spoodyPlayerlist – volume control](https://r2.fivemanage.com/CWDuI3yLS4av0OWnTLNNl/Screenshot_1.png)
---
## Features
- Searchable player list with live "connected" count
- Per-player voice chat volume control via a slider
- One-click mute / unmute per player
- Volume and mute states are remembered per player
- Open via keybind (default `F10`) or command (default `/playerlist`)
- Configurable server name shown in the panel
- Syncs the player list live as people join and leave
---
## Dependencies
- [ox_lib](https://github.com/overextended/ox_lib)
- A Mumble-based voice system (native FiveM voice / pma-voice)
---
## Installation
1. Make sure `ox_lib` is installed and started **before** this resource.
2. Drop the `spoodyPlayerlist` folder into your server's `resources` directory.
3. Add it to your `server.cfg`:
   ```cfg
   ensure ox_lib
   ensure spoodyPlayerlist
   ```
4. Open `config.lua` and adjust the settings to your liking (see below).
5. Restart your server, or run `ensure spoodyPlayerlist` from the console.
---
## Configuration
```lua
Config = {
    ServerName = 'Server Name RP',
    Keybind = {
        Enabled = true, --- Enable the keybind option?
        Button = 'F10', --- Keybind Button
    },
    Command = {
        Enabled = true, --- Enable the command option?
        Name = 'playerlist', --- Command name (default: /playerlist)
    }
}
```
| Option | Description |
| --- | --- |
| `ServerName` | The name shown at the bottom of the panel. |
| `Keybind.Enabled` | Toggle opening the list with a keybind. |
| `Keybind.Button` | The default key used to open the list. |
| `Command.Enabled` | Toggle opening the list with a command. |
| `Command.Name` | The command name players type to open the list. |
> The keybind can be rebound by each player in **Settings → Key Bindings → FiveM**.
---
## Usage
- Press your configured key (default `F10`) or run `/playerlist` to open the panel.
- Search for a player by their server ID.
- Click a player to expand their controls, then mute them or drag the slider to set their volume.
---
## Paid & Premium Resources
Need help or want more premium escrowed scripts? Check out the store:

<a href="https://spoody.store">
  <img src="https://r2.fivemanage.com/CWDuI3yLS4av0OWnTLNNl/tebex_banner.png" alt="Tebex Store" width="400" />
</a>

[Discord Invite](https://discord.gg/spoody)
