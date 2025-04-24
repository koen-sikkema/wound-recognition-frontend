
import 'package:go_router/go_router.dart';
import 'package:wound_recognition_frontend/services/image_picker_service/picked_image.dart';
import '../pages/home_page.dart';
import '../pages/result_page.dart';
import '../constants/app_constants.dart';
import '../pages/upload_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppConstants.HOMEURI,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppConstants.UPLOADURI,
      builder: (context, state) => const UploadPage(),
    ),
    GoRoute(
      path: AppConstants.RESULTURI,
      builder: (context, state){
        final image = state.extra as PickedImage;
        return ResultPage(
          image: image,
          label: ,
          confidence: ,
        )
      }

    ),
  ],
);
