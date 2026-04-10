enum NetworkProfile {
  normal,
  g2,
  g3,
  g4,
  offline;

  int get baseLatencyMs {
    switch (this) {
      case NetworkProfile.normal:
        return 20;
      case NetworkProfile.g4:
        return 80;
      case NetworkProfile.g3:
        return 250;
      case NetworkProfile.g2:
        return 600;
      case NetworkProfile.offline:
        return 0;
    }
  }

  int get throughputKbps {
    switch (this) {
      case NetworkProfile.normal:
        return 20000;
      case NetworkProfile.g4:
        return 9000;
      case NetworkProfile.g3:
        return 1600;
      case NetworkProfile.g2:
        return 250;
      case NetworkProfile.offline:
        return 0;
    }
  }

  String get label {
    switch (this) {
      case NetworkProfile.normal:
        return 'Normal';
      case NetworkProfile.g2:
        return '2G';
      case NetworkProfile.g3:
        return '3G';
      case NetworkProfile.g4:
        return '4G';
      case NetworkProfile.offline:
        return 'No Internet';
    }
  }
}
