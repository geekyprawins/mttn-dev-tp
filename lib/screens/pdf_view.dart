import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PdfViewScreen extends StatefulWidget {
  const PdfViewScreen({Key? key, required this.bodyW}) : super(key: key);
  final Widget bodyW;
  @override
  _PdfViewScreenState createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0E0111,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "PDF View",
          style: GoogleFonts.iceberg(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: widget.bodyW,
    );
  }
}
