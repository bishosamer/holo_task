import 'package:flutter/material.dart';

class PdpArgs {
  final int productId;
  const PdpArgs({required this.productId});
}

class PdpPage extends StatelessWidget {
  final PdpArgs args;
  const PdpPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDP')),
      body: Center(
        child: Text('Product details for ID: ${args.productId}'),
      ),
    );
  }
}
