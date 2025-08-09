import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/welcome_viewmodel.dart';
import '../model/welcome_state.dart';

class JoinFamilyDialog extends ConsumerStatefulWidget {
  const JoinFamilyDialog({super.key});

  @override
  ConsumerState<JoinFamilyDialog> createState() => _JoinFamilyDialogState();
}

class _JoinFamilyDialogState extends ConsumerState<JoinFamilyDialog> {
  final _formKey = GlobalKey<FormState>();
  final _inviteCodeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _inviteCodeController.dispose();
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
      title: const Text('Join a Family'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _inviteCodeController,
              decoration: const InputDecoration(
                labelText: 'Invite Code',
                hintText: 'Enter the 6-digit invite code',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.characters,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an invite code';
                }
                if (value.trim().length != 6) {
                  return 'Invite code must be 6 characters';
                }
                return null;
              },
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            const Text(
              'Ask your family member for the invite code to join their family.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
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
          onPressed: _isLoading ? null : _joinFamily,
          child: _isLoading
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Join'),
        ),
      ],
    );
  }

  void _joinFamily() {
    if (_formKey.currentState!.validate()) {
      ref
          .read(welcomeViewModelProvider.notifier)
          .joinFamily(_inviteCodeController.text.trim().toUpperCase());
    }
  }
}
