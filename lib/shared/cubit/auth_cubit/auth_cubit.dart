import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/shared/components/constants.dart';
import 'package:lavie_web/shared/components/reuse_functions.dart';
import 'package:lavie_web/shared/cubit/auth_cubit/auth_states.dart';
import 'package:lavie_web/shared/cubit/cubit.dart';
import 'package:lavie_web/shared/cubit/forums_cubit/forums_cubit.dart';
import 'package:lavie_web/shared/cubit/products_cubit/products_cubit.dart';
import 'package:lavie_web/shared/cubit/profile_cubit/profile_cubit.dart';

import '../../../models/login_model.dart';
import '../../api/end_points.dart';
import '../../api/google_auth.dart';
import '../../api/local/app_box.dart';
import '../../api/remote/dio_helper.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  // ignore: type_annotate_public_apis
  static AuthCubit get(context) => BlocProvider.of(context);

  int indexOfTap = 1;

  void changeIndexOfTap(int index) {
    indexOfTap = index;
    emit(AnyState());
  }

  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    emit(AnyState());
  }

  // login
  GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  LoginModel? loginModel;

  Future<void> loginFun() async {
    emit(LoginLoadingState());
    await DioHelper.postData(
      endPoint: loginEP,
      data: {
        "email": loginEmailController.text,
        "password": loginPasswordController.text
      },
    ).then((value) async {
      loginModel = LoginModel.fromJson(value.data);
      await boxSaveLogin();
      emit(LoginSuccessState());
      //login
      loginPasswordController.clear();
      loginEmailController.clear();
    }).catchError((onError) {
      if (onError.toString().contains('Http status error [400]')) {
        showToast(msg: 'incorrect email or password');
      }
      printFullText(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }

  //sign up
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();

  Future<void> signUpFun() async {
    emit(SignUpLoadingState());
    await DioHelper.postData(
      endPoint: signUpEP,
      data: {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "email": signUpEmailController.text,
        "password": signUpPasswordController.text,
      },
    ).then((value) async {
      loginModel = LoginModel.fromJson(value.data);
      await boxSaveLogin();
      emit(SignUpSuccessState());
      //sign up
      firstNameController.clear();
      lastNameController.clear();
      signUpEmailController.clear();
      signUpPasswordController.clear();
      signUpConfirmPasswordController.clear();
    }).catchError((onError) {
      if (onError.toString().contains('Http status error [409]')) {
        showToast(msg: 'email already exists');
      } else if (onError.toString().contains('Http status error [400]')) {
        showToast(msg: 'enter valid email address');
      }
      emit(LoginErrorState(onError.toString()));
    });
  }

  // TODO: function to save tokens and user id after login
  Future<void> boxSaveLogin() async {
    accessTokenConst = loginModel!.data!.accessToken;
    refreshTokenConst = loginModel!.data!.refreshToken;
    userIdConst = loginModel!.data!.user!.userId;
    AppBox.box.put(accessTokenBox, loginModel!.data!.accessToken);
    AppBox.box.put(refreshTokenBox, loginModel!.data!.refreshToken);
    AppBox.box.put(userIdBox, loginModel!.data!.user!.userId);
  }

  void logout(BuildContext context) {
    //app box
    AppBox.box.delete(accessTokenBox);
    AppBox.box.delete(refreshTokenBox);
    indexOfTap = 1;
    // AppCubit
    final appCubit = AppCubit.get(context);
    appCubit.currentIndexOfBottom = 0;
    // ProfileCubit
    final profileCubit = ProfileCubit.get(context);
    profileCubit.profileDataModel = null;
    // ProductsCubit
    final productCubit = ProductsCubit.get(context);
    productCubit.clearAllProductLists();
    productCubit.productsModel = null;
    productCubit.listOfDataCart.clear();
    productCubit.cartCount.clear();
    productCubit.totalCart = 0;
    // ForumsCubit
    ForumsCubit.get(context).clearForumsCubit();
    emit(AnyState());
  }

  Future<void> googleLoginFun() async {
    await GoogleSignInApi.login().then((value) async {
      // to get first and last name
      final fullName = value!.displayName;
      final names = fullName!.split(' ');
      final firstName = names[0];
      final lastName = names[1];
      emit(LoginLoadingState());
      await DioHelper.postData(
        endPoint: authGoogleEP,
        data: {
          "id": value.id,
          "email": value.email,
          "firstName": firstName,
          "lastName": lastName,
          "picture": "${value.photoUrl}"
        },
      ).then((value) async {
        loginModel = LoginModel.fromJson(value.data);
        await boxSaveLogin();
        emit(LoginSuccessState());
      }).catchError((onError) {
        if (onError.toString().contains('Http status error [400]')) {
          showToast(msg: 'incorrect email or password');
        }
        emit(LoginErrorState(onError.toString()));
      });
    }).catchError((onError) {
      printFullText( onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }
}
