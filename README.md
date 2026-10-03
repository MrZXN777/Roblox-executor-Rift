# Rift

Rift is a Windows Luau editor with local script execution, syntax checking, a script library, and workspace tools.

Rift runs Luau locally. It does not inject into Roblox or execute scripts in live games. Its local runtime does not include Roblox services such as `game` or `Instance`.

## Run

Open `release/Rift-v0.6.4-win32-x64/Rift.exe` after packaging. Keep the whole folder together. Development: install with pnpm, `pnpm build`, then `pnpm start`. `pnpm dev` runs a browser preview; native dialogs and process detection are available only in Electron.

## Working features

- Public GitHub Gist import: Settings → Connections → Public GitHub Gist, or Script Hub → Import Gist. Loads public Lua/Luau/text/Markdown files for selection; never executes on import. Private gists and publishing are not connected.
- Sync-folder snapshots: Settings → Connections → Workspace Snapshots. Choose an existing folder (optionally managed by OneDrive/Dropbox/etc.), publish an immutable snapshot, and browse/restore snapshots. Your provider handles cloud transfer. This is manual snapshot sync, not automatic merging; no cloud credentials are stored. Disconnect preserves snapshots.

- Original subdued background and a three-second animated Rift mark. Appearance settings can disable either; reduced-motion preferences are respected.

- Shared gliding sidebar highlight matched to the second recording; startup, client scanning, local-runtime connecting, and save indicators driven by real operation state.
- Context menus on files, tabs, library cards, profiles, output, and workspace areas. Keyboard access through Shift+F10, arrow keys, Enter and Escape. Monaco retains its editor menu plus local run/check/export actions.
- Script source/sort/list controls, profile groups and pins, resizable explorer and terminal, saved layouts. See `FEATURE-PARITY.md` for the website audit and remaining gaps.

- Five tabs and the recorded settings/navigation structure; expanding hover labels, collapsible sidebar, 13 themes and custom palettes, saved/imported/exported themes, subtle ambient motion, smooth scrolling, adjustable transitions, and local background music.
- Monaco Lua highlighting, completion snippets, tabs, search, undo, import/export, native clipboard, configurable fonts, smooth caret/typing feedback, Markdown preview, tab/file search, and folder import.
- Typed Luau compilation and execution in a separate Web Worker; stop button, time limit, errors, output capture, and returned values. The editor and local demo share Rift's own Luau engine. This runtime does not contain Roblox services such as `game` or `Instance`.
- Loopback execution bridge remains in the codebase for tests and future opt-in integrations, but its connection dialog and Real/demo controls are removed from the app UI. Live Player execution is not available in this build. See `EXECUTION-BRIDGE.md` for the internal protocol.
- Searchable bundled/local script library, bookmarks, execution history.
- Local username/place-ID profiles; launching through the registered Roblox protocol uses Roblox's currently signed-in account.
- Running Roblox Player/Studio process detection on Windows.
- Atomic workspace writes, queued saves, validated backups, restore, corrupt-file protection, native window controls, always-on-top, size restoration, capture privacy, and optional tray behavior.
- Append-only tagged console output, resizable terminal, output export, and searchable grid/list profile views.

## Not implemented

Standalone Roblox injection engine; account-cookie sessions and account switching; multi-launch; account generation; cloud scripts; licensing; external script providers; Discord/IDE integrations; decompilation, RakNet, or internal Roblox UI; hardware spoofing and driver loading. Unavailable integration controls are labeled or disabled. The UI must not imply these features are working.

## Verification

v0.4 repairs closed-tab persistence, active-tab restoration, per-tab scroll snapshots, stale Markdown overlays, unsupported or colliding shortcut assignments, backup recovery after load failure, preset validation, theme logo preference persistence, native clipboard writes, and successful syntax-check feedback. Renderer and native storage now share the same validation module. Markdown import and large console exports are supported. Sixteen automated tests pass; browser checks cover preview switching and shortcut rejection, and an isolated Windows package smoke test confirms startup and the native bridge. This is a local-workflow repair release, not completion of the missing online or Roblox engine systems.

`pnpm test` checks real Luau execution/errors/termination, persistence, invalid input, corrupt-file recovery, and search/tab normalization. `pnpm build` builds the offline renderer. `pnpm package` creates the unpacked Windows app. The app has no analytics or remote scripts.

Workspace data: Electron's `userData/workspace.json` (normally `%APPDATA%/Rift`). Set `RIFT_DATA_DIR` for an isolated test directory. The recording and any personal identifiers seen in it are not bundled in the app.

## Reference notes

The supplied 80.97-second recording shows Home, Editor, Script Hub, Accounts, and Settings. Some panels are scrolled quickly and some buttons are only hovered. Transition duration is visually approximated, not recovered from the original source. Main app control was blocked by Windows integrity levels, so behavior not demonstrated in the recording is not treated as verified.

Observed settings categories: Roblox, Client, Appearance, Window, Editor, Terminal, Behavior, Keybinds, Connections. Observed secondary pages: overview/account/update log/recent scripts; browse/saved/recent; accounts/multi launch/games/options/generator. The recording shows cloud and auto-execute folders, Explorer Options, output tabs, animation settings, themes, account encryption, and integrations. Backend capabilities remain separate engineering work.

