## Flutter Chaos Toolkit

Runtime performance overlay toolkit for Flutter applications.

### Features
- Real-time FPS display from engine `FrameTiming`
- Optional memory usage display
- Optional CPU placeholder row for future native integrations
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
        showMemory: true,
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
