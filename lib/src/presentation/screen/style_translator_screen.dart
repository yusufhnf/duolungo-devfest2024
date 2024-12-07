import 'package:chips_choice/chips_choice.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/services/gemini_service.dart';
import '../../core/di/locator.dart';

class StyleTranslatorScreen extends StatefulWidget {
  const StyleTranslatorScreen({super.key});

  @override
  State<StyleTranslatorScreen> createState() => _StyleTranslatorScreenState();
}

class _StyleTranslatorScreenState extends State<StyleTranslatorScreen> {
  int _selectedTag = 0;
  bool _isLoading = false;
  String _result = "";
  final TextEditingController _controller = TextEditingController();
  final GeminiService _geminiService = locator<GeminiService>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox.expand(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _controller,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Enter here',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text("Select translation style",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  ChipsChoice<int>.single(
                    choiceStyle: C2ChipStyle.outlined(
                        color: Colors.green,
                        selectedStyle: C2ChipStyle.filled(
                            color: Colors.green,
                            foregroundColor: Colors.white)),
                    alignment: WrapAlignment.start,
                    value: _selectedTag,
                    onChanged: (val) => setState(() => _selectedTag = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: Constants.translationStyle,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  if (_result.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Result",
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            _result,
                            style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  minimumSize: const Size(48.0, 48.0),
                                  backgroundColor: Colors.green),
                              onPressed: () async {
                                await FlutterClipboard.copy(_result);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Copied to clipboard")));
                              },
                              child:
                                  const Icon(Icons.copy, color: Colors.white),
                            ),
                            const SizedBox(width: 16.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  minimumSize: const Size(48.0, 48.0),
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _result = "";
                                });
                              },
                              child:
                                  const Icon(Icons.clear, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16.0),
                  minimumSize: const Size(double.infinity, 48.0),
                  backgroundColor: Colors.green),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _generateText();
                }
              },
              child: _isLoading
                  ? const CupertinoActivityIndicator(
                      color: Colors.white,
                    )
                  : const Text("Submit",
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> _generateText() async {
    setState(() {
      _isLoading = true;
    });
    final String prompt =
        "Terjemahkan kalimat ini ke bahasa Inggris dengan gaya ${Constants.translationStyle[_selectedTag]}. Berikan terjemahan langsung tanpa penjelasan apapun: ${_controller.text}";
    final result = await _geminiService.generateText(prompt);

    setState(() {
      _result = result ?? 'No result';
      _isLoading = false;
    });
  }
}
