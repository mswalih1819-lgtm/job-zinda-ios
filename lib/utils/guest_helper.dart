import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/model/logged_in_user.dart';

/// Returns true if user is a guest (action should be blocked).
/// Shows a login dialog automatically.
bool isGuestUser(BuildContext context) {
  if (LoggedInUser.isGuest) {
    showLoginRequiredDialog(context);
    return true;
  }
  return false;
}

void showLoginRequiredDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 48,
              color: Color(0xFF8A4FFF),
            ),
            const SizedBox(height: 16),
            const Text(
              "Login Required",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "You need to login or create an account to use this feature.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A4FFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(ctx);
                  await LoggedInUser.clearUserData();
                  if (context.mounted) {
                    context.go(PPages.loginWelcomeScreenUi);
                  }
                },
                child: const Text(
                  "Login / Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                "Continue as Guest",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    },
  );
}
