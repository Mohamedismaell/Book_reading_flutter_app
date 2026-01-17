import 'package:bookreading/core/theme/extensions/scaled_text.dart';
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
          // LAYER 1: The Book Content
          // We wrap it in a GestureDetector to catch the "1 click"
          GestureDetector(
            onTap: _toggleTools, // Tapping the page toggles the tool
            child: PageView.builder(
              itemBuilder: (context, index) {
                return Center(child: Text("Page Text Here..."));
              },
            ),
          ),

          // LAYER 2: The "Disappearing Tool" (Bottom Right)
          // We use AnimatedOpacity so it fades in/out smoothly
          IgnorePointer(
            // Important: If it's invisible, don't let it block touches
            ignoring: !_areToolsVisible,
            child: AnimatedOpacity(
              opacity: _areToolsVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 200),
              child: FloatingActionButton(
                onPressed: () {
                  print("Tool Clicked!");
                },
                child: Icon(Icons.settings), // Your tool icon
              ),
            ),
          ),
        ],
      ),
    );
  }
}
