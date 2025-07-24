# Gemini CLI GUI with Flutter

## 1. Goal
To create a Flutter-based Graphical User Interface (GUI) for interacting with the Gemini CLI, allowing users to execute commands and view their output within a user-friendly application.

## 2. Implementation Method

Flutter applications can execute external command-line processes and capture their output using the `dart:io` library.

### Key `dart:io` Classes:

*   **`Process.run()`**:
    *   **Purpose**: Executes a command and waits for it to complete, returning a `ProcessResult` object containing `stdout`, `stderr`, and `exitCode`.
    *   **Use Case**: Ideal for single-shot commands where you need the complete output after execution (e.g., `gemini --version`).

*   **`Process.start()`**:
    *   **Purpose**: Starts a process and returns a `Process` object immediately, allowing for asynchronous interaction with its `stdin`, `stdout`, and `stderr` streams.
    *   **Use Case**: Essential for long-running processes or interactive CLIs where you need to stream output in real-time (e.g., `gemini chat`, `gemini run`). This will be crucial for the Gemini CLI interaction.

### Proposed Approach:

1.  **Execute CLI Commands**: Use `Process.start()` to run the Gemini CLI. This will allow us to capture output as it's generated, which is important for interactive commands like `gemini chat`.
2.  **Capture Output**: Listen to the `stdout` and `stderr` streams of the spawned process.
3.  **Display Output**: Update the Flutter UI in real-time with the captured output.
4.  **Send Input**: Provide a mechanism (e.g., a text input field) to send commands or input to the CLI's `stdin`.

## 3. GUI Plan (High-Level)

The GUI will aim for a clean, functional design, providing a clear interface for command input and output display.

### Components:

*   **Command Input Field**: A `TextField` where users can type Gemini CLI commands.
*   **Execute Button**: A button to trigger the execution of the command entered in the input field.
*   **Output Display Area**: A scrollable `Text` widget or `ListView` to display the `stdout` and `stderr` from the Gemini CLI. This area should update in real-time.
*   **Status Bar/Indicators**: (Optional) To show the current status of the CLI process (e.g., "Running...", "Idle", "Error").
*   **History/Log**: (Optional) A way to view previous commands and their outputs.

### Initial Screen Layout:

```
+-------------------------------------+
| AppBar (Gemini CLI GUI)             |
+-------------------------------------+
|                                     |
|  [Output Display Area (Scrollable)] |
|                                     |
|                                     |
|                                     |
|                                     |
+-------------------------------------+
| [Command Input Field             ]  |
+-------------------------------------+
| [Execute Button]                    |
+-------------------------------------+
```

## 4. Progress Update

*   **Project Setup**: A new Flutter project named `gemini_cli_gui` has been successfully created in a subfolder.
*   **Basic UI Implementation**: The `lib/main.dart` file has been updated to include the basic UI structure: a command input `TextField`, an "Execute Command" `ElevatedButton`, and a scrollable `Text` widget for displaying output.
*   **CLI Integration**: `dart:io`'s `Process.start()` is integrated to execute commands entered by the user. `stdout` and `stderr` are captured and displayed in real-time.
*   **`stdin` Input**: Implemented the ability to send input to the running CLI process's `stdin`, crucial for interactive commands like `gemini chat`.
*   **Output Clearing**: Added a "Clear Output" button to clear the output display area.
*   **Improved Error Display**: Refined error display by using a custom `OutputEntry` class and `ListView.builder` to show error messages in red.
*   **Status Indicators**: Implemented `ProcessStatus` enum and a status display to show the current state of the CLI process (Idle, Running, Error).
*   **Command History**: Added command history functionality, allowing users to navigate through previously entered commands using arrow keys.
*   **Platform Compatibility**: The application has been successfully run and tested on Windows.
*   **Gemini Executable Path Resolution**: Resolved the issue where the `gemini` CLI was not found by the GUI application by explicitly providing the absolute path to the `gemini.cmd` executable (`C:\Program Files\nodejs\gemini.cmd`) within the `_executeCommand` function. This ensures the application can correctly locate and run the Gemini CLI.

```