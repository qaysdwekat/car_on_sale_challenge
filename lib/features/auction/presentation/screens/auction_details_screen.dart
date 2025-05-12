import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../domain/entities/auction.dart';

class AuctionDetailsScreen extends StatelessWidget {
  final Auction details;

  const AuctionDetailsScreen({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auction Details')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Model:', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    details.model ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  Text('Price:', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    '\$${details.price}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  Text('UUID:', style: Theme.of(context).textTheme.titleMedium),
                  Text(details.externalId ?? '', style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 20),

                  Text('Customer Feedback:', style: Theme.of(context).textTheme.titleMedium),
                  Row(
                    children: [
                      Icon(
                        details.positiveCustomerFeedback == true ? Icons.thumb_up : Icons.thumb_down,
                        color: details.positiveCustomerFeedback == true ? Colors.green : Colors.red,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        details.positiveCustomerFeedback == true ? 'Positive' : 'Negative',
                        style: TextStyle(
                          color: details.positiveCustomerFeedback == true ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffF8C600),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  S.current.dismiss,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
