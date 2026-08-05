///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$en app = Translations$app$en.internal(_root);
	late final Translations$checkIn$en checkIn = Translations$checkIn$en.internal(_root);
	late final Translations$consumption$en consumption = Translations$consumption$en.internal(_root);
	late final Translations$context$en context = Translations$context$en.internal(_root);
	late final Translations$emotion$en emotion = Translations$emotion$en.internal(_root);
	late final Translations$export$en export = Translations$export$en.internal(_root);
	late final Translations$goal$en goal = Translations$goal$en.internal(_root);
	late final Translations$harvest$en harvest = Translations$harvest$en.internal(_root);
	late final Translations$home$en home = Translations$home$en.internal(_root);
	late final Translations$journal$en journal = Translations$journal$en.internal(_root);
	late final Translations$learning$en learning = Translations$learning$en.internal(_root);
	late final Translations$learningModules$en learningModules = Translations$learningModules$en.internal(_root);
	late final Translations$licenses$en licenses = Translations$licenses$en.internal(_root);
	late final Translations$locale$en locale = Translations$locale$en.internal(_root);
	late final Translations$navigation$en navigation = Translations$navigation$en.internal(_root);
	late final Translations$notifications$en notifications = Translations$notifications$en.internal(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
	late final Translations$outcome$en outcome = Translations$outcome$en.internal(_root);
	late final Translations$period$en period = Translations$period$en.internal(_root);
	late final Translations$progress$en progress = Translations$progress$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$strategy$en strategy = Translations$strategy$en.internal(_root);
	late final Translations$theme$en theme = Translations$theme$en.internal(_root);
	late final Translations$trigger$en trigger = Translations$trigger$en.internal(_root);
	late final Translations$urge$en urge = Translations$urge$en.internal(_root);
}

// Path: app
class Translations$app$en {
	Translations$app$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'StopCorn'
	String get name => 'StopCorn';

	/// en: 'StopCorn corn cob logo'
	String get logoSemantics => 'StopCorn corn cob logo';

	/// en: 'this content'
	String get urgeCueSemantics => 'this content';

	/// en: 'Loading…'
	String get loading => 'Loading…';

	/// en: 'Try again'
	String get retry => 'Try again';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Continue'
	String get continueLabel => 'Continue';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Back to home'
	String get backHome => 'Back to home';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Saving…'
	String get saving => 'Saving…';

	/// en: 'No selection'
	String get noChoice => 'No selection';

	/// en: 'Unknown'
	String get unknown => 'Unknown';

	/// en: '$count min'
	String minutes({required Object count}) => '${count} min';

	/// en: 'StopCorn is not a medical tool. It does not diagnose and cannot replace a health professional. If this behavior causes severe distress, persistent loss of control, or significant consequences in your life, talking to a qualified professional may help.'
	String get notMedicalDisclaimer => 'StopCorn is not a medical tool. It does not diagnose and cannot replace a health professional. If this behavior causes severe distress, persistent loss of control, or significant consequences in your life, talking to a qualified professional may help.';

	late final Translations$app$technicalDetails$en technicalDetails = Translations$app$technicalDetails$en.internal(_root);
	late final Translations$app$splash$en splash = Translations$app$splash$en.internal(_root);
	late final Translations$app$score$en score = Translations$app$score$en.internal(_root);

	/// en: 'Module #$order'
	String moduleNumber({required Object order}) => 'Module #${order}';
}

// Path: checkIn
class Translations$checkIn$en {
	Translations$checkIn$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Daily check-in'
	String get title => 'Daily check-in';

	late final Translations$checkIn$intro$en intro = Translations$checkIn$intro$en.internal(_root);
	late final Translations$checkIn$mood$en mood = Translations$checkIn$mood$en.internal(_root);
	late final Translations$checkIn$control$en control = Translations$checkIn$control$en.internal(_root);
	late final Translations$checkIn$urge$en urge = Translations$checkIn$urge$en.internal(_root);
	late final Translations$checkIn$consumption$en consumption = Translations$checkIn$consumption$en.internal(_root);
	late final Translations$checkIn$sleep$en sleep = Translations$checkIn$sleep$en.internal(_root);
	late final Translations$checkIn$note$en note = Translations$checkIn$note$en.internal(_root);
	late final Translations$checkIn$saved$en saved = Translations$checkIn$saved$en.internal(_root);
	late final Translations$checkIn$error$en error = Translations$checkIn$error$en.internal(_root);
}

// Path: consumption
class Translations$consumption$en {
	Translations$consumption$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Record a consumption'
	String get title => 'Record a consumption';

	/// en: 'A few details are enough. You can skip every optional question.'
	String get intro => 'A few details are enough. You can skip every optional question.';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Time'
	String get time => 'Time';

	late final Translations$consumption$factors$en factors = Translations$consumption$factors$en.internal(_root);
	late final Translations$consumption$control$en control = Translations$consumption$control$en.internal(_root);
	late final Translations$consumption$context$en context = Translations$consumption$context$en.internal(_root);
	late final Translations$consumption$contextualGoal$en contextualGoal = Translations$consumption$contextualGoal$en.internal(_root);
	late final Translations$consumption$note$en note = Translations$consumption$note$en.internal(_root);
	late final Translations$consumption$saved$en saved = Translations$consumption$saved$en.internal(_root);
	late final Translations$consumption$edit$en edit = Translations$consumption$edit$en.internal(_root);
	late final Translations$consumption$error$en error = Translations$consumption$error$en.internal(_root);
}

// Path: context
class Translations$context$en {
	Translations$context$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Late in the evening'
	String get lateEvening => 'Late in the evening';

	/// en: 'In the bedroom'
	String get bedroom => 'In the bedroom';

	/// en: 'Home alone'
	String get homeAlone => 'Home alone';

	/// en: 'After using social media'
	String get afterSocialMedia => 'After using social media';

	/// en: 'During a stressful period'
	String get duringStress => 'During a stressful period';
}

// Path: emotion
class Translations$emotion$en {
	Translations$emotion$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Calm'
	String get calm => 'Calm';

	/// en: 'Boredom'
	String get bored => 'Boredom';

	/// en: 'Stress'
	String get stressed => 'Stress';

	/// en: 'Loneliness'
	String get lonely => 'Loneliness';

	/// en: 'Sad'
	String get sad => 'Sad';

	/// en: 'Angry'
	String get angry => 'Angry';

	/// en: 'Anxiety'
	String get anxious => 'Anxiety';

	/// en: 'Tired'
	String get tired => 'Tired';

	/// en: 'Excited'
	String get excited => 'Excited';

	/// en: 'Frustration'
	String get frustrated => 'Frustration';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: export
class Translations$export$en {
	Translations$export$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Export my data'
	String get title => 'Export my data';

	/// en: 'I understand that this file may be sensitive'
	String get confirm => 'I understand that this file may be sensitive';

	/// en: 'Back to settings'
	String get backSettings => 'Back to settings';

	/// en: 'The export could not be created. No data was sent.'
	String get error => 'The export could not be created. No data was sent.';

	late final Translations$export$warning$en warning = Translations$export$warning$en.internal(_root);
	late final Translations$export$create$en create = Translations$export$create$en.internal(_root);
	late final Translations$export$share$en share = Translations$export$share$en.internal(_root);
}

// Path: goal
class Translations$goal$en {
	Translations$goal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$goal$abstinence$en abstinence = Translations$goal$abstinence$en.internal(_root);
	late final Translations$goal$reduction$en reduction = Translations$goal$reduction$en.internal(_root);
	late final Translations$goal$contextual$en contextual = Translations$goal$contextual$en.internal(_root);
	late final Translations$goal$observation$en observation = Translations$goal$observation$en.internal(_root);
}

// Path: harvest
class Translations$harvest$en {
	Translations$harvest$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Harvest'
	String get label => 'Harvest';

	/// en: 'What's this?'
	String get explanationAction => 'What\'s this?';

	late final Translations$harvest$cornPoints$en cornPoints = Translations$harvest$cornPoints$en.internal(_root);
	late final Translations$harvest$momentum$en momentum = Translations$harvest$momentum$en.internal(_root);
	late final Translations$harvest$reward$en reward = Translations$harvest$reward$en.internal(_root);
	late final Translations$harvest$sheet$en sheet = Translations$harvest$sheet$en.internal(_root);
}

// Path: home
class Translations$home$en {
	Translations$home$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$home$load$en load = Translations$home$load$en.internal(_root);
	late final Translations$home$sections$en sections = Translations$home$sections$en.internal(_root);
	late final Translations$home$goal$en goal = Translations$home$goal$en.internal(_root);
	late final Translations$home$checkIn$en checkIn = Translations$home$checkIn$en.internal(_root);
	late final Translations$home$urge$en urge = Translations$home$urge$en.internal(_root);
	late final Translations$home$strategy$en strategy = Translations$home$strategy$en.internal(_root);
	late final Translations$home$metrics$en metrics = Translations$home$metrics$en.internal(_root);
	late final Translations$home$actions$en actions = Translations$home$actions$en.internal(_root);
	late final Translations$home$learningRecommendation$en learningRecommendation = Translations$home$learningRecommendation$en.internal(_root);
}

// Path: journal
class Translations$journal$en {
	Translations$journal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$journal$history$en history = Translations$journal$history$en.internal(_root);
	late final Translations$journal$edit$en edit = Translations$journal$edit$en.internal(_root);
	late final Translations$journal$delete$en delete = Translations$journal$delete$en.internal(_root);
	late final Translations$journal$error$en error = Translations$journal$error$en.internal(_root);
}

// Path: learning
class Translations$learning$en {
	Translations$learning$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Six short modules, available offline and without diagnosis.'
	String get subtitle => 'Six short modules, available offline and without diagnosis.';

	/// en: 'Learning modules'
	String get semantics => 'Learning modules';

	late final Translations$learning$evidence$en evidence = Translations$learning$evidence$en.internal(_root);
	late final Translations$learning$sources$en sources = Translations$learning$sources$en.internal(_root);
	late final Translations$learning$module$en module = Translations$learning$module$en.internal(_root);
	late final Translations$learning$status$en status = Translations$learning$status$en.internal(_root);
	late final Translations$learning$reading$en reading = Translations$learning$reading$en.internal(_root);
	late final Translations$learning$reflection$en reflection = Translations$learning$reflection$en.internal(_root);
	late final Translations$learning$completion$en completion = Translations$learning$completion$en.internal(_root);
	late final Translations$learning$error$en error = Translations$learning$error$en.internal(_root);
}

// Path: learningModules
class Translations$learningModules$en {
	Translations$learningModules$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$learningModules$continueAfterSetback$en continueAfterSetback = Translations$learningModules$continueAfterSetback$en.internal(_root);
	late final Translations$learningModules$mapTerrain$en mapTerrain = Translations$learningModules$mapTerrain$en.internal(_root);
	late final Translations$learningModules$prepareEnvironment$en prepareEnvironment = Translations$learningModules$prepareEnvironment$en.internal(_root);
	late final Translations$learningModules$rideUrge$en rideUrge = Translations$learningModules$rideUrge$en.internal(_root);
	late final Translations$learningModules$understandLoop$en understandLoop = Translations$learningModules$understandLoop$en.internal(_root);
	late final Translations$learningModules$whyChange$en whyChange = Translations$learningModules$whyChange$en.internal(_root);
}

// Path: licenses
class Translations$licenses$en {
	Translations$licenses$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Open-source licenses'
	String get title => 'Open-source licenses';

	/// en: 'StopCorn uses open-source components. Select an entry to read its license text.'
	String get intro => 'StopCorn uses open-source components. Select an entry to read its license text.';

	/// en: 'Licenses could not be loaded.'
	String get loadError => 'Licenses could not be loaded.';

	/// en: 'Other component'
	String get otherComponent => 'Other component';
}

// Path: locale
class Translations$locale$en {
	Translations$locale$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'App language'
	String get label => 'App language';

	/// en: 'English'
	String get english => 'English';

	/// en: 'French'
	String get french => 'French';

	late final Translations$locale$section$en section = Translations$locale$section$en.internal(_root);
}

// Path: navigation
class Translations$navigation$en {
	Translations$navigation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$navigation$home$en home = Translations$navigation$home$en.internal(_root);

	/// en: 'Progress'
	String get progress => 'Progress';

	/// en: 'Learn'
	String get learn => 'Learn';

	/// en: 'Settings'
	String get settings => 'Settings';
}

// Path: notifications
class Translations$notifications$en {
	Translations$notifications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$notifications$dailyCheckIn$en dailyCheckIn = Translations$notifications$dailyCheckIn$en.internal(_root);
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Setup'
	String get pageTitle => 'Setup';

	/// en: 'Step $current of $total'
	String step({required Object current, required Object total}) => 'Step ${current} of ${total}';

	late final Translations$onboarding$welcome$en welcome = Translations$onboarding$welcome$en.internal(_root);
	late final Translations$onboarding$goal$en goal = Translations$onboarding$goal$en.internal(_root);
	late final Translations$onboarding$baseline$en baseline = Translations$onboarding$baseline$en.internal(_root);
	late final Translations$onboarding$strategies$en strategies = Translations$onboarding$strategies$en.internal(_root);
	late final Translations$onboarding$privacy$en privacy = Translations$onboarding$privacy$en.internal(_root);

	/// en: 'Start'
	String get start => 'Start';

	/// en: 'Finish setup'
	String get finish => 'Finish setup';

	late final Translations$onboarding$error$en error = Translations$onboarding$error$en.internal(_root);
	late final Translations$onboarding$validation$en validation = Translations$onboarding$validation$en.internal(_root);
}

// Path: outcome
class Translations$outcome$en {
	Translations$outcome$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The urge passed'
	String get passed => 'The urge passed';

	/// en: 'It decreased'
	String get reduced => 'It decreased';

	/// en: 'I will wait'
	String get delayed => 'I will wait';

	/// en: 'I will consume'
	String get consumed => 'I will consume';

	/// en: 'I prefer to stop this flow now'
	String get abandoned => 'I prefer to stop this flow now';
}

// Path: period
class Translations$period$en {
	Translations$period$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '7 days'
	String get sevenDays => '7 days';

	/// en: '30 days'
	String get thirtyDays => '30 days';

	/// en: '90 days'
	String get ninetyDays => '90 days';

	/// en: 'All'
	String get all => 'All';
}

// Path: progress
class Translations$progress$en {
	Translations$progress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Descriptive markers built only from what you chose to record.'
	String get subtitle => 'Descriptive markers built only from what you chose to record.';

	late final Translations$progress$error$en error = Translations$progress$error$en.internal(_root);
	late final Translations$progress$overview$en overview = Translations$progress$overview$en.internal(_root);
	late final Translations$progress$events$en events = Translations$progress$events$en.internal(_root);
	late final Translations$progress$urges$en urges = Translations$progress$urges$en.internal(_root);
	late final Translations$progress$patterns$en patterns = Translations$progress$patterns$en.internal(_root);
	late final Translations$progress$strategies$en strategies = Translations$progress$strategies$en.internal(_root);
	late final Translations$progress$checkIns$en checkIns = Translations$progress$checkIns$en.internal(_root);
	late final Translations$progress$comparison$en comparison = Translations$progress$comparison$en.internal(_root);
	late final Translations$progress$startingPoint$en startingPoint = Translations$progress$startingPoint$en.internal(_root);

	/// en: 'Harvest'
	String get harvest => 'Harvest';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$settings$support$en support = Translations$settings$support$en.internal(_root);
	late final Translations$settings$appearance$en appearance = Translations$settings$appearance$en.internal(_root);
	late final Translations$settings$reminders$en reminders = Translations$settings$reminders$en.internal(_root);
	late final Translations$settings$progress$en progress = Translations$settings$progress$en.internal(_root);
	late final Translations$settings$personalPlan$en personalPlan = Translations$settings$personalPlan$en.internal(_root);
	late final Translations$settings$data$en data = Translations$settings$data$en.internal(_root);
	late final Translations$settings$developer$en developer = Translations$settings$developer$en.internal(_root);
	late final Translations$settings$about$en about = Translations$settings$about$en.internal(_root);
	late final Translations$settings$goalEditor$en goalEditor = Translations$settings$goalEditor$en.internal(_root);
	late final Translations$settings$error$en error = Translations$settings$error$en.internal(_root);
}

// Path: strategy
class Translations$strategy$en {
	Translations$strategy$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Put the phone out of reach'
	String get putPhoneAway => 'Put the phone out of reach';

	/// en: 'Leave the room'
	String get leaveRoom => 'Leave the room';

	/// en: 'Walk for five minutes'
	String get walkFiveMinutes => 'Walk for five minutes';

	/// en: 'Breathe slowly for 90 seconds'
	String get slowBreathing => 'Breathe slowly for 90 seconds';

	/// en: 'Drink a glass of water and change activity'
	String get waterAndSwitch => 'Drink a glass of water and change activity';

	/// en: 'Message someone you chose'
	String get messageSomeone => 'Message someone you chose';

	/// en: 'Start a two-minute task'
	String get twoMinuteTask => 'Start a two-minute task';

	/// en: 'Take a shower'
	String get takeShower => 'Take a shower';

	/// en: 'Wait ten minutes before deciding'
	String get waitTenMinutes => 'Wait ten minutes before deciding';

	/// en: 'Personal strategy'
	String get personal => 'Personal strategy';

	/// en: 'A simple action to try when you need support.'
	String get genericDescription => 'A simple action to try when you need support.';

