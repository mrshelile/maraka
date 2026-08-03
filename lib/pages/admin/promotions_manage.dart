import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../service/admin_promotion_service.dart';

class PromotionsManagePage extends StatefulWidget {
  final String token;
  const PromotionsManagePage({Key? key, required this.token}) : super(key: key);

  @override
  State<PromotionsManagePage> createState() => _PromotionsManagePageState();
}

class _PromotionsManagePageState extends State<PromotionsManagePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtl = TextEditingController();
  final _linkCtl = TextEditingController();
  final _expireCtl = TextEditingController();
  String _promotionType = 'customizable';
  bool _splash = false;
  bool _home = true;
  File? _pickedImage;
  bool _loading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final x = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (x != null) {
      setState(() => _pickedImage = File(x.path));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_pickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please pick an image')));
      return;
    }

    setState(() => _loading = true);
    try {
      final displayId = await AdminPromotionService.uploadImage(_pickedImage!, widget.token);

      final isoDate = _expireCtl.text; // expect ISO format from user or implement picker
      await AdminPromotionService.createBanner(
        token: widget.token,
        title: _titleCtl.text,
        promotionType: _promotionType,
        link: _linkCtl.text,
        displayId: displayId,
        expireDateIso: isoDate,
        splashscreen: _splash,
        home: _home,
      );

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Promotion created')));
      Navigator.of(context).pop(true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: \\$e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Promotions')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _titleCtl, decoration: const InputDecoration(labelText: 'Title'), validator: (v) => v==null||v.isEmpty? 'Required': null),
              const SizedBox(height: 8),
              TextFormField(controller: _linkCtl, decoration: const InputDecoration(labelText: 'Link (https://...)')),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _promotionType,
                items: const [
                  DropdownMenuItem(value: 'fresh_arrivals', child: Text('Fresh Arrivals')),
                  DropdownMenuItem(value: 'monthend_specials', child: Text('Monthend Specials')),
                  DropdownMenuItem(value: 'customizable', child: Text('Customizable')),
                ],
                onChanged: (v) => setState(() => _promotionType = v ?? 'customizable'),
                decoration: const InputDecoration(labelText: 'Promotion Type'),
              ),
              const SizedBox(height: 8),
              TextFormField(controller: _expireCtl, decoration: const InputDecoration(labelText: 'Expire date (ISO e.g. 2026-12-31T23:59:59Z)')),
              const SizedBox(height: 8),
              SwitchListTile(title: const Text('Splashscreen'), value: _splash, onChanged: (v) => setState(()=>_splash=v)),
              SwitchListTile(title: const Text('Home'), value: _home, onChanged: (v) => setState(()=>_home=v)),
              const SizedBox(height: 12),
              _pickedImage == null ? ElevatedButton.icon(onPressed: _pickImage, icon: const Icon(Icons.photo), label: const Text('Pick Image')) : Column(children: [Image.file(_pickedImage!, height:150), TextButton(onPressed: _pickImage, child: const Text('Change'))]),
              const SizedBox(height: 16),
              _loading ? const Center(child: CircularProgressIndicator()) : ElevatedButton(onPressed: _submit, child: const Text('Create Promotion')),
            ],
          ),
        ),
      ),
    );
  }
}
