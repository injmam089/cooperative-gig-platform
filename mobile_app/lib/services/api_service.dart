import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  // Configured for local device / emulator / server
  static const String baseUrl = 'http://10.0.2.2:8088/api'; // Android Emulator alias for localhost:8088

  static Future<UserSession?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return UserSession.fromJson(data['data']);
        }
      }
    } catch (e) {
      print('Login error: $e');
    }
    return null;
  }

  static Future<List<ServiceItemModel>> getServices() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/services'));
      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        return list.map((item) => ServiceItemModel.fromJson(item)).toList();
      }
    } catch (e) {
      print('Fetch services error: $e');
    }
    return [];
  }

  static Future<List<WorkerModel>> getNearbyWorkers({String? skill}) async {
    try {
      String url = '$baseUrl/workers/nearby?radiusKm=25.0';
      if (skill != null && skill.isNotEmpty) {
        url += '&skill=$skill';
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        return list.map((item) => WorkerModel.fromJson(item['worker'])).toList();
      }
    } catch (e) {
      print('Fetch workers error: $e');
    }
    return [];
  }

  static Future<List<BookingModel>> getBookings({int? customerId, int? workerId}) async {
    try {
      String url = '$baseUrl/bookings';
      if (customerId != null) {
        url += '?customerId=$customerId';
      } else if (workerId != null) {
        url += '?workerId=$workerId';
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List list = jsonDecode(response.body);
        return list.map((item) => BookingModel.fromJson(item)).toList();
      }
    } catch (e) {
      print('Fetch bookings error: $e');
    }
    return [];
  }

  static Future<bool> createBooking({
    required int customerId,
    required int workerId,
    required int serviceId,
    required String bookingType,
    required String description,
    required String location,
    required String scheduledDate,
    required String scheduledTimeSlot,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/bookings'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'customerId': customerId,
          'workerId': workerId,
          'serviceId': serviceId,
          'bookingType': bookingType,
          'description': description,
          'location': location,
          'scheduledDate': scheduledDate,
          'scheduledTimeSlot': scheduledTimeSlot,
        }),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print('Create booking error: $e');
      return false;
    }
  }

  static Future<bool> updateBookingStatus(int bookingId, String newStatus) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/bookings/$bookingId/status'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'status': newStatus}),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Update status error: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getDemandForecast(String category) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/ai/demand?category=$category'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Demand forecast error: $e');
    }
    return null;
  }
}
