import 'package:crypto_coins/repositories/crypto_coins/crypto_coins.dart';
import 'package:flutter/material.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final coinDetail = coin.details;
    return ListTile(
      leading: Image.network(coinDetail.fullImageUrl),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ), // применение стиля bodyMedium к тексту
      subtitle: Text(
        '${coinDetail.priceInUSD} \$',
        style: theme.textTheme.labelSmall,
      ),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/coin',
          arguments: coin, // передача параметра с этого экрана в /coin
        );
      },
    );
  }
}
