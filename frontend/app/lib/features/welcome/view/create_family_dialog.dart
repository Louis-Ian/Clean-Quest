import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/welcome_viewmodel.dart';
import '../model/welcome_state.dart';

class CreateFamilyDialog extends ConsumerStatefulWidget {
  const CreateFamilyDialog({super.key});

  @override
  ConsumerState<CreateFamilyDialog> createState() => _CreateFamilyDialogState();
}

class _CreateFamilyDialogState extends ConsumerState<CreateFamilyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _familyNameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _familyNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(welcomeViewModelProvider, (previous, next) {
      switch (next) {
        case WelcomeInitial():
          break;
        case WelcomeLoading():
          setState(() => _isLoading = true);
        case WelcomeSuccess(family: final family):
          setState(() => _isLoading = false);
          Navigator.of(context).pop(family);
        case WelcomeError(message: final message):
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return AlertDialog(
      title: const Text('Create a Family'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _familyNameController,
              decoration: const InputDecoration(
                labelText: 'Family Name',
                hintText: 'Enter your family name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a family name';
                }
                if (value.trim().length < 2) {
                  return 'Family name must be at least 2 characters';
                }
                return null;
              },
              enabled: !_isLoading,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _createFamily,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }

  void _createFamily() {
    if (_formKey.currentState!.validate()) {
      ref.read(welcomeViewModelProvider.notifier).createFamily(_familyNameController.text.trim());
    }
  }
}
