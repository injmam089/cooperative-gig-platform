import 'package:flutter/material.dart';
import 'models/models.dart';
import 'services/api_service.dart';

void main() {
  runApp(const CooperativeGigApp());
}

class CooperativeGigApp extends StatelessWidget {
  const CooperativeGigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cooperative Gig Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF166534), // Cooperative forest green
          primary: const Color(0xFF166534),
          secondary: const Color(0xFF0284C7),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;
  UserSession? _currentUser;
  bool _isLoading = true;

  List<ServiceItemModel> _services = [];
  List<WorkerModel> _workers = [];
  List<BookingModel> _bookings = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    final services = await ApiService.getServices();
    final workers = await ApiService.getNearbyWorkers();
    final bookings = await ApiService.getBookings();

    setState(() {
      _services = services;
      _workers = workers;
      _bookings = bookings;
      _isLoading = false;
    });
  }

  Future<void> _performDemoLogin(String role) async {
    String email = 'customer@example.com';
    if (role == 'WORKER') email = 'rahul.plumber@example.com';
    if (role == 'ADMIN') email = 'society.admin@example.com';

    final session = await ApiService.login(email, 'Password@123');
    if (session != null) {
      setState(() {
        _currentUser = session;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged in as ${session.fullName} (${session.role})')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF166534),
        foregroundColor: Colors.white,
        title: Row(
          children: [
            const Text('⚡ ', style: TextStyle(fontSize: 22)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cooperative Gig', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  _currentUser != null ? '${_currentUser!.fullName} (${_currentUser!.role})' : 'Direct Community Services',
                  style: const TextStyle(fontSize: 11, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            onSelected: (val) {
              if (val == 'LOGOUT') {
                setState(() => _currentUser = null);
              } else {
                _performDemoLogin(val);
              }
            },
            itemBuilder: (ctx) => [
              const PopupMenuItem(value: 'CUSTOMER', child: Text('👤 Login as Customer')),
              const PopupMenuItem(value: 'WORKER', child: Text('👷 Login as Worker (Rahul)')),
              const PopupMenuItem(value: 'ADMIN', child: Text('⚙️ Login as Society Admin')),
              if (_currentUser != null) const PopupMenuItem(value: 'LOGOUT', child: Text('🚪 Logout')),
            ],
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildCurrentBody(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.handyman), label: 'Workers'),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.psychology), label: 'AI & Analytics'),
        ],
      ),
    );
  }

  Widget _buildCurrentBody() {
    switch (_currentIndex) {
      case 0:
        return _buildExploreTab();
      case 1:
        return _buildWorkersTab();
      case 2:
        return _buildBookingsTab();
      case 3:
        return _buildAiAnalyticsTab();
      default:
        return _buildExploreTab();
    }
  }

  Widget _buildExploreTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Cooperative Banner
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF166534), Color(0xFF15803D)]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '🤝 100% Cooperative Owned',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'Direct booking with verified trade workers. Zero middleman cuts. 85% fair earnings go directly to workers.',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('Explore Services', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: _services.length,
          itemBuilder: (ctx, i) {
            final s = _services[i];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedCategory = s.serviceName;
                    _currentIndex = 1; // Switch to workers tab filtered by skill
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(s.icon, style: const TextStyle(fontSize: 32)),
                      const SizedBox(height: 8),
                      Text(
                        s.serviceName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${s.basePrice.toInt()}',
                        style: const TextStyle(color: Color(0xFF166534), fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildWorkersTab() {
    final filtered = _selectedCategory == null
        ? _workers
        : _workers.where((w) => w.skill.toLowerCase().contains(_selectedCategory!.substring(0, 3).toLowerCase())).toList();

    return Column(
      children: [
        if (_selectedCategory != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.green.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filtering: $_selectedCategory', style: const TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => setState(() => _selectedCategory = null),
                  child: const Text('Clear Filter'),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            itemBuilder: (ctx, i) {
              final w = filtered[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.green.shade100,
                            child: Text(w.fullName[0], style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF166534))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(w.fullName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                    const SizedBox(width: 6),
                                    const Icon(Icons.verified, size: 16, color: Colors.blue),
                                  ],
                                ),
                                Text('${w.skill} • ${w.experienceYears} yrs exp', style: TextStyle(color: Colors.grey.shade700, fontSize: 12)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(6)),
                            child: Row(
                              children: [
                                const Icon(Icons.star, size: 14, color: Colors.amber),
                                const SizedBox(width: 4),
                                Text('${w.averageRating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('📍 ${w.location}', style: const TextStyle(fontSize: 12, color: Colors.black87)),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF166534),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () => _showBookingDialog(w),
                            child: const Text('Book Worker'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showBookingDialog(WorkerModel worker) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Book ${worker.fullName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Trade: ${worker.skill}'),
            const SizedBox(height: 8),
            Text('Fair Estimate: ₹249 - ₹350'),
            const SizedBox(height: 8),
            const Text('Cooperative Guarantee: 85% paid directly to worker upon verified completion.'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF166534), foregroundColor: Colors.white),
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await ApiService.createBooking(
                customerId: _currentUser?.customerId ?? 1,
                workerId: worker.workerId,
                serviceId: 1,
                bookingType: 'NORMAL',
                description: 'Mobile App Scheduled Service Booking',
                location: 'Lucknow, UP',
                scheduledDate: 'Tomorrow',
                scheduledTimeSlot: '10:00 AM - 12:00 PM',
              );
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('🎉 Booking created successfully!')),
                );
                _loadInitialData();
              }
            },
            child: const Text('Confirm Booking'),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: _bookings.length,
      itemBuilder: (ctx, i) {
        final b = _bookings[i];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Booking #${b.bookingId}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: b.status == 'COMPLETED' ? Colors.green.shade100 : Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        b.status,
                        style: TextStyle(
                          color: b.status == 'COMPLETED' ? Colors.green.shade800 : Colors.blue.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text('${b.serviceName} with ${b.workerName} (${b.workerSkill})'),
                Text('Scheduled: ${b.scheduledDate} • ${b.scheduledTimeSlot}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const Divider(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total: ₹${b.finalPrice.toInt()} (Worker: ₹${b.workerEarnings.toInt()})', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF166534))),
                    if (b.status != 'COMPLETED' && b.status != 'CANCELLED')
                      TextButton(
                        onPressed: () async {
                          await ApiService.updateBookingStatus(b.bookingId, 'COMPLETED');
                          _loadInitialData();
                        },
                        child: const Text('Mark Complete'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAiAnalyticsTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('🧠 AI Demand Forecasting', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          'ML-driven Scikit-Learn predictions based on seasonal trends, historical booking volume, and local cooperative capacity.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.trending_up, color: Color(0xFF166534)),
                    SizedBox(width: 8),
                    Text('Next 7-Day Surge Forecast', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 12),
                _buildForecastRow('Plumbing Services', '42 requests', 'Deficit: 5 plumbers', Colors.orange),
                _buildForecastRow('Electrical Services', '35 requests', 'Supply: Optimal', Colors.green),
                _buildForecastRow('AC Maintenance', '58 requests', 'Deficit: 12 technicians', Colors.red),
                _buildForecastRow('Home Cleaning', '29 requests', 'Supply: Optimal', Colors.green),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForecastRow(String service, String demand, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(service, style: const TextStyle(fontWeight: FontWeight.w500)),
          Row(
            children: [
              Text(demand, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
                child: Text(status, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
