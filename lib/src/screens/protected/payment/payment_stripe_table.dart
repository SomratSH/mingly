import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mingly/src/components/custom_snackbar.dart';
import 'package:mingly/src/screens/protected/booking_summary/widget/custom_confirm_dialog.dart';
import 'package:mingly/src/screens/protected/event_list_screen/events_provider.dart';
import 'package:provider/provider.dart';

import 'package:webview_flutter/webview_flutter.dart';

class StripePaymentWebViewTable extends StatefulWidget {
  final String? message;
  final String url;
  final void Function()? onSuccess;

  const StripePaymentWebViewTable({
    Key? key,
    required this.url,
    this.onSuccess,
    this.message,
  }) : super(key: key);

  @override
  State<StripePaymentWebViewTable> createState() =>
      _StripePaymentWebViewTableState();
}

class _StripePaymentWebViewTableState extends State<StripePaymentWebViewTable> {
  late final WebViewController _controller;
  bool isLoading = true;
  bool hasShownError = false; // Prevent duplicate error messages

  // Use the actual URL from your backend/Stripe success redirect
  // final String successUrlPattern = 'https://chasethecashsa.com/status=success';
  final String successUrlPattern = "success/";
  final String cancelUrlPattern = "cancel";
  // Professional SnackBar helper methods
  void _showSuccessSnackBar() {
    CustomSnackbar.show(
      context,
      message: "Payment Successful!\nYour table has been sucessfully booked.",
    );
  }

  void _showCancelledSnackBar() {
    CustomSnackbar.show(
      message: 'Payment Cancelled\nYou can try again anytime',
      context,
    );
  }

  @override
  void initState() {
    super.initState();
    print(widget.url);

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) {},
          onPageStarted: (url) {
            if (mounted) {
              setState(() {
                isLoading = true;
                hasShownError = false;
              });
            }
          },
          onPageFinished: (url) {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (error) {
            print("WebView error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            print("Navigation: ${request.url}");

            // ✅ Detect PayFast success
            if (request.url.contains(successUrlPattern)) {
              _showSuccessSnackBar();
              widget.onSuccess?.call();
              Navigator.of(context).pop(true);

              return NavigationDecision.prevent;
            }

            // ✅ Detect PayFast cancel
            if (request.url.contains(cancelUrlPattern)) {
              _showCancelledSnackBar();
              Navigator.of(context).pop(false);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.payment, color: Colors.green),
            SizedBox(width: 12),
            Text(
              'Secure Payment',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black54),
          onPressed: () {
            // Don't show cancellation message if user just closes without starting payment
            if (!isLoading) {
              _showCancelledSnackBar();
            }
            Navigator.of(context).pop(false);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black54),
            onPressed: () {
              _controller.reload();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green,
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Loading Payment Gateway...',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please wait while we connect securely',
                        style: TextStyle(color: Colors.black38, fontSize: 14),
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
}
