import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:study_material_bank/data/subjects.dart';
import 'package:study_material_bank/utils/animated_page_route.dart';
import 'package:study_material_bank/utils/constants.dart';
import 'package:study_material_bank/screens/pdf_view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({
    Key? key,
    required this.semCode,
    required this.branchCode,
  }) : super(key: key);
  final int semCode;
  final int branchCode;

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  List<String> getSubjects() {
    if (widget.branchCode == 0) {
      switch (widget.semCode) {
        case 3:
          return cseSem3Subs;
        case 4:
          return cseSem4Subs;
        case 5:
          return cseSem5Subs;
        case 6:
          return cseSem6Subs;

        default:
          return [];
      }
    } else if (widget.branchCode == 1) {
      switch (widget.semCode) {
        case 3:
          return eeeSem3Subs;
        case 4:
          return eeeSem4Subs;
        case 5:
          return eeeSem5Subs;
        case 6:
          return eeeSem6Subs;

        default:
          return [];
      }
    }
    return [];
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> listExample() async {
    firebase_storage.ListResult result =
        await firebase_storage.FirebaseStorage.instance.ref().listAll();

    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });

    result.prefixes.forEach((firebase_storage.Reference ref) {
      print('Found directory: $ref');
    });
  }

  Future<String> downloadURLExample(String path) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(path)
        .getDownloadURL();
    return (downloadURL);
  }

  Future openFile(String url, String fileName) async {
    final file = await downloadPDF(url, fileName);
    if (file == null) {
      return;
    }

    print('Path: ${file.path}');
    OpenFile.open(file.path);
  }

  Future<File> downloadPDF(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');

    final response = await Dio().get(
      url,
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0,
      ),
    );

    final downloadedFile = file.openSync(
      mode: FileMode.write,
    );

    downloadedFile.writeFromSync(response.data);

    await downloadedFile.close();

    return file;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listExample();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0E0111,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select Subject",
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: index % 2 == 0 ? kTile1 : kTile2,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            getSubjects()[index],
                            style: GoogleFonts.lemonada(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      // elevation: 20,
                      backgroundColor: Colors.black87,
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                String p =
                                    (widget.branchCode == 0) ? "cse" : "eee";
                                String path =
                                    await downloadURLExample("$p/$p-1.pdf");

                                Navigator.push(
                                  context,
                                  AnimatedPageRoute(
                                    PdfViewScreen(
                                      bodyW: SfPdfViewer.network(path),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 120,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "View",
                                    style: GoogleFonts.lemonada(
                                      fontSize: 15,
                                      // color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                String p =
                                    (widget.branchCode == 0) ? "cse" : "eee";
                                String path =
                                    await downloadURLExample("$p/$p-1.pdf");
                                // TODO: Implement download
                                openFile(path, '$p-1.pdf');
                              },
                              child: Container(
                                width: 120,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Download",
                                    style: GoogleFonts.lemonada(
                                      fontSize: 15,
                                      // color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      title: Center(
                        child: Text(
                          "Choose Action",
                          style: GoogleFonts.iceberg(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.white,
            );
          },
          itemCount: getSubjects().length,
        ),
      ),
    );
  }
}
