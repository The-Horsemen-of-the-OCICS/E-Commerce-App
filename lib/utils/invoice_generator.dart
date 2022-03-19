import 'dart:io';
import 'package:ecommerceapp/utils/save_to_file.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import '../models/order.dart';

class InvoiceGenerator {
  static Future<void> generate(Order order) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (Context context) => [
        builderForHeader(order),
        SizedBox(height: 3 * PdfPageFormat.cm),
        builderForTitle(order),
        builderForInvoice(order),
        Divider(),
        builderForTotal(order),
      ],
      footer: (context) => builderForFooter(),
    ));

    FileSaveHelper.saveAndLaunchFile(name: 'invoice.pdf', pdf: pdf);
  }

  static Widget builderForHeader(Order order) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress('75 Rue de la République, 75018 Paris'),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: order.id,
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(order),
              buildInvoiceInfo(order),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Order order) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('UserId: ${order.userId}'),
          Text(order.shippingAddress),
        ],
      );

  static Widget buildInvoiceInfo(Order order) {
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      'Payment Terms:',
    ];
    final paymentMethods = 'Online Credit Card';
    final data = <String>[
      order.id,
      order.orderDate,
      paymentMethods,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(String address) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Horseman. Co LTD.',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(address),
        ],
      );

  static Widget builderForTitle(Order order) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text('Invoice shown below is a electronically generated invoice.'),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget builderForInvoice(Order order) {
    final headers = ['Item Name', 'Quantity', 'Unit Price', 'SubTotal'];
    final data = order.cartList.map((cartItem) {
      final subTotal = cartItem.itemPrice * cartItem.quantity;

      return [
        cartItem.name,
        '${cartItem.quantity}',
        '\$ ${cartItem.itemPrice}',
        '\$ ${subTotal.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget builderForTotal(Order order) {
    final netTotal = order.cartList
        .map((cartItem) => cartItem.itemPrice * cartItem.quantity)
        .reduce((item1, item2) => item1 + item2);
    final taxRate = 0.13;
    final tax = netTotal * taxRate;
    final total = netTotal + tax;

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: '\$ ${netTotal.toStringAsFixed(2)}',
                  unite: true,
                ),
                buildText(
                  title: 'Vat ${taxRate * 100} %',
                  value: '\$ ${tax.toStringAsFixed(2)}',
                  unite: true,
                ),
                Divider(),
                buildText(
                  title: 'Total amount',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: '\$ ${total.toStringAsFixed(2)}',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget builderForFooter() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text('Thanks for your order!',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      );

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
