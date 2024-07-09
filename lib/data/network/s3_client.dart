import 'package:http/http.dart' as http;

class S3Client {
  final String preSignedUrl;

  S3Client(this.preSignedUrl);

  Future<void> uploadFile({
    required String fileName,
    required List<int> fileBytes,
  }) async {
    var uri = Uri.parse(preSignedUrl);
    var request = http.MultipartRequest('POST', uri)..files.add(
      http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
      ),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to upload file');
    }
  }
}