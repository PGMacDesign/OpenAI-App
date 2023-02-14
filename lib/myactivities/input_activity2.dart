import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyScreen extends StatefulWidget {
  const ApiKeyScreen({Key? key}) : super(key: key);

  @override
  _ApiKeyScreenState createState() => _ApiKeyScreenState();
}

class _ApiKeyScreenState extends State<ApiKeyScreen> {
  final TextEditingController _inputController = TextEditingController();
  String? _apiKey;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  void _loadApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _apiKey = prefs.getString('api_key');
    });
  }

  void _saveApiKey(String apiKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_key', apiKey);
    setState(() {
      _apiKey = apiKey;
    });
  }

  void _clearApiKey() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('api_key');
    setState(() {
      _apiKey = null;
    });
  }

  bool _isInputValid(String input) {
    return input.length > 0;
  }

  Widget _buildInputSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _inputController,
          onChanged: (text) {
            setState(() {
              // enable/disable the button based on input length
              _isInputValid(text)
                  ? _continueButtonEnabled = true
                  : _continueButtonEnabled = false;
            });
          },
        ),
        ElevatedButton(
          child: Text('Save'),
          onPressed: _isInputValid(_inputController.text)
              ? () {
            _saveApiKey(_inputController.text);
          }
              : null,
        ),
      ],
    );
  }

  Widget _buildInfoSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Valid API Key Stored'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Edit'),
                onPressed: () {
                  _clearApiKey();
                  _inputController.clear();
              },
          )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Text('Continue to API'),
            onPressed: () {
              // Navigate to new activity here
            },
          ),
        ),
      ],
    );
  }

  bool _continueButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _apiKey == null ? _buildInputSection() : _buildInfoSection(),
      ),
    );
  }
}