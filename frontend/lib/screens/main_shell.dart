import 'package:fleet_management_app/screens/obd_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';
import 'vehicles_screen.dart';
import 'gps_map_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int selectedIndex = 0;

  static const _brandBlue = Color(0xFF1A3B5D);
  static const _teal = Color(0xFF2DD4BF);
  static const _darkText = Color(0xFF0F2A40);
  static const _mutedText = Color(0xFFAEC3D6);

  final List<Widget> _pages = [
    const DashboardScreen(),  
    VehiclesScreen(),         
    const GpsMapScreen(),     
    const ObdScreen(),        
  ];

  void _onLogout() {
    context.read<AuthBlock>().add(LogoutButtonPressed());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBlock, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth >= 700;
          return Scaffold(
            body: isWide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSidebar(),
                      Expanded(
                        child: IndexedStack(
                            index: selectedIndex, children: _pages),
                      ),
                    ],
                  )
                : IndexedStack(index: selectedIndex, children: _pages),
            bottomNavigationBar: isWide ? null : _buildBottomNav(),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      selectedItemColor: _brandBlue,
      unselectedItemColor: Colors.grey,
      onTap: (i) {
        if (i == 4) { 
          _onLogout();
        } else {
          setState(() => selectedIndex = i);
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_outlined), label: 'Vehicles'),
        BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined), label: 'GPS'),
        BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined), label: 'OBD'),
        BottomNavigationBarItem(
            icon: Icon(Icons.logout), label: 'Logout'),
      ],
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 220,
      color: _brandBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: _teal,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: const Icon(Icons.local_shipping,
                      size: 20, color: _darkText),
                ),
                const SizedBox(width: 10),
                const Text('Fleet Manager',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 12),
          _navItem(0, Icons.dashboard_outlined, 'Dashboard'),
          _navItem(1, Icons.directions_car_outlined, 'Vehicles'),
          _navItem(2, Icons.map_outlined, 'GPS Map'),
          _navItem(3, Icons.analytics_outlined, 'OBD Monitor'),
          const Spacer(),
          const Divider(color: Colors.white24, height: 1),
          InkWell(
            onTap: _onLogout,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  Icon(Icons.logout, size: 19, color: Color(0xFFF0A6A6)),
                  SizedBox(width: 12),
                  Text('Log out',
                      style:
                          TextStyle(color: Color(0xFFF0A6A6), fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final bool selected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        color: selected ? _teal : Colors.transparent,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: () => setState(() => selectedIndex = index),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
            child: Row(
              children: [
                Icon(icon, size: 19, color: selected ? _darkText : _mutedText),
                const SizedBox(width: 12),
                Text(label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            selected ? FontWeight.w500 : FontWeight.normal,
                        color: selected ? _darkText : _mutedText)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}