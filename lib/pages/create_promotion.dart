import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maraka/service/promotion_management_service.dart';
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
  File? _image;
  DateTime? _expireDate;
  String _promotionType = 'fresh_arrivals';
  bool _home = true;
  bool _splashscreen = false;
  bool _saving = false;
  String _error = '';

  static const _types = <String, String>{
    'fresh_arrivals': 'Fresh Arrivals',
    'monthend_specials': 'Monthend Specials',
    'customizable': 'Customizable Promo',
  };

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
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

    setState(() {
      _saving = true;
      _error = '';
    });
    try {
      await PromotionManagementService.createPromotion(
        image: _image!,
        title: _titleController.text.trim(),
        promotionType: _promotionType,
        link: _linkController.text.trim(),
        expireDate: _expireDate!,
        home: _home,
        splashscreen: _splashscreen,
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
      appBar: AppBar(title: const Text('Create Promotion')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            OutlinedButton.icon(
              onPressed: _chooseImage,
              icon: const Icon(Icons.image_outlined),
              label: Text(_image == null ? 'Choose flyer image' : 'Image selected'),
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
            DropdownButtonFormField<String>(
              value: _promotionType,
              decoration: const InputDecoration(labelText: 'Promotion type'),
              items: _types.entries
                  .map((entry) => DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _promotionType = value!),
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
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show on Home'),
              value: _home,
              onChanged: (value) => setState(() => _home = value),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show on startup'),
              value: _splashscreen,
              onChanged: (value) => setState(() => _splashscreen = value),
            ),
            if (_error.isNotEmpty)
              Text(_error, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 20),
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
              style: FilledButton.styleFrom(backgroundColor: MyColors.blue3),
            ),
          ],
        ),
      ),
    );
  }
}
