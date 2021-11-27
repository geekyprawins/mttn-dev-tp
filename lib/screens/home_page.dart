import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_material_bank/screens/semester_screen.dart';
import 'package:study_material_bank/utils/animated_page_route.dart';
import 'package:study_material_bank/data/branches.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0111),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC16EE4),
        centerTitle: true,
        title: Text(
          "Select Branch",
          style: GoogleFonts.iceberg(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              child: branchTiles[index],
              onTap: () {
                Navigator.push(
                  context,
                  AnimatedPageRoute(
                    SemesterScreen(branchCode: index),
                  ),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.white,
            );
          },
          itemCount: branchTiles.length,
        ),
      ),
    );
  }
}
