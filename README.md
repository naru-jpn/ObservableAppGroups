# ObservableAppGroups

Sample project for observable file changes in app groups container with Combine.

<kbd><img src="https://user-images.githubusercontent.com/5572875/188913438-71e0f387-02e0-4a52-9d9a-a117f0a155f6.png" width="450"></kbd>

## Overview

This project contains 3 local packages to manage files in container. (See `Packages/Package.swift`)

- `FileObserver`
  - Class to observe file changes using DispatchSourceFileSystemObject.
- `AppGroupsFileSystem`
  - App groups container url provider and class representing file contained on app groups container.
- `BroadcastPreferences`
  - Informations shared and observed between application and app extension.

Broadcast upload extension updates shared Bool variable `isBroadcasting`.

```swift
try? BroadcastPreferences.shared.isBroadcasting.write(true)
```

Application observes `isBroadcasting` with SwiftUI.

```swift
Text(viewModel.isBroadcasting ? "Broadcasting" : "Not Broadcasting")
```

<kbd><img src="https://user-images.githubusercontent.com/5572875/188913479-0b8a32b3-7f50-4772-8be8-1ee740d60d59.png" width="600"></kbd>
