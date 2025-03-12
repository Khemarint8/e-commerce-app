import 'package:danastoreadminpanel/order.dart';
import 'package:danastoreadminpanel/utils/constants/enums.dart';
import 'package:danastoreadminpanel/utils/constants/helpers/helper_functions.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final RxList<double> weeklySales = <double>[].obs;
  final RxMap<OrderStatus, int> orderStatusData = <OrderStatus, int>{}.obs;
  final RxMap<OrderStatus, double> totalAmounts = <OrderStatus, double>{}.obs;

  static final List<OrderModel> orders = [
    OrderModel(
      id: 'CWT0012',
      status: OrderStatus.processing,
      totalAmount: 265,
      orderDate: DateTime(2025, 2, 10),
      deliveryDate: DateTime(2025, 2, 10),
      items: [],
    ),
    OrderModel(
      id: 'CWT0025',
      status: OrderStatus.shipped,
      totalAmount: 234,
      orderDate: DateTime(2025, 2, 11),
      deliveryDate: DateTime(2025, 2, 11),
      items: [],
    ),
    OrderModel(
      id: 'CWT0043',
      status: OrderStatus.delivered,
      totalAmount: 543,
      orderDate: DateTime(2025, 2, 12),
      deliveryDate: DateTime(2025, 2, 12),
      items: [],
    ),
    OrderModel(
      id: 'CWT0090',
      status: OrderStatus.processing,
      totalAmount: 123,
      orderDate: DateTime(2025, 2, 13),
      deliveryDate: DateTime(2025, 2, 13),
      items: [],
    ),
    OrderModel(
      id: 'CWT0056',
      status: OrderStatus.processing,
      totalAmount: 321,
      orderDate: DateTime(2025, 2, 13),
      deliveryDate: DateTime(2025, 2, 13),
      items: [],
    ),
  ];

  @override
  void onInit() {
    _calculateWeeklySales();
    _calculateOrderStatusData();
    super.onInit();
  }

  // Calculate weekly sales
  void _calculateWeeklySales() {
    // Reset weeklySales to zeros
    weeklySales.value = List<double>.filled(7, 0.0);

    for (var order in orders) {
      final DateTime orderWeekStart =
          THelperFunctions.getStartOfWeek(order.orderDate);

      // Check if the order is within the current week
      if (orderWeekStart.isBefore(DateTime.now()) &&
          orderWeekStart.add(const Duration(days: 7)).isAfter(DateTime.now())) {
        int index = (order.orderDate.weekday - 1) % 7;

        // Ensure the index is non-negative
        index = index < 0 ? index + 7 : index;

        weeklySales[index] += order.totalAmount;

        print(
            'OrderDate: ${order.orderDate}, CurrentWeekDay: $orderWeekStart, Index: $index');
      }
    }

    print('Weekly Sales: $weeklySales');
  }

  // Order status counts
  void _calculateOrderStatusData() {
    // Reset status data
    orderStatusData.clear();

    // Map to store total amounts for each status
    totalAmounts.value = {for (var status in OrderStatus.values) status: 0.0};

    for (var order in orders) {
      // Count Orders
      final status = order.status;
      orderStatusData[status] = (orderStatusData[status] ?? 0) + 1;
      // calculate total amount
      totalAmounts[status] = (totalAmounts[status] ?? 0) + order.totalAmount;
    }
    print("Order Status Data: $orderStatusData");
  }

  String getDisplayStatusName(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }
}
