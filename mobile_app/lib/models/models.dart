class UserSession {
  final String token;
  final int userId;
  final String email;
  final String fullName;
  final String role; // CUSTOMER, WORKER, SOCIETY_ADMIN, FEDERATION_ADMIN
  final int? customerId;
  final int? workerId;
  final int? societyId;

  UserSession({
    required this.token,
    required this.userId,
    required this.email,
    required this.fullName,
    required this.role,
    this.customerId,
    this.workerId,
    this.societyId,
  });

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      token: json['token'] ?? '',
      userId: json['userId'] ?? 0,
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      role: json['role'] ?? 'CUSTOMER',
      customerId: json['customerId'],
      workerId: json['workerId'],
      societyId: json['societyId'],
    );
  }
}

class ServiceItemModel {
  final int serviceId;
  final String serviceName;
  final String description;
  final String icon;
  final double basePrice;
  final double emergencyFee;

  ServiceItemModel({
    required this.serviceId,
    required this.serviceName,
    required this.description,
    required this.icon,
    required this.basePrice,
    required this.emergencyFee,
  });

  factory ServiceItemModel.fromJson(Map<String, dynamic> json) {
    return ServiceItemModel(
      serviceId: json['serviceId'] ?? 0,
      serviceName: json['serviceName'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '🛠️',
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 299.0,
      emergencyFee: (json['emergencyFee'] as num?)?.toDouble() ?? 150.0,
    );
  }
}

class WorkerModel {
  final int workerId;
  final String fullName;
  final String phone;
  final String skill;
  final int experienceYears;
  final String location;
  final double averageRating;
  final int totalRatings;
  final int completedJobsCount;
  final String status;
  final String availability;

  WorkerModel({
    required this.workerId,
    required this.fullName,
    required this.phone,
    required this.skill,
    required this.experienceYears,
    required this.location,
    required this.averageRating,
    required this.totalRatings,
    required this.completedJobsCount,
    required this.status,
    required this.availability,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      workerId: json['workerId'] ?? 0,
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      skill: json['skill'] ?? '',
      experienceYears: json['experienceYears'] ?? 1,
      location: json['location'] ?? '',
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 4.8,
      totalRatings: json['totalRatings'] ?? 0,
      completedJobsCount: json['completedJobsCount'] ?? 0,
      status: json['status'] ?? 'VERIFIED',
      availability: json['currentAvailability'] ?? 'AVAILABLE',
    );
  }
}

class BookingModel {
  final int bookingId;
  final String serviceName;
  final String customerName;
  final String workerName;
  final String workerSkill;
  final String status;
  final String bookingType;
  final double finalPrice;
  final double workerEarnings;
  final String scheduledDate;
  final String scheduledTimeSlot;
  final String location;
  final String description;

  BookingModel({
    required this.bookingId,
    required this.serviceName,
    required this.customerName,
    required this.workerName,
    required this.workerSkill,
    required this.status,
    required this.bookingType,
    required this.finalPrice,
    required this.workerEarnings,
    required this.scheduledDate,
    required this.scheduledTimeSlot,
    required this.location,
    required this.description,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['bookingId'] ?? 0,
      serviceName: json['service']?['serviceName'] ?? 'Service',
      customerName: json['customer']?['fullName'] ?? 'Customer',
      workerName: json['worker']?['fullName'] ?? 'Worker',
      workerSkill: json['worker']?['skill'] ?? 'Skilled Trade',
      status: json['status'] ?? 'REQUESTED',
      bookingType: json['bookingType'] ?? 'NORMAL',
      finalPrice: (json['finalPrice'] as num?)?.toDouble() ?? 299.0,
      workerEarnings: (json['workerEarnings'] as num?)?.toDouble() ?? 254.15,
      scheduledDate: json['scheduledDate'] ?? 'Today',
      scheduledTimeSlot: json['scheduledTimeSlot'] ?? 'Morning',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
    );
  }
}
