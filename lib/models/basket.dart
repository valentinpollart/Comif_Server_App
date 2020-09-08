import 'package:Comif_Server_App/models/product.dart';
import 'package:Comif_Server_App/models/user.dart';

class Basket {
  User client;
  Map<int, int> products;

  Basket({this.client, this.products});
}