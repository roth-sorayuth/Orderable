import '../models/payment.dart';


class PaymentService {
  final List<Payment> payments = [];



  Payment processPayment({required String paymentId, required double amountPaid, required double totalOrderPrice}) {

    Payment? payment = _findPaymentOrNull(id: paymentId);  
    if (payment != null) {
      throw Exception('Payment with id $paymentId already exists.');
    }
    if(amountPaid < totalOrderPrice){
      throw Exception('not enough money to pay!');
    }
    double change = amountPaid - totalOrderPrice;
    Payment p = Payment(id: paymentId, amountPaid: amountPaid,change: change);
    payments.add(p);
    return p;
  }



  
  Payment? getPayment({required String paymentId}){
    return _findPaymentOrNull(id: paymentId);
  }


  Payment? _findPaymentOrNull({required String id}) {
    for(Payment p in payments) {
      if (p.id == id) {
        return p;
      }
    }
    return null;
  }
}