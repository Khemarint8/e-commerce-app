import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/t_rounded_image.dart';
import 'package:danastoreadminpanel/order.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderTransaction extends StatelessWidget {
  const OrderTransaction({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transactions', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Adjust as per your needs 
          Row(
            children: [
              Expanded(
                flex: TDeviceUtils.isMobileScreen(context) ? 2 : 1,
                child: Row(
                  children: [
                    const TRoundedImage(imageType: ImageType.asset, image: TImages.paypal),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payment via ${order.paymentMethod.capitalize}', style: Theme.of(context).textTheme.titleLarge),
                        // Adjust your Payment Method Fee if any 
                        Text('${order.paymentMethod.capitalize} fee \$25', style: Theme.of(context).textTheme.labelMedium),
                      ],
                    ))
                  ],
                ),
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date', style: Theme.of(context).textTheme.labelMedium),
                  Text('April 21 2025', style: Theme.of(context).textTheme.bodyLarge),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}