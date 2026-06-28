import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormMahasiswaPage extends StatefulWidget {
  final String apiUrl;
  final Map? data;

  const FormMahasiswaPage({super.key, required this.apiUrl, this.data});

  @override
  State<FormMahasiswaPage> createState() => _FormMahasiswaPageState();
}

class _FormMahasiswaPageState extends State<FormMahasiswaPage> {
  final idController = TextEditingController();
  final namaController = TextEditingController();
  final prodiController = TextEditingController();

  bool get isEdit => widget.data != null;

  @override
  void initState() {
    super.initState();

    if (isEdit) {
      idController.text = widget.data!["id"].toString();

      namaController.text = widget.data!["nama"].toString();

      prodiController.text = widget.data!["prodi"].toString();
    }
  }

  Future<void> simpan() async {
    String url;

    if (isEdit) {
      url =
          "${widget.apiUrl}?action=update&id=${idController.text}&nama=${Uri.encodeComponent(namaController.text)}&prodi=${Uri.encodeComponent(prodiController.text)}";
    } else {
      url =
          "${widget.apiUrl}?action=create&id=${idController.text}&nama=${Uri.encodeComponent(namaController.text)}&prodi=${Uri.encodeComponent(prodiController.text)}";
    }

    final response = await http.get(Uri.parse(url));

    print(response.body);

    if (mounted) {
      Navigator.pop(context);
    }
  }

  InputDecoration inputStyle(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: const Color(0xFF06B6D4)),
      filled: true,
      fillColor: const Color(0xFF1E293B),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF06B6D4), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),

      appBar: AppBar(
        title: Text(isEdit ? "Edit Mahasiswa" : "Tambah Mahasiswa"),
        backgroundColor: const Color(0xFF111827),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFF06B6D4),
                  child: Icon(Icons.person, color: Colors.white, size: 45),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: idController,
                  enabled: !isEdit,
                  style: const TextStyle(color: Colors.white),
                  decoration: inputStyle("ID Mahasiswa", Icons.badge),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: namaController,
                  style: const TextStyle(color: Colors.white),
                  decoration: inputStyle("Nama Mahasiswa", Icons.person),
                ),

                const SizedBox(height: 15),

                TextField(
                  controller: prodiController,
                  style: const TextStyle(color: Colors.white),
                  decoration: inputStyle("Program Studi", Icons.school),
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: simpan,
                    icon: Icon(isEdit ? Icons.update : Icons.save),
                    label: Text(
                      isEdit ? "UPDATE DATA" : "SIMPAN DATA",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06B6D4),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
