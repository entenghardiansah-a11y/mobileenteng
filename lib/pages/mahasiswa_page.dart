import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../form_mahasiswa_page.dart';

class MahasiswaPage extends StatefulWidget {
  const MahasiswaPage({super.key});

  @override
  State<MahasiswaPage> createState() => _MahasiswaPageState();
}

class _MahasiswaPageState extends State<MahasiswaPage> {
  List mahasiswa = [];

  final String apiUrl =
      "https://script.google.com/macros/s/AKfycbx73uQOILA09ys0i3NWRTzi5_5Uduf_LHSt3LHBQ3lpCB7BYkjtelmjhstHZ-hyhWTMzw/exec";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final response = await http.get(Uri.parse(apiUrl));

    setState(() {
      mahasiswa = jsonDecode(response.body);
    });
  }

  Future<void> hapusData(String id) async {
    final url = "$apiUrl?action=delete&id=$id";

    await http.get(Uri.parse(url));

    getData();
  }

  void konfirmasiHapus(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text("Konfirmasi", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Yakin ingin menghapus data?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await hapusData(id);
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        title: const Text("Data Mahasiswa"),
        centerTitle: true,
        backgroundColor: const Color(0xFF111827),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF06B6D4),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormMahasiswaPage(apiUrl: apiUrl),
            ),
          );
          getData();
        },
      ),

      body: mahasiswa.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF06B6D4)),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: mahasiswa.length,
              itemBuilder: (context, index) {
                return Card(
                  color: const Color(0xFF1E293B),
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),

                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF06B6D4),
                      child: Text(
                        mahasiswa[index]["id"].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    title: Text(
                      mahasiswa[index]["nama"].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      mahasiswa[index]["prodi"].toString(),
                      style: const TextStyle(color: Colors.white70),
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xFF3B82F6),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FormMahasiswaPage(
                                  apiUrl: apiUrl,
                                  data: mahasiswa[index],
                                ),
                              ),
                            );

                            getData();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            konfirmasiHapus(mahasiswa[index]["id"].toString());
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
