
import 'package:go_router/go_router.dart';
import '../pages/home_page.dart';
import '../pages/result_page.dart';
import '../constants/app_constants.dart';
import '../pages/upload_page.dart';
import '../routes/result_page_args.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppConstants.HOMEROUTE,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppConstants.UPLOADROUTE,
      builder: (context, state) => const UploadPage(),
    ),
    GoRoute(
      path: AppConstants.RESULTROUTE,
      builder: (context, state){
        final args = state.extra as ResultPageArgs;
        return ResultPage(
            image: args.image,
            filename: args.filename
        );
      }
    ),
  ],
);
