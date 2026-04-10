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
  String _apiResult = 'No API call yet';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return Stack(
          children: <Widget>[
            child ?? const SizedBox.shrink(),
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
            SwitchListTile(
              title: const Text('Show Network Profile'),
              value: _config.showNetworkProfile,
              onChanged: (bool value) => setState(
                () => _config = _config.copyWith(showNetworkProfile: value),
              ),
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
            DropdownButton<NetworkProfile>(
              value: _config.networkProfile,
              items: NetworkProfile.values
                  .map(
                    (NetworkProfile p) => DropdownMenuItem<NetworkProfile>(
                      value: p,
                      child: Text(p.label),
                    ),
                  )
                  .toList(),
              onChanged: (NetworkProfile? value) {
                if (value == null) return;
                setState(
                  () => _config = _config.copyWith(networkProfile: value),
                );
                ChaosToolkit.instance.setNetworkProfile(value);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final Uri uri = Uri.parse(
                  'https://jsonplaceholder.typicode.com/todos/1',
                );
                try {
                  final ChaosHttpResult result = await ChaosToolkit
                      .instance
                      .httpClient
                      .get(uri, profile: _config.networkProfile);
                  setState(() {
                    _apiResult =
                        '${result.profile.label}: ${result.durationMs} ms (status ${result.response.statusCode})';
                  });
                } on ChaosNetworkException catch (e) {
                  setState(() => _apiResult = e.message);
                } catch (e) {
                  setState(() => _apiResult = 'Request failed: $e');
                }
              },
              child: const Text('Test API Call'),
            ),
            const SizedBox(height: 8),
            Text(_apiResult),
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
