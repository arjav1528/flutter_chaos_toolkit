## 0.1.0

- Added `ChaosOverlay` with configurable metric rows.
- Added `ChaosConfig` to accept runtime display options (`showFPS`, `showCPU`, etc.).
- Added `ChaosOverlayManager` and `ChaosToolkit` singleton for programmatic control.
- Added metrics pipeline (`FpsTracker`, `MemoryTracker`, `MetricsController`).
- Added network throttling profiles and `ChaosHttpClient` for simulated API latency testing.
- Added tests and example app with live config toggles.
