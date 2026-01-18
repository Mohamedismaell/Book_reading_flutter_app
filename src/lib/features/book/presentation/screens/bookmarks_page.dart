import 'package:flutter/material.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _areToolsVisible = false;

  void _toggleTools() {
    setState(() {
      _areToolsVisible = !_areToolsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: _toggleTools,
            child: PageView.builder(
              itemBuilder: (context, index) {
                return Center(child: Text("Page Text Here..."));
              },
            ),
          ),

          IgnorePointer(
            ignoring: !_areToolsVisible,
            child: AnimatedOpacity(
              opacity: _areToolsVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: FloatingActionButton(
                onPressed: () {
                  // print("Tool Clicked!");
                },
                child: Icon(Icons.settings),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
