import 'dart:convert';
import 'package:http/http.dart' as http;

/// Build Request Headers for an OpenAI Request
Map<String, String> buildCompletionsRequestHeaders(String apiKey) {
  return {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey"
  };
}

/// Build Request Params for an OpenAI request
Map<String, Object> buildCompletionsRequestParams(String prompt, {maxTokens = 100, temperature = 0.5}) {
  Map<String, Object> map = {};
  map["prompt"] = prompt;
  map["max_tokens"] = (maxTokens == null) ? 100 : maxTokens;
  map["temperature"] = (temperature == null) ? 0.5 : temperature;
  return map;
}

/// Send a Completions request. Defaults to the `/completions` endpoint if null is sent
Future<http.Response?> sendCompletionsApiRequest(String? endpoint,
                                                 Map<String, String> headers,
                                                 Map<String, Object> params) async {
  Uri? toSend;
  try {
    toSend = (endpoint != null)
        ? Uri.parse(endpoint)
        : Uri.parse("https://api.openai.com/v1/engines/davinci/completions");
    print("ABOUT TO SEND TO: $toSend");
    print("headers: " + headers.toString());
    print("params: " + params.toString());
  } on FormatException catch (e){ //Can't trigger, but wanted to keep it for reference of >1 error
    print("FormatException: $e");
    return null;
  } on Exception catch (e){
    print("Exception: $e");
    return null;
  }
  return await http.post(toSend, headers: headers, body: json.encode(params));
}


/// Parse an http.Response into a string
String parseCompletionsResponse(http.Response response) {
  print("RESPONSE CODE == ${response.statusCode}");
  if (response.statusCode == 200) {
    var responseJson = json.decode(response.body);
    print("RESPONSE JSON == $responseJson");
    var choices = responseJson['choices'];
    print("choices == ${choices.toString()}");
    return responseJson['choices'][0]['text'];
  } else {
    throw Exception('Failed to fetch completion from OpenAI');
  }
}



