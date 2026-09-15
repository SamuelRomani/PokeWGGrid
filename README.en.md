<div align="center">

<img src="tray.png" width="72" alt="PokeWGGrid">

# PokeWGGrid

**Two idle-game accounts in a single window.**

![Platform](https://img.shields.io/badge/Windows%20%C2%B7%20macOS%20%C2%B7%20Linux-0078D6)
![Electron](https://img.shields.io/badge/Electron-43-47848F)
[![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

[Português](README.md)

</div>

> The recommended way is running from source: you grab the code, look at what it does and run it yourself, no blind trust required. There is also a **[portable .exe](https://github.com/SamuelRomani/PokeWGGrid/releases/tag/latest)**, built automatically by GitHub on every change to this repository's code (not a build of mine, it's public) — handy if you do not want to deal with Node.js, but then the trust shifts to whoever builds it: GitHub Actions itself, with every build log public.

> ### 🔒 Your login data stays only on your computer
> Login and password are encrypted on your own PC and never leave it. No server, no repository. The whole code is here for you to check.

## What it is

Two accounts running at once, each in its own quadrant with a separate session. You save the login once and the app signs in on its own from then on. If a session drops mid farm, it logs back in without you being around. It does not play the game for you — it does not automate any action inside the game, and never touches the captcha — it just organizes the accounts you already have.

This project is derived from [IdleGrid](https://github.com/SamuelRomani/IdleGrid), the same account organizer, but pointed at **pokewg.com** instead of another game, with the account limit reduced to 2 and none of the extra automations (IdleGrid has a few, optional, specific to that other game). Auto-login works on any standard login form — it does not depend on anything specific to this game.

## How to run

You need Node.js installed once. After that it is quick.

**1. Install Node.js**
Download the LTS version at [nodejs.org](https://nodejs.org) and install it (just next, next, finish).

**2. Download this code**
Click the green **Code** button above, then **Download ZIP**. Extract the folder wherever you want. If you use Git, clone it:

```bash
git clone https://github.com/SamuelRomani/PokeWGGrid.git
```

**3. Open the app**
On Windows, double click the **Abrir PokeWGGrid** (`.vbs`) file in the folder. The first time it installs what it needs and opens on its own; after that it opens right away, no black window. Want a shortcut? Right-click it, **Send to: Desktop (create shortcut)**.

You can also use **iniciar.bat**, but it keeps a black window open, and closing it closes the app too.

On macOS or Linux, open a terminal in the folder and run:

```bash
bash iniciar.sh
```

That is it. Log in or create an account in each panel and, under "Accounts", save the login. Next time it signs in on its own.

## What it does

- Run 1 or 2 accounts, you choose how many panels to open.
- Auto login, even when the session expires in the middle of a farm.
- Shows its own version in the top bar and lets you know when the repository's `main` is newer. On Windows, the update button (asks for confirmation first) does it on its own: source code uses `git pull` (or re-downloads the ZIP if it is not a clone); the portable `.exe` downloads the new version (published as a release on every push to `main`) and swaps the old file for the new one.
- Eco mode that keeps CPU use down without hurting progress.
- Notifies you when an account drops.
- Turn each panel on or off, zoom, full screen and keyboard shortcuts.
- Run your own userscripts in each panel (Scripts / Extras menu).
- Tray, start with Windows, and Portuguese, English or Spanish.

## Security

- Passwords are encrypted by Electron's `safeStorage`, which uses the OS API (DPAPI on Windows). They never leave the PC.
- Panels are locked to the game's domain. An external link opens in your real browser, and the password is only typed into the official login page.
- The game's camera, microphone, location and notifications are blocked.
- You always solve the captcha. The app fills the fields and presses Enter once they're correct, but it never touches the "Confirm you are human" widget. Beating bot detection is not the point.

## Under the hood

Each panel is an Electron `<webview>` with its own partition (`persist:conta1` and `conta2`), and that is what keeps the accounts isolated and logged in between launches. Eco swaps `requestAnimationFrame` for a slower version, and the login fills through the input's native setter (targeting `autocomplete=username`/`current-password` fields, falling back to the first text/password field in the form). It is all in `main.js`, `preload.js` and `index.html`, nothing hidden.

## License

MIT. Independent project.
