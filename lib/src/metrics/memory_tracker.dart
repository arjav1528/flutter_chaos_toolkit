import 'dart:io';

class MemoryTracker {
  double _heapUsageMB = 0;

  double get heapUsageMB => _heapUsageMB;

  void update() {
    final int rssBytes = ProcessInfo.currentRss;
    _heapUsageMB = rssBytes / (1024 * 1024);
  }
}
