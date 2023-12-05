import 'dart:core';

import 'package:paypal_api/constants/app_constants.dart';
import 'package:paypal_api/request/invoice_request.dart';
import 'package:retrofit/http.dart';

import '../models/link.dart';
import '../response/invoice_response.dart';
import 'package:dio/dio.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ApiClient {

  ApiClient(Dio dio);

  @POST('/v2/invoicing/generate-next-invoice-number')
  Future<String> createInvoiceNumber();

  @POST('/v2/invoicing/invoices')
  Future<InvoiceResponse> createInvoice(@Body() InvoiceRequest invoiceRequest);

  @POST('/invoicing/invoices/{invoice_id}/send')
  Future<List<Link>> sendInvoice(
      {@Path('invoice_id') required String invoiceId});
}
