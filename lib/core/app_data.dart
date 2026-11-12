import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/core/asset_res.dart';
import 'package:social_media_app_ui/core/models/post_model.dart';
import 'package:social_media_app_ui/core/models/profile_grid_item_model.dart';
import 'package:social_media_app_ui/core/models/profile_model.dart';
import 'package:social_media_app_ui/core/models/story_model.dart';

class AppData {
  static const welcomeAvatars = [AssetRes.welcomeAvatar1, AssetRes.welcomeAvatar2];

  static const stories = [
    StoryModel(name: 'Irma', image: AssetRes.storyIrma, isLive: true),
    StoryModel(name: 'Amanda', image: AssetRes.storyAmanda),
    StoryModel(name: 'Luiz', image: AssetRes.storyLuiz),
    StoryModel(name: 'Nina', image: AssetRes.storyNina),
    StoryModel(name: 'Izaa', image: AssetRes.storyIzaa),
    StoryModel(name: 'Irma', image: AssetRes.storyIrma, isLive: true),
    StoryModel(name: 'Amanda', image: AssetRes.storyAmanda),
    StoryModel(name: 'Luiz', image: AssetRes.storyLuiz),
  ];

  static const posts = [
    PostModel(
      author: 'Alana maesya',
      handle: '@Naisyaatxt',
      avatar: AssetRes.storyIrma,
      image: AssetRes.post1,
      likes: 1245,
      comments: 173,
      shares: 229,
      caption: 'Love your mine #lovetoyou #foryourpage\n#beautifull #popular #peoplefrost',
      aspectRatio: NumberConstant.postAspectRatio,
      isVerified: true,
    ),
    PostModel(
      author: 'Alana maesya',
      handle: '@Naisyaatxt',
      avatar: AssetRes.storyIrma,
      image: AssetRes.post2,
      likes: 1245,
      comments: 173,
      shares: 229,
      caption: '',
      aspectRatio: NumberConstant.postSecondaryAspectRatio,
      isVerified: true,
    ),
    PostModel(
      author: 'Alana maesya',
      handle: '@Naisyaatxt',
      avatar: AssetRes.storyIrma,
      image: AssetRes.post3,
      likes: 1245,
      comments: 173,
      shares: 229,
      caption: 'Love your mine #lovetoyou #foryourpage\n#beautifull #popular #peoplefrost',
      aspectRatio: NumberConstant.postAspectRatio,
      isVerified: true,
    ),
  ];

  static const profile = ProfileModel(
    name: 'Katty Abrahams',
    bio: "I'm delighted to introduce myself as a\nprofessional model 👋",
    avatar: AssetRes.profileAvatar,
    cover: AssetRes.profileCover,
    followers: '567 K',
    followings: '1665',
    posts: '166',
  );

  static const profileGridItems = [
    ProfileGridItemModel(image: AssetRes.grid1, aspectRatio: NumberConstant.profileGridAspectTall),
    ProfileGridItemModel(image: AssetRes.grid2, aspectRatio: NumberConstant.profileGridAspectMedium),
    ProfileGridItemModel(image: AssetRes.grid3, aspectRatio: NumberConstant.profileGridAspectShort),
    ProfileGridItemModel(image: AssetRes.grid4, aspectRatio: NumberConstant.profileGridAspectLower),
  ];
}
