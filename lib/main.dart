// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:moonknight/photoview/home_screen.dart';
import 'package:moonknight/simple_browser/main.dart';
import 'package:moonknight/snap/screens/camera.dart';
import 'package:tamannaah/forms/sherlock.dart';
import 'package:tamannaah/ui/mario/mario_test.dart';
import 'charts/main.dart';
import 'package:moonknight/snap/snapapp.dart';
import 'basic_app_2/basic_app2.dart';
import 'clubhouse/clubhouse.dart';
import 'dismissible/main.dart';
import 'firebase_options.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'food_ui/main.dart';
import 'insta/main.dart';
import 'graphic/main.dart';
import 'material3/main.dart';

void main() async {
  // runApp(const Ariana());
  // runApp(AnimPlayground());

  // clubhouse();

  // runApp(MarioTest());

  // runApp(const FoodOrder());

  // runApp(MaterialApp(home: DismissibleSimple()));
  // runApp(const MaterialApp(home: PhotoviewScreen()));

  // runApp(const ProviderScope(child: BasicApp2()));

  // runApp(const ProviderScope(child: BrowserApp()));

  // runApp(const ProviderScope(observers: [StateLogger()], child: GoRouterRiver()));

  // cameraMain();

  // runApp(const MaterialDemo());

  graphicmain();
  // chartsMain();

  // snap();

  // insta();
}

/// - - - - - - - - -
///       [(.)]
/// - - - - - - - - -
/// StateNotifierProvider<AuthStateNotifier, AuthState>
///     AuthStateNotifier()
///         Authenticator()
///             logOut()
///             loginWithFacebook()
///             loginWithGoogle()
///         UserInfoStorage()
///             saveUserInfo()
///
/// Future<ImageWithAspectRatio> thumbnailProvider
/// ThumbnailRequest
/// FileThumbnailView
///
/// PostSetting Enum
/// StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>
///     PostSettingNotifier()
///         setSetting(PostSetting, bool)
///
/// PostPayload
///
/// imageUploaderProvider = StateNotifierProvider<ImageUploadNotifier, IsLoading>
///     ImageUploadNotifier()
///         upload()
///             add thumbnail to firebasestorage
///             add image to firebasestorage
///             add postpayload to firebasefirestore
///
/// allPostsProvider = StreamProvider.autoDispose<Iterable<Post>>
///     FirebaseFirestore listen to posts collection
///
/// specificPostWithCommentsProvider = StreamProvider.family.autoDispose<PostWithComments, RequestForPostAndComments>
///     FirebaseFirestore listen to comments collection
///
/// canCurrentUserDeletePostProvider = StreamProvider.autoDispose.family<bool, Post>
///
/// deletePostProvider = StateNotifierProvider<DeletePostStateNotifier, IsLoading>
///     DeletePostStateNotifier()
///         deletePost()
///             FirebaseStorage delete thumbnail
///             FirebaseStorage delete originalFileStorageId
///             deleteAllComments()
///             deleteAllLikes()
///             deletePost()
///         _deleteAllDocuments()
///             FirebaseFirestore.instance.runTransaction(FirebaseFirestore transaction.delete())
///
/// hasLikedPostProvider = StreamProvider.family.autoDispose<bool, PostId>
///
/// Future<bool> likeDislikePost(LikeDislikePostRef ref, {required LikeDislikeRequest request})
///
/// postCommentsProvider = StreamProvider.family.autoDispose<Iterable<Comment>, RequestForPostAndComments>
///     FirebaseFirestore listen to comments collection
///
/// sendCommentProvider = StateNotifierProvider<SendCommentNotifier, IsLoading>
///
/// postLikesCountProvider = StreamProvider.family.autoDispose<int, PostId>
///
/// - - - - - - - - -
///      [main]
/// - - - - - - - - -
///       ref.listen -> isLoadingProvider -> LoadingScreen
///           authState.isLoading || isUploadingImage || isSendingComment || isDeletingComment || isDeletingPost
///       ref.watch  -> isLoggedInProvider -> (MainView, LoginView)
///           LoginView
///               ref.watch(authStateProvider)
///               ref.read(authStateProvider.notifier).loginWithFacebook
///               ref.read(authStateProvider.notifier).loginWithGoogle
///           MainView
///               -
///                 videoFile = ImagePicker.pickVideoFromGallery()
///                 ref.refresh(postSettingProvider)
///                 push CreateNewPostView(videoFile)
///               -
///                 imageFile = ImagePicker.pickImageFromGallery()
///                 ref.refresh(postSettingProvider)
///                 push CreateNewPostView(imageFile)
///               -
///                 ref.read(authStateProvider.notifier).logOut()
///               -
///                 UserPostsView()
///               -
///                 SearchView()
///               -
///                 HomeView()
///
///           CreateNewPostView
///               final postSettings = ref.watch(postSettingProvider);
///               final postController = useTextEditingController();
///               final isPostButtonEnabled = useState(false);
///               useEffect(() {
///                 void listener() {
///                   isPostButtonEnabled.value = postController.text.isNotEmpty;
///                 }
///
///                 postController.addListener(listener);
///                 return () {
///                   postController.removeListener(listener);
///                 };
///               }, [postController]);
///
///               FileThumbnailView(
///                 thumbnailRequest: thumbnailRequest,
///               ),
///
///               ref.read(userIdProvider)
///               ref.read(imageUploaderProvider.notifier).upload()
///               ref.read(postSettingProvider.notifier).setSetting()
///
///           HomeView
///               final posts = ref.watch(allPostsProvider);
///                   RefreshIndicator(
///                     onRefresh: () {
///                       ref.refresh(allPostsProvider);
///                       return Future.delayed(
///                         const Duration(
///                           seconds: 1,
///                         ),
///                       );
///                     },
///                     child: posts.when(
///                         data: (posts) {
///                             PostsGridView()
///                                 PostDetailsView()
///                                     postWithComments = ref.watch(specificPostWithCommentsProvider())
///                                     canDeletePost = ref.watch(canCurrentUserDeletePostProvider())
///
///                                     postWithComments.when(data: share)
///                                     canDeletePost -> ref.read(deletePostProvider.notifier).deletePost()
///
///                                     ref.read(likeDislikePostProvider(request: likeRequest,),)
///
///                                     PostCommentsView
///                                         ref.watch(postCommentsProvider(request.value))
///                                         RefreshIndicator(ref.refresh(postCommentsProvider))
///                                         ref.read(sendCommentProvider.notifier)
///
///                                         ref.watch(postLikesCountProvider(postId))
///
///           SearchView
///               ref.watch(postsBySearchtermProvider(searchTerm))
///
///           UserPostsView
///
///
///
///
void insta() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'insta',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: InstaApp()));
}
