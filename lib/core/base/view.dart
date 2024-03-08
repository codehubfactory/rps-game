import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  final bool? isLoading;
  final Widget? body;
  final Widget? floatingActionButton;
  final Color? scaffoldBackgroundColor;
  final BottomNavigationBar? bottomNavigationBar;
  final PreferredSizeWidget? appBar;

  const BaseView({
    super.key,
    this.appBar,
    this.isLoading,
    this.body,
    this.floatingActionButton,
    this.scaffoldBackgroundColor,
    this.bottomNavigationBar,
  });

  @override
  State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.scaffoldBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.floatingActionButton,
      body: (widget.isLoading ?? false) ? const Center(child: CircularProgressIndicator()) : SafeArea(child: widget.body ?? const SizedBox()),
    );
  }
}
