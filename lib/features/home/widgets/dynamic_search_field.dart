//App bar Search field
import 'package:flutter/material.dart';
import 'package:office_book_app/core/app_colors.dart';
import 'package:office_book_app/core/app_enums.dart';
import 'package:office_book_app/features/auth/screens/lock_screen.dart';
import 'package:office_book_app/features/home/providers/app_bar_provider.dart';
import 'package:provider/provider.dart';

class DynamicSearchField extends StatefulWidget {
  const DynamicSearchField({super.key});

  @override
  State<DynamicSearchField> createState() => _DynamicSearchFieldState();
}

class _DynamicSearchFieldState extends State<DynamicSearchField> {
  //Controllers
  final searchFieldController = TextEditingController();

  //Command lists
  final List<Map<String, dynamic>> searchBoxCommands = [
    {
      "command": "/available",
      "status": UserStatus.available,
      "message": "Set your status to available",
    },
    {
      "command": "/away",
      "status": UserStatus.away,
      "message": "Set your status to away",
    },
    {
      "command": "/busy",
      "status": UserStatus.busy,
      "message": "Set your status to busy",
    },
    {
      "command": "/offline",
      "status": UserStatus.offline,
      "message": "Set your status to offline",
    },
    {
      "command": "/lock",
      "status": UserStatus.away,
      "message": "Lock your screen (Status will be set to away)",
    },
    {
      "command": "/signout",
      "status": UserStatus.offline,
      "message": "Signout from the application",
    },
  ];

  List<Map<String, dynamic>> _filteredCommands = [];
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final GlobalKey _fieldKey = GlobalKey();

  void _handleSearchInput() {
    final input = searchFieldController.text;
    if (input.startsWith('/')) {
      final keyword = input.toLowerCase();
      setState(() {
        _filteredCommands =
            searchBoxCommands
                .where((cmd) => cmd['command'].startsWith(keyword))
                .toList();
      });
      _showSuggestionsOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showSuggestionsOverlay() {
    _removeOverlay(); // Remove old if any

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: _getTextFieldWidth(),
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 40),
            child: Material(
              color: Colors.grey[850],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              elevation: 4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCommands.length,
                itemBuilder: (ctx, index) {
                  final cmd = _filteredCommands[index];
                  return ListTile(
                    title: Text(
                      cmd['command'],
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      cmd['message'],
                      style: TextStyle(
                        color: AppColors.textTertiary,
                        fontSize: 13,
                      ),
                    ),
                    onTap: () {
                      searchFieldController.clear();
                      context.read<AppBarProvider>().setUserStatus(
                        cmd['status'],
                      );
                      if (cmd['command'] == '/lock') {
                        //Lock the screen
                        Navigator.popUntil(context, (route) => false);
                        Navigator.pushNamed(context, LockScreen.routeName);
                      }
                      _removeOverlay();
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  double _getTextFieldWidth() {
    final renderBox =
        _fieldKey.currentContext?.findRenderObject() as RenderBox?;
    return renderBox?.size.width ?? 300;
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void initState() {
    searchFieldController.addListener(_handleSearchInput);
    super.initState();
  }

  @override
  void dispose() {
    searchFieldController.removeListener(_handleSearchInput);
    searchFieldController.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _fieldKey,
        child: TextField(
          controller: searchFieldController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            hintText: 'Set Status',
            hintStyle: const TextStyle(color: Color(0xFFB3B3B3)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
