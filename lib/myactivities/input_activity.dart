import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openai_appp/utilities.dart';
import 'package:openai_appp/custom_ui/text_view_with_state.dart';
import 'package:openai_appp/networking/networking_utilities.dart';
import 'package:http/http.dart' as http;

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String _inputText = "";
  final _textController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String apikey = await readFromAsset("assets/apikeys/api_key_openai.txt");
      print("API KEY == $apikey");
      http.Response? response = await sendCompletionsApiRequest(null,
          buildCompletionsRequestHeaders(apikey), buildCompletionsRequestParams(_inputText));
      if(response != null){
        String parsedResponse = parseCompletionsResponse(response);
        _textController.text = parsedResponse;
      } else {
        _textController.text = "Response was null";
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e){
      print(e);
      _textController.text = "Request Failed due to error: $e";
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Note: This code is the equivalent of handler.postDelayed() in Android
  // Future.delayed(Duration(seconds: 5), () {
  //   setState(() {
  //     _isLoading = false;
  //   });
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text',
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) => _inputText = value,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Submit'),
              onPressed: _submitData,
            ),
          ),
          //Scroll view for vertical scrolling
          SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                )
            )
          )
        ],
      ),
    );
  }
}