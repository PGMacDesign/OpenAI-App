import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiKeyScreen2 extends StatefulWidget {
  const ApiKeyScreen2({Key? key}) : super(key: key);

  @override
  _ApiKeyScreen2State createState() => _ApiKeyScreen2State();
}

class _ApiKeyScreen2State extends State<ApiKeyScreen2>
    with SingleTickerProviderStateMixin {
  final TextEditingController _inputController = TextEditingController();
  String? _apiKey;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _loadApiKey();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
    return FadeTransition(
        opacity: _opacityAnimation,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Please Enter your API Key',
              style: TextStyle(fontSize: 20.0),
            ),
            TextField(
              controller: _inputController,
              onChanged: (text) {
                setState(() {
                  // enable/disable the button based on input length
                  _isInputValid(text)
                      ?
                  {
                    _animationController.forward(),
                    _continueButtonEnabled = true
                  }
                      :
                  {
                    _animationController.reverse(),
                    _continueButtonEnabled = false
                  };
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
        )
    );

  }

  Widget _buildInfoSection() {
    return FadeTransition(
        opacity: _opacityAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Valid API Key Stored',
                style: TextStyle(fontSize: 20.0),
              ),
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
                  // todo Navigate to new activity here
                },
              ),
            ),
          ],
        )
    );
  }

  bool _continueButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    if(true){
      return Scaffold(
        body: Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: _apiKey == null ? _buildInputSection() : _buildInfoSection(),
            )
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: _apiKey == null ? _buildInputSection() : _buildInfoSection(),
        ),
      );
    }
  }
}