	/// en: '(one) {Suggested timer: $count second.} (other) {Suggested timer: $count seconds.}'
	String timerSeconds({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Suggested timer: ${count} second.',
		other: 'Suggested timer: ${count} seconds.',
	);

	/// en: '(one) {Suggested timer: $count minute.} (other) {Suggested timer: $count minutes.}'
	String timerMinutes({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Suggested timer: ${count} minute.',
		other: 'Suggested timer: ${count} minutes.',
	);
}

// Path: theme
class Translations$theme$en {
	Translations$theme$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Follow system'
	String get system => 'Follow system';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';
}

// Path: trigger
class Translations$trigger$en {
	Translations$trigger$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Boredom'
	String get boredom => 'Boredom';

	/// en: 'Stress'
	String get stress => 'Stress';

	/// en: 'Loneliness'
	String get loneliness => 'Loneliness';

	/// en: 'Tiredness'
	String get fatigue => 'Tiredness';

	/// en: 'Habit'
	String get habit => 'Habit';

	/// en: 'Arousal'
	String get arousal => 'Arousal';

	/// en: 'Social media'
	String get socialMedia => 'Social media';

	/// en: 'Relationship difficulty'
	String get relationshipDifficulty => 'Relationship difficulty';

	/// en: 'Alcohol or another substance'
	String get alcoholOrSubstance => 'Alcohol or another substance';

	/// en: 'Phone in bed'
	String get bedtimePhone => 'Phone in bed';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: urge
class Translations$urge$en {
	Translations$urge$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Take a break'
	String get pauseTitle => 'Take a break';

	/// en: 'Leave'
	String get quit => 'Leave';

	late final Translations$urge$support$en support = Translations$urge$support$en.internal(_root);
	late final Translations$urge$grounding$en grounding = Translations$urge$grounding$en.internal(_root);
	late final Translations$urge$strategy$en strategy = Translations$urge$strategy$en.internal(_root);
	late final Translations$urge$result$en result = Translations$urge$result$en.internal(_root);
	late final Translations$urge$complete$en complete = Translations$urge$complete$en.internal(_root);
	late final Translations$urge$intensity$en intensity = Translations$urge$intensity$en.internal(_root);
	late final Translations$urge$factors$en factors = Translations$urge$factors$en.internal(_root);
	late final Translations$urge$timer$en timer = Translations$urge$timer$en.internal(_root);
	late final Translations$urge$error$en error = Translations$urge$error$en.internal(_root);
}

// Path: app.technicalDetails
class Translations$app$technicalDetails$en {
	Translations$app$technicalDetails$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show technical details'
	String get show => 'Show technical details';

	/// en: 'Hide technical details'
	String get hide => 'Hide technical details';
}

// Path: app.splash
class Translations$app$splash$en {
	Translations$app$splash$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Preparing StopCorn…'
	String get preparing => 'Preparing StopCorn…';

	/// en: 'StopCorn could not start. Your data was not changed.'
	String get error => 'StopCorn could not start. Your data was not changed.';
}

// Path: app.score
class Translations$app$score$en {
	Translations$app$score$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Optional — not answered'
	String get unanswered => 'Optional — not answered';

	/// en: '$value / 10'
	String outOfTen({required Object value}) => '${value} / 10';

	/// en: 'Clear $label'
	String clear({required Object label}) => 'Clear ${label}';

	/// en: '$label: not answered'
	String unansweredSemantics({required Object label}) => '${label}: not answered';

	/// en: '$label: $value out of 10'
	String answeredSemantics({required Object label, required Object value}) => '${label}: ${value} out of 10';
}

// Path: checkIn.intro
class Translations$checkIn$intro$en {
	Translations$checkIn$intro$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A quick marker, in under a minute.'
	String get create => 'A quick marker, in under a minute.';

	/// en: 'Edit today's check-in.'
	String get edit => 'Edit today\'s check-in.';
}

// Path: checkIn.mood
class Translations$checkIn$mood$en {
	Translations$checkIn$mood$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mood'
	String get label => 'Mood';

	/// en: '0 = very difficult, 10 = very good'
	String get scale => '0 = very difficult, 10 = very good';
}

// Path: checkIn.control
class Translations$checkIn$control$en {
	Translations$checkIn$control$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sense of control'
	String get label => 'Sense of control';

	/// en: '0 = no control, 10 = complete control'
	String get scale => '0 = no control, 10 = complete control';
}

// Path: checkIn.urge
class Translations$checkIn$urge$en {
	Translations$checkIn$urge$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Approximate number of urges (optional)'
	String get count => 'Approximate number of urges (optional)';

	/// en: 'Example: 3'
	String get hint => 'Example: 3';

	/// en: 'The number cannot be negative.'
	String get negative => 'The number cannot be negative.';
}

// Path: checkIn.consumption
class Translations$checkIn$consumption$en {
	Translations$checkIn$consumption$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {$count consumption event recorded on that day.} (other) {$count consumption events recorded on that day.}'
	String recorded({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} consumption event recorded on that day.',
		other: '${count} consumption events recorded on that day.',
	);

	/// en: 'No consumption event recorded on that day.'
	String get none => 'No consumption event recorded on that day.';
}

// Path: checkIn.sleep
class Translations$checkIn$sleep$en {
	Translations$checkIn$sleep$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sleep quality (optional)'
	String get label => 'Sleep quality (optional)';

	/// en: '0 = very poor, 10 = excellent'
	String get scale => '0 = very poor, 10 = excellent';
}

// Path: checkIn.note
class Translations$checkIn$note$en {
	Translations$checkIn$note$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Optional note'
	String get label => 'Optional note';

	/// en: 'What stood out today…'
	String get hint => 'What stood out today…';
}

// Path: checkIn.saved
class Translations$checkIn$saved$en {
	Translations$checkIn$saved$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Check-in saved.'
	String get title => 'Check-in saved.';

	/// en: 'These markers will help you observe trends over time.'
	String get body => 'These markers will help you observe trends over time.';
}

// Path: checkIn.error
class Translations$checkIn$error$en {
	Translations$checkIn$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The daily check-in could not be loaded.'
	String get load => 'The daily check-in could not be loaded.';

	/// en: 'Unable to save right now. Try again in a moment.'
	String get save => 'Unable to save right now. Try again in a moment.';
}

// Path: consumption.factors
class Translations$consumption$factors$en {
	Translations$consumption$factors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Contributing factors (optional)'
	String get label => 'Contributing factors (optional)';

	/// en: 'Trigger'
	String get trigger => 'Trigger';

	/// en: 'Emotion'
	String get emotion => 'Emotion';
}

// Path: consumption.control
class Translations$consumption$control$en {
	Translations$consumption$control$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sense of control (optional)'
	String get label => 'Sense of control (optional)';

	/// en: '0 = no control, 10 = complete control'
	String get scale => '0 = no control, 10 = complete control';
}

// Path: consumption.context
class Translations$consumption$context$en {
	Translations$consumption$context$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Very short context (optional)'
	String get label => 'Very short context (optional)';

	/// en: 'Example: alone in the evening'
	String get hint => 'Example: alone in the evening';

	/// en: 'Keep it general: no website, search, or explicit detail.'
	String get description => 'Keep it general: no website, search, or explicit detail.';
}

// Path: consumption.contextualGoal
class Translations$consumption$contextualGoal$en {
	Translations$consumption$contextualGoal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your protected contexts'
	String get title => 'Your protected contexts';

	/// en: 'Select any context from your current goal that applied. This makes that goal visible in your progress without replacing the optional note below.'
	String get description => 'Select any context from your current goal that applied. This makes that goal visible in your progress without replacing the optional note below.';

	/// en: 'Contexts from my goal (optional)'
	String get label => 'Contexts from my goal (optional)';
}

// Path: consumption.note
class Translations$consumption$note$en {
	Translations$consumption$note$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Optional note'
	String get label => 'Optional note';

	/// en: 'A helpful marker for later…'
	String get hint => 'A helpful marker for later…';
}

// Path: consumption.saved
class Translations$consumption$saved$en {
	Translations$consumption$saved$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'It's saved.'
	String get title => 'It\'s saved.';

	/// en: 'The goal is to better understand the situation, not to judge yourself.'
	String get body => 'The goal is to better understand the situation, not to judge yourself.';
}

// Path: consumption.edit
class Translations$consumption$edit$en {
	Translations$consumption$edit$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Correct this consumption'
	String get title => 'Correct this consumption';
}

// Path: consumption.error
class Translations$consumption$error$en {
	Translations$consumption$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The form could not be prepared.'
	String get load => 'The form could not be prepared.';

	/// en: 'Unable to save right now. Try again in a moment.'
	String get save => 'Unable to save right now. Try again in a moment.';

	/// en: 'This consumption no longer exists.'
	String get missingEvent => 'This consumption no longer exists.';
}

// Path: export.warning
class Translations$export$warning$en {
	Translations$export$warning$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Before continuing'
	String get title => 'Before continuing';

	/// en: 'The JSON file may contain sensitive personal information: notes, goals, and observations you chose to record.'
	String get sensitive => 'The JSON file may contain sensitive personal information: notes, goals, and observations you chose to record.';

	/// en: 'StopCorn never sends it automatically. Once created, only the system share sheet will open.'
	String get share => 'StopCorn never sends it automatically. Once created, only the system share sheet will open.';
}

// Path: export.create
class Translations$export$create$en {
	Translations$export$create$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create and open sharing'
	String get action => 'Create and open sharing';

	/// en: 'Creating file…'
	String get progress => 'Creating file…';
}

// Path: export.share
class Translations$export$share$en {
	Translations$export$share$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'StopCorn data export'
	String get subject => 'StopCorn data export';

	/// en: 'StopCorn export'
	String get title => 'StopCorn export';
}

// Path: goal.abstinence
class Translations$goal$abstinence$en {
	Translations$goal$abstinence$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Stop'
	String get title => 'Stop';

	/// en: 'I want to stop consuming.'
	String get description => 'I want to stop consuming.';
}

// Path: goal.reduction
class Translations$goal$reduction$en {
	Translations$goal$reduction$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reduce'
	String get title => 'Reduce';

	/// en: 'I want to gradually reduce the frequency.'
	String get description => 'I want to gradually reduce the frequency.';
}

// Path: goal.contextual
class Translations$goal$contextual$en {
	Translations$goal$contextual$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Avoid certain contexts'
	String get title => 'Avoid certain contexts';

	/// en: 'I want to regain control in certain situations.'
	String get description => 'I want to regain control in certain situations.';
}

// Path: goal.observation
class Translations$goal$observation$en {
	Translations$goal$observation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Observe first'
	String get title => 'Observe first';

	/// en: 'I want to understand my habits before setting a target.'
	String get description => 'I want to understand my habits before setting a target.';
}

// Path: harvest.cornPoints
class Translations$harvest$cornPoints$en {
	Translations$harvest$cornPoints$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Corn points'
	String get title => 'Corn points';

	/// en: 'Today's corn point is collected.'
	String get todayCollected => 'Today\'s corn point is collected.';

	/// en: 'One constructive action is enough to collect today's corn point.'
	String get todayAvailable => 'One constructive action is enough to collect today\'s corn point.';
}

// Path: harvest.momentum
class Translations$harvest$momentum$en {
	Translations$harvest$momentum$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Momentum'
	String get title => 'Momentum';

	/// en: '(one) {Current momentum: $count day in a row.} (other) {Current momentum: $count days in a row.}'
	String currentMomentum({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Current momentum: ${count} day in a row.',
		other: 'Current momentum: ${count} days in a row.',
	);

	/// en: '(one) {Best momentum: $count day in a row.} (other) {Best momentum: $count days in a row.}'
	String bestMomentum({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Best momentum: ${count} day in a row.',
		other: 'Best momentum: ${count} days in a row.',
	);

	/// en: 'Corn point collected on this day'
	String get dayCollected => 'Corn point collected on this day';

	/// en: 'No corn point collected on this day'
	String get dayNotCollected => 'No corn point collected on this day';

	/// en: 'Upcoming day'
	String get dayUpcoming => 'Upcoming day';
}

// Path: harvest.reward
class Translations$harvest$reward$en {
	Translations$harvest$reward$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Corn point collected!'
	String get title => 'Corn point collected!';

	/// en: 'Your constructive action moves your harvest forward.'
	String get body => 'Your constructive action moves your harvest forward.';

	/// en: '$gain Corn point added. New total: $total.'
	String pointsSemantics({required Object gain, required Object total}) => '${gain} Corn point added. New total: ${total}.';

	/// en: '(one) {Momentum increased by $gain. New momentum: $total day.} (other) {Momentum increased by $gain. New momentum: $total days.}'
	String momentumSemantics({required num total, required Object gain}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(total,
		one: 'Momentum increased by ${gain}. New momentum: ${total} day.',
		other: 'Momentum increased by ${gain}. New momentum: ${total} days.',
	);

	/// en: '+$count'
	String gain({required Object count}) => '+${count}';

	/// en: 'Continue'
	String get continueAction => 'Continue';
}

// Path: harvest.sheet
class Translations$harvest$sheet$en {
	Translations$harvest$sheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How does the harvest work?'
	String get title => 'How does the harvest work?';

	/// en: 'The harvest highlights actions that help you move forward. It does not measure abstinence and never judges the outcome of a day.'
	String get intro => 'The harvest highlights actions that help you move forward. It does not measure abstinence and never judges the outcome of a day.';

	/// en: 'You can collect at most one corn point per day. One constructive action is enough.'
	String get onePerDay => 'You can collect at most one corn point per day. One constructive action is enough.';

	/// en: 'Completing a support flow counts, whatever its outcome.'
	String get urge => 'Completing a support flow counts, whatever its outcome.';

	/// en: 'Completing a daily check-in counts.'
	String get checkIn => 'Completing a daily check-in counts.';

	/// en: 'Honestly recording consumption also counts: honesty is never penalized.'
	String get observation => 'Honestly recording consumption also counts: honesty is never penalized.';

	/// en: 'Completing a learning module counts.'
	String get learning => 'Completing a learning module counts.';

	/// en: 'Creating or updating your goal counts.'
	String get goal => 'Creating or updating your goal counts.';

	/// en: 'What about momentum?'
	String get momentumTitle => 'What about momentum?';

	/// en: 'Momentum is the number of cultivated days in a row. The current day remains a grace period. If momentum ends, your harvest never shrinks and every corn point remains yours.'
	String get momentumBody => 'Momentum is the number of cultivated days in a row. The current day remains a grace period. If momentum ends, your harvest never shrinks and every corn point remains yours.';
}

// Path: home.load
class Translations$home$load$en {
	Translations$home$load$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Today's data could not be loaded.'
	String get error => 'Today\'s data could not be loaded.';
}

// Path: home.sections
class Translations$home$sections$en {
	Translations$home$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Metrics'
	String get metrics => 'Metrics';

	/// en: 'Last 30 days'
	String get lastThirtyDays => 'Last 30 days';

	/// en: 'Quick actions'
	String get quickActions => 'Quick actions';
}

// Path: home.goal
class Translations$home$goal$en {
	Translations$home$goal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Goal'
	String get title => 'Goal';

	/// en: 'Goal to be defined'
	String get undefined => 'Goal to be defined';

	/// en: '(one) {Desired limit: $count event per week.} (other) {Desired limit: $count events per week.}'
	String weeklyLimit({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Desired limit: ${count} event per week.',
		other: 'Desired limit: ${count} events per week.',
	);

	/// en: 'Protected contexts: $contexts.'
	String contexts({required Object contexts}) => 'Protected contexts: ${contexts}.';
}

// Path: home.checkIn
class Translations$home$checkIn$en {
	Translations$home$checkIn$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Daily check-in'
	String get title => 'Daily check-in';

	/// en: 'Daily check-in recorded.'
	String get completed => 'Daily check-in recorded.';

	/// en: 'Daily check-in available whenever you want. Tap to record.'
	String get available => 'Daily check-in available whenever you want.\nTap to record.';

	late final Translations$home$checkIn$action$en action = Translations$home$checkIn$action$en.internal(_root);
}

// Path: home.urge
class Translations$home$urge$en {
	Translations$home$urge$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Urges today'
	String get today => 'Urges today';

	/// en: '(zero) {No urge recorded today.} (one) {$count urge recorded today.} (other) {$count urges recorded today.}'
	TextSpan count({required num count, required InlineSpan Function(num) countBuilder}) => RichPluralResolvers.bridge(
		n: count,
		resolver: _root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'),
		zero: () => TextSpan(children: [
			const TextSpan(text: 'No urge recorded today.'),
		]),
		one: () => TextSpan(children: [
			countBuilder(count),
			const TextSpan(text: ' urge recorded today.'),
		]),
		other: () => TextSpan(children: [
			countBuilder(count),
			const TextSpan(text: ' urges recorded today.'),
		]),
	);

	/// en: 'I feel an urge to view content, take a break'
	String get semantics => 'I feel an urge to view content, take a break';

	/// en: 'I need $corn'
	TextSpan action({required InlineSpan corn}) => TextSpan(children: [
		const TextSpan(text: 'I need '),
		corn,
	]);

	/// en: 'Take a break'
	String get subtitle => 'Take a break';
}

// Path: home.strategy
class Translations$home$strategy$en {
	Translations$home$strategy$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Last helpful strategy'
	String get lastHelpful => 'Last helpful strategy';
}

// Path: home.metrics
class Translations$home$metrics$en {
	Translations$home$metrics$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {day without a recorded consumption event} (other) {days without a recorded consumption event}'
	String daysWithout({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'day without a recorded consumption event',
		other: 'days without a recorded consumption event',
	);

	/// en: '(one) {urge moved through or reduced} (other) {urges moved through or reduced}'
	String traversedUrges({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'urge moved through or reduced',
		other: 'urges moved through or reduced',
	);

	/// en: 'average reported rate control'
	String get averageControl => 'average reported rate control';

	/// en: 'Your first observations will appear here. You do not need to record everything perfectly: a few markers are enough to begin.'
	String get empty => 'Your first observations will appear here. You do not need to record everything perfectly: a few markers are enough to begin.';
}

// Path: home.actions
class Translations$home$actions$en {
	Translations$home$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Open my journal'
	String get openJournal => 'Open my journal';

	/// en: 'Record a consumption event'
	String get logConsumption => 'Record a consumption event';

	/// en: 'Review my plan'
	String get reviewPlan => 'Review my plan';
}

// Path: home.learningRecommendation
class Translations$home$learningRecommendation$en {
	Translations$home$learningRecommendation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Up next'
	String get title => 'Up next';

	/// en: 'Continue reading'
	String get action => 'Continue reading';
}

// Path: journal.history
class Translations$journal$history$en {
	Translations$journal$history$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Journal'
	String get title => 'Journal';

	/// en: 'Find the consumption events, support sessions, and daily check-ins you chose to record, grouped by date.'
	String get intro => 'Find the consumption events, support sessions, and daily check-ins you chose to record, grouped by date.';

	/// en: 'The journal could not be loaded.'
	String get error => 'The journal could not be loaded.';

	late final Translations$journal$history$empty$en empty = Translations$journal$history$empty$en.internal(_root);
	late final Translations$journal$history$date$en date = Translations$journal$history$date$en.internal(_root);
	late final Translations$journal$history$entry$en entry = Translations$journal$history$entry$en.internal(_root);
	late final Translations$journal$history$details$en details = Translations$journal$history$details$en.internal(_root);
}

// Path: journal.edit
class Translations$journal$edit$en {
	Translations$journal$edit$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Correct'
	String get action => 'Correct';
}

// Path: journal.delete
class Translations$journal$delete$en {
	Translations$journal$delete$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete'
	String get action => 'Delete';

	/// en: 'Delete this entry?'
	String get title => 'Delete this entry?';

	/// en: 'This entry and its private note will be permanently removed from your journal. Your statistics will be recalculated without it.'
	String get consumption => 'This entry and its private note will be permanently removed from your journal. Your statistics will be recalculated without it.';

	/// en: 'This daily check-in and its private note will be permanently removed from your journal. Your statistics will be recalculated without it.'
	String get checkIn => 'This daily check-in and its private note will be permanently removed from your journal. Your statistics will be recalculated without it.';

	/// en: 'This support session and the reflection written at the end will be permanently removed. The strategy tried during it stops counting; a consumption event recorded from it is kept.'
	String get urge => 'This support session and the reflection written at the end will be permanently removed. The strategy tried during it stops counting; a consumption event recorded from it is kept.';

	/// en: 'This cannot be undone.'
	String get irreversible => 'This cannot be undone.';

	/// en: 'Delete permanently'
	String get confirm => 'Delete permanently';
}

// Path: journal.error
class Translations$journal$error$en {
	Translations$journal$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This entry could not be deleted. Nothing was changed.'
	String get delete => 'This entry could not be deleted. Nothing was changed.';
}

// Path: learning.evidence
class Translations$learning$evidence$en {
	Translations$learning$evidence$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What informs these modules?'
	String get title => 'What informs these modules?';

	/// en: 'Evidence and limitations'
	String get sheetTitle => 'Evidence and limitations';

	/// en: 'Each module cites peer-reviewed research supporting general principles about motivation, habits, self-control, mindfulness, or self-compassion.'
	String get principles => 'Each module cites peer-reviewed research supporting general principles about motivation, habits, self-control, mindfulness, or self-compassion.';

	/// en: 'These sources do not clinically validate StopCorn. Some concern general behavior or smoking, and pornography-specific studies can involve limited samples. The modules provide cautious educational guidance, not a diagnosis or treatment.'
	String get limitations => 'These sources do not clinically validate StopCorn. Some concern general behavior or smoking, and pornography-specific studies can involve limited samples. The modules provide cautious educational guidance, not a diagnosis or treatment.';
}

// Path: learning.sources
class Translations$learning$sources$en {
	Translations$learning$sources$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {$count scientific source} (other) {$count scientific sources}'
	String title({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} scientific source',
		other: '${count} scientific sources',
	);

	/// en: 'References and scope of the evidence'
	String get shortDescription => 'References and scope of the evidence';

	/// en: 'Scientific sources'
	String get sheetTitle => 'Scientific sources';

	/// en: 'Read each result within its population and study design: an association does not establish a cause, and a finding from another behavior or a limited sample may not generalize. These references do not prove that this module or StopCorn is a treatment.'
	String get scope => 'Read each result within its population and study design: an association does not establish a cause, and a finding from another behavior or a limited sample may not generalize. These references do not prove that this module or StopCorn is a treatment.';
}

// Path: learning.module
class Translations$learning$module$en {
	Translations$learning$module$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '$minutes min · $status'
	String line({required Object minutes, required Object status}) => '${minutes} min · ${status}';

	/// en: 'Progress for module $title'
	String progress({required Object title}) => 'Progress for module ${title}';

	/// en: 'Module'
	String get pageTitle => 'Module';

	/// en: 'This module could not be loaded.'
	String get loadError => 'This module could not be loaded.';
}

// Path: learning.status
class Translations$learning$status$en {
	Translations$learning$status$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Reading again'
	String get reviewing => 'Reading again';

	/// en: 'Resume reading'
	String get resume => 'Resume reading';

	/// en: 'Discover'
	String get discover => 'Discover';
}

// Path: learning.reading
class Translations$learning$reading$en {
	Translations$learning$reading$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Module reading progress'
	String get progress => 'Module reading progress';

	/// en: 'Part $current of $total'
	String part({required Object current, required Object total}) => 'Part ${current} of ${total}';

	/// en: 'Previous'
	String get previous => 'Previous';
}

// Path: learning.reflection
class Translations$learning$reflection$en {
	Translations$learning$reflection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Optional reflection'
	String get optional => 'Optional reflection';

	/// en: 'My reflection'
	String get label => 'My reflection';

	/// en: 'A few words for yourself…'
	String get hint => 'A few words for yourself…';

	/// en: 'This note stays only on your device.'
	String get localNote => 'This note stays only on your device.';

	/// en: 'Continue to reflection'
	String get continueAction => 'Continue to reflection';

	/// en: 'Your reflection'
	String get yours => 'Your reflection';
}

// Path: learning.completion
class Translations$learning$completion$en {
	Translations$learning$completion$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Module completed'
	String get title => 'Module completed';

	/// en: 'Finish module'
	String get finish => 'Finish module';

	/// en: 'Restart module'
	String get restart => 'Restart module';

	/// en: 'Back to modules'
	String get back => 'Back to modules';
}

// Path: learning.error
class Translations$learning$error$en {
	Translations$learning$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Modules could not be loaded.'
	String get load => 'Modules could not be loaded.';

	/// en: 'Unable to save your progress right now. Try again.'
	String get save => 'Unable to save your progress right now. Try again.';
}

// Path: learningModules.continueAfterSetback
class Translations$learningModules$continueAfterSetback$en {
	Translations$learningModules$continueAfterSetback$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Continue after a setback'
	String get title => 'Continue after a setback';

	/// en: 'Turn an event into useful information, without judgment.'
	String get summary => 'Turn an event into useful information, without judgment.';

	late final Translations$learningModules$continueAfterSetback$sections$en sections = Translations$learningModules$continueAfterSetback$sections$en.internal(_root);

	/// en: 'What useful information can you take from the last event without judging yourself?'
	String get reflectionPrompt => 'What useful information can you take from the last event without judging yourself?';
}

// Path: learningModules.mapTerrain
class Translations$learningModules$mapTerrain$en {
	Translations$learningModules$mapTerrain$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Map your terrain'
	String get title => 'Map your terrain';

	/// en: 'Identify situations that recur in your observations.'
	String get summary => 'Identify situations that recur in your observations.';

	late final Translations$learningModules$mapTerrain$sections$en sections = Translations$learningModules$mapTerrain$sections$en.internal(_root);

	/// en: 'Which situation appears most often in your observations?'
	String get reflectionPrompt => 'Which situation appears most often in your observations?';
}

// Path: learningModules.prepareEnvironment
class Translations$learningModules$prepareEnvironment$en {
	Translations$learningModules$prepareEnvironment$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Prepare your environment'
	String get title => 'Prepare your environment';

	/// en: 'Add friction and make your chosen actions easier.'
	String get summary => 'Add friction and make your chosen actions easier.';

	late final Translations$learningModules$prepareEnvironment$sections$en sections = Translations$learningModules$prepareEnvironment$sections$en.internal(_root);

	/// en: 'What change to your environment could you make today?'
	String get reflectionPrompt => 'What change to your environment could you make today?';
}

// Path: learningModules.rideUrge
class Translations$learningModules$rideUrge$en {
	Translations$learningModules$rideUrge$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ride out an impulse'
	String get title => 'Ride out an impulse';

	/// en: 'Create a little space before choosing what comes next.'
	String get summary => 'Create a little space before choosing what comes next.';

	late final Translations$learningModules$rideUrge$sections$en sections = Translations$learningModules$rideUrge$sections$en.internal(_root);

	/// en: 'Which realistic strategy could you try during the next difficult moment?'
	String get reflectionPrompt => 'Which realistic strategy could you try during the next difficult moment?';
}

// Path: learningModules.understandLoop
class Translations$learningModules$understandLoop$en {
	Translations$learningModules$understandLoop$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Understand the loop'
	String get title => 'Understand the loop';

	/// en: 'Notice the stages that can keep a habit going.'
	String get summary => 'Notice the stages that can keep a habit going.';

	late final Translations$learningModules$understandLoop$sections$en sections = Translations$learningModules$understandLoop$sections$en.internal(_root);

	/// en: 'Which part of the loop seems easiest to change this week?'
	String get reflectionPrompt => 'Which part of the loop seems easiest to change this week?';
}

// Path: learningModules.whyChange
class Translations$learningModules$whyChange$en {
	Translations$learningModules$whyChange$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Why change?'
	String get title => 'Why change?';

	/// en: 'Clarify what you want to regain or protect.'
	String get summary => 'Clarify what you want to regain or protect.';

	late final Translations$learningModules$whyChange$sections$en sections = Translations$learningModules$whyChange$sections$en.internal(_root);

	/// en: 'What would you like to regain or protect by changing this habit?'
	String get reflectionPrompt => 'What would you like to regain or protect by changing this habit?';
}

// Path: locale.section
class Translations$locale$section$en {
	Translations$locale$section$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Language'
	String get title => 'Language';

	/// en: 'Choose the language used throughout the app.'
	String get description => 'Choose the language used throughout the app.';
}

// Path: navigation.home
class Translations$navigation$home$en {
	Translations$navigation$home$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get item => 'Home';

	/// en: 'Hello'
	String get title => 'Hello';
}

// Path: notifications.dailyCheckIn
class Translations$notifications$dailyCheckIn$en {
	Translations$notifications$dailyCheckIn$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your StopCorn check-in is waiting'
	String get title => 'Your StopCorn check-in is waiting';

	/// en: 'Take a moment to note how your day went.'
	String get body => 'Take a moment to note how your day went.';

	/// en: 'Daily check-in reminders'
	String get channelName => 'Daily check-in reminders';

	/// en: 'A local reminder at 8:00 PM when the daily check-in is still empty.'
	String get channelDescription => 'A local reminder at 8:00 PM when the daily check-in is still empty.';
}

// Path: onboarding.welcome
class Translations$onboarding$welcome$en {
	Translations$onboarding$welcome$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Regain control, without judgment'
	String get title => 'Regain control, without judgment';

	/// en: 'StopCorn helps you understand your habits, navigate difficult moments, and build a plan that fits your goal.'
	String get subtitle => 'StopCorn helps you understand your habits, navigate difficult moments, and build a plan that fits your goal.';

	/// en: 'No account required'
	String get noAccount => 'No account required';

	/// en: 'Data kept on this device'
	String get localData => 'Data kept on this device';

	/// en: 'No advertising'
	String get noAds => 'No advertising';

	/// en: 'A self-help tool'
	String get selfHelp => 'A self-help tool';

	/// en: 'Learn more about privacy'
	String get privacyAction => 'Learn more about privacy';

	/// en: 'Privacy from the start'
	String get privacyTitle => 'Privacy from the start';

	/// en: 'No journal data is sent to StopCorn. The application does not read your browser, your searches, or the content you look at. You only choose the general markers you want to record. If the application crashes, an anonymous technical report can be sent so the problem gets fixed; it carries none of your entries and can be turned off in Settings.'
	String get privacyBody => 'No journal data is sent to StopCorn. The application does not read your browser, your searches, or the content you look at. You only choose the general markers you want to record. If the application crashes, an anonymous technical report can be sent so the problem gets fixed; it carries none of your entries and can be turned off in Settings.';
}

// Path: onboarding.goal
class Translations$onboarding$goal$en {
	Translations$onboarding$goal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What would you like to change?'
	String get title => 'What would you like to change?';

	/// en: 'Choose a direction that feels right. You can change it later.'
	String get subtitle => 'Choose a direction that feels right. You can change it later.';

	/// en: 'Goal selection'
	String get semantics => 'Goal selection';

	/// en: 'Desired weekly limit'
	String get weeklyLimit => 'Desired weekly limit';

	/// en: 'Example: 2'
	String get weeklyHint => 'Example: 2';

	/// en: 'Contexts to avoid'
	String get contexts => 'Contexts to avoid';

	/// en: 'Personal motivation'
	String get motivation => 'Personal motivation';

	/// en: 'What you would like to regain or protect…'
	String get motivationHint => 'What you would like to regain or protect…';
}

// Path: onboarding.baseline
class Translations$onboarding$baseline$en {
	Translations$onboarding$baseline$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your starting point'
	String get title => 'Your starting point';

	/// en: 'This is not a medical test. It will only help you observe your progress.'
	String get subtitle => 'This is not a medical test. It will only help you observe your progress.';

	/// en: 'Approximate frequency over the last 7 days'
	String get frequency => 'Approximate frequency over the last 7 days';

	/// en: 'Sense of control'
	String get control => 'Sense of control';

	/// en: 'Perceived negative impact'
	String get impact => 'Perceived negative impact';

	/// en: 'Confidence in your ability to change'
	String get confidence => 'Confidence in your ability to change';
}

// Path: onboarding.strategies
class Translations$onboarding$strategies$en {
	Translations$onboarding$strategies$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Prepare your backup plan'
	String get title => 'Prepare your backup plan';

	/// en: 'Ideally choose three realistic actions. One is enough to continue.'
	String get subtitle => 'Ideally choose three realistic actions. One is enough to continue.';

	/// en: '(zero) {No strategy selected} (one) {$count strategy selected} (other) {$count strategies selected}'
	String selected({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		zero: 'No strategy selected',
		one: '${count} strategy selected',
		other: '${count} strategies selected',
	);

	/// en: 'Backup strategies'
	String get semantics => 'Backup strategies';
}

// Path: onboarding.privacy
class Translations$onboarding$privacy$en {
	Translations$onboarding$privacy$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your data stays under your control'
	String get title => 'Your data stays under your control';

	/// en: 'This version of StopCorn works without an account or server.'
	String get subtitle => 'This version of StopCorn works without an account or server.';

	/// en: 'Data is stored only on this device.'
	String get local => 'Data is stored only on this device.';

	/// en: 'No URL or search is recorded.'
	String get noHistory => 'No URL or search is recorded.';

	/// en: 'You can voluntarily export or completely erase your data.'
	String get control => 'You can voluntarily export or completely erase your data.';

	/// en: 'Your phone's system backups may include app data depending on your system settings.'
	String get backup => 'Your phone\'s system backups may include app data depending on your system settings.';

	/// en: 'Remind me to check in'
	String get dailyCheckInReminder => 'Remind me to check in';

	/// en: 'At 8:00 PM, receive a local reminder only if today's check-in is still empty. You can change this later.'
	String get dailyCheckInReminderDescription => 'At 8:00 PM, receive a local reminder only if today\'s check-in is still empty. You can change this later.';

	/// en: 'Notifications were not allowed. Turn this option off to continue, or allow notifications and try again.'
	String get reminderPermissionDenied => 'Notifications were not allowed. Turn this option off to continue, or allow notifications and try again.';

	/// en: 'Daily reminders are not available on this device.'
	String get reminderUnavailable => 'Daily reminders are not available on this device.';

	/// en: 'The daily reminder could not be prepared. Try again or turn it off to continue.'
	String get reminderError => 'The daily reminder could not be prepared. Try again or turn it off to continue.';

	/// en: 'Anonymous crash reports help fix bugs, and can be turned off in Settings.'
	String get crashReports => 'Anonymous crash reports help fix bugs, and can be turned off in Settings.';
}

// Path: onboarding.error
class Translations$onboarding$error$en {
	Translations$onboarding$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Setup could not be loaded.'
	String get load => 'Setup could not be loaded.';

	/// en: 'Unable to save right now. Try again in a moment.'
	String get save => 'Unable to save right now. Try again in a moment.';

	/// en: 'Setup could not be completed. No data was sent.'
	String get complete => 'Setup could not be completed. No data was sent.';

	/// en: 'Onboarding is not ready yet.'
	String get notReady => 'Onboarding is not ready yet.';

	/// en: 'The saved setup draft is invalid.'
	String get invalidDraft => 'The saved setup draft is invalid.';
}

// Path: onboarding.validation
class Translations$onboarding$validation$en {
	Translations$onboarding$validation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose a goal.'
	String get goal => 'Choose a goal.';

	/// en: 'Enter a positive weekly limit.'
	String get weeklyLimit => 'Enter a positive weekly limit.';

	/// en: 'Choose at least one context.'
	String get context => 'Choose at least one context.';

	/// en: 'Choose at least one strategy.'
	String get strategy => 'Choose at least one strategy.';

	/// en: 'Scores must be between 0 and 10.'
	String get scoreRange => 'Scores must be between 0 and 10.';
}

// Path: progress.error
class Translations$progress$error$en {
	Translations$progress$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Progress data could not be loaded.'
	String get load => 'Progress data could not be loaded.';
}

// Path: progress.overview
class Translations$progress$overview$en {
	Translations$progress$overview$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Overview'
	String get title => 'Overview';

	/// en: '(one) {recorded consumption event} (other) {recorded consumption events}'
	String events({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'recorded consumption event',
		other: 'recorded consumption events',
	);

	/// en: '(one) {day without a recorded consumption event} (other) {days without a recorded consumption event}'
	String daysWithout({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'day without a recorded consumption event',
		other: 'days without a recorded consumption event',
	);

	/// en: '(one) {completed support session} (other) {completed support sessions}'
	String completedUrges({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'completed support session',
		other: 'completed support sessions',
	);

	/// en: 'average intensity decrease'
	String get averageDecrease => 'average intensity decrease';

	/// en: 'Not enough data yet'
	String get notEnough => 'Not enough data yet';

	/// en: 'The difference between the initial intensity and the final intensity'
	String get decreaseDetail => 'The difference between the initial intensity and the final intensity';

	late final Translations$progress$overview$goal$en goal = Translations$progress$overview$goal$en.internal(_root);

	/// en: 'Not enough data yet. A few markers will be enough for trends to appear.'
	String get empty => 'Not enough data yet. A few markers will be enough for trends to appear.';
}

// Path: progress.events
class Translations$progress$events$en {
	Translations$progress$events$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Event trends'
	String get title => 'Event trends';

	/// en: 'Weekly trend'
	String get weeklyTitle => 'Weekly trend';

	/// en: 'No event was recorded during this period.'
	String get empty => 'No event was recorded during this period.';

	/// en: 'Week of $date'
	String weekOf({required Object date}) => 'Week of ${date}';

	/// en: '(one) {$count voluntarily recorded event, grouped by week.} (other) {$count voluntarily recorded events, grouped by week.}'
	String summary({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} voluntarily recorded event, grouped by week.',
		other: '${count} voluntarily recorded events, grouped by week.',
	);
}

// Path: progress.urges
class Translations$progress$urges$en {
	Translations$progress$urges$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Urges of $corn'
	TextSpan title({required InlineSpan corn}) => TextSpan(children: [
		const TextSpan(text: 'Urges of '),
		corn,
	]);

	/// en: 'Average intensity'
	String get averageIntensity => 'Average intensity';

	/// en: 'Not enough completed sessions with a final intensity yet.'
	String get empty => 'Not enough completed sessions with a final intensity yet.';

	/// en: 'Initial'
	String get initial => 'Initial';

	/// en: 'Observation times'
	String get observationHours => 'Observation times';

	/// en: 'No time has been recorded for a support session or event.'
	String get noHours => 'No time has been recorded for a support session or event.';

	late final Translations$progress$urges$comparison$en comparison = Translations$progress$urges$comparison$en.internal(_root);

	/// en: 'The $label time range contains the most recorded observations.'
	String hourSummary({required Object label}) => 'The ${label} time range contains the most recorded observations.';

	late final Translations$progress$urges$timeBucket$en timeBucket = Translations$progress$urges$timeBucket$en.internal(_root);

	/// en: 'Final'
	String get finalLabel => 'Final';
}

// Path: progress.patterns
class Translations$progress$patterns$en {
	Translations$progress$patterns$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Triggers and emotions'
	String get title => 'Triggers and emotions';

	late final Translations$progress$patterns$triggers$en triggers = Translations$progress$patterns$triggers$en.internal(_root);
	late final Translations$progress$patterns$emotions$en emotions = Translations$progress$patterns$emotions$en.internal(_root);

	/// en: '$label is the most frequently recorded $kind during this period.'
	String rankingSummary({required Object label, required Object kind}) => '${label} is the most frequently recorded ${kind} during this period.';
}

// Path: progress.strategies
class Translations$progress$strategies$en {
	Translations$progress$strategies$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Strategies'
	String get title => 'Strategies';

	/// en: 'Perceived effectiveness'
	String get effectiveness => 'Perceived effectiveness';

	/// en: 'No strategy was rated during this period. The scale runs from −5 to +5.'
	String get empty => 'No strategy was rated during this period. The scale runs from −5 to +5.';

	/// en: '(one) {$effect ($count rating)} (other) {$effect ($count ratings)}'
	String evaluations({required num count, required Object effect}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${effect} (${count} rating)',
		other: '${effect} (${count} ratings)',
	);

	/// en: 'Use and rate a strategy at least three times to get a more reliable marker.'
	String get threshold => 'Use and rate a strategy at least three times to get a more reliable marker.';

	/// en: '$strategy is the highest-rated strategy among those used at least three times.'
	String best({required Object strategy}) => '${strategy} is the highest-rated strategy among those used at least three times.';
}

// Path: progress.checkIns
class Translations$progress$checkIns$en {
	Translations$progress$checkIns$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Check-ins'
	String get title => 'Check-ins';

	/// en: '(one) {daily check-in} (other) {daily check-ins}'
	String count({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'daily check-in',
		other: 'daily check-ins',
	);

	/// en: 'average mood rate'
	String get averageMood => 'average mood rate';

	/// en: 'average control rate'
	String get averageControl => 'average control rate';

	/// en: 'Out of 10'
	String get outOfTen => 'Out of 10';
}

// Path: progress.comparison
class Translations$progress$comparison$en {
	Translations$progress$comparison$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Not enough comparable data yet'
	String get unavailable => 'Not enough comparable data yet';

	/// en: 'Stable compared with the previous period'
	String get stable => 'Stable compared with the previous period';

	/// en: '$value% $direction than the previous period'
	String value({required Object value, required Object direction}) => '${value}% ${direction} than the previous period';

	/// en: 'more'
	String get more => 'more';

	/// en: 'less'
	String get less => 'less';
}

// Path: progress.startingPoint
class Translations$progress$startingPoint$en {
	Translations$progress$startingPoint$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Comparison with my starting point'
	String get sectionTitle => 'Comparison with my starting point';

	/// en: 'My starting point'
	String get screenTitle => 'My starting point';

	/// en: 'These answers were recorded during your initial setup. They are a personal reference point, not a diagnosis.'
	String get intro => 'These answers were recorded during your initial setup. They are a personal reference point, not a diagnosis.';

	/// en: 'Initial assessment recorded on $date.'
	String recordedOn({required Object date}) => 'Initial assessment recorded on ${date}.';

	/// en: 'Your initial goal'
	String get goalTitle => 'Your initial goal';

	/// en: 'Your initial goal is no longer available.'
	String get goalUnavailable => 'Your initial goal is no longer available.';

	/// en: 'Desired limit: $count per week'
	String weeklyLimit({required Object count}) => 'Desired limit: ${count} per week';

	/// en: 'Selected contexts: $contexts'
	String contexts({required Object contexts}) => 'Selected contexts: ${contexts}';

	/// en: 'Your initial motivation'
	String get motivationTitle => 'Your initial motivation';

	/// en: 'Your initial markers'
	String get markersTitle => 'Your initial markers';

	/// en: 'Approximate frequency over the preceding 7 days'
	String get frequency => 'Approximate frequency over the preceding 7 days';

	/// en: '$count over 7 days'
	String frequencyValue({required Object count}) => '${count} over 7 days';

	/// en: 'Sense of control'
	String get control => 'Sense of control';

	/// en: 'Perceived negative impact'
	String get impact => 'Perceived negative impact';

	/// en: 'Confidence in your ability to change'
	String get confidence => 'Confidence in your ability to change';

	/// en: '$value / 10'
	String score({required Object value}) => '${value} / 10';

	/// en: 'These values only reflect how you felt when you completed the initial assessment.'
	String get disclaimer => 'These values only reflect how you felt when you completed the initial assessment.';

	late final Translations$progress$startingPoint$comparison$en comparison = Translations$progress$startingPoint$comparison$en.internal(_root);

	/// en: 'No initial assessment is available.'
	String get empty => 'No initial assessment is available.';

	/// en: 'Your starting point could not be loaded.'
	String get error => 'Your starting point could not be loaded.';
}

// Path: settings.support
class Translations$settings$support$en {
	Translations$settings$support$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'An open project, built to stay accessible'
	String get title => 'An open project, built to stay accessible';

	/// en: 'StopCorn grew from a simple observation: comparable tools often end up behind a subscription or limited features. The app is therefore free and open source, with no ads or trackers, so anyone can move forward without a barrier.'
	String get body => 'StopCorn grew from a simple observation: comparable tools often end up behind a subscription or limited features. The app is therefore free and open source, with no ads or trackers, so anyone can move forward without a barrier.';

	late final Translations$settings$support$values$en values = Translations$settings$support$values$en.internal(_root);

	/// en: 'If StopCorn helps you, you can support its development. This is entirely optional and does not unlock any feature.'
	String get contribution => 'If StopCorn helps you, you can support its development. This is entirely optional and does not unlock any feature.';

	/// en: 'Support development'
	String get supportAction => 'Support development';

	/// en: 'Collapse the project card'
	String get collapseAction => 'Collapse the project card';

	/// en: 'Expand the project card'
	String get expandAction => 'Expand the project card';

	/// en: 'Source code'
	String get sourceAction => 'Source code';

	/// en: 'Website'
	String get websiteAction => 'Website';

	/// en: 'Thank you! Your support helps StopCorn stay free and independent.'
	String get thanks => 'Thank you! Your support helps StopCorn stay free and independent.';

	late final Translations$settings$support$error$en error = Translations$settings$support$error$en.internal(_root);
}

// Path: settings.appearance
class Translations$settings$appearance$en {
	Translations$settings$appearance$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Appearance'
	String get title => 'Appearance';

	/// en: 'Choose a theme or follow the system setting.'
	String get description => 'Choose a theme or follow the system setting.';
}

// Path: settings.reminders
class Translations$settings$reminders$en {
	Translations$settings$reminders$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reminders'
	String get title => 'Reminders';

	/// en: 'Choose whether StopCorn should gently prompt you at the end of the day.'
	String get description => 'Choose whether StopCorn should gently prompt you at the end of the day.';

	late final Translations$settings$reminders$daily$en daily = Translations$settings$reminders$daily$en.internal(_root);
	late final Translations$settings$reminders$error$en error = Translations$settings$reminders$error$en.internal(_root);
}

// Path: settings.progress
class Translations$settings$progress$en {
	Translations$settings$progress$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Progress'
	String get title => 'Progress';

	/// en: 'Adapt the indicators to what is useful to you.'
	String get description => 'Adapt the indicators to what is useful to you.';

	/// en: 'Default period'
	String get defaultPeriod => 'Default period';

	late final Translations$settings$progress$harvest$en harvest = Translations$settings$progress$harvest$en.internal(_root);
}

// Path: settings.personalPlan
class Translations$settings$personalPlan$en {
	Translations$settings$personalPlan$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Personal plan'
	String get title => 'Personal plan';

	/// en: 'Keep the options you want to find quickly when you need support.'
	String get description => 'Keep the options you want to find quickly when you need support.';

	late final Translations$settings$personalPlan$goal$en goal = Translations$settings$personalPlan$goal$en.internal(_root);
	late final Translations$settings$personalPlan$backup$en backup = Translations$settings$personalPlan$backup$en.internal(_root);
	late final Translations$settings$personalPlan$history$en history = Translations$settings$personalPlan$history$en.internal(_root);
}

// Path: settings.data
class Translations$settings$data$en {
	Translations$settings$data$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Data'
	String get title => 'Data';

	/// en: 'Your data stays local unless you choose to export it.'
	String get description => 'Your data stays local unless you choose to export it.';

	late final Translations$settings$data$errorReporting$en errorReporting = Translations$settings$data$errorReporting$en.internal(_root);
	late final Translations$settings$data$export$en export = Translations$settings$data$export$en.internal(_root);
	late final Translations$settings$data$stored$en stored = Translations$settings$data$stored$en.internal(_root);
	late final Translations$settings$data$delete$en delete = Translations$settings$data$delete$en.internal(_root);
}

// Path: settings.developer
class Translations$settings$developer$en {
	Translations$settings$developer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Developer tools'
	String get title => 'Developer tools';

	/// en: 'Utilities available only in debug builds.'
	String get description => 'Utilities available only in debug builds.';

	late final Translations$settings$developer$sample$en sample = Translations$settings$developer$sample$en.internal(_root);
	late final Translations$settings$developer$cornPoint$en cornPoint = Translations$settings$developer$cornPoint$en.internal(_root);
	late final Translations$settings$developer$supportThanks$en supportThanks = Translations$settings$developer$supportThanks$en.internal(_root);
}

// Path: settings.about
class Translations$settings$about$en {
	Translations$settings$about$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get title => 'About';

	/// en: 'Information about StopCorn and its scope.'
	String get description => 'Information about StopCorn and its scope.';

	/// en: 'Version $version.'
	String version({required Object version}) => 'Version ${version}.';

	/// en: 'StopCorn is a free, private, judgment-free self-help tool.'
	String get body => 'StopCorn is a free, private, judgment-free self-help tool.';

	late final Translations$settings$about$privacy$en privacy = Translations$settings$about$privacy$en.internal(_root);

	/// en: 'Open-source licenses'
	String get licenses => 'Open-source licenses';

	/// en: 'Find professional help'
	String get professionalHelp => 'Find professional help';

	late final Translations$settings$about$help$en help = Translations$settings$about$help$en.internal(_root);
}

// Path: settings.goalEditor
class Translations$settings$goalEditor$en {
	Translations$settings$goalEditor$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose a new goal'
	String get title => 'Choose a new goal';

	/// en: 'The current goal will remain in your history.'
	String get history => 'The current goal will remain in your history.';

	/// en: 'Activate this goal'
	String get activate => 'Activate this goal';

	/// en: 'The goal could not be saved.'
	String get error => 'The goal could not be saved.';

	late final Translations$settings$goalEditor$validation$en validation = Translations$settings$goalEditor$validation$en.internal(_root);
}

// Path: settings.error
class Translations$settings$error$en {
	Translations$settings$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings could not be loaded.'
	String get load => 'Settings could not be loaded.';

	/// en: 'Unable to save this setting right now.'
	String get save => 'Unable to save this setting right now.';
}

// Path: urge.support
class Translations$urge$support$en {
	Translations$urge$support$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose support'
	String get pageTitle => 'Choose support';

	/// en: 'What would help right now?'
	String get title => 'What would help right now?';

	/// en: 'Choose the option that feels most accessible. You remain in control of the pace.'
	String get subtitle => 'Choose the option that feels most accessible. You remain in control of the pace.';

	/// en: 'Available forms of support'
	String get semantics => 'Available forms of support';

	/// en: 'Guided pause'
	String get guidedTitle => 'Guided pause';

	/// en: 'Follow a short grounding pause, then check in again.'
	String get guidedDescription => 'Follow a short grounding pause, then check in again.';

	/// en: 'Backup plan'
	String get planTitle => 'Backup plan';

	/// en: '(zero) {No action has been prepared yet.} (one) {Choose from the action you prepared.} (other) {Choose from the $count actions you prepared.}'
	String planDescription({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		zero: 'No action has been prepared yet.',
		one: 'Choose from the action you prepared.',
		other: 'Choose from the ${count} actions you prepared.',
	);

	/// en: 'Other ideas'
	String get ideasTitle => 'Other ideas';

	/// en: '(zero) {No other action is available.} (one) {Explore one other action.} (other) {Explore $count other actions.}'
	String ideasDescription({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		zero: 'No other action is available.',
		one: 'Explore one other action.',
		other: 'Explore ${count} other actions.',
	);
}

// Path: urge.grounding
class Translations$urge$grounding$en {
	Translations$urge$grounding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Place your feet on the floor.'
	String get feet => 'Place your feet on the floor.';

	/// en: 'Breathe in slowly.'
	String get inhale => 'Breathe in slowly.';

	/// en: 'Notice what you feel without trying to push it away.'
	String get observe => 'Notice what you feel without trying to push it away.';

	/// en: 'Breathe out longer than you breathe in.'
	String get exhale => 'Breathe out longer than you breathe in.';

	/// en: 'Simply notice whether it rises, falls, or stays stable.'
	String get change => 'Simply notice whether it rises, falls, or stays stable.';

	/// en: 'Give yourself a moment.'
	String get title => 'Give yourself a moment.';

	/// en: 'This short pause is an aid to relaxation, not a medical rule.'
	String get subtitle => 'This short pause is an aid to relaxation, not a medical rule.';

	/// en: 'Pause progress'
	String get semantics => 'Pause progress';

	/// en: 'Skip'
	String get skip => 'Skip';
}

// Path: urge.strategy
class Translations$urge$strategy$en {
	Translations$urge$strategy$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose an action'
	String get pageTitle => 'Choose an action';

	/// en: 'What action can you try now?'
	String get title => 'What action can you try now?';

	/// en: 'One small, realistic action is enough. It does not need to make the feeling disappear.'
	String get subtitle => 'One small, realistic action is enough. It does not need to make the feeling disappear.';

	/// en: 'Your backup plan'
	String get planTitle => 'Your backup plan';

	/// en: 'Choose one of the actions you prepared for this moment.'
	String get planSubtitle => 'Choose one of the actions you prepared for this moment.';

	/// en: 'Other ideas'
	String get ideasTitle => 'Other ideas';

	/// en: 'Choose another simple action that feels realistic right now.'
	String get ideasSubtitle => 'Choose another simple action that feels realistic right now.';

	/// en: 'Strategies could not be loaded.'
	String get loadError => 'Strategies could not be loaded.';

	/// en: 'No action is available in this list.'
	String get empty => 'No action is available in this list.';

	/// en: 'Available strategies'
	String get semantics => 'Available strategies';

	/// en: 'Start this action'
	String get start => 'Start this action';

	/// en: 'Action started: $strategy.'
	String started({required Object strategy}) => 'Action started: ${strategy}.';

	/// en: 'Suggested time'
	String get timerTitle => 'Suggested time';

	/// en: 'This timer is only a guide: you can finish sooner or take as much time as you need.'
	String get timerGuidance => 'This timer is only a guide: you can finish sooner or take as much time as you need.';

	/// en: 'Indicative action timer'
	String get timerSemantics => 'Indicative action timer';

	/// en: 'The suggested time has elapsed.'
	String get timerComplete => 'The suggested time has elapsed.';

	/// en: 'Check in again'
	String get reassess => 'Check in again';

	/// en: 'Perceived usefulness of the strategy'
	String get effect => 'Perceived usefulness of the strategy';
}

// Path: urge.result
class Translations$urge$result$en {
	Translations$urge$result$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Check in'
	String get pageTitle => 'Check in';

	/// en: 'How strong is your urge now?'
	TextSpan get title => TextSpan(children: [
		const TextSpan(text: 'How strong is your urge now?'),
	]);

	/// en: 'It may have increased, decreased, or stayed the same.'
	String get subtitle => 'It may have increased, decreased, or stayed the same.';

	late final Translations$urge$result$outcome$en outcome = Translations$urge$result$outcome$en.internal(_root);

	/// en: 'Optional note'
	String get note => 'Optional note';

	/// en: 'A useful marker for next time.'
	String get noteHint => 'A useful marker for next time.';

	/// en: 'Finish the flow'
	String get finish => 'Finish the flow';
}

// Path: urge.complete
class Translations$urge$complete$en {
	Translations$urge$complete$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Flow complete'
	String get title => 'Flow complete';

	/// en: 'No problem.'
	String get consumedHeadline => 'No problem.';

	/// en: 'Great!'
	String get otherHeadline => 'Great!';

	/// en: 'This event does not erase your progress. You can simply note what may help next time.'
	String get consumedBody => 'This event does not erase your progress.\nYou can simply note what may help next time.';

	/// en: 'You made space between your urge and your choice. This is a skill that grows one attempt at a time.'
	String get otherBody => 'You made space between your urge and your choice.\nThis is a skill that grows one attempt at a time.';

	/// en: 'Record what happened'
	String get log => 'Record what happened';
}

// Path: urge.intensity
class Translations$urge$intensity$en {
	Translations$urge$intensity$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How strong is your urge?'
	TextSpan get title => TextSpan(children: [
		const TextSpan(text: 'How strong is your urge?'),
	]);

	/// en: 'Rate it out of 10. There is no wrong answer: this marker will help show how it changes.'
	String get subtitle => 'Rate it out of 10. There is no wrong answer: this marker will help show how it changes.';

	/// en: 'Current intensity'
	String get label => 'Current intensity';
}

// Path: urge.factors
class Translations$urge$factors$en {
	Translations$urge$factors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'More details?'
	String get title => 'More details?';

	/// en: 'These optional details can help you better understand these moments.'
	String get subtitle => 'These optional details can help you better understand these moments.';

	/// en: 'Contributing factors (optional)'
	String get label => 'Contributing factors (optional)';

	/// en: 'Trigger'
	String get trigger => 'Trigger';

	/// en: 'Emotion'
	String get emotion => 'Emotion';
}

// Path: urge.timer
class Translations$urge$timer$en {
	Translations$urge$timer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {$count second remaining} (other) {$count seconds remaining}'
	String count({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} second remaining',
		other: '${count} seconds remaining',
	);
}

// Path: urge.error
class Translations$urge$error$en {
	Translations$urge$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unable to start this support flow right now. Try again.'
	String get start => 'Unable to start this support flow right now. Try again.';

	/// en: 'This session is no longer available.'
	String get missingSession => 'This session is no longer available.';

	/// en: 'The strategy could not be saved. Try again.'
	String get strategySave => 'The strategy could not be saved. Try again.';

	/// en: 'Choose the result that best describes the situation.'
	String get outcomeRequired => 'Choose the result that best describes the situation.';

	/// en: 'Unable to save right now. Try again in a moment.'
	String get save => 'Unable to save right now. Try again in a moment.';
}

// Path: home.checkIn.action
class Translations$home$checkIn$action$en {
	Translations$home$checkIn$action$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit my daily check-in'
	String get done => 'Edit my daily check-in';

	/// en: 'Record my daily check-in'
	String get pending => 'Record my daily check-in';
}

// Path: journal.history.empty
class Translations$journal$history$empty$en {
	Translations$journal$history$empty$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your journal is still empty'
	String get title => 'Your journal is still empty';

	/// en: 'Consumption events and check-ins you record will appear here.'
	String get body => 'Consumption events and check-ins you record will appear here.';
}

// Path: journal.history.date
class Translations$journal$history$date$en {
	Translations$journal$history$date$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Yesterday'
	String get yesterday => 'Yesterday';
}

// Path: journal.history.entry
class Translations$journal$history$entry$en {
	Translations$journal$history$entry$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Consumption event'
	String get consumption => 'Consumption event';

	/// en: 'Daily check-in'
	String get checkIn => 'Daily check-in';

	/// en: 'At $time'
	String time({required Object time}) => 'At ${time}';

	/// en: 'Mood: $mood/10 · Control: $control/10'
	String checkInSummary({required Object mood, required Object control}) => 'Mood: ${mood}/10 · Control: ${control}/10';

	/// en: 'No context or note.'
	String get noText => 'No context or note.';

	/// en: '(zero) {No entries} (one) {$count entry} (other) {$count entries}'
	String entries({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		zero: 'No entries',
		one: '${count} entry',
		other: '${count} entries',
	);

	/// en: 'Support session'
	String get urge => 'Support session';

	/// en: 'Intensity $initial → $finalValue'
	String urgeSummary({required Object initial, required Object finalValue}) => 'Intensity ${initial} → ${finalValue}';

	/// en: 'Starting intensity $initial'
	String urgeSummaryPartial({required Object initial}) => 'Starting intensity ${initial}';
}

// Path: journal.history.details
class Translations$journal$history$details$en {
	Translations$journal$history$details$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(zero) {no urge of $corn} (one) {$count urge of $corn} (other) {$count urges of $corn}'
	TextSpan cornUrges({required num count, required InlineSpan Function(num) countBuilder, required InlineSpan corn}) => RichPluralResolvers.bridge(
		n: count,
		resolver: _root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'),
		zero: () => TextSpan(children: [
			const TextSpan(text: 'no urge of '),
			corn,
		]),
		one: () => TextSpan(children: [
			countBuilder(count),
			const TextSpan(text: ' urge of '),
			corn,
		]),
		other: () => TextSpan(children: [
			countBuilder(count),
			const TextSpan(text: ' urges of '),
			corn,
		]),
	);

	/// en: 'Starting intensity'
	String get initialIntensity => 'Starting intensity';

	/// en: 'Intensity at the end'
	String get finalIntensity => 'Intensity at the end';

	/// en: 'Outcome'
	String get outcome => 'Outcome';

	/// en: 'Action tried'
	String get strategy => 'Action tried';

	/// en: 'Guided pause'
	String get pause => 'Guided pause';

	/// en: '(one) {$count second} (other) {$count seconds}'
	String pauseSeconds({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} second',
		other: '${count} seconds',
	);

	/// en: 'Your reflection'
	String get reflection => 'Your reflection';
}

// Path: learningModules.continueAfterSetback.sections
class Translations$learningModules$continueAfterSetback$sections$en {
	Translations$learningModules$continueAfterSetback$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$learningModules$continueAfterSetback$sections$perspective$en perspective = Translations$learningModules$continueAfterSetback$sections$perspective$en.internal(_root);
	late final Translations$learningModules$continueAfterSetback$sections$adjust$en adjust = Translations$learningModules$continueAfterSetback$sections$adjust$en.internal(_root);
	late final Translations$learningModules$continueAfterSetback$sections$help$en help = Translations$learningModules$continueAfterSetback$sections$help$en.internal(_root);
}

// Path: learningModules.mapTerrain.sections
class Translations$learningModules$mapTerrain$sections$en {
	Translations$learningModules$mapTerrain$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$learningModules$mapTerrain$sections$states$en states = Translations$learningModules$mapTerrain$sections$states$en.internal(_root);
	late final Translations$learningModules$mapTerrain$sections$routines$en routines = Translations$learningModules$mapTerrain$sections$routines$en.internal(_root);
	late final Translations$learningModules$mapTerrain$sections$map$en map = Translations$learningModules$mapTerrain$sections$map$en.internal(_root);
}

// Path: learningModules.prepareEnvironment.sections
class Translations$learningModules$prepareEnvironment$sections$en {
	Translations$learningModules$prepareEnvironment$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$learningModules$prepareEnvironment$sections$friction$en friction = Translations$learningModules$prepareEnvironment$sections$friction$en.internal(_root);
	late final Translations$learningModules$prepareEnvironment$sections$moments$en moments = Translations$learningModules$prepareEnvironment$sections$moments$en.internal(_root);
	late final Translations$learningModules$prepareEnvironment$sections$alternative$en alternative = Translations$learningModules$prepareEnvironment$sections$alternative$en.internal(_root);
}

// Path: learningModules.rideUrge.sections
class Translations$learningModules$rideUrge$sections$en {
	Translations$learningModules$rideUrge$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$learningModules$rideUrge$sections$delay$en delay = Translations$learningModules$rideUrge$sections$delay$en.internal(_root);
	late final Translations$learningModules$rideUrge$sections$concrete$en concrete = Translations$learningModules$rideUrge$sections$concrete$en.internal(_root);
	late final Translations$learningModules$rideUrge$sections$expectations$en expectations = Translations$learningModules$rideUrge$sections$expectations$en.internal(_root);
}

// Path: learningModules.understandLoop.sections
class Translations$learningModules$understandLoop$sections$en {
	Translations$learningModules$understandLoop$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$learningModules$understandLoop$sections$sequence$en sequence = Translations$learningModules$understandLoop$sections$sequence$en.internal(_root);
	late final Translations$learningModules$understandLoop$sections$action$en action = Translations$learningModules$understandLoop$sections$action$en.internal(_root);
	late final Translations$learningModules$understandLoop$sections$observe$en observe = Translations$learningModules$understandLoop$sections$observe$en.internal(_root);
}

// Path: learningModules.whyChange.sections
class Translations$learningModules$whyChange$sections$en {
	Translations$learningModules$whyChange$sections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$learningModules$whyChange$sections$direction$en direction = Translations$learningModules$whyChange$sections$direction$en.internal(_root);
	late final Translations$learningModules$whyChange$sections$benefits$en benefits = Translations$learningModules$whyChange$sections$benefits$en.internal(_root);
	late final Translations$learningModules$whyChange$sections$changes$en changes = Translations$learningModules$whyChange$sections$changes$en.internal(_root);
}

// Path: progress.overview.goal
class Translations$progress$overview$goal$en {
	Translations$progress$overview$goal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '(one) {$count consumption event was voluntarily recorded during the selected period. Missing observations never prove that no event occurred.} (other) {$count consumption events were voluntarily recorded during the selected period. Missing observations never prove that no event occurred.}'
	String abstinence({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} consumption event was voluntarily recorded during the selected period. Missing observations never prove that no event occurred.',
		other: '${count} consumption events were voluntarily recorded during the selected period. Missing observations never prove that no event occurred.',
	);

	/// en: '(one) {This week: $count recorded event for a desired limit of $limit.} (other) {This week: $count recorded events for a desired limit of $limit.}'
	String reduction({required num count, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'This week: ${count} recorded event for a desired limit of ${limit}.',
		other: 'This week: ${count} recorded events for a desired limit of ${limit}.',
	);

	/// en: '(one) {$count recorded event matched one of your protected contexts during the selected period: $contexts.} (other) {$count recorded events matched one of your protected contexts during the selected period: $contexts.}'
	String contextual({required num count, required Object contexts}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} recorded event matched one of your protected contexts during the selected period: ${contexts}.',
		other: '${count} recorded events matched one of your protected contexts during the selected period: ${contexts}.',
	);

	/// en: '(one) {$count voluntary marker was recorded during the selected period. Every honest observation helps reveal patterns.} (other) {$count voluntary markers were recorded during the selected period. Every honest observation helps reveal patterns.}'
	String observation({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} voluntary marker was recorded during the selected period. Every honest observation helps reveal patterns.',
		other: '${count} voluntary markers were recorded during the selected period. Every honest observation helps reveal patterns.',
	);
}

// Path: progress.urges.comparison
class Translations$progress$urges$comparison$en {
	Translations$progress$urges$comparison$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Not enough data yet to compare the beginning and end of support sessions.'
	String get unavailable => 'Not enough data yet to compare the beginning and end of support sessions.';

	/// en: '(one) {Intensity decreased by an average of $value point during complete sessions.} (other) {Intensity decreased by an average of $value points during complete sessions.}'
	String decrease({required num count, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Intensity decreased by an average of ${value} point during complete sessions.',
		other: 'Intensity decreased by an average of ${value} points during complete sessions.',
	);

	/// en: '(one) {Intensity increased by an average of $value point during complete sessions.} (other) {Intensity increased by an average of $value points during complete sessions.}'
	String increase({required num count, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: 'Intensity increased by an average of ${value} point during complete sessions.',
		other: 'Intensity increased by an average of ${value} points during complete sessions.',
	);
}

// Path: progress.urges.timeBucket
class Translations$progress$urges$timeBucket$en {
	Translations$progress$urges$timeBucket$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '$start:00 – midnight'
	String midnight({required Object start}) => '${start}:00 – midnight';

	/// en: '$start:00 – $end:00'
	String range({required Object start, required Object end}) => '${start}:00 – ${end}:00';
}

// Path: progress.patterns.triggers
class Translations$progress$patterns$triggers$en {
	Translations$progress$patterns$triggers$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Most recorded triggers'
	String get title => 'Most recorded triggers';

	/// en: 'trigger'
	String get kind => 'trigger';

	/// en: 'No trigger has been recorded yet.'
	String get empty => 'No trigger has been recorded yet.';
}

// Path: progress.patterns.emotions
class Translations$progress$patterns$emotions$en {
	Translations$progress$patterns$emotions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Most recorded emotions'
	String get title => 'Most recorded emotions';

	/// en: 'emotion'
	String get kind => 'emotion';

	/// en: 'No emotion has been recorded yet.'
	String get empty => 'No emotion has been recorded yet.';
}

// Path: progress.startingPoint.comparison
class Translations$progress$startingPoint$comparison$en {
	Translations$progress$startingPoint$comparison$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Compared with observations from the selected period.'
	String get intro => 'Compared with observations from the selected period.';

	/// en: 'Sense of control'
	String get control => 'Sense of control';

	/// en: 'Initial'
	String get initial => 'Initial';

	/// en: 'Final'
	String get finalLabel => 'Final';

	/// en: '(zero) {Average calculated from $count daily check-in.} (one) {Average calculated from $count daily check-in.} (other) {Average calculated from $count daily check-ins.}'
	String controlDetail({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		zero: 'Average calculated from ${count} daily check-in.',
		one: 'Average calculated from ${count} daily check-in.',
		other: 'Average calculated from ${count} daily check-ins.',
	);

	/// en: 'At least five daily check-ins are needed before a comparison can be shown.'
	String get controlPending => 'At least five daily check-ins are needed before a comparison can be shown.';

	/// en: 'Weekly frequency'
	String get frequency => 'Weekly frequency';

	/// en: 'A complete week of observation is needed before a comparison can be shown.'
	String get frequencyPending => 'A complete week of observation is needed before a comparison can be shown.';

	/// en: 'The current value only counts consumption events you chose to record, so it may differ from the actual frequency.'
	String get frequencyDetail => 'The current value only counts consumption events you chose to record, so it may differ from the actual frequency.';

	/// en: 'View my starting point'
	String get open => 'View my starting point';
}

// Path: settings.support.values
class Translations$settings$support$values$en {
	Translations$settings$support$values$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Free'
	String get free => 'Free';

	/// en: 'Open source'
	String get openSource => 'Open source';

	/// en: 'No ads'
	String get noAds => 'No ads';

	/// en: 'No trackers'
	String get noTracking => 'No trackers';
}

// Path: settings.support.error
class Translations$settings$support$error$en {
	Translations$settings$support$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This link could not be opened right now.'
	String get link => 'This link could not be opened right now.';

	/// en: 'In-app support is not configured in this build yet.'
	String get notConfigured => 'In-app support is not configured in this build yet.';

	/// en: 'The support page could not be displayed right now.'
	String get paywall => 'The support page could not be displayed right now.';
}

// Path: settings.reminders.daily
class Translations$settings$reminders$daily$en {
	Translations$settings$reminders$daily$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Daily check-in reminder'
	String get label => 'Daily check-in reminder';

	/// en: 'At 8:00 PM, notify me only if today's check-in is still empty.'
	String get description => 'At 8:00 PM, notify me only if today\'s check-in is still empty.';

	/// en: 'Daily reminders are not available on this device.'
	String get unavailable => 'Daily reminders are not available on this device.';
}

// Path: settings.reminders.error
class Translations$settings$reminders$error$en {
	Translations$settings$reminders$error$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications were not allowed in the system settings.'
	String get permissionDenied => 'Notifications were not allowed in the system settings.';

	/// en: 'The daily reminder could not be updated.'
	String get save => 'The daily reminder could not be updated.';
}

// Path: settings.progress.harvest
class Translations$settings$progress$harvest$en {
	Translations$settings$progress$harvest$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Harvest'
	String get label => 'Harvest';

	/// en: 'Collect at most one corn point per constructive day. Your harvest never decreases.'
	String get description => 'Collect at most one corn point per constructive day. Your harvest never decreases.';
}

// Path: settings.personalPlan.goal
class Translations$settings$personalPlan$goal$en {
	Translations$settings$personalPlan$goal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My goal'
	String get label => 'My goal';

	/// en: 'No active goal'
	String get none => 'No active goal';
}

// Path: settings.personalPlan.backup
class Translations$settings$personalPlan$backup$en {
	Translations$settings$personalPlan$backup$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My backup plan'
	String get title => 'My backup plan';

	/// en: 'Prioritize actions you can realistically try in a difficult moment.'
	String get description => 'Prioritize actions you can realistically try in a difficult moment.';

	/// en: '(zero) {No action selected} (one) {$count action selected} (other) {$count actions selected}'
	String summary({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		zero: 'No action selected',
		one: '${count} action selected',
		other: '${count} actions selected',
	);
}

// Path: settings.personalPlan.history
class Translations$settings$personalPlan$history$en {
	Translations$settings$personalPlan$history$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Goal history'
	String get title => 'Goal history';

	/// en: 'The directions you have set so far'
	String get subtitle => 'The directions you have set so far';

	/// en: 'See the history'
	String get open => 'See the history';

	/// en: 'Current'
	String get current => 'Current';

	/// en: 'Ended on $date'
	String ended({required Object date}) => 'Ended on ${date}';

	/// en: 'Started on $date'
	String started({required Object date}) => 'Started on ${date}';

	/// en: 'You have not set a goal yet.'
	String get empty => 'You have not set a goal yet.';

	/// en: 'The goal history could not be loaded.'
	String get error => 'The goal history could not be loaded.';

	/// en: '(one) {$count goal} (other) {$count goals}'
	String count({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} goal',
		other: '${count} goals',
	);

	/// en: '(one) {$count event per week} (other) {$count events per week}'
	String weeklyLimit({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} event per week',
		other: '${count} events per week',
	);

	/// en: 'Protected contexts: $contexts'
	String contexts({required Object contexts}) => 'Protected contexts: ${contexts}';
}

// Path: settings.data.errorReporting
class Translations$settings$data$errorReporting$en {
	Translations$settings$data$errorReporting$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Anonymous crash reports'
	String get label => 'Anonymous crash reports';

	/// en: 'Sends a technical report when StopCorn crashes, so the problem can be fixed. It contains no goal, journal record, note, or preference value. Turn this off to send nothing at all.'
	String get description => 'Sends a technical report when StopCorn crashes, so the problem can be fixed. It contains no goal, journal record, note, or preference value. Turn this off to send nothing at all.';
}

// Path: settings.data.export
class Translations$settings$data$export$en {
	Translations$settings$data$export$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Export my data'
	String get title => 'Export my data';

	/// en: 'Create a versioned JSON file.'
	String get description => 'Create a versioned JSON file.';
}

// Path: settings.data.stored
class Translations$settings$data$stored$en {
	Translations$settings$data$stored$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What is stored'
	String get title => 'What is stored';

	/// en: 'Understand local data.'
	String get description => 'Understand local data.';

	/// en: 'StopCorn locally stores your goals, check-ins, support sessions, voluntary events, strategies used, and learning progress.'
	String get body1 => 'StopCorn locally stores your goals, check-ins, support sessions, voluntary events, strategies used, and learning progress.';

	/// en: 'The app never collects URLs, browser history, searches, screenshots, contacts, or location.'
	String get body2 => 'The app never collects URLs, browser history, searches, screenshots, contacts, or location.';

	/// en: 'Depending on system settings, a phone backup may include app data.'
	String get body3 => 'Depending on system settings, a phone backup may include app data.';
}

// Path: settings.data.delete
class Translations$settings$data$delete$en {
	Translations$settings$data$delete$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete all my data'
	String get action => 'Delete all my data';

	/// en: 'Permanent action in two steps.'
	String get description => 'Permanent action in two steps.';

	/// en: 'Deleting…'
	String get progress => 'Deleting…';

	/// en: 'Confirm deletion'
	String get semantics => 'Confirm deletion';

	/// en: 'Delete all data?'
	String get title => 'Delete all data?';

	/// en: 'Goals, observations, notes, check-ins, progress, preferences, and cached exports will be erased from this device. This action is permanent.'
	String get body => 'Goals, observations, notes, check-ins, progress, preferences, and cached exports will be erased from this device. This action is permanent.';

	/// en: 'Deletion could not be completed. Some data may already be erased; try again to finish.'
	String get error => 'Deletion could not be completed. Some data may already be erased; try again to finish.';

	late final Translations$settings$data$delete$confirmation$en confirmation = Translations$settings$data$delete$confirmation$en.internal(_root);
}

// Path: settings.developer.sample
class Translations$settings$developer$sample$en {
	Translations$settings$developer$sample$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Load sample data'
	String get action => 'Load sample data';

	/// en: 'Add a coherent 60-day local history without deleting your existing records.'
	String get description => 'Add a coherent 60-day local history without deleting your existing records.';

	/// en: 'Loading sample data…'
	String get progress => 'Loading sample data…';

	/// en: 'Sample data loaded. You can reload it at any time.'
	String get loaded => 'Sample data loaded. You can reload it at any time.';

	/// en: 'Sample data could not be loaded.'
	String get error => 'Sample data could not be loaded.';
}

// Path: settings.developer.cornPoint
class Translations$settings$developer$cornPoint$en {
	Translations$settings$developer$cornPoint$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Grant a Corn point'
	String get action => 'Grant a Corn point';

	/// en: 'Add a bonus point and open the animated dialog, even when today's Corn point is already collected.'
	String get description => 'Add a bonus point and open the animated dialog, even when today\'s Corn point is already collected.';
}

// Path: settings.developer.supportThanks
class Translations$settings$developer$supportThanks$en {
	Translations$settings$developer$supportThanks$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show the support thank-you'
	String get label => 'Show the support thank-you';

	/// en: 'Locally shows the thank-you note in the support card without a RevenueCat purchase.'
	String get description => 'Locally shows the thank-you note in the support card without a RevenueCat purchase.';
}

// Path: settings.about.privacy
class Translations$settings$about$privacy$en {
	Translations$settings$about$privacy$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Privacy'
	String get title => 'Privacy';

	/// en: 'No StopCorn account is created and daily self-help use involves no usage tracking, audience analytics, or advertising.'
	String get body1 => 'No StopCorn account is created and daily self-help use involves no usage tracking, audience analytics, or advertising.';

	/// en: 'All observations stay on this device unless you explicitly create and share an export.'
	String get body2 => 'All observations stay on this device unless you explicitly create and share an export.';

	/// en: 'StopCorn only contacts RevenueCat if you open the support page yourself: displaying Settings stays a local operation. After that, the application checks on launch whether a purchase exists, so it can thank you. RevenueCat and your device's store then process the information needed for a purchase, without your private notes. StopCorn disables diagnostics and advertising-identifier collection.'
	String get body3 => 'StopCorn only contacts RevenueCat if you open the support page yourself: displaying Settings stays a local operation. After that, the application checks on launch whether a purchase exists, so it can thank you. RevenueCat and your device\'s store then process the information needed for a purchase, without your private notes. StopCorn disables diagnostics and advertising-identifier collection.';

	/// en: 'Complete deletion erases StopCorn user data and preferences, then returns the app to its initial state.'
	String get body4 => 'Complete deletion erases StopCorn user data and preferences, then returns the app to its initial state.';

	/// en: 'View the privacy policy'
	String get policyAction => 'View the privacy policy';

	/// en: 'The privacy policy could not be opened right now.'
	String get policyError => 'The privacy policy could not be opened right now.';

	/// en: 'Anonymous crash reports are sent through Sentry so failures can be fixed. They contain the technical error and where it happened, never a goal, a journal record, a note, or a database value. The switch in the Data section stops them completely.'
	String get body5 => 'Anonymous crash reports are sent through Sentry so failures can be fixed. They contain the technical error and where it happened, never a goal, a journal record, a note, or a database value. The switch in the Data section stops them completely.';
}

// Path: settings.about.help
class Translations$settings$about$help$en {
	Translations$settings$about$help$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Professional help'
	String get title => 'Professional help';

	/// en: 'A general practitioner, psychologist, or another qualified professional can help assess the situation and suggest suitable support.'
	String get body1 => 'A general practitioner, psychologist, or another qualified professional can help assess the situation and suggest suitable support.';

	/// en: 'Seeking help may be useful if distress is severe, loss of control persists, or consequences become significant.'
	String get body2 => 'Seeking help may be useful if distress is severe, loss of control persists, or consequences become significant.';

	/// en: 'StopCorn does not diagnose and cannot replace that support.'
	String get body3 => 'StopCorn does not diagnose and cannot replace that support.';
}

// Path: settings.goalEditor.validation
class Translations$settings$goalEditor$validation$en {
	Translations$settings$goalEditor$validation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enter a positive weekly limit.'
	String get weeklyLimit => 'Enter a positive weekly limit.';

	/// en: 'Choose at least one context.'
	String get context => 'Choose at least one context.';
}

// Path: urge.result.outcome
class Translations$urge$result$outcome$en {
	Translations$urge$result$outcome$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'And now?'
	String get title => 'And now?';

	/// en: 'Feel free to be honest. As always, no judgement!'
	String get subtitle => 'Feel free to be honest. As always, no judgement!';

	/// en: 'Outcome'
	String get label => 'Outcome';
}

// Path: learningModules.continueAfterSetback.sections.perspective
class Translations$learningModules$continueAfterSetback$sections$perspective$en {
	Translations$learningModules$continueAfterSetback$sections$perspective$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Move beyond “everything is ruined”'
	String get title => 'Move beyond “everything is ruined”';

	/// en: 'One event does not erase the pauses, choices, and observations you have already made.'
	String get paragraph1 => 'One event does not erase the pauses, choices, and observations you have already made.';

	/// en: 'The thought that everything is ruined can push you to abandon a plan that is still useful.'
	String get paragraph2 => 'The thought that everything is ruined can push you to abandon a plan that is still useful.';
}

// Path: learningModules.continueAfterSetback.sections.adjust
class Translations$learningModules$continueAfterSetback$sections$adjust$en {
	Translations$learningModules$continueAfterSetback$sections$adjust$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Adjust rather than punish'
	String get title => 'Adjust rather than punish';

	/// en: 'Look at what came before: time, tiredness, emotion, device, or general context.'
	String get paragraph1 => 'Look at what came before: time, tiredness, emotion, device, or general context.';

	/// en: 'Then choose one limited adjustment. Punishment or an unrealistic goal rarely provides useful information.'
	String get paragraph2 => 'Then choose one limited adjustment. Punishment or an unrealistic goal rarely provides useful information.';
}

// Path: learningModules.continueAfterSetback.sections.help
class Translations$learningModules$continueAfterSetback$sections$help$en {
	Translations$learningModules$continueAfterSetback$sections$help$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Know when to ask for help'
	String get title => 'Know when to ask for help';

	/// en: 'If loss of control persists, causes severe distress, or has significant consequences, talking to a qualified professional may help.'
	String get paragraph1 => 'If loss of control persists, causes severe distress, or has significant consequences, talking to a qualified professional may help.';

	/// en: 'Asking for help can be part of the plan; it does not take away from progress already made.'
	String get paragraph2 => 'Asking for help can be part of the plan; it does not take away from progress already made.';
}

// Path: learningModules.mapTerrain.sections.states
class Translations$learningModules$mapTerrain$sections$states$en {
	Translations$learningModules$mapTerrain$sections$states$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Times and states'
	String get title => 'Times and states';

	/// en: 'Time and place can become recurring context cues. Stress, boredom, or trying to get some distance from a difficult emotion may also appear in your observations.'
	String get paragraph1 => 'Time and place can become recurring context cues. Stress, boredom, or trying to get some distance from a difficult emotion may also appear in your observations.';

	/// en: 'Treat these repetitions as hypotheses, not causes: several observations over time are more informative than one coincidence.'
	String get paragraph2 => 'Treat these repetitions as hypotheses, not causes: several observations over time are more informative than one coincidence.';
}

// Path: learningModules.mapTerrain.sections.routines
class Translations$learningModules$mapTerrain$sections$routines$en {
	Translations$learningModules$mapTerrain$sections$routines$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Devices and routines'
	String get title => 'Devices and routines';

	/// en: 'A device available in the same place and at the same time can make an automatic response easier.'
	String get paragraph1 => 'A device available in the same place and at the same time can make an automatic response easier.';

	/// en: 'If your notes show that social media or an evening routine often comes first, treat it as a useful pattern—not necessarily the only cause.'
	String get paragraph2 => 'If your notes show that social media or an evening routine often comes first, treat it as a useful pattern—not necessarily the only cause.';
}

// Path: learningModules.mapTerrain.sections.map
class Translations$learningModules$mapTerrain$sections$map$en {
	Translations$learningModules$mapTerrain$sections$map$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A map, not a verdict'
	String get title => 'A map, not a verdict';

	/// en: 'Mapping your terrain helps you prepare options. It does not mean avoiding every difficult situation.'
	String get paragraph1 => 'Mapping your terrain helps you prepare options. It does not mean avoiding every difficult situation.';

	/// en: 'A few general observations are enough; no explicit detail or browsing history is useful.'
	String get paragraph2 => 'A few general observations are enough; no explicit detail or browsing history is useful.';
}

// Path: learningModules.prepareEnvironment.sections.friction
class Translations$learningModules$prepareEnvironment$sections$friction$en {
	Translations$learningModules$prepareEnvironment$sections$friction$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reduce automatic access'
	String get title => 'Reduce automatic access';

	/// en: 'Leaving the phone outside the bedroom, setting time boundaries, or using the system focus mode can add intentional friction.'
	String get paragraph1 => 'Leaving the phone outside the bedroom, setting time boundaries, or using the system focus mode can add intentional friction.';

	/// en: 'A blocker can complement a plan, but it cannot resolve a difficulty on its own.'
	String get paragraph2 => 'A blocker can complement a plan, but it cannot resolve a difficulty on its own.';
}

// Path: learningModules.prepareEnvironment.sections.moments
class Translations$learningModules$prepareEnvironment$sections$moments$en {
	Translations$learningModules$prepareEnvironment$sections$moments$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Prepare vulnerable moments'
	String get title => 'Prepare vulnerable moments';

	/// en: 'If tired evenings recur in your observations, preparing a simple routine or charging a device elsewhere can make the desired choice easier.'
	String get paragraph1 => 'If tired evenings recur in your observations, preparing a simple routine or charging a device elsewhere can make the desired choice easier.';

	/// en: 'If certain accounts or networks often come before difficult moments, you can adjust access without having to remove everything.'
	String get paragraph2 => 'If certain accounts or networks often come before difficult moments, you can adjust access without having to remove everything.';
}

// Path: learningModules.prepareEnvironment.sections.alternative
class Translations$learningModules$prepareEnvironment$sections$alternative$en {
	Translations$learningModules$prepareEnvironment$sections$alternative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Make the alternative visible'
	String get title => 'Make the alternative visible';

	/// en: 'Prepare an accessible replacement action: a book nearby, a short walk, or a task chosen in advance.'
	String get paragraph1 => 'Prepare an accessible replacement action: a book nearby, a short walk, or a task chosen in advance.';

	/// en: 'Your environment works best when it supports a specific intention.'
	String get paragraph2 => 'Your environment works best when it supports a specific intention.';
}

// Path: learningModules.rideUrge.sections.delay
class Translations$learningModules$rideUrge$sections$delay$en {
	Translations$learningModules$rideUrge$sections$delay$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Give yourself a moment'
	String get title => 'Give yourself a moment';

	/// en: 'An impulse does not require an immediate or permanent decision.'
	String get paragraph1 => 'An impulse does not require an immediate or permanent decision.';

	/// en: 'Waiting briefly gives you a chance to notice whether its intensity rises, falls, or stays stable.'
	String get paragraph2 => 'Waiting briefly gives you a chance to notice whether its intensity rises, falls, or stays stable.';
}

// Path: learningModules.rideUrge.sections.concrete
class Translations$learningModules$rideUrge$sections$concrete$en {
	Translations$learningModules$rideUrge$sections$concrete$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Change something concrete'
	String get title => 'Change something concrete';

	/// en: 'Changing rooms, putting down the phone, or starting a very small task can interrupt an automatic response.'
	String get paragraph1 => 'Changing rooms, putting down the phone, or starting a very small task can interrupt an automatic response.';

	/// en: 'Choose an action simple enough to remain possible even when your energy is low.'
	String get paragraph2 => 'Choose an action simple enough to remain possible even when your energy is low.';
}

// Path: learningModules.rideUrge.sections.expectations
class Translations$learningModules$rideUrge$sections$expectations$en {
	Translations$learningModules$rideUrge$sections$expectations$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Do not demand disappearance'
	String get title => 'Do not demand disappearance';

	/// en: 'A strategy can still be useful when the feeling does not disappear immediately.'
	String get paragraph1 => 'A strategy can still be useful when the feeling does not disappear immediately.';

	/// en: 'The aim is to practice making a choice, not to achieve a perfect result every time.'
	String get paragraph2 => 'The aim is to practice making a choice, not to achieve a perfect result every time.';
}

// Path: learningModules.understandLoop.sections.sequence
class Translations$learningModules$understandLoop$sections$sequence$en {
	Translations$learningModules$understandLoop$sections$sequence$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A sequence to observe'
	String get title => 'A sequence to observe';

	/// en: 'A habit can sometimes be described as: situation → emotion → impulse → behavior → immediate effect or relief → consequences.'
	String get paragraph1 => 'A habit can sometimes be described as: situation → emotion → impulse → behavior → immediate effect or relief → consequences.';

	/// en: 'This is a practical observation model, not a sequence proven to apply to everyone. Some stages may happen very quickly or be difficult to notice.'
	String get paragraph2 => 'This is a practical observation model, not a sequence proven to apply to everyone. Some stages may happen very quickly or be difficult to notice.';
}

// Path: learningModules.understandLoop.sections.action
class Translations$learningModules$understandLoop$sections$action$en {
	Translations$learningModules$understandLoop$sections$action$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find a point of action'
	String get title => 'Find a point of action';

	/// en: 'You do not need to control the entire loop. Changing location, waiting a few minutes, or choosing another action can create space.'
	String get paragraph1 => 'You do not need to control the entire loop. Changing location, waiting a few minutes, or choosing another action can create space.';

	/// en: 'Observing the situation and emotion can help you choose a realistic point of action.'
	String get paragraph2 => 'Observing the situation and emotion can help you choose a realistic point of action.';
}

// Path: learningModules.understandLoop.sections.observe
class Translations$learningModules$understandLoop$sections$observe$en {
	Translations$learningModules$understandLoop$sections$observe$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Observe without diagnosing'
	String get title => 'Observe without diagnosing';

	/// en: 'StopCorn notes are personal markers, not a diagnosis.'
	String get paragraph1 => 'StopCorn notes are personal markers, not a diagnosis.';

	/// en: 'The aim is to make recurring sequences more visible so you can adjust your plan.'
	String get paragraph2 => 'The aim is to make recurring sequences more visible so you can adjust your plan.';
}

// Path: learningModules.whyChange.sections.direction
class Translations$learningModules$whyChange$sections$direction$en {
	Translations$learningModules$whyChange$sections$direction$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A goal that belongs to you'
	String get title => 'A goal that belongs to you';

	/// en: 'Change is more sustainable when your chosen direction reflects what matters to you, rather than only an outside expectation.'
	String get paragraph1 => 'Change is more sustainable when your chosen direction reflects what matters to you, rather than only an outside expectation.';

	/// en: 'You may want to stop, reduce, avoid certain situations, or simply observe. None of these goals defines your worth.'
	String get paragraph2 => 'You may want to stop, reduce, avoid certain situations, or simply observe. None of these goals defines your worth.';
}

// Path: learningModules.whyChange.sections.benefits
class Translations$learningModules$whyChange$sections$benefits$en {
	Translations$learningModules$whyChange$sections$benefits$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Concrete benefits'
	String get title => 'Concrete benefits';

	/// en: 'Try to name what you would like to regain: time, mental space, sleep, a calmer relationship, or the feeling that you are choosing.'
	String get paragraph1 => 'Try to name what you would like to regain: time, mental space, sleep, a calmer relationship, or the feeling that you are choosing.';

	/// en: 'A specific motivation can be a useful marker when the impulse is strong.'
	String get paragraph2 => 'A specific motivation can be a useful marker when the impulse is strong.';
}

// Path: learningModules.whyChange.sections.changes
class Translations$learningModules$whyChange$sections$changes$en {
	Translations$learningModules$whyChange$sections$changes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Motivation changes'
	String get title => 'Motivation changes';

	/// en: 'Motivation varies from one day to the next. That variation is neither a failure nor proof that your goal is wrong.'
	String get paragraph1 => 'Motivation varies from one day to the next. That variation is neither a failure nor proof that your goal is wrong.';

	/// en: 'When motivation drops, a small action prepared in advance can take over.'
	String get paragraph2 => 'When motivation drops, a small action prepared in advance can take over.';
}

// Path: settings.data.delete.confirmation
class Translations$settings$data$delete$confirmation$en {
	Translations$settings$data$delete$confirmation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Permanent deletion'
	String get semantics => 'Permanent deletion';

	/// en: 'Final confirmation'
	String get title => 'Final confirmation';

	/// en: 'Delete permanently'
	String get action => 'Delete permanently';

	/// en: 'Keep my data'
	String get keep => 'Keep my data';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'StopCorn',
			'app.logoSemantics' => 'StopCorn corn cob logo',
			'app.urgeCueSemantics' => 'this content',
			'app.loading' => 'Loading…',
			'app.retry' => 'Try again',
			'app.cancel' => 'Cancel',
			'app.close' => 'Close',
			'app.continueLabel' => 'Continue',
			'app.back' => 'Back',
			'app.backHome' => 'Back to home',
			'app.save' => 'Save',
			'app.saving' => 'Saving…',
			'app.noChoice' => 'No selection',
			'app.unknown' => 'Unknown',
			'app.minutes' => ({required Object count}) => '${count} min',
			'app.notMedicalDisclaimer' => 'StopCorn is not a medical tool. It does not diagnose and cannot replace a health professional. If this behavior causes severe distress, persistent loss of control, or significant consequences in your life, talking to a qualified professional may help.',
			'app.technicalDetails.show' => 'Show technical details',
			'app.technicalDetails.hide' => 'Hide technical details',
			'app.splash.preparing' => 'Preparing StopCorn…',
			'app.splash.error' => 'StopCorn could not start. Your data was not changed.',
			'app.score.unanswered' => 'Optional — not answered',
			'app.score.outOfTen' => ({required Object value}) => '${value} / 10',
			'app.score.clear' => ({required Object label}) => 'Clear ${label}',
			'app.score.unansweredSemantics' => ({required Object label}) => '${label}: not answered',
			'app.score.answeredSemantics' => ({required Object label, required Object value}) => '${label}: ${value} out of 10',
			'app.moduleNumber' => ({required Object order}) => 'Module #${order}',
			'checkIn.title' => 'Daily check-in',
			'checkIn.intro.create' => 'A quick marker, in under a minute.',
			'checkIn.intro.edit' => 'Edit today\'s check-in.',
			'checkIn.mood.label' => 'Mood',
			'checkIn.mood.scale' => '0 = very difficult, 10 = very good',
			'checkIn.control.label' => 'Sense of control',
			'checkIn.control.scale' => '0 = no control, 10 = complete control',
			'checkIn.urge.count' => 'Approximate number of urges (optional)',
			'checkIn.urge.hint' => 'Example: 3',
			'checkIn.urge.negative' => 'The number cannot be negative.',
			'checkIn.consumption.recorded' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} consumption event recorded on that day.', other: '${count} consumption events recorded on that day.', ), 
			'checkIn.consumption.none' => 'No consumption event recorded on that day.',
			'checkIn.sleep.label' => 'Sleep quality (optional)',
			'checkIn.sleep.scale' => '0 = very poor, 10 = excellent',
			'checkIn.note.label' => 'Optional note',
			'checkIn.note.hint' => 'What stood out today…',
			'checkIn.saved.title' => 'Check-in saved.',
			'checkIn.saved.body' => 'These markers will help you observe trends over time.',
			'checkIn.error.load' => 'The daily check-in could not be loaded.',
			'checkIn.error.save' => 'Unable to save right now. Try again in a moment.',
			'consumption.title' => 'Record a consumption',
			'consumption.intro' => 'A few details are enough. You can skip every optional question.',
			'consumption.date' => 'Date',
			'consumption.time' => 'Time',
			'consumption.factors.label' => 'Contributing factors (optional)',
			'consumption.factors.trigger' => 'Trigger',
			'consumption.factors.emotion' => 'Emotion',
			'consumption.control.label' => 'Sense of control (optional)',
			'consumption.control.scale' => '0 = no control, 10 = complete control',
			'consumption.context.label' => 'Very short context (optional)',
			'consumption.context.hint' => 'Example: alone in the evening',
			'consumption.context.description' => 'Keep it general: no website, search, or explicit detail.',
			'consumption.contextualGoal.title' => 'Your protected contexts',
			'consumption.contextualGoal.description' => 'Select any context from your current goal that applied. This makes that goal visible in your progress without replacing the optional note below.',
			'consumption.contextualGoal.label' => 'Contexts from my goal (optional)',
			'consumption.note.label' => 'Optional note',
			'consumption.note.hint' => 'A helpful marker for later…',
			'consumption.saved.title' => 'It\'s saved.',
			'consumption.saved.body' => 'The goal is to better understand the situation, not to judge yourself.',
			'consumption.edit.title' => 'Correct this consumption',
			'consumption.error.load' => 'The form could not be prepared.',
			'consumption.error.save' => 'Unable to save right now. Try again in a moment.',
			'consumption.error.missingEvent' => 'This consumption no longer exists.',
			'context.lateEvening' => 'Late in the evening',
			'context.bedroom' => 'In the bedroom',
			'context.homeAlone' => 'Home alone',
			'context.afterSocialMedia' => 'After using social media',
			'context.duringStress' => 'During a stressful period',
			'emotion.calm' => 'Calm',
			'emotion.bored' => 'Boredom',
			'emotion.stressed' => 'Stress',
			'emotion.lonely' => 'Loneliness',
			'emotion.sad' => 'Sad',
			'emotion.angry' => 'Angry',
			'emotion.anxious' => 'Anxiety',
			'emotion.tired' => 'Tired',
			'emotion.excited' => 'Excited',
			'emotion.frustrated' => 'Frustration',
			'emotion.other' => 'Other',
			'export.title' => 'Export my data',
			'export.confirm' => 'I understand that this file may be sensitive',
			'export.backSettings' => 'Back to settings',
			'export.error' => 'The export could not be created. No data was sent.',
			'export.warning.title' => 'Before continuing',
			'export.warning.sensitive' => 'The JSON file may contain sensitive personal information: notes, goals, and observations you chose to record.',
			'export.warning.share' => 'StopCorn never sends it automatically. Once created, only the system share sheet will open.',
			'export.create.action' => 'Create and open sharing',
			'export.create.progress' => 'Creating file…',
			'export.share.subject' => 'StopCorn data export',
			'export.share.title' => 'StopCorn export',
			'goal.abstinence.title' => 'Stop',
			'goal.abstinence.description' => 'I want to stop consuming.',
			'goal.reduction.title' => 'Reduce',
			'goal.reduction.description' => 'I want to gradually reduce the frequency.',
			'goal.contextual.title' => 'Avoid certain contexts',
			'goal.contextual.description' => 'I want to regain control in certain situations.',
			'goal.observation.title' => 'Observe first',
			'goal.observation.description' => 'I want to understand my habits before setting a target.',
			'harvest.label' => 'Harvest',
			'harvest.explanationAction' => 'What\'s this?',
			'harvest.cornPoints.title' => 'Corn points',
			'harvest.cornPoints.todayCollected' => 'Today\'s corn point is collected.',
			'harvest.cornPoints.todayAvailable' => 'One constructive action is enough to collect today\'s corn point.',
			'harvest.momentum.title' => 'Momentum',
			'harvest.momentum.currentMomentum' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'Current momentum: ${count} day in a row.', other: 'Current momentum: ${count} days in a row.', ), 
			'harvest.momentum.bestMomentum' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'Best momentum: ${count} day in a row.', other: 'Best momentum: ${count} days in a row.', ), 
			'harvest.momentum.dayCollected' => 'Corn point collected on this day',
			'harvest.momentum.dayNotCollected' => 'No corn point collected on this day',
			'harvest.momentum.dayUpcoming' => 'Upcoming day',
			'harvest.reward.title' => 'Corn point collected!',
			'harvest.reward.body' => 'Your constructive action moves your harvest forward.',
			'harvest.reward.pointsSemantics' => ({required Object gain, required Object total}) => '${gain} Corn point added. New total: ${total}.',
			'harvest.reward.momentumSemantics' => ({required num total, required Object gain}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(total, one: 'Momentum increased by ${gain}. New momentum: ${total} day.', other: 'Momentum increased by ${gain}. New momentum: ${total} days.', ), 
			'harvest.reward.gain' => ({required Object count}) => '+${count}',
			'harvest.reward.continueAction' => 'Continue',
			'harvest.sheet.title' => 'How does the harvest work?',
			'harvest.sheet.intro' => 'The harvest highlights actions that help you move forward. It does not measure abstinence and never judges the outcome of a day.',
			'harvest.sheet.onePerDay' => 'You can collect at most one corn point per day. One constructive action is enough.',
			'harvest.sheet.urge' => 'Completing a support flow counts, whatever its outcome.',
			'harvest.sheet.checkIn' => 'Completing a daily check-in counts.',
			'harvest.sheet.observation' => 'Honestly recording consumption also counts: honesty is never penalized.',
			'harvest.sheet.learning' => 'Completing a learning module counts.',
			'harvest.sheet.goal' => 'Creating or updating your goal counts.',
			'harvest.sheet.momentumTitle' => 'What about momentum?',
			'harvest.sheet.momentumBody' => 'Momentum is the number of cultivated days in a row. The current day remains a grace period. If momentum ends, your harvest never shrinks and every corn point remains yours.',
			'home.load.error' => 'Today\'s data could not be loaded.',
			'home.sections.today' => 'Today',
			'home.sections.metrics' => 'Metrics',
			'home.sections.lastThirtyDays' => 'Last 30 days',
			'home.sections.quickActions' => 'Quick actions',
			'home.goal.title' => 'Goal',
			'home.goal.undefined' => 'Goal to be defined',
			'home.goal.weeklyLimit' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'Desired limit: ${count} event per week.', other: 'Desired limit: ${count} events per week.', ), 
			'home.goal.contexts' => ({required Object contexts}) => 'Protected contexts: ${contexts}.',
			'home.checkIn.title' => 'Daily check-in',
			'home.checkIn.completed' => 'Daily check-in recorded.',
			'home.checkIn.available' => 'Daily check-in available whenever you want.\nTap to record.',
			'home.checkIn.action.done' => 'Edit my daily check-in',
			'home.checkIn.action.pending' => 'Record my daily check-in',
			'home.urge.today' => 'Urges today',
			'home.urge.count' => ({required num count, required InlineSpan Function(num) countBuilder}) => RichPluralResolvers.bridge( n: count, resolver: _root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'), zero: () => TextSpan(children: [ const TextSpan(text: 'No urge recorded today.'), ]), one: () => TextSpan(children: [ countBuilder(count), const TextSpan(text: ' urge recorded today.'), ]), other: () => TextSpan(children: [ countBuilder(count), const TextSpan(text: ' urges recorded today.'), ]), ), 
			'home.urge.semantics' => 'I feel an urge to view content, take a break',
			'home.urge.action' => ({required InlineSpan corn}) => TextSpan(children: [ const TextSpan(text: 'I need '), corn, ]), 
			'home.urge.subtitle' => 'Take a break',
			'home.strategy.lastHelpful' => 'Last helpful strategy',
			'home.metrics.daysWithout' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'day without a recorded consumption event', other: 'days without a recorded consumption event', ), 
			'home.metrics.traversedUrges' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'urge moved through or reduced', other: 'urges moved through or reduced', ), 
			'home.metrics.averageControl' => 'average reported rate control',
			'home.metrics.empty' => 'Your first observations will appear here. You do not need to record everything perfectly: a few markers are enough to begin.',
			'home.actions.openJournal' => 'Open my journal',
			'home.actions.logConsumption' => 'Record a consumption event',
			'home.actions.reviewPlan' => 'Review my plan',
			'home.learningRecommendation.title' => 'Up next',
			'home.learningRecommendation.action' => 'Continue reading',
			'journal.history.title' => 'Journal',
			'journal.history.intro' => 'Find the consumption events, support sessions, and daily check-ins you chose to record, grouped by date.',
			'journal.history.error' => 'The journal could not be loaded.',
			'journal.history.empty.title' => 'Your journal is still empty',
			'journal.history.empty.body' => 'Consumption events and check-ins you record will appear here.',
			'journal.history.date.today' => 'Today',
			'journal.history.date.yesterday' => 'Yesterday',
			'journal.history.entry.consumption' => 'Consumption event',
			'journal.history.entry.checkIn' => 'Daily check-in',
			'journal.history.entry.time' => ({required Object time}) => 'At ${time}',
			'journal.history.entry.checkInSummary' => ({required Object mood, required Object control}) => 'Mood: ${mood}/10 · Control: ${control}/10',
			'journal.history.entry.noText' => 'No context or note.',
			'journal.history.entry.entries' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, zero: 'No entries', one: '${count} entry', other: '${count} entries', ), 
			'journal.history.entry.urge' => 'Support session',
			'journal.history.entry.urgeSummary' => ({required Object initial, required Object finalValue}) => 'Intensity ${initial} → ${finalValue}',
			'journal.history.entry.urgeSummaryPartial' => ({required Object initial}) => 'Starting intensity ${initial}',
			'journal.history.details.cornUrges' => ({required num count, required InlineSpan Function(num) countBuilder, required InlineSpan corn}) => RichPluralResolvers.bridge( n: count, resolver: _root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'), zero: () => TextSpan(children: [ const TextSpan(text: 'no urge of '), corn, ]), one: () => TextSpan(children: [ countBuilder(count), const TextSpan(text: ' urge of '), corn, ]), other: () => TextSpan(children: [ countBuilder(count), const TextSpan(text: ' urges of '), corn, ]), ), 
			'journal.history.details.initialIntensity' => 'Starting intensity',
			'journal.history.details.finalIntensity' => 'Intensity at the end',
			'journal.history.details.outcome' => 'Outcome',
			'journal.history.details.strategy' => 'Action tried',
			'journal.history.details.pause' => 'Guided pause',
			'journal.history.details.pauseSeconds' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} second', other: '${count} seconds', ), 
			'journal.history.details.reflection' => 'Your reflection',
			'journal.edit.action' => 'Correct',
			'journal.delete.action' => 'Delete',
			'journal.delete.title' => 'Delete this entry?',
			'journal.delete.consumption' => 'This entry and its private note will be permanently removed from your journal. Your statistics will be recalculated without it.',
			'journal.delete.checkIn' => 'This daily check-in and its private note will be permanently removed from your journal. Your statistics will be recalculated without it.',
			'journal.delete.urge' => 'This support session and the reflection written at the end will be permanently removed. The strategy tried during it stops counting; a consumption event recorded from it is kept.',
			'journal.delete.irreversible' => 'This cannot be undone.',
			'journal.delete.confirm' => 'Delete permanently',
			'journal.error.delete' => 'This entry could not be deleted. Nothing was changed.',
			'learning.subtitle' => 'Six short modules, available offline and without diagnosis.',
			'learning.semantics' => 'Learning modules',
			'learning.evidence.title' => 'What informs these modules?',
			'learning.evidence.sheetTitle' => 'Evidence and limitations',
			'learning.evidence.principles' => 'Each module cites peer-reviewed research supporting general principles about motivation, habits, self-control, mindfulness, or self-compassion.',
			'learning.evidence.limitations' => 'These sources do not clinically validate StopCorn. Some concern general behavior or smoking, and pornography-specific studies can involve limited samples. The modules provide cautious educational guidance, not a diagnosis or treatment.',
			'learning.sources.title' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} scientific source', other: '${count} scientific sources', ), 
			'learning.sources.shortDescription' => 'References and scope of the evidence',
			'learning.sources.sheetTitle' => 'Scientific sources',
			'learning.sources.scope' => 'Read each result within its population and study design: an association does not establish a cause, and a finding from another behavior or a limited sample may not generalize. These references do not prove that this module or StopCorn is a treatment.',
			'learning.module.line' => ({required Object minutes, required Object status}) => '${minutes} min · ${status}',
			'learning.module.progress' => ({required Object title}) => 'Progress for module ${title}',
			'learning.module.pageTitle' => 'Module',
			'learning.module.loadError' => 'This module could not be loaded.',
			'learning.status.completed' => 'Completed',
			'learning.status.reviewing' => 'Reading again',
			'learning.status.resume' => 'Resume reading',
			'learning.status.discover' => 'Discover',
			'learning.reading.progress' => 'Module reading progress',
			'learning.reading.part' => ({required Object current, required Object total}) => 'Part ${current} of ${total}',
			'learning.reading.previous' => 'Previous',
			'learning.reflection.optional' => 'Optional reflection',
			'learning.reflection.label' => 'My reflection',
			'learning.reflection.hint' => 'A few words for yourself…',
			'learning.reflection.localNote' => 'This note stays only on your device.',
			'learning.reflection.continueAction' => 'Continue to reflection',
			'learning.reflection.yours' => 'Your reflection',
			'learning.completion.title' => 'Module completed',
			'learning.completion.finish' => 'Finish module',
			'learning.completion.restart' => 'Restart module',
			'learning.completion.back' => 'Back to modules',
			'learning.error.load' => 'Modules could not be loaded.',
			'learning.error.save' => 'Unable to save your progress right now. Try again.',
			'learningModules.continueAfterSetback.title' => 'Continue after a setback',
			'learningModules.continueAfterSetback.summary' => 'Turn an event into useful information, without judgment.',
			'learningModules.continueAfterSetback.sections.perspective.title' => 'Move beyond “everything is ruined”',
			'learningModules.continueAfterSetback.sections.perspective.paragraph1' => 'One event does not erase the pauses, choices, and observations you have already made.',
			'learningModules.continueAfterSetback.sections.perspective.paragraph2' => 'The thought that everything is ruined can push you to abandon a plan that is still useful.',
			'learningModules.continueAfterSetback.sections.adjust.title' => 'Adjust rather than punish',
			'learningModules.continueAfterSetback.sections.adjust.paragraph1' => 'Look at what came before: time, tiredness, emotion, device, or general context.',
			'learningModules.continueAfterSetback.sections.adjust.paragraph2' => 'Then choose one limited adjustment. Punishment or an unrealistic goal rarely provides useful information.',
			'learningModules.continueAfterSetback.sections.help.title' => 'Know when to ask for help',
			'learningModules.continueAfterSetback.sections.help.paragraph1' => 'If loss of control persists, causes severe distress, or has significant consequences, talking to a qualified professional may help.',
			'learningModules.continueAfterSetback.sections.help.paragraph2' => 'Asking for help can be part of the plan; it does not take away from progress already made.',
			'learningModules.continueAfterSetback.reflectionPrompt' => 'What useful information can you take from the last event without judging yourself?',
			'learningModules.mapTerrain.title' => 'Map your terrain',
			'learningModules.mapTerrain.summary' => 'Identify situations that recur in your observations.',
			'learningModules.mapTerrain.sections.states.title' => 'Times and states',
			'learningModules.mapTerrain.sections.states.paragraph1' => 'Time and place can become recurring context cues. Stress, boredom, or trying to get some distance from a difficult emotion may also appear in your observations.',
			'learningModules.mapTerrain.sections.states.paragraph2' => 'Treat these repetitions as hypotheses, not causes: several observations over time are more informative than one coincidence.',
			'learningModules.mapTerrain.sections.routines.title' => 'Devices and routines',
			'learningModules.mapTerrain.sections.routines.paragraph1' => 'A device available in the same place and at the same time can make an automatic response easier.',
			'learningModules.mapTerrain.sections.routines.paragraph2' => 'If your notes show that social media or an evening routine often comes first, treat it as a useful pattern—not necessarily the only cause.',
			'learningModules.mapTerrain.sections.map.title' => 'A map, not a verdict',
			'learningModules.mapTerrain.sections.map.paragraph1' => 'Mapping your terrain helps you prepare options. It does not mean avoiding every difficult situation.',
			'learningModules.mapTerrain.sections.map.paragraph2' => 'A few general observations are enough; no explicit detail or browsing history is useful.',
			'learningModules.mapTerrain.reflectionPrompt' => 'Which situation appears most often in your observations?',
			'learningModules.prepareEnvironment.title' => 'Prepare your environment',
			'learningModules.prepareEnvironment.summary' => 'Add friction and make your chosen actions easier.',
			'learningModules.prepareEnvironment.sections.friction.title' => 'Reduce automatic access',
			'learningModules.prepareEnvironment.sections.friction.paragraph1' => 'Leaving the phone outside the bedroom, setting time boundaries, or using the system focus mode can add intentional friction.',
			'learningModules.prepareEnvironment.sections.friction.paragraph2' => 'A blocker can complement a plan, but it cannot resolve a difficulty on its own.',
			'learningModules.prepareEnvironment.sections.moments.title' => 'Prepare vulnerable moments',
			'learningModules.prepareEnvironment.sections.moments.paragraph1' => 'If tired evenings recur in your observations, preparing a simple routine or charging a device elsewhere can make the desired choice easier.',
			'learningModules.prepareEnvironment.sections.moments.paragraph2' => 'If certain accounts or networks often come before difficult moments, you can adjust access without having to remove everything.',
			'learningModules.prepareEnvironment.sections.alternative.title' => 'Make the alternative visible',
			'learningModules.prepareEnvironment.sections.alternative.paragraph1' => 'Prepare an accessible replacement action: a book nearby, a short walk, or a task chosen in advance.',
			'learningModules.prepareEnvironment.sections.alternative.paragraph2' => 'Your environment works best when it supports a specific intention.',
			'learningModules.prepareEnvironment.reflectionPrompt' => 'What change to your environment could you make today?',
			'learningModules.rideUrge.title' => 'Ride out an impulse',
			'learningModules.rideUrge.summary' => 'Create a little space before choosing what comes next.',
			'learningModules.rideUrge.sections.delay.title' => 'Give yourself a moment',
			'learningModules.rideUrge.sections.delay.paragraph1' => 'An impulse does not require an immediate or permanent decision.',
			'learningModules.rideUrge.sections.delay.paragraph2' => 'Waiting briefly gives you a chance to notice whether its intensity rises, falls, or stays stable.',
			'learningModules.rideUrge.sections.concrete.title' => 'Change something concrete',
			'learningModules.rideUrge.sections.concrete.paragraph1' => 'Changing rooms, putting down the phone, or starting a very small task can interrupt an automatic response.',
			'learningModules.rideUrge.sections.concrete.paragraph2' => 'Choose an action simple enough to remain possible even when your energy is low.',
			'learningModules.rideUrge.sections.expectations.title' => 'Do not demand disappearance',
			'learningModules.rideUrge.sections.expectations.paragraph1' => 'A strategy can still be useful when the feeling does not disappear immediately.',
			'learningModules.rideUrge.sections.expectations.paragraph2' => 'The aim is to practice making a choice, not to achieve a perfect result every time.',
			'learningModules.rideUrge.reflectionPrompt' => 'Which realistic strategy could you try during the next difficult moment?',
			'learningModules.understandLoop.title' => 'Understand the loop',
			'learningModules.understandLoop.summary' => 'Notice the stages that can keep a habit going.',
			'learningModules.understandLoop.sections.sequence.title' => 'A sequence to observe',
			'learningModules.understandLoop.sections.sequence.paragraph1' => 'A habit can sometimes be described as: situation → emotion → impulse → behavior → immediate effect or relief → consequences.',
			'learningModules.understandLoop.sections.sequence.paragraph2' => 'This is a practical observation model, not a sequence proven to apply to everyone. Some stages may happen very quickly or be difficult to notice.',
			'learningModules.understandLoop.sections.action.title' => 'Find a point of action',
			'learningModules.understandLoop.sections.action.paragraph1' => 'You do not need to control the entire loop. Changing location, waiting a few minutes, or choosing another action can create space.',
			'learningModules.understandLoop.sections.action.paragraph2' => 'Observing the situation and emotion can help you choose a realistic point of action.',
			'learningModules.understandLoop.sections.observe.title' => 'Observe without diagnosing',
			'learningModules.understandLoop.sections.observe.paragraph1' => 'StopCorn notes are personal markers, not a diagnosis.',
			'learningModules.understandLoop.sections.observe.paragraph2' => 'The aim is to make recurring sequences more visible so you can adjust your plan.',
			'learningModules.understandLoop.reflectionPrompt' => 'Which part of the loop seems easiest to change this week?',
			'learningModules.whyChange.title' => 'Why change?',
			'learningModules.whyChange.summary' => 'Clarify what you want to regain or protect.',
			'learningModules.whyChange.sections.direction.title' => 'A goal that belongs to you',
			'learningModules.whyChange.sections.direction.paragraph1' => 'Change is more sustainable when your chosen direction reflects what matters to you, rather than only an outside expectation.',
			'learningModules.whyChange.sections.direction.paragraph2' => 'You may want to stop, reduce, avoid certain situations, or simply observe. None of these goals defines your worth.',
			'learningModules.whyChange.sections.benefits.title' => 'Concrete benefits',
			'learningModules.whyChange.sections.benefits.paragraph1' => 'Try to name what you would like to regain: time, mental space, sleep, a calmer relationship, or the feeling that you are choosing.',
			'learningModules.whyChange.sections.benefits.paragraph2' => 'A specific motivation can be a useful marker when the impulse is strong.',
			'learningModules.whyChange.sections.changes.title' => 'Motivation changes',
			'learningModules.whyChange.sections.changes.paragraph1' => 'Motivation varies from one day to the next. That variation is neither a failure nor proof that your goal is wrong.',
			'learningModules.whyChange.sections.changes.paragraph2' => 'When motivation drops, a small action prepared in advance can take over.',
			'learningModules.whyChange.reflectionPrompt' => 'What would you like to regain or protect by changing this habit?',
			'licenses.title' => 'Open-source licenses',
			'licenses.intro' => 'StopCorn uses open-source components. Select an entry to read its license text.',
			'licenses.loadError' => 'Licenses could not be loaded.',
			'licenses.otherComponent' => 'Other component',
			'locale.label' => 'App language',
			'locale.english' => 'English',
			'locale.french' => 'French',
			'locale.section.title' => 'Language',
			'locale.section.description' => 'Choose the language used throughout the app.',
			'navigation.home.item' => 'Home',
			'navigation.home.title' => 'Hello',
			'navigation.progress' => 'Progress',
			'navigation.learn' => 'Learn',
			'navigation.settings' => 'Settings',
			'notifications.dailyCheckIn.title' => 'Your StopCorn check-in is waiting',
			'notifications.dailyCheckIn.body' => 'Take a moment to note how your day went.',
			'notifications.dailyCheckIn.channelName' => 'Daily check-in reminders',
			'notifications.dailyCheckIn.channelDescription' => 'A local reminder at 8:00 PM when the daily check-in is still empty.',
			'onboarding.pageTitle' => 'Setup',
			'onboarding.step' => ({required Object current, required Object total}) => 'Step ${current} of ${total}',
			'onboarding.welcome.title' => 'Regain control, without judgment',
			'onboarding.welcome.subtitle' => 'StopCorn helps you understand your habits, navigate difficult moments, and build a plan that fits your goal.',
			'onboarding.welcome.noAccount' => 'No account required',
			'onboarding.welcome.localData' => 'Data kept on this device',
			'onboarding.welcome.noAds' => 'No advertising',
			'onboarding.welcome.selfHelp' => 'A self-help tool',
			'onboarding.welcome.privacyAction' => 'Learn more about privacy',
			'onboarding.welcome.privacyTitle' => 'Privacy from the start',
			'onboarding.welcome.privacyBody' => 'No journal data is sent to StopCorn. The application does not read your browser, your searches, or the content you look at. You only choose the general markers you want to record. If the application crashes, an anonymous technical report can be sent so the problem gets fixed; it carries none of your entries and can be turned off in Settings.',
			'onboarding.goal.title' => 'What would you like to change?',
			'onboarding.goal.subtitle' => 'Choose a direction that feels right. You can change it later.',
			'onboarding.goal.semantics' => 'Goal selection',
			'onboarding.goal.weeklyLimit' => 'Desired weekly limit',
			'onboarding.goal.weeklyHint' => 'Example: 2',
			'onboarding.goal.contexts' => 'Contexts to avoid',
			'onboarding.goal.motivation' => 'Personal motivation',
			'onboarding.goal.motivationHint' => 'What you would like to regain or protect…',
			'onboarding.baseline.title' => 'Your starting point',
			'onboarding.baseline.subtitle' => 'This is not a medical test. It will only help you observe your progress.',
			'onboarding.baseline.frequency' => 'Approximate frequency over the last 7 days',
			'onboarding.baseline.control' => 'Sense of control',
			'onboarding.baseline.impact' => 'Perceived negative impact',
			'onboarding.baseline.confidence' => 'Confidence in your ability to change',
			'onboarding.strategies.title' => 'Prepare your backup plan',
			'onboarding.strategies.subtitle' => 'Ideally choose three realistic actions. One is enough to continue.',
			'onboarding.strategies.selected' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, zero: 'No strategy selected', one: '${count} strategy selected', other: '${count} strategies selected', ), 
			'onboarding.strategies.semantics' => 'Backup strategies',
			'onboarding.privacy.title' => 'Your data stays under your control',
			'onboarding.privacy.subtitle' => 'This version of StopCorn works without an account or server.',
			'onboarding.privacy.local' => 'Data is stored only on this device.',
			'onboarding.privacy.noHistory' => 'No URL or search is recorded.',
			'onboarding.privacy.control' => 'You can voluntarily export or completely erase your data.',
			'onboarding.privacy.backup' => 'Your phone\'s system backups may include app data depending on your system settings.',
			'onboarding.privacy.dailyCheckInReminder' => 'Remind me to check in',
			'onboarding.privacy.dailyCheckInReminderDescription' => 'At 8:00 PM, receive a local reminder only if today\'s check-in is still empty. You can change this later.',
			'onboarding.privacy.reminderPermissionDenied' => 'Notifications were not allowed. Turn this option off to continue, or allow notifications and try again.',
			'onboarding.privacy.reminderUnavailable' => 'Daily reminders are not available on this device.',
			'onboarding.privacy.reminderError' => 'The daily reminder could not be prepared. Try again or turn it off to continue.',
			'onboarding.privacy.crashReports' => 'Anonymous crash reports help fix bugs, and can be turned off in Settings.',
			'onboarding.start' => 'Start',
			'onboarding.finish' => 'Finish setup',
			'onboarding.error.load' => 'Setup could not be loaded.',
			'onboarding.error.save' => 'Unable to save right now. Try again in a moment.',
			'onboarding.error.complete' => 'Setup could not be completed. No data was sent.',
			'onboarding.error.notReady' => 'Onboarding is not ready yet.',
			'onboarding.error.invalidDraft' => 'The saved setup draft is invalid.',
			'onboarding.validation.goal' => 'Choose a goal.',
			'onboarding.validation.weeklyLimit' => 'Enter a positive weekly limit.',
			'onboarding.validation.context' => 'Choose at least one context.',
			'onboarding.validation.strategy' => 'Choose at least one strategy.',
			'onboarding.validation.scoreRange' => 'Scores must be between 0 and 10.',
			'outcome.passed' => 'The urge passed',
			'outcome.reduced' => 'It decreased',
			'outcome.delayed' => 'I will wait',
			'outcome.consumed' => 'I will consume',
			'outcome.abandoned' => 'I prefer to stop this flow now',
			'period.sevenDays' => '7 days',
			'period.thirtyDays' => '30 days',
			'period.ninetyDays' => '90 days',
			'period.all' => 'All',
			'progress.subtitle' => 'Descriptive markers built only from what you chose to record.',
			'progress.error.load' => 'Progress data could not be loaded.',
			'progress.overview.title' => 'Overview',
			'progress.overview.events' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'recorded consumption event', other: 'recorded consumption events', ), 
			'progress.overview.daysWithout' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'day without a recorded consumption event', other: 'days without a recorded consumption event', ), 
			'progress.overview.completedUrges' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'completed support session', other: 'completed support sessions', ), 
			'progress.overview.averageDecrease' => 'average intensity decrease',
			'progress.overview.notEnough' => 'Not enough data yet',
			'progress.overview.decreaseDetail' => 'The difference between the initial intensity and the final intensity',
			'progress.overview.goal.abstinence' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} consumption event was voluntarily recorded during the selected period. Missing observations never prove that no event occurred.', other: '${count} consumption events were voluntarily recorded during the selected period. Missing observations never prove that no event occurred.', ), 
			'progress.overview.goal.reduction' => ({required num count, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'This week: ${count} recorded event for a desired limit of ${limit}.', other: 'This week: ${count} recorded events for a desired limit of ${limit}.', ), 
			'progress.overview.goal.contextual' => ({required num count, required Object contexts}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} recorded event matched one of your protected contexts during the selected period: ${contexts}.', other: '${count} recorded events matched one of your protected contexts during the selected period: ${contexts}.', ), 
			'progress.overview.goal.observation' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} voluntary marker was recorded during the selected period. Every honest observation helps reveal patterns.', other: '${count} voluntary markers were recorded during the selected period. Every honest observation helps reveal patterns.', ), 
			'progress.overview.empty' => 'Not enough data yet. A few markers will be enough for trends to appear.',
			'progress.events.title' => 'Event trends',
			'progress.events.weeklyTitle' => 'Weekly trend',
			'progress.events.empty' => 'No event was recorded during this period.',
			'progress.events.weekOf' => ({required Object date}) => 'Week of ${date}',
			'progress.events.summary' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} voluntarily recorded event, grouped by week.', other: '${count} voluntarily recorded events, grouped by week.', ), 
			'progress.urges.title' => ({required InlineSpan corn}) => TextSpan(children: [ const TextSpan(text: 'Urges of '), corn, ]), 
			'progress.urges.averageIntensity' => 'Average intensity',
			'progress.urges.empty' => 'Not enough completed sessions with a final intensity yet.',
			'progress.urges.initial' => 'Initial',
			'progress.urges.observationHours' => 'Observation times',
			'progress.urges.noHours' => 'No time has been recorded for a support session or event.',
			'progress.urges.comparison.unavailable' => 'Not enough data yet to compare the beginning and end of support sessions.',
			'progress.urges.comparison.decrease' => ({required num count, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'Intensity decreased by an average of ${value} point during complete sessions.', other: 'Intensity decreased by an average of ${value} points during complete sessions.', ), 
			'progress.urges.comparison.increase' => ({required num count, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'Intensity increased by an average of ${value} point during complete sessions.', other: 'Intensity increased by an average of ${value} points during complete sessions.', ), 
			'progress.urges.hourSummary' => ({required Object label}) => 'The ${label} time range contains the most recorded observations.',
			'progress.urges.timeBucket.midnight' => ({required Object start}) => '${start}:00 – midnight',
			'progress.urges.timeBucket.range' => ({required Object start, required Object end}) => '${start}:00 – ${end}:00',
			'progress.urges.finalLabel' => 'Final',
			'progress.patterns.title' => 'Triggers and emotions',
			'progress.patterns.triggers.title' => 'Most recorded triggers',
			'progress.patterns.triggers.kind' => 'trigger',
			'progress.patterns.triggers.empty' => 'No trigger has been recorded yet.',
			'progress.patterns.emotions.title' => 'Most recorded emotions',
			'progress.patterns.emotions.kind' => 'emotion',
			'progress.patterns.emotions.empty' => 'No emotion has been recorded yet.',
			'progress.patterns.rankingSummary' => ({required Object label, required Object kind}) => '${label} is the most frequently recorded ${kind} during this period.',
			'progress.strategies.title' => 'Strategies',
			'progress.strategies.effectiveness' => 'Perceived effectiveness',
			'progress.strategies.empty' => 'No strategy was rated during this period. The scale runs from −5 to +5.',
			'progress.strategies.evaluations' => ({required num count, required Object effect}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${effect} (${count} rating)', other: '${effect} (${count} ratings)', ), 
			'progress.strategies.threshold' => 'Use and rate a strategy at least three times to get a more reliable marker.',
			'progress.strategies.best' => ({required Object strategy}) => '${strategy} is the highest-rated strategy among those used at least three times.',
			'progress.checkIns.title' => 'Check-ins',
			'progress.checkIns.count' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'daily check-in', other: 'daily check-ins', ), 
			'progress.checkIns.averageMood' => 'average mood rate',
			'progress.checkIns.averageControl' => 'average control rate',
			'progress.checkIns.outOfTen' => 'Out of 10',
			'progress.comparison.unavailable' => 'Not enough comparable data yet',
			'progress.comparison.stable' => 'Stable compared with the previous period',
			'progress.comparison.value' => ({required Object value, required Object direction}) => '${value}% ${direction} than the previous period',
			'progress.comparison.more' => 'more',
			'progress.comparison.less' => 'less',
			'progress.startingPoint.sectionTitle' => 'Comparison with my starting point',
			'progress.startingPoint.screenTitle' => 'My starting point',
			'progress.startingPoint.intro' => 'These answers were recorded during your initial setup. They are a personal reference point, not a diagnosis.',
			'progress.startingPoint.recordedOn' => ({required Object date}) => 'Initial assessment recorded on ${date}.',
			'progress.startingPoint.goalTitle' => 'Your initial goal',
			'progress.startingPoint.goalUnavailable' => 'Your initial goal is no longer available.',
			'progress.startingPoint.weeklyLimit' => ({required Object count}) => 'Desired limit: ${count} per week',
			'progress.startingPoint.contexts' => ({required Object contexts}) => 'Selected contexts: ${contexts}',
			'progress.startingPoint.motivationTitle' => 'Your initial motivation',
			'progress.startingPoint.markersTitle' => 'Your initial markers',
			'progress.startingPoint.frequency' => 'Approximate frequency over the preceding 7 days',
			'progress.startingPoint.frequencyValue' => ({required Object count}) => '${count} over 7 days',
			'progress.startingPoint.control' => 'Sense of control',
			'progress.startingPoint.impact' => 'Perceived negative impact',
			'progress.startingPoint.confidence' => 'Confidence in your ability to change',
			'progress.startingPoint.score' => ({required Object value}) => '${value} / 10',
			'progress.startingPoint.disclaimer' => 'These values only reflect how you felt when you completed the initial assessment.',
			'progress.startingPoint.comparison.intro' => 'Compared with observations from the selected period.',
			'progress.startingPoint.comparison.control' => 'Sense of control',
			'progress.startingPoint.comparison.initial' => 'Initial',
			'progress.startingPoint.comparison.finalLabel' => 'Final',
			'progress.startingPoint.comparison.controlDetail' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, zero: 'Average calculated from ${count} daily check-in.', one: 'Average calculated from ${count} daily check-in.', other: 'Average calculated from ${count} daily check-ins.', ), 
			'progress.startingPoint.comparison.controlPending' => 'At least five daily check-ins are needed before a comparison can be shown.',
			'progress.startingPoint.comparison.frequency' => 'Weekly frequency',
			'progress.startingPoint.comparison.frequencyPending' => 'A complete week of observation is needed before a comparison can be shown.',
			'progress.startingPoint.comparison.frequencyDetail' => 'The current value only counts consumption events you chose to record, so it may differ from the actual frequency.',
			'progress.startingPoint.comparison.open' => 'View my starting point',
			'progress.startingPoint.empty' => 'No initial assessment is available.',
			'progress.startingPoint.error' => 'Your starting point could not be loaded.',
			'progress.harvest' => 'Harvest',
			'settings.support.title' => 'An open project, built to stay accessible',
			'settings.support.body' => 'StopCorn grew from a simple observation: comparable tools often end up behind a subscription or limited features. The app is therefore free and open source, with no ads or trackers, so anyone can move forward without a barrier.',
			'settings.support.values.free' => 'Free',
			'settings.support.values.openSource' => 'Open source',
			'settings.support.values.noAds' => 'No ads',
			'settings.support.values.noTracking' => 'No trackers',
			'settings.support.contribution' => 'If StopCorn helps you, you can support its development. This is entirely optional and does not unlock any feature.',
			'settings.support.supportAction' => 'Support development',
			'settings.support.collapseAction' => 'Collapse the project card',
			'settings.support.expandAction' => 'Expand the project card',
			'settings.support.sourceAction' => 'Source code',
			'settings.support.websiteAction' => 'Website',
			'settings.support.thanks' => 'Thank you! Your support helps StopCorn stay free and independent.',
			'settings.support.error.link' => 'This link could not be opened right now.',
			'settings.support.error.notConfigured' => 'In-app support is not configured in this build yet.',
			'settings.support.error.paywall' => 'The support page could not be displayed right now.',
			'settings.appearance.title' => 'Appearance',
			'settings.appearance.description' => 'Choose a theme or follow the system setting.',
			'settings.reminders.title' => 'Reminders',
			'settings.reminders.description' => 'Choose whether StopCorn should gently prompt you at the end of the day.',
			'settings.reminders.daily.label' => 'Daily check-in reminder',
			'settings.reminders.daily.description' => 'At 8:00 PM, notify me only if today\'s check-in is still empty.',
			'settings.reminders.daily.unavailable' => 'Daily reminders are not available on this device.',
			'settings.reminders.error.permissionDenied' => 'Notifications were not allowed in the system settings.',
			'settings.reminders.error.save' => 'The daily reminder could not be updated.',
			'settings.progress.title' => 'Progress',
			'settings.progress.description' => 'Adapt the indicators to what is useful to you.',
			'settings.progress.defaultPeriod' => 'Default period',
			'settings.progress.harvest.label' => 'Harvest',
			'settings.progress.harvest.description' => 'Collect at most one corn point per constructive day. Your harvest never decreases.',
			'settings.personalPlan.title' => 'Personal plan',
			'settings.personalPlan.description' => 'Keep the options you want to find quickly when you need support.',
			'settings.personalPlan.goal.label' => 'My goal',
			'settings.personalPlan.goal.none' => 'No active goal',
			'settings.personalPlan.backup.title' => 'My backup plan',
			'settings.personalPlan.backup.description' => 'Prioritize actions you can realistically try in a difficult moment.',
			'settings.personalPlan.backup.summary' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, zero: 'No action selected', one: '${count} action selected', other: '${count} actions selected', ), 
			'settings.personalPlan.history.title' => 'Goal history',
			'settings.personalPlan.history.subtitle' => 'The directions you have set so far',
			'settings.personalPlan.history.open' => 'See the history',
			'settings.personalPlan.history.current' => 'Current',
			'settings.personalPlan.history.ended' => ({required Object date}) => 'Ended on ${date}',
			'settings.personalPlan.history.started' => ({required Object date}) => 'Started on ${date}',
			'settings.personalPlan.history.empty' => 'You have not set a goal yet.',
			'settings.personalPlan.history.error' => 'The goal history could not be loaded.',
			'settings.personalPlan.history.count' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} goal', other: '${count} goals', ), 
			'settings.personalPlan.history.weeklyLimit' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} event per week', other: '${count} events per week', ), 
			'settings.personalPlan.history.contexts' => ({required Object contexts}) => 'Protected contexts: ${contexts}',
			_ => null,
		} ?? switch (path) {
			'settings.data.title' => 'Data',
			'settings.data.description' => 'Your data stays local unless you choose to export it.',
			'settings.data.errorReporting.label' => 'Anonymous crash reports',
			'settings.data.errorReporting.description' => 'Sends a technical report when StopCorn crashes, so the problem can be fixed. It contains no goal, journal record, note, or preference value. Turn this off to send nothing at all.',
			'settings.data.export.title' => 'Export my data',
			'settings.data.export.description' => 'Create a versioned JSON file.',
			'settings.data.stored.title' => 'What is stored',
			'settings.data.stored.description' => 'Understand local data.',
			'settings.data.stored.body1' => 'StopCorn locally stores your goals, check-ins, support sessions, voluntary events, strategies used, and learning progress.',
			'settings.data.stored.body2' => 'The app never collects URLs, browser history, searches, screenshots, contacts, or location.',
			'settings.data.stored.body3' => 'Depending on system settings, a phone backup may include app data.',
			'settings.data.delete.action' => 'Delete all my data',
			'settings.data.delete.description' => 'Permanent action in two steps.',
			'settings.data.delete.progress' => 'Deleting…',
			'settings.data.delete.semantics' => 'Confirm deletion',
			'settings.data.delete.title' => 'Delete all data?',
			'settings.data.delete.body' => 'Goals, observations, notes, check-ins, progress, preferences, and cached exports will be erased from this device. This action is permanent.',
			'settings.data.delete.error' => 'Deletion could not be completed. Some data may already be erased; try again to finish.',
			'settings.data.delete.confirmation.semantics' => 'Permanent deletion',
			'settings.data.delete.confirmation.title' => 'Final confirmation',
			'settings.data.delete.confirmation.action' => 'Delete permanently',
			'settings.data.delete.confirmation.keep' => 'Keep my data',
			'settings.developer.title' => 'Developer tools',
			'settings.developer.description' => 'Utilities available only in debug builds.',
			'settings.developer.sample.action' => 'Load sample data',
			'settings.developer.sample.description' => 'Add a coherent 60-day local history without deleting your existing records.',
			'settings.developer.sample.progress' => 'Loading sample data…',
			'settings.developer.sample.loaded' => 'Sample data loaded. You can reload it at any time.',
			'settings.developer.sample.error' => 'Sample data could not be loaded.',
			'settings.developer.cornPoint.action' => 'Grant a Corn point',
			'settings.developer.cornPoint.description' => 'Add a bonus point and open the animated dialog, even when today\'s Corn point is already collected.',
			'settings.developer.supportThanks.label' => 'Show the support thank-you',
			'settings.developer.supportThanks.description' => 'Locally shows the thank-you note in the support card without a RevenueCat purchase.',
			'settings.about.title' => 'About',
			'settings.about.description' => 'Information about StopCorn and its scope.',
			'settings.about.version' => ({required Object version}) => 'Version ${version}.',
			'settings.about.body' => 'StopCorn is a free, private, judgment-free self-help tool.',
			'settings.about.privacy.title' => 'Privacy',
			'settings.about.privacy.body1' => 'No StopCorn account is created and daily self-help use involves no usage tracking, audience analytics, or advertising.',
			'settings.about.privacy.body2' => 'All observations stay on this device unless you explicitly create and share an export.',
			'settings.about.privacy.body3' => 'StopCorn only contacts RevenueCat if you open the support page yourself: displaying Settings stays a local operation. After that, the application checks on launch whether a purchase exists, so it can thank you. RevenueCat and your device\'s store then process the information needed for a purchase, without your private notes. StopCorn disables diagnostics and advertising-identifier collection.',
			'settings.about.privacy.body4' => 'Complete deletion erases StopCorn user data and preferences, then returns the app to its initial state.',
			'settings.about.privacy.policyAction' => 'View the privacy policy',
			'settings.about.privacy.policyError' => 'The privacy policy could not be opened right now.',
			'settings.about.privacy.body5' => 'Anonymous crash reports are sent through Sentry so failures can be fixed. They contain the technical error and where it happened, never a goal, a journal record, a note, or a database value. The switch in the Data section stops them completely.',
			'settings.about.licenses' => 'Open-source licenses',
			'settings.about.professionalHelp' => 'Find professional help',
			'settings.about.help.title' => 'Professional help',
			'settings.about.help.body1' => 'A general practitioner, psychologist, or another qualified professional can help assess the situation and suggest suitable support.',
			'settings.about.help.body2' => 'Seeking help may be useful if distress is severe, loss of control persists, or consequences become significant.',
			'settings.about.help.body3' => 'StopCorn does not diagnose and cannot replace that support.',
			'settings.goalEditor.title' => 'Choose a new goal',
			'settings.goalEditor.history' => 'The current goal will remain in your history.',
			'settings.goalEditor.activate' => 'Activate this goal',
			'settings.goalEditor.error' => 'The goal could not be saved.',
			'settings.goalEditor.validation.weeklyLimit' => 'Enter a positive weekly limit.',
			'settings.goalEditor.validation.context' => 'Choose at least one context.',
			'settings.error.load' => 'Settings could not be loaded.',
			'settings.error.save' => 'Unable to save this setting right now.',
			'strategy.putPhoneAway' => 'Put the phone out of reach',
			'strategy.leaveRoom' => 'Leave the room',
			'strategy.walkFiveMinutes' => 'Walk for five minutes',
			'strategy.slowBreathing' => 'Breathe slowly for 90 seconds',
			'strategy.waterAndSwitch' => 'Drink a glass of water and change activity',
			'strategy.messageSomeone' => 'Message someone you chose',
			'strategy.twoMinuteTask' => 'Start a two-minute task',
			'strategy.takeShower' => 'Take a shower',
			'strategy.waitTenMinutes' => 'Wait ten minutes before deciding',
			'strategy.personal' => 'Personal strategy',
			'strategy.genericDescription' => 'A simple action to try when you need support.',
			'strategy.timerSeconds' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'Suggested timer: ${count} second.', other: 'Suggested timer: ${count} seconds.', ), 
			'strategy.timerMinutes' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: 'Suggested timer: ${count} minute.', other: 'Suggested timer: ${count} minutes.', ), 
			'theme.system' => 'Follow system',
			'theme.light' => 'Light',
			'theme.dark' => 'Dark',
			'trigger.boredom' => 'Boredom',
			'trigger.stress' => 'Stress',
			'trigger.loneliness' => 'Loneliness',
			'trigger.fatigue' => 'Tiredness',
			'trigger.habit' => 'Habit',
			'trigger.arousal' => 'Arousal',
			'trigger.socialMedia' => 'Social media',
			'trigger.relationshipDifficulty' => 'Relationship difficulty',
			'trigger.alcoholOrSubstance' => 'Alcohol or another substance',
			'trigger.bedtimePhone' => 'Phone in bed',
			'trigger.other' => 'Other',
			'urge.pauseTitle' => 'Take a break',
			'urge.quit' => 'Leave',
			'urge.support.pageTitle' => 'Choose support',
			'urge.support.title' => 'What would help right now?',
			'urge.support.subtitle' => 'Choose the option that feels most accessible. You remain in control of the pace.',
			'urge.support.semantics' => 'Available forms of support',
			'urge.support.guidedTitle' => 'Guided pause',
			'urge.support.guidedDescription' => 'Follow a short grounding pause, then check in again.',
			'urge.support.planTitle' => 'Backup plan',
			'urge.support.planDescription' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, zero: 'No action has been prepared yet.', one: 'Choose from the action you prepared.', other: 'Choose from the ${count} actions you prepared.', ), 
			'urge.support.ideasTitle' => 'Other ideas',
			'urge.support.ideasDescription' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, zero: 'No other action is available.', one: 'Explore one other action.', other: 'Explore ${count} other actions.', ), 
			'urge.grounding.feet' => 'Place your feet on the floor.',
			'urge.grounding.inhale' => 'Breathe in slowly.',
			'urge.grounding.observe' => 'Notice what you feel without trying to push it away.',
			'urge.grounding.exhale' => 'Breathe out longer than you breathe in.',
			'urge.grounding.change' => 'Simply notice whether it rises, falls, or stays stable.',
			'urge.grounding.title' => 'Give yourself a moment.',
			'urge.grounding.subtitle' => 'This short pause is an aid to relaxation, not a medical rule.',
			'urge.grounding.semantics' => 'Pause progress',
			'urge.grounding.skip' => 'Skip',
			'urge.strategy.pageTitle' => 'Choose an action',
			'urge.strategy.title' => 'What action can you try now?',
			'urge.strategy.subtitle' => 'One small, realistic action is enough. It does not need to make the feeling disappear.',
			'urge.strategy.planTitle' => 'Your backup plan',
			'urge.strategy.planSubtitle' => 'Choose one of the actions you prepared for this moment.',
			'urge.strategy.ideasTitle' => 'Other ideas',
			'urge.strategy.ideasSubtitle' => 'Choose another simple action that feels realistic right now.',
			'urge.strategy.loadError' => 'Strategies could not be loaded.',
			'urge.strategy.empty' => 'No action is available in this list.',
			'urge.strategy.semantics' => 'Available strategies',
			'urge.strategy.start' => 'Start this action',
			'urge.strategy.started' => ({required Object strategy}) => 'Action started: ${strategy}.',
			'urge.strategy.timerTitle' => 'Suggested time',
			'urge.strategy.timerGuidance' => 'This timer is only a guide: you can finish sooner or take as much time as you need.',
			'urge.strategy.timerSemantics' => 'Indicative action timer',
			'urge.strategy.timerComplete' => 'The suggested time has elapsed.',
			'urge.strategy.reassess' => 'Check in again',
			'urge.strategy.effect' => 'Perceived usefulness of the strategy',
			'urge.result.pageTitle' => 'Check in',
			'urge.result.title' => TextSpan(children: [ const TextSpan(text: 'How strong is your urge now?'), ]), 
			'urge.result.subtitle' => 'It may have increased, decreased, or stayed the same.',
			'urge.result.outcome.title' => 'And now?',
			'urge.result.outcome.subtitle' => 'Feel free to be honest. As always, no judgement!',
			'urge.result.outcome.label' => 'Outcome',
			'urge.result.note' => 'Optional note',
			'urge.result.noteHint' => 'A useful marker for next time.',
			'urge.result.finish' => 'Finish the flow',
			'urge.complete.title' => 'Flow complete',
			'urge.complete.consumedHeadline' => 'No problem.',
			'urge.complete.otherHeadline' => 'Great!',
			'urge.complete.consumedBody' => 'This event does not erase your progress.\nYou can simply note what may help next time.',
			'urge.complete.otherBody' => 'You made space between your urge and your choice.\nThis is a skill that grows one attempt at a time.',
			'urge.complete.log' => 'Record what happened',
			'urge.intensity.title' => TextSpan(children: [ const TextSpan(text: 'How strong is your urge?'), ]), 
			'urge.intensity.subtitle' => 'Rate it out of 10. There is no wrong answer: this marker will help show how it changes.',
			'urge.intensity.label' => 'Current intensity',
			'urge.factors.title' => 'More details?',
			'urge.factors.subtitle' => 'These optional details can help you better understand these moments.',
			'urge.factors.label' => 'Contributing factors (optional)',
			'urge.factors.trigger' => 'Trigger',
			'urge.factors.emotion' => 'Emotion',
			'urge.timer.count' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} second remaining', other: '${count} seconds remaining', ), 
			'urge.error.start' => 'Unable to start this support flow right now. Try again.',
			'urge.error.missingSession' => 'This session is no longer available.',
			'urge.error.strategySave' => 'The strategy could not be saved. Try again.',
			'urge.error.outcomeRequired' => 'Choose the result that best describes the situation.',
			'urge.error.save' => 'Unable to save right now. Try again in a moment.',
			_ => null,
		};
	}
}
