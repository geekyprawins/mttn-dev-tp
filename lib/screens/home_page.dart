import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
    return Container(
      color: Colors.greenAccent,
    );
  }
}

//  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
//child: SfPdfViewer.network(
//         "https://firebasestorage.googleapis.com/v0/b/mttn-dev-tp.appspot.com/o/dse-1.pdf?alt=media&token=d957816c-a876-4a18-9921-04c3a1c40877",
//         key: _pdfViewerKey,
//       ),
