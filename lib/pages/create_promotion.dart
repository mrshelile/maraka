import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/logic/user_logic.dart';
import 'package:maraka/service/promotion_management_service.dart';
import 'package:maraka/themes/background.dart';
import 'package:maraka/themes/color.dart';

class CreatePromotionPage extends StatefulWidget {
  const CreatePromotionPage({super.key});

  @override
  State<CreatePromotionPage> createState() => _CreatePromotionPageState();
}

class _CreatePromotionPageState extends State<CreatePromotionPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _linkController = TextEditingController();
  final _promotionTypeController = TextEditingController();
  File? _image;
  DateTime? _expireDate;
  bool _home = true;
  bool _splashscreen = false;
  bool _saving = false;
  String _error = '';

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    _promotionTypeController.dispose();
    super.dispose();
  }

  Future<void> _chooseImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result?.files.single.path != null) {
      setState(() => _image = File(result!.files.single.path!));
    }
  }

  Future<void> _chooseExpiry() async {
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 730)),
      initialDate: _expireDate ?? DateTime.now().add(const Duration(days: 30)),
    );
    if (selected != null) {
      setState(() => _expireDate = DateTime(
            selected.year,
            selected.month,
            selected.day,
            23,
            59,
            59,
          ));
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    if (_image == null || _expireDate == null) {
      setState(() => _error = 'Choose an image and expiry date.');
      return;
    }

    if (_linkController.text.trim().isEmpty) {
      _linkController.text = 'https://maraka.co.ls';
    }

    setState(() {
      _saving = true;
      _error = '';
    });
    try {
      final user = Get.find<User>();
      final promotionType = _promotionTypeController.text.trim().isEmpty
          ? 'Customizable Promo'
          : _promotionTypeController.text.trim();
      await PromotionManagementService.createPromotion(
        image: _image!,
        title: _titleController.text.trim(),
        promotionType: promotionType,
        link: _linkController.text.trim(),
        expireDate: _expireDate!,
        home: _home,
        splashscreen: _splashscreen,
        owner: user.name ?? user.email,
      );
      if (mounted) {
        Get.back();
        Get.snackbar('Promotion created', 'It is now available in the app.');
      }
    } catch (error) {
      setState(() => _error = 'Could not create promotion.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Promotion'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: MyColors.brown3,
      ),
      body: Stack(
        children: [
          CustomPaint(
            painter: BackgroundDesign(),
            child: Container(),
          ),
          SafeArea(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity( 0.92),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity( 0.16),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create a fresh promotion',
                          style: TextStyle(
                            color: MyColors.brown3,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Add a flyer that will appear in the app and catch attention.',
                          style: TextStyle(
                            color: MyColors.brown3.withOpacity( 0.7),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: _chooseImage,
                          icon: const Icon(Icons.image_outlined),
                          label: Text(
                            _image == null ? 'Choose flyer image' : 'Image selected',
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: MyColors.blue3,
                            side: BorderSide(color: MyColors.blue3.withOpacity( 0.4)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(labelText: 'Promotion title'),
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'Enter a title'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _promotionTypeController,
                          decoration: const InputDecoration(
                            labelText: 'Promotion type',
                            helperText: 'Enter a custom promotion category or name',
                          ),
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'Enter a promotion type'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _linkController,
                          keyboardType: TextInputType.url,
                          decoration: const InputDecoration(labelText: 'Link (optional)'),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          onPressed: _chooseExpiry,
                          icon: const Icon(Icons.event_outlined),
                          label: Text(_expireDate == null
                              ? 'Choose expiry date'
                              : 'Expires ${_expireDate!.toLocal().toString().split(' ').first}'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: MyColors.blue3,
                            side: BorderSide(color: MyColors.blue3.withOpacity( 0.4)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Show on Home'),
                          value: _home,
                          onChanged: (value) => setState(() => _home = value),
                          activeColor: MyColors.blue3,
                        ),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Show on startup'),
                          value: _splashscreen,
                          onChanged: (value) => setState(() => _splashscreen = value),
                          activeColor: MyColors.blue3,
                        ),
                        if (_error.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(_error, style: const TextStyle(color: Colors.red)),
                          ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _saving ? null : _save,
                          icon: _saving
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.publish),
                          label: const Text('Publish promotion'),
                          style: FilledButton.styleFrom(
                            backgroundColor: MyColors.blue3,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
