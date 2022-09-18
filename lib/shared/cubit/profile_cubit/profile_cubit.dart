import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavie_web/shared/cubit/profile_cubit/profile_states.dart';

import '../../../models/profile_data_model.dart';
import '../../../modules/profile_screen/profile_body/personal_information_body.dart';
import '../../api/end_points.dart';
import '../../api/remote/dio_helper.dart';
import '../../components/constants.dart';
import '../../components/reuse_functions.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  // ignore: type_annotate_public_apis
  static ProfileCubit get(context) => BlocProvider.of(context);

  List<String> profileText = [
    "personal information",
    "profile picture",
  ];
  List<Widget> profileBody = [
    const PersonalInformation(),
    const PersonalInformation(),
  ];
  int indexOfProfileTap = 0;

  void changeIndexOfProfileTap(int index) {
    indexOfProfileTap = index;
    emit(AnyState());
  }

  ProfileDataModel? profileDataModel;

  Future<void> getProfileData() async {
    emit(GetProfileDataLoadingState());
    await DioHelper.getData(
      url: currentUserDataEP,
      token: accessTokenConst,
    ).then((value) async {
      profileDataModel = ProfileDataModel.fromJson(value.data);
      emailInfo.text= profileDataModel!.data!.email??'';
      firstNameInfo.text= profileDataModel!.data!.firstName??'';
      lastNameInfo.text= profileDataModel!.data!.lastName??'';
      imageUrlInfo.text= profileDataModel!.data!.imageUrl??'';
      emit(GetProfileDataSuccessState());
    }).catchError((onError) {
      if (kDebugMode) {
        showToast(msg: 'error on get profile');
        printFullText(onError.toString());
      }
      emit(GetProfileDataErrorState(onError.toString()));
    });
  }

  GlobalKey<FormState> personalInfoKey = GlobalKey<FormState>();
  TextEditingController firstNameInfo = TextEditingController();
  TextEditingController lastNameInfo = TextEditingController();
  TextEditingController imageUrlInfo = TextEditingController();
  TextEditingController emailInfo = TextEditingController();

  Future<void> updateProfile() async {
    emit(GetProfileDataLoadingState());
    await DioHelper.patchData(
      endPoint: currentUserDataEP,
      token: accessTokenConst,
      data: {
        "firstName": firstNameInfo.text,
        "lastName": lastNameInfo.text,
        "imageUrl": imageUrlInfo.text,
        "email": emailInfo.text,
      },
    ).then((value) async {
      await getProfileData();
      showToast(msg: 'updated successfully');
    }).catchError((onError) {
      if (kDebugMode) {
        showToast(msg: 'error on get updateProfileName');
        printFullText(onError.toString());
      }
      showToast(msg: 'email may be exist.');
      emit(GetProfileDataErrorState(onError.toString()));
    });
  }
}
