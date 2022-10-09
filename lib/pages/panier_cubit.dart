import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../product.dart';

part 'panier_state.dart';

class PanierCubit extends Cubit<num> {
  PanierCubit() : super(0);

  void addProdut(Product product) => emit(state + product.price);
  void removeProdut(Product product) => emit(state - product.price);

}
