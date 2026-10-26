// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventContent _$EventContentFromJson(Map<String, dynamic> json) => EventContent(
  chrome: ChromeContent.fromJson(json['chrome'] as Map<String, dynamic>),
  event: EventInfo.fromJson(json['event'] as Map<String, dynamic>),
  navigation: (json['navigation'] as List<dynamic>)
      .map((e) => NavItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  hero: HeroContent.fromJson(json['hero'] as Map<String, dynamic>),
  lineup: LineupContent.fromJson(json['lineup'] as Map<String, dynamic>),
  tagline: TaglineContent.fromJson(json['tagline'] as Map<String, dynamic>),
  location: LocationContent.fromJson(json['location'] as Map<String, dynamic>),
  faq: FaqContent.fromJson(json['faq'] as Map<String, dynamic>),
  footer: FooterContent.fromJson(json['footer'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EventContentToJson(EventContent instance) =>
    <String, dynamic>{
      'chrome': instance.chrome.toJson(),
      'event': instance.event.toJson(),
      'navigation': instance.navigation.map((e) => e.toJson()).toList(),
      'hero': instance.hero.toJson(),
      'lineup': instance.lineup.toJson(),
      'tagline': instance.tagline.toJson(),
      'location': instance.location.toJson(),
      'faq': instance.faq.toJson(),
      'footer': instance.footer.toJson(),
    };

ChromeContent _$ChromeContentFromJson(Map<String, dynamic> json) =>
    ChromeContent(
      brand: json['brand'] as String,
      buyLabel: json['buyLabel'] as String,
      profileImage: json['profileImage'] as String,
      profileAlt: json['profileAlt'] as String,
      openMenuLabel: json['openMenuLabel'] as String,
      closeMenuLabel: json['closeMenuLabel'] as String,
    );

Map<String, dynamic> _$ChromeContentToJson(ChromeContent instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'buyLabel': instance.buyLabel,
      'profileImage': instance.profileImage,
      'profileAlt': instance.profileAlt,
      'openMenuLabel': instance.openMenuLabel,
      'closeMenuLabel': instance.closeMenuLabel,
    };

EventInfo _$EventInfoFromJson(Map<String, dynamic> json) => EventInfo(
  name: json['name'] as String,
  edition: json['edition'] as String,
  startsAt: DateTime.parse(json['startsAt'] as String),
  instagramUrl: json['instagramUrl'] as String,
  instagramHandle: json['instagramHandle'] as String,
  mapsUrl: json['mapsUrl'] as String,
);

Map<String, dynamic> _$EventInfoToJson(EventInfo instance) => <String, dynamic>{
  'name': instance.name,
  'edition': instance.edition,
  'startsAt': instance.startsAt.toIso8601String(),
  'instagramUrl': instance.instagramUrl,
  'instagramHandle': instance.instagramHandle,
  'mapsUrl': instance.mapsUrl,
};

NavItem _$NavItemFromJson(Map<String, dynamic> json) =>
    NavItem(label: json['label'] as String, section: json['section'] as String);

Map<String, dynamic> _$NavItemToJson(NavItem instance) => <String, dynamic>{
  'label': instance.label,
  'section': instance.section,
};

HeroContent _$HeroContentFromJson(Map<String, dynamic> json) => HeroContent(
  badge: json['badge'] as String,
  title: json['title'] as String,
  edition: json['edition'] as String,
  dateLine: json['dateLine'] as String,
  venueLine: json['venueLine'] as String,
  highlightEyebrow: json['highlightEyebrow'] as String,
  highlightName: json['highlightName'] as String,
  highlightSubtitle: json['highlightSubtitle'] as String,
  highlightBadge: json['highlightBadge'] as String,
  quote: json['quote'] as String,
  description: json['description'] as String,
  countdownLabel: json['countdownLabel'] as String,
  countdownUnits: (json['countdownUnits'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  primaryCta: json['primaryCta'] as String,
  secondaryCta: json['secondaryCta'] as String,
  posterImage: json['posterImage'] as String,
  posterAlt: json['posterAlt'] as String,
  posterBadge: json['posterBadge'] as String,
  posterLocationLabel: json['posterLocationLabel'] as String,
  posterLocation: json['posterLocation'] as String,
  posterLocationDetail: json['posterLocationDetail'] as String,
);

Map<String, dynamic> _$HeroContentToJson(HeroContent instance) =>
    <String, dynamic>{
      'badge': instance.badge,
      'title': instance.title,
      'edition': instance.edition,
      'dateLine': instance.dateLine,
      'venueLine': instance.venueLine,
      'highlightEyebrow': instance.highlightEyebrow,
      'highlightName': instance.highlightName,
      'highlightSubtitle': instance.highlightSubtitle,
      'highlightBadge': instance.highlightBadge,
      'quote': instance.quote,
      'description': instance.description,
      'countdownLabel': instance.countdownLabel,
      'countdownUnits': instance.countdownUnits,
      'primaryCta': instance.primaryCta,
      'secondaryCta': instance.secondaryCta,
      'posterImage': instance.posterImage,
      'posterAlt': instance.posterAlt,
      'posterBadge': instance.posterBadge,
      'posterLocationLabel': instance.posterLocationLabel,
      'posterLocation': instance.posterLocation,
      'posterLocationDetail': instance.posterLocationDetail,
    };

LineupContent _$LineupContentFromJson(Map<String, dynamic> json) =>
    LineupContent(
      eyebrow: json['eyebrow'] as String,
      title: json['title'] as String,
      intro: json['intro'] as String,
      headliner: Headliner.fromJson(json['headliner'] as Map<String, dynamic>),
      support: (json['support'] as List<dynamic>)
          .map((e) => SupportArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      soundTitle: json['soundTitle'] as String,
      soundBody: json['soundBody'] as String,
    );

Map<String, dynamic> _$LineupContentToJson(LineupContent instance) =>
    <String, dynamic>{
      'eyebrow': instance.eyebrow,
      'title': instance.title,
      'intro': instance.intro,
      'headliner': instance.headliner.toJson(),
      'support': instance.support.map((e) => e.toJson()).toList(),
      'soundTitle': instance.soundTitle,
      'soundBody': instance.soundBody,
    };

Headliner _$HeadlinerFromJson(Map<String, dynamic> json) => Headliner(
  badge: json['badge'] as String,
  time: json['time'] as String,
  name: json['name'] as String,
  tags: json['tags'] as String,
  bio: json['bio'] as String,
  image: json['image'] as String,
  imageAlt: json['imageAlt'] as String,
  previewTitle: json['previewTitle'] as String,
  previewLive: json['previewLive'] as String,
  previewTrack: json['previewTrack'] as String,
);

Map<String, dynamic> _$HeadlinerToJson(Headliner instance) => <String, dynamic>{
  'badge': instance.badge,
  'time': instance.time,
  'name': instance.name,
  'tags': instance.tags,
  'bio': instance.bio,
  'image': instance.image,
  'imageAlt': instance.imageAlt,
  'previewTitle': instance.previewTitle,
  'previewLive': instance.previewLive,
  'previewTrack': instance.previewTrack,
};

SupportArtist _$SupportArtistFromJson(Map<String, dynamic> json) =>
    SupportArtist(
      time: json['time'] as String,
      name: json['name'] as String,
      style: json['style'] as String,
      image: json['image'] as String,
      imageAlt: json['imageAlt'] as String,
    );

Map<String, dynamic> _$SupportArtistToJson(SupportArtist instance) =>
    <String, dynamic>{
      'time': instance.time,
      'name': instance.name,
      'style': instance.style,
      'image': instance.image,
      'imageAlt': instance.imageAlt,
    };

TaglineContent _$TaglineContentFromJson(Map<String, dynamic> json) =>
    TaglineContent(lead: json['lead'] as String, mark: json['mark'] as String);

Map<String, dynamic> _$TaglineContentToJson(TaglineContent instance) =>
    <String, dynamic>{'lead': instance.lead, 'mark': instance.mark};

LocationContent _$LocationContentFromJson(Map<String, dynamic> json) =>
    LocationContent(
      eyebrow: json['eyebrow'] as String,
      title: json['title'] as String,
      body: (json['body'] as List<dynamic>)
          .map((e) => TextRun.fromJson(e as Map<String, dynamic>))
          .toList(),
      mapImage: json['mapImage'] as String,
      mapAlt: json['mapAlt'] as String,
      mapTitle: json['mapTitle'] as String,
      mapSubtitle: json['mapSubtitle'] as String,
      mapCta: json['mapCta'] as String,
      notes: (json['notes'] as List<dynamic>)
          .map((e) => InfoNote.fromJson(e as Map<String, dynamic>))
          .toList(),
      dressLabel: json['dressLabel'] as String,
      dressTitle: json['dressTitle'] as String,
      dressChip: json['dressChip'] as String,
    );

Map<String, dynamic> _$LocationContentToJson(LocationContent instance) =>
    <String, dynamic>{
      'eyebrow': instance.eyebrow,
      'title': instance.title,
      'body': instance.body.map((e) => e.toJson()).toList(),
      'mapImage': instance.mapImage,
      'mapAlt': instance.mapAlt,
      'mapTitle': instance.mapTitle,
      'mapSubtitle': instance.mapSubtitle,
      'mapCta': instance.mapCta,
      'notes': instance.notes.map((e) => e.toJson()).toList(),
      'dressLabel': instance.dressLabel,
      'dressTitle': instance.dressTitle,
      'dressChip': instance.dressChip,
    };

InfoNote _$InfoNoteFromJson(Map<String, dynamic> json) => InfoNote(
  icon: json['icon'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
);

Map<String, dynamic> _$InfoNoteToJson(InfoNote instance) => <String, dynamic>{
  'icon': instance.icon,
  'title': instance.title,
  'body': instance.body,
};

FaqContent _$FaqContentFromJson(Map<String, dynamic> json) => FaqContent(
  eyebrow: json['eyebrow'] as String,
  title: json['title'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => FaqItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  supportTitle: json['supportTitle'] as String,
  supportBody: json['supportBody'] as String,
  supportCta: json['supportCta'] as String,
);

Map<String, dynamic> _$FaqContentToJson(FaqContent instance) =>
    <String, dynamic>{
      'eyebrow': instance.eyebrow,
      'title': instance.title,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'supportTitle': instance.supportTitle,
      'supportBody': instance.supportBody,
      'supportCta': instance.supportCta,
    };

FaqItem _$FaqItemFromJson(Map<String, dynamic> json) => FaqItem(
  id: json['id'] as String,
  question: json['question'] as String,
  answer: json['answer'] as String,
  initiallyExpanded: json['initiallyExpanded'] as bool,
);

Map<String, dynamic> _$FaqItemToJson(FaqItem instance) => <String, dynamic>{
  'id': instance.id,
  'question': instance.question,
  'answer': instance.answer,
  'initiallyExpanded': instance.initiallyExpanded,
};

FooterContent _$FooterContentFromJson(Map<String, dynamic> json) =>
    FooterContent(
      quote: json['quote'] as String,
      about: json['about'] as String,
      navTitle: json['navTitle'] as String,
      newsletterTitle: json['newsletterTitle'] as String,
      newsletterBody: json['newsletterBody'] as String,
      newsletterPlaceholder: json['newsletterPlaceholder'] as String,
      newsletterCta: json['newsletterCta'] as String,
      newsletterNote: json['newsletterNote'] as String,
      newsletterInvalid: json['newsletterInvalid'] as String,
      newsletterPending: json['newsletterPending'] as String,
      legal: json['legal'] as String,
      links: (json['links'] as List<dynamic>)
          .map((e) => FooterLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FooterContentToJson(FooterContent instance) =>
    <String, dynamic>{
      'quote': instance.quote,
      'about': instance.about,
      'navTitle': instance.navTitle,
      'newsletterTitle': instance.newsletterTitle,
      'newsletterBody': instance.newsletterBody,
      'newsletterPlaceholder': instance.newsletterPlaceholder,
      'newsletterCta': instance.newsletterCta,
      'newsletterNote': instance.newsletterNote,
      'newsletterInvalid': instance.newsletterInvalid,
      'newsletterPending': instance.newsletterPending,
      'legal': instance.legal,
      'links': instance.links.map((e) => e.toJson()).toList(),
    };

FooterLink _$FooterLinkFromJson(Map<String, dynamic> json) => FooterLink(
  label: json['label'] as String,
  section: json['section'] as String?,
);

Map<String, dynamic> _$FooterLinkToJson(FooterLink instance) =>
    <String, dynamic>{'label': instance.label, 'section': instance.section};

TextRun _$TextRunFromJson(Map<String, dynamic> json) => TextRun(
  text: json['text'] as String,
  emphasis: json['emphasis'] as String?,
);

Map<String, dynamic> _$TextRunToJson(TextRun instance) => <String, dynamic>{
  'text': instance.text,
  'emphasis': instance.emphasis,
};
