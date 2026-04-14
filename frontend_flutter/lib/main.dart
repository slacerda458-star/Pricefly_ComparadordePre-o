import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List produtos = [];

  Future<void> buscarProdutos() async {
    var url = Uri.parse('http://localhost:5000/produtos');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        produtos = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    buscarProdutos();
  }

  @override
Widget build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Column(
        children: [
          // 🔝 HEADER
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.white),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text("cadastrar"),
                    ),
                  ],
                ),

                // 🔍 BUSCA
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Buscar produtos...",
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: const Icon(Icons.close),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),

                // 🦉 LOGO
                const Icon(Icons.flutter_dash, color: Colors.white, size: 30),
              ],
            ),
          ),

          // 🛍️ CARROSSEL
          Expanded(
            child: Container(
              color: Colors.grey[300],
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: () {},
                  ),

                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        itemProduto("assets/pc.png"),
                        itemProduto("assets/teclado.png"),
                        itemProduto("assets/cadeira.png"),
                        itemProduto("assets/mouse.png"),
                      ],
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.arrow_forward, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget itemProduto(String imagem) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 150,
          color: Colors.white,
          child: Image.asset(imagem, fit: BoxFit.cover),
        ),
      ),
    );
  }
}