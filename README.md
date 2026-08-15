# World Clock

A macOS/iOS app for displaying current times across multiple cities worldwide.

## Features

- Display current time for multiple cities simultaneously
- Add and remove cities
- Time zone support
- Simple and intuitive UI

## Requirements

- macOS 13.0 or later (for macOS app)
- iOS 16.0 or later (for iOS app)
- Xcode 14.0 or later
- Swift 5.7 or later

## Download

Grab the latest build from the
[Releases page](https://github.com/shinji-kasai/World-Clock/releases):

1. Download the `.zip` and unzip it
2. Drag `World Clock.app` to `/Applications`
3. **Right-click → Open** the first time — this build isn't notarized (no
   paid Apple Developer account), so Gatekeeper will otherwise block it as
   "unidentified developer"; right-click Open bypasses that one-time warning

## Building from source

### 1. Open the Project

```bash
open "World Clock.xcodeproj"
```

### 2. Build & Run

- In Xcode, select "My Mac" or any simulator from the target selector in the top left
- Press **⌘R** (Command + R) to build and run

### 3. Clean Build (if errors occur)

```bash
# In Xcode: Shift + Command + K
# Or
Product → Clean Build Folder
```

## Project Structure

```
World Clock/
├── App/                    # Application core
│   ├── AppDelegate.swift
│   ├── WorldClockApp.swift # Main app entry point
│   └── Info.plist
├── Models/                 # Data models
│   └── City.swift         # City data structure
├── Views/                  # UI screens
│   └── MainView.swift     # Main view
└── Managers/              # Business logic
    └── CityManager.swift  # City management
```

## Development

### Adding New Cities

City list is managed in `CityManager.swift`.

### Customizing the UI

Edit the main UI in `MainView.swift`.

## Releasing

Push a tag matching `v*` (e.g. `git tag v1.2 && git push origin v1.2`) and a
GitHub Actions workflow (`.github/workflows/release.yml`) builds a universal
binary (Apple Silicon + Intel), ad-hoc signs it, zips it, and publishes a
GitHub Release automatically with the zip attached.

Bump `MARKETING_VERSION` in `World Clock.xcodeproj/project.pbxproj` to match
the tag before tagging — `Info.plist`'s `CFBundleShortVersionString` reads
from it directly.

### Publish to App Store

1. Apple Developer Program membership required
2. **Product → Archive**
3. Upload to **App Store Connect**

## Troubleshooting

### Build Errors

```bash
# Delete Derived Data
rm -rf ~/Library/Developer/Xcode/DerivedData
```

Then in Xcode, **Clean Build Folder** (Shift + Command + K)

### Icon Not Displaying

- Check `WorlClockIcon.icon/icon.json` configuration
- Verify assets are properly included in the target

## License

MIT License

## Author

Shinji Kasai

---

## Future Features

- [ ] Dark mode support
- [ ] Widget support
- [ ] City search functionality
- [ ] Custom time zone settings
