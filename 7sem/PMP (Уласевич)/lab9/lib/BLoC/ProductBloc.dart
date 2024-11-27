import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab9/Events/ProductEvent.dart';
import 'package:lab9/Product.dart';
import 'package:lab9/State/ProductState.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<ProductStarted>((event, emit) async {
      emit(ProductLoading());
      await Future.delayed(Duration(seconds: 2));
      emit(ProductLoaded([
        Product(image:   "assets/images/nord_kit.png",
            image2: "assets/images/kit_2.png",
            image3: "assets/images/kit3.png",
            logoImage: "assets/images/nord_kit_photo.png",
            name:   "NORD KIT",
            company: "Smok®",
            cost: "26.90\$",
            firstColor:  "assets/images/nord1.png",
            secondColor: "assets/images/nord2.png",
            thirdColor:  "assets/images/nord3.png",
            fourthColor: "assets/images/nord4.png"),


        Product(image: "assets/images/eleaf.png",
            image2: "assets/images/kit_2.png",
            image3: "assets/images/kit_2.png",
            logoImage: "assets/images/eleaf_photo.png",
            name:   "Tance",
            company: "Eleaf",
            cost: "19.90\$",
            firstColor: "assets/images/tance1.png",
            secondColor: "assets/images/tance2.png",
            thirdColor: "assets/images/tance3.png",
            fourthColor: "assets/images/eleaf4.png"),

        Product(image: "assets/images/novo_2_kit.png",
            image2: "assets/images/kit_2.png",
            image3: "assets/images/kit_2.png",
            logoImage: "assets/images/novo_2_kit_photo.png",
            name:   "NOVO 2 KIT",
            company: "Smok®",
            cost: "25.90\$",
            firstColor: "assets/images/novo1.png",
            secondColor: "assets/images/novo2.png",
            thirdColor: "assets/images/novo3.png",
            fourthColor: "assets/images/novo4.png"),

        Product(image: "assets/images/ego_aio.png",
            image2: "assets/images/kit_2.png",
            image3: "assets/images/kit_2.png",
            logoImage: "assets/images/ego_aio_photo.png",
            name: "EGO AIO",
            company: "Joyetech",
            cost: "19.90\$",
            firstColor: "assets/images/ego1.png",
            secondColor: "assets/images/ego2.png",
            thirdColor: "assets/images/ego3.png",
            fourthColor: "assets/images/ego4.png")
      ]));
    });
  }
}