import 'package:danastoreadminpanel/common/widgets/containers/rounded_container.dart';
import 'package:danastoreadminpanel/common/widgets/images/t_rounded_image.dart';
import 'package:danastoreadminpanel/order.dart';
import 'package:danastoreadminpanel/utils/constants/colors.dart';
import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/helpers/pricing_calculator.dart';
import 'package:danastoreadminpanel/utils/constants/image_strings.dart';
import 'package:danastoreadminpanel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatelessWidget {
  const OrderItems({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final subTotal = order.items.fold(0.0, (previousValue, element) => previousValue + (element.price * element.quantity));
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Items', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Items
          // ListView.separated(
          //   shrinkWrap: true,
          //   itemCount: order.items.length,
          //   physics: const NeverScrollableScrollPhysics(),
          //   separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
          //   itemBuilder: (_, index) {
          //     final item = order.items[index];
          //     return Row(
          //       children: [
          //         Expanded(child: Row(
          //           children: [
          //             TRoundedImage(
          //               backgroundColor: TColors.primaryBackground,
          //               imageType: item.image != null ? ImageType.network : ImageType.asset,
          //               image: item.image ?? TImages.defaultImage,
          //             ),
          //               const SizedBox(width: TSizes.spaceBtwItems),
          //               Expanded(child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     item.title,
          //                     style: Theme.of(context).textTheme.titleMedium,
          //                     overflow: TextOverflow.ellipsis,
          //                     maxLines: 1,
          //                   ),
          //                   if (item.selectedVariation != null) Text(item.selectedVariation!.entries.map((e) => ('${e.key} : ${e.value}')).toString())
          //                 ],
          //               ))
          //           ],
          //         )),
          //         const SizedBox(width: TSizes.spaceBtwItems),
          //         SizedBox(
          //           width: TSizes.xl * 2,
          //           child: Text('\$${item.price.toStringAsFixed(1)}', style: Theme.of(context).textTheme.bodyLarge),
          //         ),
          //         SizedBox(
          //           width: TDeviceUtils.isMobileScreen(context) ? TSizes.xl * 1.4 : TSizes.xl * 2,
          //           child: Text(item.quantity.toString(), style: Theme.of(context).textTheme.bodyLarge),
          //         ),
          //         SizedBox(
          //           width: TDeviceUtils.isMobileScreen(context) ? TSizes.xl * 1.4 : TSizes.xl * 2,
          //           child: Text('\$${item.totalAmount}', style: Theme.of(context).textTheme.bodyLarge),
          //         )
          //       ],
          //     );
          //   },
          //   ),
          ListView.separated(
  shrinkWrap: true,
  itemCount: 5, // For demo purposes, you can change this number
  physics: const NeverScrollableScrollPhysics(),
  separatorBuilder: (_, __) => const SizedBox(height: 10), // Example separator
  itemBuilder: (_, index) {
    return Row(
      children: [
        TRoundedImage(
          backgroundColor: Colors.grey.shade300, // Placeholder color for background
          imageType:ImageType.asset, // Example for switching image type
          image: TImages.defaultImage, // Example image URL, replace with actual data
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Item ${index + 1}', // Example text
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('Description for item ${index + 1}'),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Text('\$${(index + 1) * 10}', style: Theme.of(context).textTheme.bodyLarge), // Example price
        const SizedBox(width: 10),
        Text('Qty: ${index + 1}', style: Theme.of(context).textTheme.bodyLarge), // Example quantity
        const SizedBox(width: 10),
        Text('\$${(index + 1) * 10 * (index + 1)}', style: Theme.of(context).textTheme.bodyLarge), // Example total
      ],
    );
  },
),

            const SizedBox(height: TSizes.spaceBtwSections),

            // Items Total
            TRoundedContainer(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              backgroundColor: TColors.primaryBackground,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: Theme.of(context).textTheme.titleLarge),
                      Text('\$$subTotal', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount', style: Theme.of(context).textTheme.titleLarge),
                      Text('\$0.00', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount', style: Theme.of(context).textTheme.titleLarge),
                      Text('\$0.00', style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping',style: Theme.of(context).textTheme.titleLarge),
                      Text(
                        '\$${TPricingCalculator.calculateShippingCost(subTotal, '')}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax', style: Theme.of(context).textTheme.titleLarge,),
                      Text(
                        '\$${TPricingCalculator.calculateTax(subTotal, '')}',style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: Theme.of(context).textTheme.titleLarge),
                     Text(
                        '\$${TPricingCalculator.calculateTotalPrice(subTotal, '')}',style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}