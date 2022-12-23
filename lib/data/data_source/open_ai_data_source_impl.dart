import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../../resource/app_constant.dart';
import '../../util/api_client.dart';
import '../dto/open_ai_data_dto.dart';
import 'open_ai_data_source.dart';

class OpenAIDataSourceImpl implements OpenAIDataSource {
  final ApiClient apiClient;

  const OpenAIDataSourceImpl(this.apiClient);

  @override
  Future<OpenAIDataDTO> getImages({required String prompt, required int n, required String size}) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['OPEN_AI_KEY']}',
    };

    final Map<String, dynamic> body = {
      'prompt': prompt,
      'n': n,
      'size': size,
    };

    final Response response = await apiClient.postData(urlOpenAI, pathOpenAI, headers, body);
    if (response.statusCode != HttpStatus.ok) {
      throw Exception(json.decode(response.body)['message']);
    }

    return OpenAIDataDTO.fromJson(json.decode(response.body));
  }
}
