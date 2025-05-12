import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarOnSaleWidget extends StatefulWidget {
  final bool isLoading;
  final String title;
  final String placeholder;
  final String action;
  final Function(String value) onPressed;
  final String? Function(String? value) validator;

  const CarOnSaleWidget({
    super.key,
    required this.isLoading,
    required this.title,
    required this.action,
    required this.placeholder,
    required this.onPressed,
    required this.validator,
  });

  @override
  State<StatefulWidget> createState() => _CarOnSaleState();
}

class _CarOnSaleState extends State<CarOnSaleWidget> {
  late TextEditingController controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      color: Color(0xFF2F323E),
      child: SafeArea(
        bottom: false,
        child: Column(
          spacing: 24,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset('assets/logo/car_on_sale_logo.svg', height: size.height * 0.14),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
                ),
                child: Column(
                  spacing: 24,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controller,
                              autocorrect: false,
                              enableSuggestions: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF2F323E))),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffF8C600), width: 2),
                                ),
                                hintText: widget.placeholder,
                              ),
                              validator: widget.validator,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            final value = controller.text;
                            widget.onPressed(value);
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF8C600),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child:
                            (widget.isLoading)
                                ? CircularProgressIndicator(backgroundColor: Colors.white)
                                : Text(
                                  widget.action,
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                      ),
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
