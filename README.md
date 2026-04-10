## Flutter Chaos Toolkit

Runtime performance overlay toolkit for Flutter applications.

### Features
- Real-time FPS display from engine `FrameTiming`
- Optional memory usage display
- Optional CPU placeholder row for future native integrations
- Network throttling profiles (`normal`, `2G`, `3G`, `4G`, `no internet`)
- Configurable placement (`topLeft`, `topRight`, `bottomLeft`, `bottomRight`)
- Overlay manager API and singleton toolkit controller

### Installation
Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter_chaos_toolkit: ^0.1.0
```

### Usage

```dart
Stack(
  children: [
    const MyAppContent(),
    ChaosOverlay(
      config: ChaosConfig(
        showFPS: true,
        showFrameTime: true,
        showJankPercent: true,
        showMemory: true,
        showCPU: true,
        showNetworkProfile: true,
        position: ChaosPosition.topLeft,
        networkProfile: NetworkProfile.normal,
      ),
    ),
  ],
)
```

### Runtime Reconfiguration

```dart
ChaosToolkit.instance.configure(
  ChaosConfig.performance().copyWith(showMemory: true),
);
ChaosToolkit.instance.show(context);
```

### Simulate Network Profiles for API Timing

```dart
ChaosToolkit.instance.setNetworkProfile(NetworkProfile.g3);

final ChaosHttpResult result = await ChaosToolkit.instance.httpClient.get(
  Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
);
print('${result.profile.label}: ${result.durationMs}ms');
```

### Sample Screenshots

<img width="1206" height="2622" alt="Chaos Toolkit - Normal Profile<img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 - 2026-04-10 at 19 44 56" src="https://github.com/user-attachments/assets/d5c6ef0c-3695-4a64-9368-27ff16b946bc" />




