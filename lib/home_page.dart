import 'package:flutter/material.dart';
import 'pages/mahasiswa_page.dart';
import 'form_mahasiswa_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String apiUrl =
      "https://script.google.com/macros/s/AKfycbx73uQOILA09ys0i3NWRTzi5_5Uduf_LHSt3LHBQ3lpCB7BYkjtelmjhstHZ-hyhWTMzw/exec";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: const Color(0xFF111827),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF06B6D4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.school,
                        size: 55,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Aplikasi Data Mahasiswa",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Flutter + Google Sheet Database",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  _menuCard(
                    context,
                    "Data Mahasiswa",
                    Icons.people,
                    const Color(0xFF3B82F6),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const MahasiswaPage(),
                        ),
                      );
                    },
                  ),

                  _menuCard(
                    context,
                    "Tambah Data",
                    Icons.person_add,
                    const Color(0xFF06B6D4),
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => FormMahasiswaPage(apiUrl: apiUrl),
                        ),
                      );
                    },
                  ),

                  _menuCard(
                    context,
                    "Informasi",
                    Icons.info,
                    const Color(0xFFF59E0B),
                    () {
                      showAboutDialog(
                        context: context,
                        applicationName: "Database Mahasiswa",
                        applicationVersion: "1.0",
                        children: const [
                          Text(
                            "Aplikasi CRUD Flutter dengan Google Sheet sebagai database online.",
                          ),
                        ],
                      );
                    },
                  ),

                  _menuCard(
                    context,
                    "Logout",
                    Icons.logout,
                    const Color(0xFFEF4444),
                    () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Card(
                color: const Color(0xFF1E293B),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Tentang Aplikasi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Aplikasi ini dibuat menggunakan Flutter dan Google Sheet sebagai database online untuk implementasi CRUD (Create, Read, Update, Delete).",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: onTap,
      child: Card(
        color: const Color(0xFF1E293B),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
