import 'package:test/test.dart';
import 'package:orderly/services/payment_service.dart'; 
import 'package:orderly/services/order_service.dart'; 

void main(){


  test(' Success payment', () {
    final paymentService = PaymentService();
    paymentService.processPayment(paymentId: 'payment1', amountPaid: 100.0, totalOrderPrice: 90);

    expect(paymentService.payments.length, 1);
    expect(paymentService.payments[0].id, 'payment1');
    expect(paymentService.payments[0].amountPaid, 100.0);
    expect(paymentService.payments[0].change, 10);

  });

 
  

  
}
