import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemini CLI GUI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GeminiCliGuiPage(),
    );
  }
}

class GeminiCliGuiPage extends StatefulWidget {
  const GeminiCliGuiPage({super.key});

  @override
  State<GeminiCliGuiPage> createState() => _GeminiCliGuiPageState();
}

enum OutputType { normal, error }

class OutputEntry {
  final String text;
  final OutputType type;

  OutputEntry(this.text, {this.type = OutputType.normal});
}

enum ProcessStatus { idle, running, error }

class _GeminiCliGuiPageState extends State<GeminiCliGuiPage> {
  final TextEditingController _commandController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  List<OutputEntry> _output = [];
  Process? _currentProcess;
  ProcessStatus _processStatus = ProcessStatus.idle;
  List<String> _commandHistory = [];
  int _historyIndex = -1;
  final FocusNode _commandFocusNode = FocusNode();

  @override
  void dispose() {
    _commandController.dispose();
    _inputController.dispose();
    _commandFocusNode.dispose();
    _currentProcess?.kill(); // Ensure process is killed on dispose
    super.dispose();
  }

  Future<void> _executeCommand() async {
    final command = _commandController.text.trim();
    if (command.isEmpty) {
      setState(() {
        _output.add(OutputEntry('Please enter a command.', type: OutputType.error));
      });
      return;
    }

    // Add command to history
    if (_commandHistory.isEmpty || _commandHistory.last != command) {
      _commandHistory.add(command);
    }
    _historyIndex = _commandHistory.length; // Reset history index

    setState(() {
      _output.add(OutputEntry('Executing: $command'));
      _processStatus = ProcessStatus.running;
    });

    try {
      final parts = command.split(' ');
      String executable = parts[0];
      final arguments = parts.sublist(1);

      if (executable == 'gemini') {
        executable = 'C:\\Program Files\\nodejs\\gemini.cmd'; // Use absolute path for gemini
      }

      _currentProcess = await Process.start(executable, arguments);

      // Listen to stdout
      _currentProcess!.stdout.transform(utf8.decoder).listen((data) {
        setState(() {
          _output.add(OutputEntry(data));
        });
      });

      // Listen to stderr
      _currentProcess!.stderr.transform(utf8.decoder).listen((data) {
        setState(() {
          _output.add(OutputEntry('Error: $data', type: OutputType.error));
        });
      });

      // Wait for the process to exit and get the exit code
      final exitCode = await _currentProcess!.exitCode;
      setState(() {
        _output.add(OutputEntry('\nProcess exited with code: $exitCode'));
        _currentProcess = null; // Clear the process when it exits
        _processStatus = ProcessStatus.idle;
      });

    } catch (e) {
      setState(() {
        _output.add(OutputEntry('\nError executing command: $e', type: OutputType.error));
        _processStatus = ProcessStatus.error;
      });
    }
  }

  void _sendInput() {
    if (_currentProcess != null) {
      final input = _inputController.text.trim();
      _currentProcess!.stdin.writeln(input);
      _inputController.clear();
      setState(() {
        _output.add(OutputEntry('> $input')); // Echo input to output
      });
    } else {
      setState(() {
        _output.add(OutputEntry('No active process to send input to.', type: OutputType.error));
      });
    }
  }

  void _clearOutput() {
    setState(() {
      _output = [];
      _processStatus = ProcessStatus.idle;
    });
  }

  void _onCommandSubmitted(String value) {
    _executeCommand();
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        setState(() {
          if (_historyIndex > 0) {
            _historyIndex--;
            _commandController.text = _commandHistory[_historyIndex];
            _commandController.selection = TextSelection.fromPosition(
                TextPosition(offset: _commandController.text.length));
          }
        });
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        setState(() {
          if (_historyIndex < _commandHistory.length - 1) {
            _historyIndex++;
            _commandController.text = _commandHistory[_historyIndex];
            _commandController.selection = TextSelection.fromPosition(
                TextPosition(offset: _commandController.text.length));
          } else if (_historyIndex == _commandHistory.length - 1) {
            _historyIndex++;
            _commandController.text = '';
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Gemini CLI GUI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text('Status: ${_processStatus.name}', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _output.length,
                itemBuilder: (context, index) {
                  final entry = _output[index];
                  return Text(
                    entry.text,
                    style: TextStyle(
                      color: entry.type == OutputType.error ? Colors.red : Colors.black,
                    ),
                  );
                },
              ),
            ),
            RawKeyboardListener(
              focusNode: _commandFocusNode,
              onKey: _handleKeyEvent,
              child: TextField(
                controller: _commandController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Gemini CLI command',
                ),
                onSubmitted: _onCommandSubmitted,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _executeCommand,
              child: const Text('Execute Command'),
            ),
            const SizedBox(height: 16), // Add some spacing
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Send input to CLI (e.g., for chat)',
              ),
              onSubmitted: (_) => _sendInput(),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _sendInput,
              child: const Text('Send Input'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _clearOutput,
              child: const Text('Clear Output'),
            ),
          ],
        ),
      ),
    );
  }
}
