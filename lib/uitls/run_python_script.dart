import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';

Future<void> runPythonScript(String link) async {
  try {
    // Read the Python script from the asset bundle
    String pythonScript =
        await rootBundle.loadString('assets/script/simple_cast.py');

    // Create a temporary directory
    Directory tempDir = await Directory.systemTemp.createTemp();
    String tempFilePath = '${tempDir.path}/your_script.py';

    // Write the Python script to the temporary directory
    await File(tempFilePath).writeAsString(pythonScript);

    // Run the Python script using Process.run
    await Process.run('python', [tempFilePath, link]);

    // Print the result

    // Optionally, you can delete the temporary directory if needed
    //await tempDir.delete(recursive: true);
  } catch (e) {
    log('Error running Python script: $e');
  }
}
