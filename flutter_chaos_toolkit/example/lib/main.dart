import 'package:flutter/material.dart';
import 'package:flutter_chaos_toolkit/flutter_chaos_toolkit.dart';

void main() {
  runApp(const ChaosExampleApp());
}

class ChaosExampleApp extends StatefulWidget {
  const ChaosExampleApp({super.key});

  @override
  State<ChaosExampleApp> createState() => _ChaosExampleAppState();
}

class _ChaosExampleAppState extends State<ChaosExampleApp> {
  ChaosConfig _config = ChaosConfig.performance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: <Widget>[
            child ?? const SizedBox.shrink(),
            ChaosOverlay(config: _config),
          ],
        );
      },
      home: Scaffold(
        appBar: AppBar(title: const Text('Chaos Toolkit Demo')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            SwitchListTile(
              title: const Text('Show FPS'),
              value: _config.showFPS,
              onChanged: (bool value) =>
                  setState(() => _config = _config.copyWith(showFPS: value)),
            ),
            SwitchListTile(
              title: const Text('Show Memory'),
              value: _config.showMemory,
              onChanged: (bool value) =>
                  setState(() => _config = _config.copyWith(showMemory: value)),
            ),
            SwitchListTile(
              title: const Text('Show CPU (placeholder)'),
              value: _config.showCPU,
              onChanged: (bool value) =>
                  setState(() => _config = _config.copyWith(showCPU: value)),
            ),
            DropdownButton<ChaosPosition>(
              value: _config.position,
              items: ChaosPosition.values
                  .map(
                    (ChaosPosition p) => DropdownMenuItem<ChaosPosition>(
                      value: p,
                      child: Text(p.name),
                    ),
                  )
                  .toList(),
              onChanged: (ChaosPosition? value) {
                if (value == null) return;
                setState(() => _config = _config.copyWith(position: value));
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const _SecondScreen(),
                  ),
                );
              },
              child: const Text('Open Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecondScreen extends StatelessWidget {
  const _SecondScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: const Center(child: Text('Overlay is visible here too.')),
    );
  }
}
