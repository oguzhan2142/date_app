import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/features/profile/model/order_image.dart';
import 'package:frontend/features/profile/provider/profile_repository_provider.dart';
import 'package:frontend/model/auth.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../repository/i_profile_repository.dart';

class PhotosViewModel extends ViewModel {
  PhotosViewModel({required super.context, required super.ref});

  final imagesProvider = StateProvider<List<OrderImage>>((ref) {
    return [];
  });

  late final IProfileRepository profileRepository;

  @override
  void init() {
    profileRepository = ref.read(profileRepositoryProvider);
    _initUserPhotos();
    super.init();
  }

  void _initUserPhotos() {
    profileRepository
        .getUserPhotos(
      userId: Auth.instance!.user.id,
    )
        .then((value) {
      ref.read(imagesProvider.state).state = value
              ?.map((e) => OrderImage(
                    orderImageType: OrderImageType.API,
                    data: e,
                  ))
              .toList() ??
          [];
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

    var images = ref.read(imagesProvider);

    var bytes = await croppedFile?.readAsBytes();

    if (bytes == null) {
      return;
    }

    if (croppedFile == null) {
      return;
    }

    ref.read(imagesProvider.state).state = [
      ...images,
      OrderImage(
        orderImageType: OrderImageType.WILL_UPLOAD,
        data: bytes,
      )
    ];
    var result = await ref.read(profileRepositoryProvider).uploadPhoto(
          userId: Auth.instance!.user.id,
          key: const Uuid().v4(),
          filePath: croppedFile.path,
        );

    if (result == null) {
      ref.read(imagesProvider.state).state = images;
    } else {
      var currentImages = ref.read(imagesProvider);
      var updatedLast = OrderImage(
        orderImageType: OrderImageType.API,
        data: result,
      );

      currentImages[currentImages.length - 1] = updatedLast;
      ref.read(imagesProvider.state).state = currentImages;
    }
  }

  void onIndexChanged(int oldIndex, int newIndex) {
    print('oldIndex : $oldIndex , newIndex: $newIndex');
    var currentImages = ref.read(imagesProvider);
    var imageList = [...currentImages];

    final element = imageList.removeAt(oldIndex);

    imageList.insert(newIndex, element);

    ref.read(imagesProvider.state).state = imageList;

    profileRepository.updateOrder(
      userId: Auth.instance!.user.id,
      index: newIndex,
      key: currentImages[oldIndex].data.key,
    );
  }
}
