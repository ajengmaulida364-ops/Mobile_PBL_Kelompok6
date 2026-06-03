import 'dart:convert';

import 'package:http/http.dart'
    as http;

class PaymentService {

  final String baseUrl =
      'http://10.0.2.2:8000/api/admin';

  /// LIST SISWA
  Future<List> getStudents() async {

    final response =
        await http.get(

      Uri.parse(
        '$baseUrl/payments',
      ),
    );

    if (response.statusCode ==
        200) {

      final data =
          jsonDecode(
        response.body,
      );

      return data['data'];

    } else {

      throw Exception(
        'Gagal ambil pembayaran',
      );
    }
  }

  /// DETAIL PEMBAYARAN
  Future<Map<String, dynamic>>
      getPaymentDetail(
    int studentId,
  ) async {

    final response =
        await http.get(

      Uri.parse(
        '$baseUrl/payments/$studentId',
      ),
    );

    if (response.statusCode ==
        200) {

      return jsonDecode(
        response.body,
      );

    } else {

      throw Exception(
        'Gagal ambil detail pembayaran',
      );
    }
  }

  /// BAYAR
  Future<void> pay({

    required int studentId,

    required String bulan,

    required int jumlah,
  }) async {

    final response =
        await http.post(

      Uri.parse(
        '$baseUrl/payments/store',
      ),

      body: {

        'student_id':
            studentId.toString(),

        'bulan': bulan,

        'jumlah':
            jumlah.toString(),
      },
    );

    if (response.statusCode !=
        200) {

      throw Exception(
        'Pembayaran gagal',
      );
    }
  }
}