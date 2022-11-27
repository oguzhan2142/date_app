import 'package:flutter/material.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/model/auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/i_profile_repository.dart';

class PhotosViewModel extends ViewModel {
  // final imagesProvider = StateProvider<List<OrderImage>>((ref) {
  //   return [];
  // });

  late final IProfileRepository profileRepository;

  PhotosViewModel({required super.context}) {
    _initUserPhotos();
  }

  void _initUserPhotos() {
    profileRepository
        .getUserPhotos(
      userId: Auth.instance!.user.id,
    )
        .then((value) {
      // ref.read(imagesProvider.state).state = value
      //         ?.map((e) => OrderImage(
      //               orderImageType: OrderImageType.API,
      //               data: e,
      //             ))
      //         .toList() ??
      //     [];
    });
  }

  void onTapNewPhoto() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // 7:10 crop
    if (image?.path == null) {
      return;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image!.path,
      aspectRatio: const CropAspectRatio(ratioX: 7, ratioY: 11),
      compressFormat: ImageCompressFormat.png,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Resize',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Resize',
          aspectRatioLockEnabled: true,
        ),
      ],
    );

    // var images = ref.read(imagesProvider);

    var bytes = await croppedFile?.readAsBytes();

    if (bytes == null) {
      return;
    }

    if (croppedFile == null) {
      return;
    }

    // ref.read(imagesProvider.state).state = [
    //   ...images,
    //   OrderImage(
    //     orderImageType: OrderImageType.WILL_UPLOAD,
    //     data: bytes,
    //   )
    // ];
    // var result = await ref.read(profileRepositoryProvider).uploadPhoto(
    //       userId: Auth.instance!.user.id,
    //       key: const Uuid().v4(),
    //       filePath: croppedFile.path,
    //     );

    // if (result == null) {
    //   ref.read(imagesProvider.state).state = images;
    // } else {
    //   var currentImages = ref.read(imagesProvider);
    //   var updatedLast = OrderImage(
    //     orderImageType: OrderImageType.API,
    //     data: result,
    //   );

    //   currentImages[currentImages.length - 1] = updatedLast;
    //   ref.read(imagesProvider.state).state = currentImages;
  }

  void onIndexChanged(int oldIndex, int newIndex) {
    // print('oldIndex : $oldIndex , newIndex: $newIndex');
    // var currentImages = ref.read(imagesProvider);
    // var imageList = [...currentImages];

    // final element = imageList.removeAt(oldIndex);

    // imageList.insert(newIndex, element);

    // ref.read(imagesProvider.state).state = imageList;

    // profileRepository.updateOrder(
    //   userId: Auth.instance!.user.id,
    //   index: newIndex,
    //   key: currentImages[oldIndex].data.key,
    // );
  }

  void onDeletePhoto(String photoId) async {
    // bool isSuccess = await profileRepository.deletePhoto(
    //   userId: Auth.instance!.user.id,
    //   photoId: photoId,
    // );

    // if (isSuccess) {
    //   _initUserPhotos();
    // }
  }
}
