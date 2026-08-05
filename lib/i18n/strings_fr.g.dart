///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';

import 'strings.g.dart';

// Path: <root>
class TranslationsFr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsFr _root = this; // ignore: unused_field

	@override 
	TranslationsFr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$fr app = _Translations$app$fr._(_root);
	@override late final _Translations$checkIn$fr checkIn = _Translations$checkIn$fr._(_root);
	@override late final _Translations$consumption$fr consumption = _Translations$consumption$fr._(_root);
	@override late final _Translations$context$fr context = _Translations$context$fr._(_root);
	@override late final _Translations$emotion$fr emotion = _Translations$emotion$fr._(_root);
	@override late final _Translations$export$fr export = _Translations$export$fr._(_root);
	@override late final _Translations$goal$fr goal = _Translations$goal$fr._(_root);
	@override late final _Translations$harvest$fr harvest = _Translations$harvest$fr._(_root);
	@override late final _Translations$home$fr home = _Translations$home$fr._(_root);
	@override late final _Translations$journal$fr journal = _Translations$journal$fr._(_root);
	@override late final _Translations$learning$fr learning = _Translations$learning$fr._(_root);
	@override late final _Translations$learningModules$fr learningModules = _Translations$learningModules$fr._(_root);
	@override late final _Translations$licenses$fr licenses = _Translations$licenses$fr._(_root);
	@override late final _Translations$locale$fr locale = _Translations$locale$fr._(_root);
	@override late final _Translations$navigation$fr navigation = _Translations$navigation$fr._(_root);
	@override late final _Translations$notifications$fr notifications = _Translations$notifications$fr._(_root);
	@override late final _Translations$onboarding$fr onboarding = _Translations$onboarding$fr._(_root);
	@override late final _Translations$outcome$fr outcome = _Translations$outcome$fr._(_root);
	@override late final _Translations$period$fr period = _Translations$period$fr._(_root);
	@override late final _Translations$progress$fr progress = _Translations$progress$fr._(_root);
	@override late final _Translations$settings$fr settings = _Translations$settings$fr._(_root);
	@override late final _Translations$strategy$fr strategy = _Translations$strategy$fr._(_root);
	@override late final _Translations$theme$fr theme = _Translations$theme$fr._(_root);
	@override late final _Translations$trigger$fr trigger = _Translations$trigger$fr._(_root);
	@override late final _Translations$urge$fr urge = _Translations$urge$fr._(_root);
}

// Path: app
class _Translations$app$fr extends Translations$app$en {
	_Translations$app$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get name => 'StopCorn';
	@override String get logoSemantics => 'Logo en forme d\'épi de maïs de StopCorn';
	@override String get urgeCueSemantics => 'ce contenu';
	@override String get loading => 'Chargement…';
	@override String get retry => 'Réessayer';
	@override String get cancel => 'Annuler';
	@override String get close => 'Fermer';
	@override String get continueLabel => 'Continuer';
	@override String get back => 'Retour';
	@override String get backHome => 'Retour à l\'accueil';
	@override String get save => 'Enregistrer';
	@override String get saving => 'Enregistrement…';
	@override String get noChoice => 'Aucun choix';
	@override String get unknown => 'Inconnu';
	@override String minutes({required Object count}) => '${count} min';
	@override String get notMedicalDisclaimer => 'StopCorn n\'est pas un outil de prise en charge médicale. Il ne pose aucun diagnostic et ne remplace pas un professionnel de santé. Si ce comportement entraîne une forte souffrance, une perte de contrôle persistante ou des conséquences importantes dans ta vie, il peut être utile d\'en parler à un professionnel qualifié.';
	@override late final _Translations$app$technicalDetails$fr technicalDetails = _Translations$app$technicalDetails$fr._(_root);
	@override late final _Translations$app$splash$fr splash = _Translations$app$splash$fr._(_root);
	@override late final _Translations$app$score$fr score = _Translations$app$score$fr._(_root);
	@override String moduleNumber({required Object order}) => 'Module n°${order}';
}

// Path: checkIn
class _Translations$checkIn$fr extends Translations$checkIn$en {
	_Translations$checkIn$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bilan du jour';
	@override late final _Translations$checkIn$intro$fr intro = _Translations$checkIn$intro$fr._(_root);
	@override late final _Translations$checkIn$mood$fr mood = _Translations$checkIn$mood$fr._(_root);
	@override late final _Translations$checkIn$control$fr control = _Translations$checkIn$control$fr._(_root);
	@override late final _Translations$checkIn$urge$fr urge = _Translations$checkIn$urge$fr._(_root);
	@override late final _Translations$checkIn$consumption$fr consumption = _Translations$checkIn$consumption$fr._(_root);
	@override late final _Translations$checkIn$sleep$fr sleep = _Translations$checkIn$sleep$fr._(_root);
	@override late final _Translations$checkIn$note$fr note = _Translations$checkIn$note$fr._(_root);
	@override late final _Translations$checkIn$saved$fr saved = _Translations$checkIn$saved$fr._(_root);
	@override late final _Translations$checkIn$error$fr error = _Translations$checkIn$error$fr._(_root);
}

// Path: consumption
class _Translations$consumption$fr extends Translations$consumption$en {
	_Translations$consumption$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Noter une consommation';
	@override String get intro => 'Quelques informations suffisent. Tu peux ignorer toutes les questions facultatives.';
	@override String get date => 'Date';
	@override String get time => 'Heure';
	@override late final _Translations$consumption$factors$fr factors = _Translations$consumption$factors$fr._(_root);
	@override late final _Translations$consumption$control$fr control = _Translations$consumption$control$fr._(_root);
	@override late final _Translations$consumption$context$fr context = _Translations$consumption$context$fr._(_root);
	@override late final _Translations$consumption$contextualGoal$fr contextualGoal = _Translations$consumption$contextualGoal$fr._(_root);
	@override late final _Translations$consumption$note$fr note = _Translations$consumption$note$fr._(_root);
	@override late final _Translations$consumption$saved$fr saved = _Translations$consumption$saved$fr._(_root);
	@override late final _Translations$consumption$edit$fr edit = _Translations$consumption$edit$fr._(_root);
	@override late final _Translations$consumption$error$fr error = _Translations$consumption$error$fr._(_root);
}

// Path: context
class _Translations$context$fr extends Translations$context$en {
	_Translations$context$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get lateEvening => 'Tard le soir';
	@override String get bedroom => 'Dans la chambre';
	@override String get homeAlone => 'Seul à la maison';
	@override String get afterSocialMedia => 'Après les réseaux sociaux';
	@override String get duringStress => 'Pendant une période de stress';
}

// Path: emotion
class _Translations$emotion$fr extends Translations$emotion$en {
	_Translations$emotion$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get calm => 'Calme';
	@override String get bored => 'Ennui';
	@override String get stressed => 'Stress';
	@override String get lonely => 'Solitude';
	@override String get sad => 'Tristesse';
	@override String get angry => 'Colère';
	@override String get anxious => 'Anxiété';
	@override String get tired => 'Fatigue';
	@override String get excited => 'Excitation';
	@override String get frustrated => 'Frustration';
	@override String get other => 'Autre';
}

// Path: export
class _Translations$export$fr extends Translations$export$en {
	_Translations$export$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exporter mes données';
	@override String get confirm => 'Je comprends que ce fichier peut être sensible';
	@override String get backSettings => 'Retour aux réglages';
	@override String get error => 'L\'export n\'a pas pu être créé. Aucune donnée n\'a été envoyée.';
	@override late final _Translations$export$warning$fr warning = _Translations$export$warning$fr._(_root);
	@override late final _Translations$export$create$fr create = _Translations$export$create$fr._(_root);
	@override late final _Translations$export$share$fr share = _Translations$export$share$fr._(_root);
}

// Path: goal
class _Translations$goal$fr extends Translations$goal$en {
	_Translations$goal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$goal$abstinence$fr abstinence = _Translations$goal$abstinence$fr._(_root);
	@override late final _Translations$goal$reduction$fr reduction = _Translations$goal$reduction$fr._(_root);
	@override late final _Translations$goal$contextual$fr contextual = _Translations$goal$contextual$fr._(_root);
	@override late final _Translations$goal$observation$fr observation = _Translations$goal$observation$fr._(_root);
}

// Path: harvest
class _Translations$harvest$fr extends Translations$harvest$en {
	_Translations$harvest$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Récolte';
	@override String get explanationAction => 'C\'est quoi ?';
	@override late final _Translations$harvest$cornPoints$fr cornPoints = _Translations$harvest$cornPoints$fr._(_root);
	@override late final _Translations$harvest$momentum$fr momentum = _Translations$harvest$momentum$fr._(_root);
	@override late final _Translations$harvest$reward$fr reward = _Translations$harvest$reward$fr._(_root);
	@override late final _Translations$harvest$sheet$fr sheet = _Translations$harvest$sheet$fr._(_root);
}

// Path: home
class _Translations$home$fr extends Translations$home$en {
	_Translations$home$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$home$load$fr load = _Translations$home$load$fr._(_root);
	@override late final _Translations$home$sections$fr sections = _Translations$home$sections$fr._(_root);
	@override late final _Translations$home$goal$fr goal = _Translations$home$goal$fr._(_root);
	@override late final _Translations$home$checkIn$fr checkIn = _Translations$home$checkIn$fr._(_root);
	@override late final _Translations$home$urge$fr urge = _Translations$home$urge$fr._(_root);
	@override late final _Translations$home$strategy$fr strategy = _Translations$home$strategy$fr._(_root);
	@override late final _Translations$home$metrics$fr metrics = _Translations$home$metrics$fr._(_root);
	@override late final _Translations$home$actions$fr actions = _Translations$home$actions$fr._(_root);
	@override late final _Translations$home$learningRecommendation$fr learningRecommendation = _Translations$home$learningRecommendation$fr._(_root);
}

// Path: journal
class _Translations$journal$fr extends Translations$journal$en {
	_Translations$journal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$journal$history$fr history = _Translations$journal$history$fr._(_root);
	@override late final _Translations$journal$edit$fr edit = _Translations$journal$edit$fr._(_root);
	@override late final _Translations$journal$delete$fr delete = _Translations$journal$delete$fr._(_root);
	@override late final _Translations$journal$error$fr error = _Translations$journal$error$fr._(_root);
}

// Path: learning
class _Translations$learning$fr extends Translations$learning$en {
	_Translations$learning$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Six modules courts, disponibles hors ligne et sans diagnostic.';
	@override String get semantics => 'Modules pédagogiques';
	@override late final _Translations$learning$evidence$fr evidence = _Translations$learning$evidence$fr._(_root);
	@override late final _Translations$learning$sources$fr sources = _Translations$learning$sources$fr._(_root);
	@override late final _Translations$learning$module$fr module = _Translations$learning$module$fr._(_root);
	@override late final _Translations$learning$status$fr status = _Translations$learning$status$fr._(_root);
	@override late final _Translations$learning$reading$fr reading = _Translations$learning$reading$fr._(_root);
	@override late final _Translations$learning$reflection$fr reflection = _Translations$learning$reflection$fr._(_root);
	@override late final _Translations$learning$completion$fr completion = _Translations$learning$completion$fr._(_root);
	@override late final _Translations$learning$error$fr error = _Translations$learning$error$fr._(_root);
}

// Path: learningModules
class _Translations$learningModules$fr extends Translations$learningModules$en {
	_Translations$learningModules$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learningModules$continueAfterSetback$fr continueAfterSetback = _Translations$learningModules$continueAfterSetback$fr._(_root);
	@override late final _Translations$learningModules$mapTerrain$fr mapTerrain = _Translations$learningModules$mapTerrain$fr._(_root);
	@override late final _Translations$learningModules$prepareEnvironment$fr prepareEnvironment = _Translations$learningModules$prepareEnvironment$fr._(_root);
	@override late final _Translations$learningModules$rideUrge$fr rideUrge = _Translations$learningModules$rideUrge$fr._(_root);
	@override late final _Translations$learningModules$understandLoop$fr understandLoop = _Translations$learningModules$understandLoop$fr._(_root);
	@override late final _Translations$learningModules$whyChange$fr whyChange = _Translations$learningModules$whyChange$fr._(_root);
}

// Path: licenses
class _Translations$licenses$fr extends Translations$licenses$en {
	_Translations$licenses$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Licences open source';
	@override String get intro => 'StopCorn utilise des composants open source. Sélectionne une entrée pour lire son texte de licence.';
	@override String get loadError => 'Les licences n\'ont pas pu être chargées.';
	@override String get otherComponent => 'Autre composant';
}

// Path: locale
class _Translations$locale$fr extends Translations$locale$en {
	_Translations$locale$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Langue de l\'application';
	@override String get english => 'Anglais';
	@override String get french => 'Français';
	@override late final _Translations$locale$section$fr section = _Translations$locale$section$fr._(_root);
}

// Path: navigation
class _Translations$navigation$fr extends Translations$navigation$en {
	_Translations$navigation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$navigation$home$fr home = _Translations$navigation$home$fr._(_root);
	@override String get progress => 'Progression';
	@override String get learn => 'Apprendre';
	@override String get settings => 'Réglages';
}

// Path: notifications
class _Translations$notifications$fr extends Translations$notifications$en {
	_Translations$notifications$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$notifications$dailyCheckIn$fr dailyCheckIn = _Translations$notifications$dailyCheckIn$fr._(_root);
}

// Path: onboarding
class _Translations$onboarding$fr extends Translations$onboarding$en {
	_Translations$onboarding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'Configuration';
	@override String step({required Object current, required Object total}) => 'Étape ${current} sur ${total}';
	@override late final _Translations$onboarding$welcome$fr welcome = _Translations$onboarding$welcome$fr._(_root);
	@override late final _Translations$onboarding$goal$fr goal = _Translations$onboarding$goal$fr._(_root);
	@override late final _Translations$onboarding$baseline$fr baseline = _Translations$onboarding$baseline$fr._(_root);
	@override late final _Translations$onboarding$strategies$fr strategies = _Translations$onboarding$strategies$fr._(_root);
	@override late final _Translations$onboarding$privacy$fr privacy = _Translations$onboarding$privacy$fr._(_root);
	@override String get start => 'Commencer';
	@override String get finish => 'Terminer la configuration';
	@override late final _Translations$onboarding$error$fr error = _Translations$onboarding$error$fr._(_root);
	@override late final _Translations$onboarding$validation$fr validation = _Translations$onboarding$validation$fr._(_root);
}

// Path: outcome
class _Translations$outcome$fr extends Translations$outcome$en {
	_Translations$outcome$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get passed => 'L\'envie est passée';
	@override String get reduced => 'Elle a diminué';
	@override String get delayed => 'Je vais attendre';
	@override String get consumed => 'Je vais consommer';
	@override String get abandoned => 'Je préfère arrêter le parcours ici';
}

// Path: period
class _Translations$period$fr extends Translations$period$en {
	_Translations$period$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sevenDays => '7 jours';
	@override String get thirtyDays => '30 jours';
	@override String get ninetyDays => '90 jours';
	@override String get all => 'Tout';
}

// Path: progress
class _Translations$progress$fr extends Translations$progress$en {
	_Translations$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get subtitle => 'Des repères descriptifs construits uniquement à partir de ce que tu as choisi d\'enregistrer.';
	@override late final _Translations$progress$error$fr error = _Translations$progress$error$fr._(_root);
	@override late final _Translations$progress$overview$fr overview = _Translations$progress$overview$fr._(_root);
	@override late final _Translations$progress$events$fr events = _Translations$progress$events$fr._(_root);
	@override late final _Translations$progress$urges$fr urges = _Translations$progress$urges$fr._(_root);
	@override late final _Translations$progress$patterns$fr patterns = _Translations$progress$patterns$fr._(_root);
	@override late final _Translations$progress$strategies$fr strategies = _Translations$progress$strategies$fr._(_root);
	@override late final _Translations$progress$checkIns$fr checkIns = _Translations$progress$checkIns$fr._(_root);
	@override late final _Translations$progress$comparison$fr comparison = _Translations$progress$comparison$fr._(_root);
	@override late final _Translations$progress$startingPoint$fr startingPoint = _Translations$progress$startingPoint$fr._(_root);
	@override String get harvest => 'Récolte';
}

// Path: settings
class _Translations$settings$fr extends Translations$settings$en {
	_Translations$settings$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$settings$support$fr support = _Translations$settings$support$fr._(_root);
	@override late final _Translations$settings$appearance$fr appearance = _Translations$settings$appearance$fr._(_root);
	@override late final _Translations$settings$reminders$fr reminders = _Translations$settings$reminders$fr._(_root);
	@override late final _Translations$settings$progress$fr progress = _Translations$settings$progress$fr._(_root);
	@override late final _Translations$settings$personalPlan$fr personalPlan = _Translations$settings$personalPlan$fr._(_root);
	@override late final _Translations$settings$data$fr data = _Translations$settings$data$fr._(_root);
	@override late final _Translations$settings$developer$fr developer = _Translations$settings$developer$fr._(_root);
	@override late final _Translations$settings$about$fr about = _Translations$settings$about$fr._(_root);
	@override late final _Translations$settings$goalEditor$fr goalEditor = _Translations$settings$goalEditor$fr._(_root);
	@override late final _Translations$settings$error$fr error = _Translations$settings$error$fr._(_root);
}

// Path: strategy
class _Translations$strategy$fr extends Translations$strategy$en {
	_Translations$strategy$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get putPhoneAway => 'Poser le téléphone hors de portée';
	@override String get leaveRoom => 'Quitter la pièce';
	@override String get walkFiveMinutes => 'Marcher cinq minutes';
	@override String get slowBreathing => 'Respirer lentement pendant 90 secondes';
	@override String get waterAndSwitch => 'Boire un verre d\'eau et changer d\'activité';
	@override String get messageSomeone => 'Envoyer un message à une personne choisie';
	@override String get twoMinuteTask => 'Lancer une tâche de deux minutes';
	@override String get takeShower => 'Prendre une douche';
	@override String get waitTenMinutes => 'Attendre dix minutes avant de décider';
	@override String get personal => 'Stratégie personnelle';
	@override String get genericDescription => 'Une action simple à essayer quand tu en as besoin.';
	@override String timerSeconds({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Minuteur proposé : ${count} secondes.',
		one: 'Minuteur proposé : ${count} seconde.',
		other: 'Minuteur proposé : ${count} secondes.',
	);
	@override String timerMinutes({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Minuteur proposé : ${count} minutes.',
		one: 'Minuteur proposé : ${count} minute.',
		other: 'Minuteur proposé : ${count} minutes.',
	);
}

// Path: theme
class _Translations$theme$fr extends Translations$theme$en {
	_Translations$theme$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get system => 'Suivre le système';
	@override String get light => 'Clair';
	@override String get dark => 'Sombre';
}

// Path: trigger
class _Translations$trigger$fr extends Translations$trigger$en {
	_Translations$trigger$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get boredom => 'Ennui';
	@override String get stress => 'Stress';
	@override String get loneliness => 'Solitude';
	@override String get fatigue => 'Fatigue';
	@override String get habit => 'Habitude';
	@override String get arousal => 'Excitation';
	@override String get socialMedia => 'Réseaux sociaux';
	@override String get relationshipDifficulty => 'Difficulté relationnelle';
	@override String get alcoholOrSubstance => 'Alcool ou autre substance';
	@override String get bedtimePhone => 'Téléphone au lit';
	@override String get other => 'Autre';
}

// Path: urge
class _Translations$urge$fr extends Translations$urge$en {
	_Translations$urge$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get pauseTitle => 'Faire une pause';
	@override String get quit => 'Quitter';
	@override late final _Translations$urge$support$fr support = _Translations$urge$support$fr._(_root);
	@override late final _Translations$urge$grounding$fr grounding = _Translations$urge$grounding$fr._(_root);
	@override late final _Translations$urge$strategy$fr strategy = _Translations$urge$strategy$fr._(_root);
	@override late final _Translations$urge$result$fr result = _Translations$urge$result$fr._(_root);
	@override late final _Translations$urge$complete$fr complete = _Translations$urge$complete$fr._(_root);
	@override late final _Translations$urge$intensity$fr intensity = _Translations$urge$intensity$fr._(_root);
	@override late final _Translations$urge$factors$fr factors = _Translations$urge$factors$fr._(_root);
	@override late final _Translations$urge$timer$fr timer = _Translations$urge$timer$fr._(_root);
	@override late final _Translations$urge$error$fr error = _Translations$urge$error$fr._(_root);
}

// Path: app.technicalDetails
class _Translations$app$technicalDetails$fr extends Translations$app$technicalDetails$en {
	_Translations$app$technicalDetails$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get show => 'Afficher le détail technique';
	@override String get hide => 'Masquer le détail technique';
}

// Path: app.splash
class _Translations$app$splash$fr extends Translations$app$splash$en {
	_Translations$app$splash$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get preparing => 'Préparation de StopCorn…';
	@override String get error => 'StopCorn n\'a pas pu démarrer. Tes données n\'ont pas été modifiées.';
}

// Path: app.score
class _Translations$app$score$fr extends Translations$app$score$en {
	_Translations$app$score$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unanswered => 'Facultatif — non renseigné';
	@override String outOfTen({required Object value}) => '${value} / 10';
	@override String clear({required Object label}) => 'Effacer ${label}';
	@override String unansweredSemantics({required Object label}) => '${label} : non renseigné';
	@override String answeredSemantics({required Object label, required Object value}) => '${label} : ${value} sur 10';
}

// Path: checkIn.intro
class _Translations$checkIn$intro$fr extends Translations$checkIn$intro$en {
	_Translations$checkIn$intro$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get create => 'Un repère rapide, en moins d\'une minute.';
	@override String get edit => 'Modifier le bilan d\'aujourd\'hui.';
}

// Path: checkIn.mood
class _Translations$checkIn$mood$fr extends Translations$checkIn$mood$en {
	_Translations$checkIn$mood$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Humeur';
	@override String get scale => '0 = très difficile, 10 = très bonne';
}

// Path: checkIn.control
class _Translations$checkIn$control$fr extends Translations$checkIn$control$en {
	_Translations$checkIn$control$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Sentiment de contrôle';
	@override String get scale => '0 = aucun contrôle, 10 = contrôle complet';
}

// Path: checkIn.urge
class _Translations$checkIn$urge$fr extends Translations$checkIn$urge$en {
	_Translations$checkIn$urge$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get count => 'Nombre approximatif d\'envies (facultatif)';
	@override String get hint => 'Exemple : 3';
	@override String get negative => 'Le nombre ne peut pas être négatif.';
}

// Path: checkIn.consumption
class _Translations$checkIn$consumption$fr extends Translations$checkIn$consumption$en {
	_Translations$checkIn$consumption$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String recorded({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		one: '${count} consommation enregistrée ce jour-là.',
		other: '${count} consommations enregistrées ce jour-là.',
	);
	@override String get none => 'Aucune consommation enregistrée ce jour-là.';
}

// Path: checkIn.sleep
class _Translations$checkIn$sleep$fr extends Translations$checkIn$sleep$en {
	_Translations$checkIn$sleep$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Qualité du sommeil (facultatif)';
	@override String get scale => '0 = très mauvaise, 10 = excellente';
}

// Path: checkIn.note
class _Translations$checkIn$note$fr extends Translations$checkIn$note$en {
	_Translations$checkIn$note$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Note facultative';
	@override String get hint => 'Ce qui a marqué ta journée…';
}

// Path: checkIn.saved
class _Translations$checkIn$saved$fr extends Translations$checkIn$saved$en {
	_Translations$checkIn$saved$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bilan enregistré.';
	@override String get body => 'Ces repères aideront à observer les tendances dans le temps.';
}

// Path: checkIn.error
class _Translations$checkIn$error$fr extends Translations$checkIn$error$en {
	_Translations$checkIn$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get load => 'Le bilan du jour n\'a pas pu être chargé.';
	@override String get save => 'Impossible d\'enregistrer pour le moment. Réessaie dans quelques instants.';
}

// Path: consumption.factors
class _Translations$consumption$factors$fr extends Translations$consumption$factors$en {
	_Translations$consumption$factors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Facteurs déclenchants (facultatif)';
	@override String get trigger => 'Déclencheur';
	@override String get emotion => 'Émotion';
}

// Path: consumption.control
class _Translations$consumption$control$fr extends Translations$consumption$control$en {
	_Translations$consumption$control$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Sentiment de contrôle (facultatif)';
	@override String get scale => '0 = aucun contrôle, 10 = contrôle complet';
}

// Path: consumption.context
class _Translations$consumption$context$fr extends Translations$consumption$context$en {
	_Translations$consumption$context$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Contexte très court (facultatif)';
	@override String get hint => 'Exemple : seul le soir';
	@override String get description => 'Reste général : aucun site, recherche ou détail explicite.';
}

// Path: consumption.contextualGoal
class _Translations$consumption$contextualGoal$fr extends Translations$consumption$contextualGoal$en {
	_Translations$consumption$contextualGoal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tes contextes protégés';
	@override String get description => 'Sélectionne les contextes de ton objectif qui correspondaient à la situation. Ils apparaîtront ainsi dans ta progression, sans remplacer la note facultative ci-dessous.';
	@override String get label => 'Contextes de mon objectif (facultatif)';
}

// Path: consumption.note
class _Translations$consumption$note$fr extends Translations$consumption$note$en {
	_Translations$consumption$note$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Note facultative';
	@override String get hint => 'Un repère utile pour la suite…';
}

// Path: consumption.saved
class _Translations$consumption$saved$fr extends Translations$consumption$saved$en {
	_Translations$consumption$saved$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'C\'est enregistré.';
	@override String get body => 'L\'objectif est de mieux comprendre la situation, pas de te juger.';
}

// Path: consumption.edit
class _Translations$consumption$edit$fr extends Translations$consumption$edit$en {
	_Translations$consumption$edit$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Corriger cette consommation';
}

// Path: consumption.error
class _Translations$consumption$error$fr extends Translations$consumption$error$en {
	_Translations$consumption$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get load => 'Le formulaire n\'a pas pu être préparé.';
	@override String get save => 'Impossible d\'enregistrer pour le moment. Réessaie dans quelques instants.';
	@override String get missingEvent => 'Cette consommation n\'existe plus.';
}

// Path: export.warning
class _Translations$export$warning$fr extends Translations$export$warning$en {
	_Translations$export$warning$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Avant de continuer';
	@override String get sensitive => 'Le fichier JSON peut contenir des informations personnelles sensibles : notes, objectifs et observations que tu as choisi d\'enregistrer.';
	@override String get share => 'StopCorn ne l\'envoie nulle part automatiquement. Après sa création, seule la feuille de partage du système s\'ouvrira.';
}

// Path: export.create
class _Translations$export$create$fr extends Translations$export$create$en {
	_Translations$export$create$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get action => 'Créer et ouvrir le partage';
	@override String get progress => 'Création du fichier…';
}

// Path: export.share
class _Translations$export$share$fr extends Translations$export$share$en {
	_Translations$export$share$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get subject => 'Export des données StopCorn';
	@override String get title => 'Export StopCorn';
}

// Path: goal.abstinence
class _Translations$goal$abstinence$fr extends Translations$goal$abstinence$en {
	_Translations$goal$abstinence$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Arrêter';
	@override String get description => 'Je souhaite ne plus consommer.';
}

// Path: goal.reduction
class _Translations$goal$reduction$fr extends Translations$goal$reduction$en {
	_Translations$goal$reduction$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Réduire';
	@override String get description => 'Je souhaite diminuer progressivement la fréquence.';
}

// Path: goal.contextual
class _Translations$goal$contextual$fr extends Translations$goal$contextual$en {
	_Translations$goal$contextual$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Éviter certains contextes';
	@override String get description => 'Je veux reprendre le contrôle dans certaines situations.';
}

// Path: goal.observation
class _Translations$goal$observation$fr extends Translations$goal$observation$en {
	_Translations$goal$observation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Observer d\'abord';
	@override String get description => 'Je veux comprendre mes habitudes avant de fixer une cible.';
}

// Path: harvest.cornPoints
class _Translations$harvest$cornPoints$fr extends Translations$harvest$cornPoints$en {
	_Translations$harvest$cornPoints$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Corn points';
	@override String get todayCollected => 'Le corn point du jour a été collecté.';
	@override String get todayAvailable => 'Un geste constructif suffit pour récolter le corn point du jour.';
}

// Path: harvest.momentum
class _Translations$harvest$momentum$fr extends Translations$harvest$momentum$en {
	_Translations$harvest$momentum$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Élan';
	@override String currentMomentum({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Élan actuel : ${count} jours de suite.',
		one: 'Élan actuel : ${count} jour de suite.',
		other: 'Élan actuel : ${count} jours de suite.',
	);
	@override String bestMomentum({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Meilleur élan : ${count} jours de suite.',
		one: 'Meilleur élan : ${count} jour de suite.',
		other: 'Meilleur élan : ${count} jours de suite.',
	);
	@override String get dayCollected => 'Corn point collecté ce jour';
	@override String get dayNotCollected => 'Aucun corn point récolté ce jour';
	@override String get dayUpcoming => 'Journée à venir';
}

// Path: harvest.reward
class _Translations$harvest$reward$fr extends Translations$harvest$reward$en {
	_Translations$harvest$reward$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Corn point récolté !';
	@override String get body => 'Ton geste constructif fait avancer ta récolte.';
	@override String pointsSemantics({required Object gain, required Object total}) => '${gain} corn point ajouté. Nouveau total : ${total}.';
	@override String momentumSemantics({required num total, required Object gain}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(total,
		one: 'Élan augmenté de ${gain}. Nouvel élan : ${total} jour.',
		other: 'Élan augmenté de ${gain}. Nouvel élan : ${total} jours.',
	);
	@override String gain({required Object count}) => '+${count}';
	@override String get continueAction => 'Continuer';
}

// Path: harvest.sheet
class _Translations$harvest$sheet$fr extends Translations$harvest$sheet$en {
	_Translations$harvest$sheet$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comment fonctionne la récolte ?';
	@override String get intro => 'La récolte met en valeur les gestes qui t\'aident à avancer. Elle ne mesure pas l\'abstinence et ne juge jamais le résultat d\'une journée.';
	@override String get onePerDay => 'Tu peux récolter au maximum un corn point par jour. Une seule action constructive suffit.';
	@override String get urge => 'Terminer un parcours d\'aide compte, quel que soit son résultat.';
	@override String get checkIn => 'Faire un bilan quotidien compte.';
	@override String get observation => 'Noter honnêtement une consommation compte également : la sincérité n\'est jamais pénalisée.';
	@override String get learning => 'Terminer un module pédagogique compte.';
	@override String get goal => 'Créer ou mettre à jour ton objectif compte.';
	@override String get momentumTitle => 'Et l\'élan ?';
	@override String get momentumBody => 'L\'élan correspond aux jours cultivés à la suite. La journée en cours reste une période de grâce. Si l\'élan s\'interrompt, ta récolte ne diminue jamais et tous tes corn points restent acquis.';
}

// Path: home.load
class _Translations$home$load$fr extends Translations$home$load$en {
	_Translations$home$load$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get error => 'Les données d\'aujourd\'hui n\'ont pas pu être chargées.';
}

// Path: home.sections
class _Translations$home$sections$fr extends Translations$home$sections$en {
	_Translations$home$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get today => 'Aujourd\'hui';
	@override String get metrics => 'Métriques';
	@override String get lastThirtyDays => 'Ces 30 derniers jours';
	@override String get quickActions => 'Actions rapides';
}

// Path: home.goal
class _Translations$home$goal$fr extends Translations$home$goal$en {
	_Translations$home$goal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Objectif';
	@override String get undefined => 'Objectif à définir';
	@override String weeklyLimit({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Limite souhaitée : ${count} événement par semaine.',
		one: 'Limite souhaitée : ${count} événement par semaine.',
		other: 'Limite souhaitée : ${count} événements par semaine.',
	);
	@override String contexts({required Object contexts}) => 'Contextes protégés : ${contexts}.';
}

// Path: home.checkIn
class _Translations$home$checkIn$fr extends Translations$home$checkIn$en {
	_Translations$home$checkIn$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bilan quotidien';
	@override String get completed => 'Bilan quotidien enregistré.';
	@override String get available => 'Bilan quotidien à faire quand tu le souhaites.\nTape pour l\'enregistrer.';
	@override late final _Translations$home$checkIn$action$fr action = _Translations$home$checkIn$action$fr._(_root);
}

// Path: home.urge
class _Translations$home$urge$fr extends Translations$home$urge$en {
	_Translations$home$urge$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get today => 'Envies aujourd\'hui';
	@override TextSpan count({required num count, required InlineSpan Function(num) countBuilder}) => RichPluralResolvers.bridge(
		n: count,
		resolver: _root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'),
		zero: () => TextSpan(children: [
			const TextSpan(text: 'Aucune envie enregistrée aujourd\'hui.'),
		]),
		one: () => TextSpan(children: [
			countBuilder(count),
			const TextSpan(text: ' envie enregistrée aujourd\'hui.'),
		]),
		other: () => TextSpan(children: [
			countBuilder(count),
			const TextSpan(text: ' envies enregistrées aujourd\'hui.'),
		]),
	);
	@override String get semantics => 'J\'ai envie de consulter du contenu, faire une pause';
	@override TextSpan action({required InlineSpan corn}) => TextSpan(children: [
		const TextSpan(text: 'J\'ai une envie de '),
		corn,
	]);
	@override String get subtitle => 'Faire une pause';
}

// Path: home.strategy
class _Translations$home$strategy$fr extends Translations$home$strategy$en {
	_Translations$home$strategy$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get lastHelpful => 'Dernière stratégie utile';
}

// Path: home.metrics
class _Translations$home$metrics$fr extends Translations$home$metrics$en {
	_Translations$home$metrics$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String daysWithout({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'jours sans consommation enregistrée',
		one: 'jour sans consommation enregistrée',
		other: 'jours sans consommation enregistrée',
	);
	@override String traversedUrges({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'envies surpassées ou réduites',
		one: 'envie surpassée ou réduite',
		other: 'envies surpassées ou réduites',
	);
	@override String get averageControl => 'taux de contrôle moyen déclaré';
	@override String get empty => 'Tes premières observations apparaîtront ici. Il n\'est pas nécessaire de tout noter parfaitement : quelques repères suffisent pour commencer.';
}

// Path: home.actions
class _Translations$home$actions$fr extends Translations$home$actions$en {
	_Translations$home$actions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get openJournal => 'Ouvrir mon journal';
	@override String get logConsumption => 'Noter une consommation';
	@override String get reviewPlan => 'Revoir mon plan';
}

// Path: home.learningRecommendation
class _Translations$home$learningRecommendation$fr extends Translations$home$learningRecommendation$en {
	_Translations$home$learningRecommendation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'À découvrir';
	@override String get action => 'Poursuivre la lecture';
}

// Path: journal.history
class _Translations$journal$history$fr extends Translations$journal$history$en {
	_Translations$journal$history$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Journal';
	@override String get intro => 'Retrouve les consommations, les sessions d\'aide et les bilans quotidiens que tu as choisi d\'enregistrer, regroupés par date.';
	@override String get error => 'Le journal n\'a pas pu être chargé.';
	@override late final _Translations$journal$history$empty$fr empty = _Translations$journal$history$empty$fr._(_root);
	@override late final _Translations$journal$history$date$fr date = _Translations$journal$history$date$fr._(_root);
	@override late final _Translations$journal$history$entry$fr entry = _Translations$journal$history$entry$fr._(_root);
	@override late final _Translations$journal$history$details$fr details = _Translations$journal$history$details$fr._(_root);
}

// Path: journal.edit
class _Translations$journal$edit$fr extends Translations$journal$edit$en {
	_Translations$journal$edit$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get action => 'Corriger';
}

// Path: journal.delete
class _Translations$journal$delete$fr extends Translations$journal$delete$en {
	_Translations$journal$delete$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get action => 'Supprimer';
	@override String get title => 'Supprimer cette entrée ?';
	@override String get consumption => 'Cette entrée et sa note privée seront définitivement retirées de ton journal. Tes statistiques seront recalculées sans elle.';
	@override String get checkIn => 'Ce bilan quotidien et sa note privée seront définitivement retirés de ton journal. Tes statistiques seront recalculées sans lui.';
	@override String get urge => 'Cette séance de soutien et la réflexion écrite à la fin seront définitivement retirées. La stratégie essayée pendant la séance cesse d\'être comptée ; une consommation notée depuis cette séance est conservée.';
	@override String get irreversible => 'Cette action est irréversible.';
	@override String get confirm => 'Supprimer définitivement';
}

// Path: journal.error
class _Translations$journal$error$fr extends Translations$journal$error$en {
	_Translations$journal$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get delete => 'Cette entrée n\'a pas pu être supprimée. Rien n\'a été modifié.';
}

// Path: learning.evidence
class _Translations$learning$evidence$fr extends Translations$learning$evidence$en {
	_Translations$learning$evidence$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sur quoi reposent ces modules ?';
	@override String get sheetTitle => 'Sources et limites';
	@override String get principles => 'Chaque module cite des travaux scientifiques sur des principes généraux liés à la motivation, aux habitudes, à la maîtrise de soi, à la pleine conscience ou à l\'autocompassion.';
	@override String get limitations => 'Ces sources ne valident pas cliniquement StopCorn. Certaines portent sur le comportement en général ou le tabagisme, et les études consacrées à la pornographie peuvent reposer sur des échantillons limités. Les modules proposent des repères éducatifs prudents, pas un diagnostic ni un traitement.';
}

// Path: learning.sources
class _Translations$learning$sources$fr extends Translations$learning$sources$en {
	_Translations$learning$sources$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String title({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count} sources scientifiques',
		one: '${count} source scientifique',
		other: '${count} sources scientifiques',
	);
	@override String get shortDescription => 'Références et portée des résultats';
	@override String get sheetTitle => 'Sources scientifiques';
	@override String get scope => 'Chaque résultat doit être replacé dans sa population et sa méthode : une association ne prouve pas une cause, et un résultat obtenu sur un autre comportement ou un échantillon limité n\'est pas forcément généralisable. Ces références ne prouvent pas que ce module ou StopCorn constitue un traitement.';
}

// Path: learning.module
class _Translations$learning$module$fr extends Translations$learning$module$en {
	_Translations$learning$module$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String line({required Object minutes, required Object status}) => '${minutes} min · ${status}';
	@override String progress({required Object title}) => 'Progression du module ${title}';
	@override String get pageTitle => 'Module';
	@override String get loadError => 'Ce module n\'a pas pu être chargé.';
}

// Path: learning.status
class _Translations$learning$status$fr extends Translations$learning$status$en {
	_Translations$learning$status$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Terminé';
	@override String get reviewing => 'Relecture en cours';
	@override String get resume => 'Poursuivre la lecture';
	@override String get discover => 'Découvrir';
}

// Path: learning.reading
class _Translations$learning$reading$fr extends Translations$learning$reading$en {
	_Translations$learning$reading$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get progress => 'Progression de lecture du module';
	@override String part({required Object current, required Object total}) => 'Partie ${current} sur ${total}';
	@override String get previous => 'Précédent';
}

// Path: learning.reflection
class _Translations$learning$reflection$fr extends Translations$learning$reflection$en {
	_Translations$learning$reflection$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get optional => 'Réflexion facultative';
	@override String get label => 'Ma réflexion';
	@override String get hint => 'Quelques mots pour toi-même…';
	@override String get localNote => 'Cette note reste uniquement sur ton appareil.';
	@override String get continueAction => 'Passer à la réflexion';
	@override String get yours => 'Ta réflexion';
}

// Path: learning.completion
class _Translations$learning$completion$fr extends Translations$learning$completion$en {
	_Translations$learning$completion$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Module terminé';
	@override String get finish => 'Terminer le module';
	@override String get restart => 'Recommencer le module';
	@override String get back => 'Retour aux modules';
}

// Path: learning.error
class _Translations$learning$error$fr extends Translations$learning$error$en {
	_Translations$learning$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get load => 'Les modules n\'ont pas pu être chargés.';
	@override String get save => 'Impossible d\'enregistrer ta progression pour le moment. Réessaie.';
}

// Path: learningModules.continueAfterSetback
class _Translations$learningModules$continueAfterSetback$fr extends Translations$learningModules$continueAfterSetback$en {
	_Translations$learningModules$continueAfterSetback$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Continuer après un écart';
	@override String get summary => 'Transforme un événement en information utile, sans te juger.';
	@override late final _Translations$learningModules$continueAfterSetback$sections$fr sections = _Translations$learningModules$continueAfterSetback$sections$fr._(_root);
	@override String get reflectionPrompt => 'Quelle information utile peux-tu tirer du dernier événement sans te juger ?';
}

// Path: learningModules.mapTerrain
class _Translations$learningModules$mapTerrain$fr extends Translations$learningModules$mapTerrain$en {
	_Translations$learningModules$mapTerrain$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Cartographier ton terrain';
	@override String get summary => 'Repère les situations qui reviennent dans tes observations.';
	@override late final _Translations$learningModules$mapTerrain$sections$fr sections = _Translations$learningModules$mapTerrain$sections$fr._(_root);
	@override String get reflectionPrompt => 'Quelle situation revient le plus souvent dans tes observations ?';
}

// Path: learningModules.prepareEnvironment
class _Translations$learningModules$prepareEnvironment$fr extends Translations$learningModules$prepareEnvironment$en {
	_Translations$learningModules$prepareEnvironment$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Préparer ton environnement';
	@override String get summary => 'Ajoute de la friction et facilite les actions que tu as choisies.';
	@override late final _Translations$learningModules$prepareEnvironment$sections$fr sections = _Translations$learningModules$prepareEnvironment$sections$fr._(_root);
	@override String get reflectionPrompt => 'Quel petit changement pourrais-tu apporter à ton environnement aujourd\'hui ?';
}

// Path: learningModules.rideUrge
class _Translations$learningModules$rideUrge$fr extends Translations$learningModules$rideUrge$en {
	_Translations$learningModules$rideUrge$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Laisser passer l\'impulsion';
	@override String get summary => 'Crée un peu d\'espace avant de choisir la suite.';
	@override late final _Translations$learningModules$rideUrge$sections$fr sections = _Translations$learningModules$rideUrge$sections$fr._(_root);
	@override String get reflectionPrompt => 'Quelle stratégie réaliste pourrais-tu essayer lors du prochain moment difficile ?';
}

// Path: learningModules.understandLoop
class _Translations$learningModules$understandLoop$fr extends Translations$learningModules$understandLoop$en {
	_Translations$learningModules$understandLoop$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Comprendre la boucle';
	@override String get summary => 'Repère les étapes qui peuvent entretenir une habitude.';
	@override late final _Translations$learningModules$understandLoop$sections$fr sections = _Translations$learningModules$understandLoop$sections$fr._(_root);
	@override String get reflectionPrompt => 'À quel moment de la boucle pourrais-tu agir le plus facilement cette semaine ?';
}

// Path: learningModules.whyChange
class _Translations$learningModules$whyChange$fr extends Translations$learningModules$whyChange$en {
	_Translations$learningModules$whyChange$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pourquoi changer ?';
	@override String get summary => 'Précise ce que tu aimerais retrouver ou préserver.';
	@override late final _Translations$learningModules$whyChange$sections$fr sections = _Translations$learningModules$whyChange$sections$fr._(_root);
	@override String get reflectionPrompt => 'Qu\'aimerais-tu retrouver ou préserver en faisant évoluer cette habitude ?';
}

// Path: locale.section
class _Translations$locale$section$fr extends Translations$locale$section$en {
	_Translations$locale$section$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Langue';
	@override String get description => 'Choisis la langue utilisée dans toute l\'application.';
}

// Path: navigation.home
class _Translations$navigation$home$fr extends Translations$navigation$home$en {
	_Translations$navigation$home$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get item => 'Accueil';
	@override String get title => 'Bonjour';
}

// Path: notifications.dailyCheckIn
class _Translations$notifications$dailyCheckIn$fr extends Translations$notifications$dailyCheckIn$en {
	_Translations$notifications$dailyCheckIn$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton bilan StopCorn t\'attend';
	@override String get body => 'Prends un moment pour noter comment s\'est passée ta journée.';
	@override String get channelName => 'Rappels du bilan quotidien';
	@override String get channelDescription => 'Un rappel local à 20 h lorsque le bilan du jour est encore vide.';
}

// Path: onboarding.welcome
class _Translations$onboarding$welcome$fr extends Translations$onboarding$welcome$en {
	_Translations$onboarding$welcome$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Reprendre le contrôle, sans jugement';
	@override String get subtitle => 'StopCorn t\'aide à comprendre tes habitudes, à traverser les moments difficiles et à construire un plan adapté à ton objectif.';
	@override String get noAccount => 'Aucune création de compte';
	@override String get localData => 'Données conservées sur l\'appareil';
	@override String get noAds => 'Aucune publicité';
	@override String get selfHelp => 'Un outil d\'auto-accompagnement';
	@override String get privacyAction => 'En savoir plus sur la confidentialité';
	@override String get privacyTitle => 'Confidentialité dès le départ';
	@override String get privacyBody => 'Aucune donnée de journal n\'est envoyée à StopCorn. L\'application ne lit ni ton navigateur, ni tes recherches, ni le contenu consulté. Tu choisis uniquement les repères généraux que tu souhaites noter. En cas de plantage, un rapport technique anonyme peut être envoyé pour que le problème soit corrigé ; il ne contient aucune de tes saisies et reste désactivable dans les réglages.';
}

// Path: onboarding.goal
class _Translations$onboarding$goal$fr extends Translations$onboarding$goal$en {
	_Translations$onboarding$goal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qu\'aimerais-tu changer ?';
	@override String get subtitle => 'Choisis un cap qui te ressemble. Tu pourras le modifier plus tard.';
	@override String get semantics => 'Choix de l\'objectif';
	@override String get weeklyLimit => 'Limite hebdomadaire souhaitée';
	@override String get weeklyHint => 'Exemple : 2';
	@override String get contexts => 'Contextes à éviter';
	@override String get motivation => 'Motivation personnelle';
	@override String get motivationHint => 'Ce que tu aimerais retrouver ou protéger…';
}

// Path: onboarding.baseline
class _Translations$onboarding$baseline$fr extends Translations$onboarding$baseline$en {
	_Translations$onboarding$baseline$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton point de départ';
	@override String get subtitle => 'Ce repère n\'est pas un test médical. Il servira seulement à observer ton évolution.';
	@override String get frequency => 'Fréquence approximative sur les 7 derniers jours';
	@override String get control => 'Sentiment de contrôle';
	@override String get impact => 'Impact négatif ressenti';
	@override String get confidence => 'Confiance dans ta capacité à changer';
}

// Path: onboarding.strategies
class _Translations$onboarding$strategies$fr extends Translations$onboarding$strategies$en {
	_Translations$onboarding$strategies$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Prépare ton plan de secours';
	@override String get subtitle => 'Choisis idéalement trois actions réalistes. Une seule suffit pour continuer.';
	@override String selected({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Aucune stratégie sélectionnée',
		one: '${count} stratégie sélectionnée',
		other: '${count} stratégies sélectionnées',
	);
	@override String get semantics => 'Stratégies de secours';
}

// Path: onboarding.privacy
class _Translations$onboarding$privacy$fr extends Translations$onboarding$privacy$en {
	_Translations$onboarding$privacy$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tes données restent sous ton contrôle';
	@override String get subtitle => 'StopCorn fonctionne sans compte et sans serveur dans cette version.';
	@override String get local => 'Données enregistrées uniquement sur cet appareil.';
	@override String get noHistory => 'Aucune URL ni recherche n\'est enregistrée.';
	@override String get control => 'Un export volontaire et une suppression totale sont possibles.';
	@override String get backup => 'Les sauvegardes système du téléphone peuvent inclure les données selon tes réglages système.';
	@override String get dailyCheckInReminder => 'Me rappeler de faire mon bilan';
	@override String get dailyCheckInReminderDescription => 'À 20 h, reçois un rappel local uniquement si le bilan du jour est encore vide. Tu pourras modifier ce choix plus tard.';
	@override String get reminderPermissionDenied => 'Les notifications n\'ont pas été autorisées. Désactive cette option pour continuer, ou autorise-les puis réessaie.';
	@override String get reminderUnavailable => 'Les rappels quotidiens ne sont pas disponibles sur cet appareil.';
	@override String get reminderError => 'Le rappel quotidien n\'a pas pu être préparé. Réessaie ou désactive-le pour continuer.';
	@override String get crashReports => 'Les rapports d\'erreur anonymes aident à corriger les bugs, et sont désactivables dans les réglages.';
}

// Path: onboarding.error
class _Translations$onboarding$error$fr extends Translations$onboarding$error$en {
	_Translations$onboarding$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get load => 'La configuration n\'a pas pu être chargée.';
	@override String get save => 'Impossible d\'enregistrer pour le moment. Réessaie dans quelques instants.';
	@override String get complete => 'La configuration n\'a pas pu être terminée. Aucune donnée n\'a été envoyée.';
	@override String get notReady => 'L\'onboarding n\'est pas encore prêt.';
	@override String get invalidDraft => 'Le brouillon de configuration enregistré est invalide.';
}

// Path: onboarding.validation
class _Translations$onboarding$validation$fr extends Translations$onboarding$validation$en {
	_Translations$onboarding$validation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get goal => 'Choisis un objectif.';
	@override String get weeklyLimit => 'Indique une limite hebdomadaire positive.';
	@override String get context => 'Choisis au moins un contexte.';
	@override String get strategy => 'Choisis au moins une stratégie.';
	@override String get scoreRange => 'Les scores doivent être compris entre 0 et 10.';
}

// Path: progress.error
class _Translations$progress$error$fr extends Translations$progress$error$en {
	_Translations$progress$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get load => 'Les données de progression n\'ont pas pu être chargées.';
}

// Path: progress.overview
class _Translations$progress$overview$fr extends Translations$progress$overview$en {
	_Translations$progress$overview$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Vue d\'ensemble';
	@override String events({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'consommations enregistrées',
		one: 'consommation enregistrée',
		other: 'consommations enregistrées',
	);
	@override String daysWithout({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'jours sans consommation enregistrée',
		one: 'jour sans consommation enregistrée',
		other: 'jours sans consommation enregistrée',
	);
	@override String completedUrges({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'sessions d\'aide terminées',
		one: 'session d\'aide terminée',
		other: 'sessions d\'aide terminées',
	);
	@override String get averageDecrease => 'diminution moyenne de l\'intensité';
	@override String get notEnough => 'Pas encore assez de données';
	@override String get decreaseDetail => 'Différence entre l\'intensité ressentie au début et celle ressentie à la fin';
	@override late final _Translations$progress$overview$goal$fr goal = _Translations$progress$overview$goal$fr._(_root);
	@override String get empty => 'Pas encore assez de données. Quelques repères suffiront pour faire apparaître des tendances.';
}

// Path: progress.events
class _Translations$progress$events$fr extends Translations$progress$events$en {
	_Translations$progress$events$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Évolution des événements';
	@override String get weeklyTitle => 'Évolution hebdomadaire';
	@override String get empty => 'Aucun événement enregistré sur cette période.';
	@override String weekOf({required Object date}) => 'Semaine du ${date}';
	@override String summary({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count} événements volontairement enregistrés, répartis par semaine.',
		one: '${count} événement volontairement enregistré, réparti par semaine.',
		other: '${count} événements volontairement enregistrés, répartis par semaine.',
	);
}

// Path: progress.urges
class _Translations$progress$urges$fr extends Translations$progress$urges$en {
	_Translations$progress$urges$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override TextSpan title({required InlineSpan corn}) => TextSpan(children: [
		const TextSpan(text: 'Envies de '),
		corn,
	]);
	@override String get averageIntensity => 'Intensité moyenne';
	@override String get empty => 'Pas encore assez de sessions terminées avec une intensité finale.';
	@override String get initial => 'Initiale';
	@override String get observationHours => 'Heures des observations';
	@override String get noHours => 'Aucune heure de parcours d\'aide ou d\'événement n\'est disponible.';
	@override late final _Translations$progress$urges$comparison$fr comparison = _Translations$progress$urges$comparison$fr._(_root);
	@override String hourSummary({required Object label}) => 'La tranche ${label} contient le plus d\'observations enregistrées.';
	@override late final _Translations$progress$urges$timeBucket$fr timeBucket = _Translations$progress$urges$timeBucket$fr._(_root);
	@override String get finalLabel => 'Finale';
}

// Path: progress.patterns
class _Translations$progress$patterns$fr extends Translations$progress$patterns$en {
	_Translations$progress$patterns$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Déclencheurs et émotions';
	@override late final _Translations$progress$patterns$triggers$fr triggers = _Translations$progress$patterns$triggers$fr._(_root);
	@override late final _Translations$progress$patterns$emotions$fr emotions = _Translations$progress$patterns$emotions$fr._(_root);
	@override String rankingSummary({required Object label, required Object kind}) => '${label} est le ${kind} le plus souvent noté sur cette période.';
}

// Path: progress.strategies
class _Translations$progress$strategies$fr extends Translations$progress$strategies$en {
	_Translations$progress$strategies$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Stratégies';
	@override String get effectiveness => 'Efficacité perçue';
	@override String get empty => 'Aucune stratégie évaluée sur cette période. L\'échelle va de −5 à +5.';
	@override String evaluations({required num count, required Object effect}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${effect} (${count} évaluations)',
		one: '${effect} (${count} évaluation)',
		other: '${effect} (${count} évaluations)',
	);
	@override String get threshold => 'Utilise et évalue une stratégie au moins trois fois pour obtenir un repère plus solide.';
	@override String best({required Object strategy}) => '${strategy} est la stratégie la mieux évaluée parmi celles utilisées au moins trois fois.';
}

// Path: progress.checkIns
class _Translations$progress$checkIns$fr extends Translations$progress$checkIns$en {
	_Translations$progress$checkIns$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bilans';
	@override String count({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'bilans quotidiens',
		one: 'bilan quotidien',
		other: 'bilans quotidiens',
	);
	@override String get averageMood => 'note d\'humeur moyenne';
	@override String get averageControl => 'taux de contrôle moyen';
	@override String get outOfTen => 'Sur 10';
}

// Path: progress.comparison
class _Translations$progress$comparison$fr extends Translations$progress$comparison$en {
	_Translations$progress$comparison$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Pas encore assez de données comparables';
	@override String get stable => 'Stable par rapport à la période précédente';
	@override String value({required Object value, required Object direction}) => '${value} % ${direction} que la période précédente';
	@override String get more => 'de plus';
	@override String get less => 'de moins';
}

// Path: progress.startingPoint
class _Translations$progress$startingPoint$fr extends Translations$progress$startingPoint$en {
	_Translations$progress$startingPoint$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get sectionTitle => 'Comparaison avec mon point de départ';
	@override String get screenTitle => 'Mon point de départ';
	@override String get intro => 'Ces réponses ont été enregistrées lors de ta configuration initiale. Elles constituent un repère personnel, pas un diagnostic.';
	@override String recordedOn({required Object date}) => 'Bilan initial enregistré le ${date}.';
	@override String get goalTitle => 'Ton objectif initial';
	@override String get goalUnavailable => 'L’objectif initial n’est plus disponible.';
	@override String weeklyLimit({required Object count}) => 'Limite souhaitée : ${count} par semaine';
	@override String contexts({required Object contexts}) => 'Contextes choisis : ${contexts}';
	@override String get motivationTitle => 'Ta motivation initiale';
	@override String get markersTitle => 'Tes repères initiaux';
	@override String get frequency => 'Fréquence approximative sur les 7 jours précédents';
	@override String frequencyValue({required Object count}) => '${count} sur 7 jours';
	@override String get control => 'Sentiment de contrôle';
	@override String get impact => 'Impact négatif ressenti';
	@override String get confidence => 'Confiance dans ta capacité à changer';
	@override String score({required Object value}) => '${value} / 10';
	@override String get disclaimer => 'Ces valeurs reflètent uniquement ton ressenti au moment du bilan initial.';
	@override late final _Translations$progress$startingPoint$comparison$fr comparison = _Translations$progress$startingPoint$comparison$fr._(_root);
	@override String get empty => 'Aucun bilan initial n’est disponible.';
	@override String get error => 'Le point de départ n’a pas pu être chargé.';
}

// Path: settings.support
class _Translations$settings$support$fr extends Translations$settings$support$en {
	_Translations$settings$support$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Un projet libre, pour rester accessible';
	@override String get body => 'StopCorn est né d\'un constat simple : les outils comparables finissent souvent derrière un abonnement ou des fonctionnalités limitées. L\'application est donc gratuite et open source, sans publicité ni traqueur, afin que chacun puisse avancer sans barrière.';
	@override late final _Translations$settings$support$values$fr values = _Translations$settings$support$values$fr._(_root);
	@override String get contribution => 'Si StopCorn t\'est utile, tu peux soutenir son développement. Ce geste est entièrement facultatif et ne débloque aucune fonctionnalité.';
	@override String get supportAction => 'Soutenir le développement';
	@override String get collapseAction => 'Réduire la carte du projet';
	@override String get expandAction => 'Déployer la carte du projet';
	@override String get sourceAction => 'Code source';
	@override String get websiteAction => 'Site web';
	@override String get thanks => 'Merci ! Ton soutien aide StopCorn à rester gratuit et indépendant.';
	@override late final _Translations$settings$support$error$fr error = _Translations$settings$support$error$fr._(_root);
}

// Path: settings.appearance
class _Translations$settings$appearance$fr extends Translations$settings$appearance$en {
	_Translations$settings$appearance$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Apparence';
	@override String get description => 'Choisis un thème ou suis le réglage du système.';
}

// Path: settings.reminders
class _Translations$settings$reminders$fr extends Translations$settings$reminders$en {
	_Translations$settings$reminders$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rappels';
	@override String get description => 'Choisis si StopCorn doit te proposer un petit bilan en fin de journée.';
	@override late final _Translations$settings$reminders$daily$fr daily = _Translations$settings$reminders$daily$fr._(_root);
	@override late final _Translations$settings$reminders$error$fr error = _Translations$settings$reminders$error$fr._(_root);
}

// Path: settings.progress
class _Translations$settings$progress$fr extends Translations$settings$progress$en {
	_Translations$settings$progress$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Progression';
	@override String get description => 'Adapte les indicateurs à ce qui t\'est utile.';
	@override String get defaultPeriod => 'Période par défaut';
	@override late final _Translations$settings$progress$harvest$fr harvest = _Translations$settings$progress$harvest$fr._(_root);
}

// Path: settings.personalPlan
class _Translations$settings$personalPlan$fr extends Translations$settings$personalPlan$en {
	_Translations$settings$personalPlan$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plan personnel';
	@override String get description => 'Garde à portée de main les options qui pourront t\'aider quand tu en as besoin.';
	@override late final _Translations$settings$personalPlan$goal$fr goal = _Translations$settings$personalPlan$goal$fr._(_root);
	@override late final _Translations$settings$personalPlan$backup$fr backup = _Translations$settings$personalPlan$backup$fr._(_root);
	@override late final _Translations$settings$personalPlan$history$fr history = _Translations$settings$personalPlan$history$fr._(_root);
}

// Path: settings.data
class _Translations$settings$data$fr extends Translations$settings$data$en {
	_Translations$settings$data$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Données';
	@override String get description => 'Tes données restent locales sauf export volontaire.';
	@override late final _Translations$settings$data$errorReporting$fr errorReporting = _Translations$settings$data$errorReporting$fr._(_root);
	@override late final _Translations$settings$data$export$fr export = _Translations$settings$data$export$fr._(_root);
	@override late final _Translations$settings$data$stored$fr stored = _Translations$settings$data$stored$fr._(_root);
	@override late final _Translations$settings$data$delete$fr delete = _Translations$settings$data$delete$fr._(_root);
}

// Path: settings.developer
class _Translations$settings$developer$fr extends Translations$settings$developer$en {
	_Translations$settings$developer$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Outils de développement';
	@override String get description => 'Utilitaires disponibles uniquement dans les versions de débogage.';
	@override late final _Translations$settings$developer$sample$fr sample = _Translations$settings$developer$sample$fr._(_root);
	@override late final _Translations$settings$developer$cornPoint$fr cornPoint = _Translations$settings$developer$cornPoint$fr._(_root);
	@override late final _Translations$settings$developer$supportThanks$fr supportThanks = _Translations$settings$developer$supportThanks$fr._(_root);
}

// Path: settings.about
class _Translations$settings$about$fr extends Translations$settings$about$en {
	_Translations$settings$about$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'À propos';
	@override String get description => 'Informations sur StopCorn et son cadre d\'utilisation.';
	@override String version({required Object version}) => 'Version ${version}.';
	@override String get body => 'StopCorn est un outil d\'auto-accompagnement gratuit, privé et sans jugement.';
	@override late final _Translations$settings$about$privacy$fr privacy = _Translations$settings$about$privacy$fr._(_root);
	@override String get licenses => 'Licences open source';
	@override String get professionalHelp => 'Trouver une aide professionnelle';
	@override late final _Translations$settings$about$help$fr help = _Translations$settings$about$help$fr._(_root);
}

// Path: settings.goalEditor
class _Translations$settings$goalEditor$fr extends Translations$settings$goalEditor$en {
	_Translations$settings$goalEditor$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Choisir un nouvel objectif';
	@override String get history => 'L\'objectif actuel restera dans ton historique.';
	@override String get activate => 'Activer cet objectif';
	@override String get error => 'L\'objectif n\'a pas pu être enregistré.';
	@override late final _Translations$settings$goalEditor$validation$fr validation = _Translations$settings$goalEditor$validation$fr._(_root);
}

// Path: settings.error
class _Translations$settings$error$fr extends Translations$settings$error$en {
	_Translations$settings$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get load => 'Les réglages n\'ont pas pu être chargés.';
	@override String get save => 'Impossible d\'enregistrer ce réglage pour le moment.';
}

// Path: urge.support
class _Translations$urge$support$fr extends Translations$urge$support$en {
	_Translations$urge$support$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'Choisir une aide';
	@override String get title => 'Qu\'est-ce qui t\'aiderait maintenant ?';
	@override String get subtitle => 'Choisis l\'option qui te paraît la plus accessible. Tu gardes la main sur le rythme.';
	@override String get semantics => 'Formes de soutien disponibles';
	@override String get guidedTitle => 'Pause guidée';
	@override String get guidedDescription => 'Prends un court moment pour souffler, puis fais à nouveau le point.';
	@override String get planTitle => 'Plan de secours';
	@override String planDescription({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Aucune action n\'a encore été préparée.',
		one: 'Choisis l\'action que tu avais préparée.',
		other: 'Choisis parmi les ${count} actions que tu avais préparées.',
	);
	@override String get ideasTitle => 'Autres idées';
	@override String ideasDescription({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Aucune autre action n\'est disponible.',
		one: 'Découvre une autre action.',
		other: 'Découvre ${count} autres actions.',
	);
}

// Path: urge.grounding
class _Translations$urge$grounding$fr extends Translations$urge$grounding$en {
	_Translations$urge$grounding$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get feet => 'Pose les pieds au sol.';
	@override String get inhale => 'Inspire lentement.';
	@override String get observe => 'Observe ce que tu ressens sans chercher à le chasser.';
	@override String get exhale => 'Expire plus longtemps que tu n\'inspires.';
	@override String get change => 'Observe simplement si cela monte, baisse ou reste stable.';
	@override String get title => 'Accorde-toi un instant.';
	@override String get subtitle => 'Cette courte pause est une aide à la décontraction, elle ne constitue pas une règle médicale.';
	@override String get semantics => 'Progression de la pause';
	@override String get skip => 'Passer';
}

// Path: urge.strategy
class _Translations$urge$strategy$fr extends Translations$urge$strategy$en {
	_Translations$urge$strategy$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'Choisir une action';
	@override String get title => 'Quelle action peux-tu essayer maintenant ?';
	@override String get subtitle => 'Une petite action réaliste suffit. Elle n\'a pas besoin de faire disparaître ce que tu ressens.';
	@override String get planTitle => 'Ton plan de secours';
	@override String get planSubtitle => 'Choisis l\'une des actions que tu avais préparées pour ce moment.';
	@override String get ideasTitle => 'Autres idées';
	@override String get ideasSubtitle => 'Choisis une autre action simple qui te paraît faisable maintenant.';
	@override String get loadError => 'Les stratégies n\'ont pas pu être chargées.';
	@override String get empty => 'Aucune action n\'est disponible dans cette liste.';
	@override String get semantics => 'Stratégies disponibles';
	@override String get start => 'Je lance cette action';
	@override String started({required Object strategy}) => 'Action lancée : ${strategy}.';
	@override String get timerTitle => 'Durée indicative';
	@override String get timerGuidance => 'Ce minuteur est seulement indicatif : tu peux terminer plus tôt ou prendre tout le temps dont tu as besoin.';
	@override String get timerSemantics => 'Minuteur indicatif de l\'action';
	@override String get timerComplete => 'La durée indicative est écoulée.';
	@override String get reassess => 'Faire le point à nouveau';
	@override String get effect => 'Utilité perçue de la stratégie';
}

// Path: urge.result
class _Translations$urge$result$fr extends Translations$urge$result$en {
	_Translations$urge$result$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get pageTitle => 'Faire le point';
	@override TextSpan get title => TextSpan(children: [
		const TextSpan(text: 'Comment évalues-tu ton envie maintenant ?'),
	]);
	@override String get subtitle => 'Elle peut avoir augmenté, diminué ou être restée stable.';
	@override late final _Translations$urge$result$outcome$fr outcome = _Translations$urge$result$outcome$fr._(_root);
	@override String get note => 'Note facultative';
	@override String get noteHint => 'Un repère utile pour la prochaine fois.';
	@override String get finish => 'Terminer le parcours';
}

// Path: urge.complete
class _Translations$urge$complete$fr extends Translations$urge$complete$en {
	_Translations$urge$complete$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Parcours terminé';
	@override String get consumedHeadline => 'Pas de souci.';
	@override String get otherHeadline => 'Super !';
	@override String get consumedBody => 'Cet événement n\'efface pas tes progrès.';
	@override String get otherBody => 'Tu as espacé ton envie et ton choix.';
	@override String get log => 'Noter ce qui s\'est passé';
}

// Path: urge.intensity
class _Translations$urge$intensity$fr extends Translations$urge$intensity$en {
	_Translations$urge$intensity$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override TextSpan get title => TextSpan(children: [
		const TextSpan(text: 'Quelle est l\'intensité de ton envie ?'),
	]);
	@override String get subtitle => 'Évalue-la sur 10. Il n\'y a pas de mauvaise réponse : ce repère permettra de voir comment elle évolue.';
	@override String get label => 'Intensité actuelle';
}

// Path: urge.factors
class _Translations$urge$factors$fr extends Translations$urge$factors$en {
	_Translations$urge$factors$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'D\'autres détails ?';
	@override String get subtitle => 'Ces informations facultatives peuvent t\'aider à mieux comprendre ces moments.';
	@override String get label => 'Facteurs déclenchants (facultatif)';
	@override String get trigger => 'Déclencheur';
	@override String get emotion => 'Émotion';
}

// Path: urge.timer
class _Translations$urge$timer$fr extends Translations$urge$timer$en {
	_Translations$urge$timer$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String count({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count}s restantes',
		one: '${count}s restante',
		other: '${count}s restantes',
	);
}

// Path: urge.error
class _Translations$urge$error$fr extends Translations$urge$error$en {
	_Translations$urge$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get start => 'Impossible de démarrer ce parcours pour le moment. Réessaie.';
	@override String get missingSession => 'Cette session n\'est plus disponible.';
	@override String get strategySave => 'La stratégie n\'a pas pu être enregistrée. Réessaie.';
	@override String get outcomeRequired => 'Choisis le résultat qui décrit le mieux la situation.';
	@override String get save => 'Impossible d\'enregistrer pour le moment. Réessaie dans quelques instants.';
}

// Path: home.checkIn.action
class _Translations$home$checkIn$action$fr extends Translations$home$checkIn$action$en {
	_Translations$home$checkIn$action$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get done => 'Éditer mon bilan quotidien';
	@override String get pending => 'Faire mon bilan quotidien';
}

// Path: journal.history.empty
class _Translations$journal$history$empty$fr extends Translations$journal$history$empty$en {
	_Translations$journal$history$empty$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ton journal est encore vide';
	@override String get body => 'Les consommations et les bilans que tu enregistreras apparaîtront ici.';
}

// Path: journal.history.date
class _Translations$journal$history$date$fr extends Translations$journal$history$date$en {
	_Translations$journal$history$date$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get today => 'Aujourd\'hui';
	@override String get yesterday => 'Hier';
}

// Path: journal.history.entry
class _Translations$journal$history$entry$fr extends Translations$journal$history$entry$en {
	_Translations$journal$history$entry$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get consumption => 'Consommation';
	@override String get checkIn => 'Bilan quotidien';
	@override String time({required Object time}) => 'À ${time}';
	@override String checkInSummary({required Object mood, required Object control}) => 'Humeur : ${mood}/10 · Contrôle : ${control}/10';
	@override String get noText => 'Aucun contexte ni aucune note.';
	@override String entries({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Aucune entrée',
		one: '${count} entrée',
		other: '${count} entrées',
	);
	@override String get urge => 'Session d\'aide';
	@override String urgeSummary({required Object initial, required Object finalValue}) => 'Intensité ${initial} → ${finalValue}';
	@override String urgeSummaryPartial({required Object initial}) => 'Intensité de départ ${initial}';
}

// Path: journal.history.details
class _Translations$journal$history$details$fr extends Translations$journal$history$details$en {
	_Translations$journal$history$details$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override TextSpan cornUrges({required num count, required InlineSpan Function(num) countBuilder, required InlineSpan corn}) => RichPluralResolvers.bridge(
		n: count,
		resolver: _root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'),
		zero: () => TextSpan(children: [
			const TextSpan(text: 'aucune envie de '),
			corn,
		]),
		one: () => TextSpan(children: [
			countBuilder(count),
			const TextSpan(text: ' envie de '),
			corn,
		]),
		other: () => TextSpan(children: [
			countBuilder(count),
			const TextSpan(text: ' envies de '),
			corn,
		]),
	);
	@override String get initialIntensity => 'Intensité de départ';
	@override String get finalIntensity => 'Intensité à la fin';
	@override String get outcome => 'Issue';
	@override String get strategy => 'Action essayée';
	@override String get pause => 'Pause guidée';
	@override String pauseSeconds({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count} secondes',
		one: '${count} seconde',
		other: '${count} secondes',
	);
	@override String get reflection => 'Ta réflexion';
}

// Path: learningModules.continueAfterSetback.sections
class _Translations$learningModules$continueAfterSetback$sections$fr extends Translations$learningModules$continueAfterSetback$sections$en {
	_Translations$learningModules$continueAfterSetback$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learningModules$continueAfterSetback$sections$perspective$fr perspective = _Translations$learningModules$continueAfterSetback$sections$perspective$fr._(_root);
	@override late final _Translations$learningModules$continueAfterSetback$sections$adjust$fr adjust = _Translations$learningModules$continueAfterSetback$sections$adjust$fr._(_root);
	@override late final _Translations$learningModules$continueAfterSetback$sections$help$fr help = _Translations$learningModules$continueAfterSetback$sections$help$fr._(_root);
}

// Path: learningModules.mapTerrain.sections
class _Translations$learningModules$mapTerrain$sections$fr extends Translations$learningModules$mapTerrain$sections$en {
	_Translations$learningModules$mapTerrain$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learningModules$mapTerrain$sections$states$fr states = _Translations$learningModules$mapTerrain$sections$states$fr._(_root);
	@override late final _Translations$learningModules$mapTerrain$sections$routines$fr routines = _Translations$learningModules$mapTerrain$sections$routines$fr._(_root);
	@override late final _Translations$learningModules$mapTerrain$sections$map$fr map = _Translations$learningModules$mapTerrain$sections$map$fr._(_root);
}

// Path: learningModules.prepareEnvironment.sections
class _Translations$learningModules$prepareEnvironment$sections$fr extends Translations$learningModules$prepareEnvironment$sections$en {
	_Translations$learningModules$prepareEnvironment$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learningModules$prepareEnvironment$sections$friction$fr friction = _Translations$learningModules$prepareEnvironment$sections$friction$fr._(_root);
	@override late final _Translations$learningModules$prepareEnvironment$sections$moments$fr moments = _Translations$learningModules$prepareEnvironment$sections$moments$fr._(_root);
	@override late final _Translations$learningModules$prepareEnvironment$sections$alternative$fr alternative = _Translations$learningModules$prepareEnvironment$sections$alternative$fr._(_root);
}

// Path: learningModules.rideUrge.sections
class _Translations$learningModules$rideUrge$sections$fr extends Translations$learningModules$rideUrge$sections$en {
	_Translations$learningModules$rideUrge$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learningModules$rideUrge$sections$delay$fr delay = _Translations$learningModules$rideUrge$sections$delay$fr._(_root);
	@override late final _Translations$learningModules$rideUrge$sections$concrete$fr concrete = _Translations$learningModules$rideUrge$sections$concrete$fr._(_root);
	@override late final _Translations$learningModules$rideUrge$sections$expectations$fr expectations = _Translations$learningModules$rideUrge$sections$expectations$fr._(_root);
}

// Path: learningModules.understandLoop.sections
class _Translations$learningModules$understandLoop$sections$fr extends Translations$learningModules$understandLoop$sections$en {
	_Translations$learningModules$understandLoop$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learningModules$understandLoop$sections$sequence$fr sequence = _Translations$learningModules$understandLoop$sections$sequence$fr._(_root);
	@override late final _Translations$learningModules$understandLoop$sections$action$fr action = _Translations$learningModules$understandLoop$sections$action$fr._(_root);
	@override late final _Translations$learningModules$understandLoop$sections$observe$fr observe = _Translations$learningModules$understandLoop$sections$observe$fr._(_root);
}

// Path: learningModules.whyChange.sections
class _Translations$learningModules$whyChange$sections$fr extends Translations$learningModules$whyChange$sections$en {
	_Translations$learningModules$whyChange$sections$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$learningModules$whyChange$sections$direction$fr direction = _Translations$learningModules$whyChange$sections$direction$fr._(_root);
	@override late final _Translations$learningModules$whyChange$sections$benefits$fr benefits = _Translations$learningModules$whyChange$sections$benefits$fr._(_root);
	@override late final _Translations$learningModules$whyChange$sections$changes$fr changes = _Translations$learningModules$whyChange$sections$changes$fr._(_root);
}

// Path: progress.overview.goal
class _Translations$progress$overview$goal$fr extends Translations$progress$overview$goal$en {
	_Translations$progress$overview$goal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String abstinence({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count} consommation enregistrée volontairement sur la période sélectionnée. Une absence d\'observation ne prouve jamais qu\'aucun événement n\'a eu lieu.',
		one: '${count} consommation enregistrée volontairement sur la période sélectionnée. Une absence d\'observation ne prouve jamais qu\'aucun événement n\'a eu lieu.',
		other: '${count} consommations enregistrées volontairement sur la période sélectionnée. Une absence d\'observation ne prouve jamais qu\'aucun événement n\'a eu lieu.',
	);
	@override String reduction({required num count, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Cette semaine : ${count} événement enregistré sur une limite souhaitée de ${limit}.',
		one: 'Cette semaine : ${count} événement enregistré sur une limite souhaitée de ${limit}.',
		other: 'Cette semaine : ${count} événements enregistrés sur une limite souhaitée de ${limit}.',
	);
	@override String contextual({required num count, required Object contexts}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count} consommation enregistrée correspondait à l\'un de tes contextes protégés sur la période sélectionnée : ${contexts}.',
		one: '${count} consommation enregistrée correspondait à l\'un de tes contextes protégés sur la période sélectionnée : ${contexts}.',
		other: '${count} consommations enregistrées correspondaient à l\'un de tes contextes protégés sur la période sélectionnée : ${contexts}.',
	);
	@override String observation({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count} repère volontaire enregistré sur la période sélectionnée. Chaque observation honnête aide à faire apparaître les tendances.',
		one: '${count} repère volontaire enregistré sur la période sélectionnée. Chaque observation honnête aide à faire apparaître les tendances.',
		other: '${count} repères volontaires enregistrés sur la période sélectionnée. Chaque observation honnête aide à faire apparaître les tendances.',
	);
}

// Path: progress.urges.comparison
class _Translations$progress$urges$comparison$fr extends Translations$progress$urges$comparison$en {
	_Translations$progress$urges$comparison$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get unavailable => 'Pas encore assez de données pour comparer le début et la fin des parcours d\'aide.';
	@override String decrease({required num count, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'L\'intensité a diminué en moyenne de ${value} points pendant les sessions complètes.',
		one: 'L\'intensité a diminué en moyenne de ${value} point pendant les sessions complètes.',
		other: 'L\'intensité a diminué en moyenne de ${value} points pendant les sessions complètes.',
	);
	@override String increase({required num count, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'L\'intensité a augmenté en moyenne de ${value} points pendant les sessions complètes.',
		one: 'L\'intensité a augmenté en moyenne de ${value} point pendant les sessions complètes.',
		other: 'L\'intensité a augmenté en moyenne de ${value} points pendant les sessions complètes.',
	);
}

// Path: progress.urges.timeBucket
class _Translations$progress$urges$timeBucket$fr extends Translations$progress$urges$timeBucket$en {
	_Translations$progress$urges$timeBucket$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String midnight({required Object start}) => '${start}h – minuit';
	@override String range({required Object start, required Object end}) => '${start}h – ${end}h';
}

// Path: progress.patterns.triggers
class _Translations$progress$patterns$triggers$fr extends Translations$progress$patterns$triggers$en {
	_Translations$progress$patterns$triggers$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Déclencheurs les plus notés';
	@override String get kind => 'déclencheur';
	@override String get empty => 'Aucun déclencheur n\'a encore été noté.';
}

// Path: progress.patterns.emotions
class _Translations$progress$patterns$emotions$fr extends Translations$progress$patterns$emotions$en {
	_Translations$progress$patterns$emotions$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Émotions les plus notées';
	@override String get kind => 'émotion';
	@override String get empty => 'Aucune émotion n\'a encore été notée.';
}

// Path: progress.startingPoint.comparison
class _Translations$progress$startingPoint$comparison$fr extends Translations$progress$startingPoint$comparison$en {
	_Translations$progress$startingPoint$comparison$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get intro => 'Comparaison avec les observations de la période sélectionnée.';
	@override String get control => 'Sentiment de contrôle';
	@override String get initial => 'Initiale';
	@override String get finalLabel => 'Finale';
	@override String controlDetail({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Moyenne calculée à partir de ${count} bilan quotidien.',
		one: 'Moyenne calculée à partir de ${count} bilan quotidien.',
		other: 'Moyenne calculée à partir de ${count} bilans quotidiens.',
	);
	@override String get controlPending => 'Au moins cinq bilans quotidiens sont nécessaires pour proposer une comparaison.';
	@override String get frequency => 'Fréquence hebdomadaire';
	@override String get frequencyPending => 'Une semaine complète d’observation est nécessaire pour proposer une comparaison.';
	@override String get frequencyDetail => 'La valeur actuelle ne compte que les consommations volontairement enregistrées et peut donc différer de la fréquence réelle.';
	@override String get open => 'Voir mon point de départ';
}

// Path: settings.support.values
class _Translations$settings$support$values$fr extends Translations$settings$support$values$en {
	_Translations$settings$support$values$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get free => 'Gratuit';
	@override String get openSource => 'Open source';
	@override String get noAds => 'Sans publicité';
	@override String get noTracking => 'Sans traqueur';
}

// Path: settings.support.error
class _Translations$settings$support$error$fr extends Translations$settings$support$error$en {
	_Translations$settings$support$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get link => 'Impossible d\'ouvrir ce lien pour le moment.';
	@override String get notConfigured => 'Le soutien intégré n\'est pas encore configuré sur cette version.';
	@override String get paywall => 'Impossible d\'afficher la page de soutien pour le moment.';
}

// Path: settings.reminders.daily
class _Translations$settings$reminders$daily$fr extends Translations$settings$reminders$daily$en {
	_Translations$settings$reminders$daily$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Rappel du bilan quotidien';
	@override String get description => 'À 20 h, me prévenir uniquement si le bilan du jour est encore vide.';
	@override String get unavailable => 'Les rappels quotidiens ne sont pas disponibles sur cet appareil.';
}

// Path: settings.reminders.error
class _Translations$settings$reminders$error$fr extends Translations$settings$reminders$error$en {
	_Translations$settings$reminders$error$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get permissionDenied => 'Les notifications n\'ont pas été autorisées dans les réglages du système.';
	@override String get save => 'Le rappel quotidien n\'a pas pu être mis à jour.';
}

// Path: settings.progress.harvest
class _Translations$settings$progress$harvest$fr extends Translations$settings$progress$harvest$en {
	_Translations$settings$progress$harvest$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Récolte';
	@override String get description => 'Récolte au maximum un corn point par journée constructive. Ta récolte ne diminue jamais.';
}

// Path: settings.personalPlan.goal
class _Translations$settings$personalPlan$goal$fr extends Translations$settings$personalPlan$goal$en {
	_Translations$settings$personalPlan$goal$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Mon objectif';
	@override String get none => 'Aucun objectif actif';
}

// Path: settings.personalPlan.backup
class _Translations$settings$personalPlan$backup$fr extends Translations$settings$personalPlan$backup$en {
	_Translations$settings$personalPlan$backup$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mon plan de secours';
	@override String get description => 'Place en priorité les actions que tu peux réellement essayer dans un moment difficile.';
	@override String summary({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: 'Aucune action sélectionnée',
		one: '${count} action sélectionnée',
		other: '${count} actions sélectionnées',
	);
}

// Path: settings.personalPlan.history
class _Translations$settings$personalPlan$history$fr extends Translations$settings$personalPlan$history$en {
	_Translations$settings$personalPlan$history$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Historique des objectifs';
	@override String get subtitle => 'Les directions que tu as choisies jusqu’ici';
	@override String get open => 'Voir l\'historique';
	@override String get current => 'En cours';
	@override String ended({required Object date}) => 'Terminé le ${date}';
	@override String started({required Object date}) => 'Commencé le ${date}';
	@override String get empty => 'Tu n\'as pas encore défini d\'objectif.';
	@override String get error => 'L\'historique des objectifs n\'a pas pu être chargé.';
	@override String count({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count} objectifs',
		one: '${count} objectif',
		other: '${count} objectifs',
	);
	@override String weeklyLimit({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count,
		zero: '${count} événements par semaine',
		one: '${count} événement par semaine',
		other: '${count} événements par semaine',
	);
	@override String contexts({required Object contexts}) => 'Contextes protégés : ${contexts}';
}

// Path: settings.data.errorReporting
class _Translations$settings$data$errorReporting$fr extends Translations$settings$data$errorReporting$en {
	_Translations$settings$data$errorReporting$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Rapports d\'erreur anonymes';
	@override String get description => 'Envoie un rapport technique lorsque StopCorn plante, afin que le problème puisse être corrigé. Il ne contient aucun objectif, entrée de journal, note ou réglage. Désactive cette option pour ne rien envoyer du tout.';
}

// Path: settings.data.export
class _Translations$settings$data$export$fr extends Translations$settings$data$export$en {
	_Translations$settings$data$export$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Exporter mes données';
	@override String get description => 'Créer un fichier JSON versionné.';
}

// Path: settings.data.stored
class _Translations$settings$data$stored$fr extends Translations$settings$data$stored$en {
	_Translations$settings$data$stored$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ce qui est stocké';
	@override String get description => 'Comprendre les données locales.';
	@override String get body1 => 'StopCorn conserve localement tes objectifs, bilans, parcours d\'aide, événements volontaires, stratégies utilisées et progression pédagogique.';
	@override String get body2 => 'L\'application ne collecte jamais les URL, l\'historique du navigateur, les recherches, les captures d\'écran, les contacts ou la position.';
	@override String get body3 => 'Selon les réglages du système, une sauvegarde du téléphone peut éventuellement inclure les données de l\'application.';
}

// Path: settings.data.delete
class _Translations$settings$data$delete$fr extends Translations$settings$data$delete$en {
	_Translations$settings$data$delete$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get action => 'Supprimer toutes mes données';
	@override String get description => 'Action définitive en deux étapes.';
	@override String get progress => 'Suppression en cours…';
	@override String get semantics => 'Confirmer la suppression';
	@override String get title => 'Supprimer toutes les données ?';
	@override String get body => 'Les objectifs, observations, notes, bilans, progressions, préférences et exports en cache seront effacés de cet appareil. Cette action est définitive.';
	@override String get error => 'La suppression n\'a pas pu être terminée. Certaines données sont peut-être déjà effacées ; réessaie pour terminer.';
	@override late final _Translations$settings$data$delete$confirmation$fr confirmation = _Translations$settings$data$delete$confirmation$fr._(_root);
}

// Path: settings.developer.sample
class _Translations$settings$developer$sample$fr extends Translations$settings$developer$sample$en {
	_Translations$settings$developer$sample$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get action => 'Charger des données d\'exemple';
	@override String get description => 'Ajoute un historique local cohérent sur 60 jours sans effacer tes données existantes.';
	@override String get progress => 'Chargement des données d\'exemple…';
	@override String get loaded => 'Données d\'exemple chargées. Tu peux les recharger à tout moment.';
	@override String get error => 'Les données d\'exemple n\'ont pas pu être chargées.';
}

// Path: settings.developer.cornPoint
class _Translations$settings$developer$cornPoint$fr extends Translations$settings$developer$cornPoint$en {
	_Translations$settings$developer$cornPoint$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get action => 'Donner un Corn point';
	@override String get description => 'Ajoute un point bonus et ouvre le dialogue animé, même si le Corn point du jour est déjà récolté.';
}

// Path: settings.developer.supportThanks
class _Translations$settings$developer$supportThanks$fr extends Translations$settings$developer$supportThanks$en {
	_Translations$settings$developer$supportThanks$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get label => 'Afficher le remerciement de soutien';
	@override String get description => 'Affiche localement la note de remerciement dans la carte de soutien, sans achat RevenueCat.';
}

// Path: settings.about.privacy
class _Translations$settings$about$privacy$fr extends Translations$settings$about$privacy$en {
	_Translations$settings$about$privacy$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Confidentialité';
	@override String get body1 => 'Aucun compte StopCorn n\'est créé et l\'accompagnement quotidien n\'utilise ni suivi d\'usage, ni mesure d\'audience, ni publicité.';
	@override String get body2 => 'Toutes les observations restent sur cet appareil, sauf si tu choisis explicitement de créer puis partager un export.';
	@override String get body3 => 'StopCorn ne contacte RevenueCat que si tu ouvres toi-même la page de soutien : afficher les Réglages reste une opération locale. Après cette ouverture, l\'application vérifie au lancement si un soutien existe, afin de pouvoir te remercier. RevenueCat et la boutique de ton appareil traitent alors les informations nécessaires à l\'achat, sans tes notes privées. StopCorn désactive les diagnostics et la collecte d\'identifiants publicitaires.';
	@override String get body4 => 'La suppression totale efface les données utilisateur et les préférences StopCorn, puis remet l\'application à son état initial.';
	@override String get policyAction => 'Voir la politique de confidentialité';
	@override String get policyError => 'Impossible d\'ouvrir la politique de confidentialité pour le moment.';
	@override String get body5 => 'Des rapports d\'erreur anonymes sont envoyés via Sentry afin que les plantages puissent être corrigés. Ils contiennent l\'erreur technique et l\'endroit où elle s\'est produite, jamais un objectif, une entrée de journal, une note ou une valeur de la base. L\'option de la section Données les arrête complètement.';
}

// Path: settings.about.help
class _Translations$settings$about$help$fr extends Translations$settings$about$help$en {
	_Translations$settings$about$help$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aide professionnelle';
	@override String get body1 => 'Un médecin généraliste, un psychologue ou un autre professionnel qualifié peut aider à évaluer la situation et proposer un accompagnement adapté.';
	@override String get body2 => 'Demander de l\'aide peut être pertinent si la souffrance est forte, si la perte de contrôle persiste ou si les conséquences deviennent importantes.';
	@override String get body3 => 'StopCorn ne fournit pas de diagnostic et ne remplace pas cet accompagnement.';
}

// Path: settings.goalEditor.validation
class _Translations$settings$goalEditor$validation$fr extends Translations$settings$goalEditor$validation$en {
	_Translations$settings$goalEditor$validation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get weeklyLimit => 'Indique une limite hebdomadaire positive.';
	@override String get context => 'Choisis au moins un contexte.';
}

// Path: urge.result.outcome
class _Translations$urge$result$outcome$fr extends Translations$urge$result$outcome$en {
	_Translations$urge$result$outcome$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Et maintenant ?';
	@override String get subtitle => 'N\'hésite pas à être honnête. Comme toujours, pas de jugement !';
	@override String get label => 'Résultat';
}

// Path: learningModules.continueAfterSetback.sections.perspective
class _Translations$learningModules$continueAfterSetback$sections$perspective$fr extends Translations$learningModules$continueAfterSetback$sections$perspective$en {
	_Translations$learningModules$continueAfterSetback$sections$perspective$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sortir du « tout est fichu »';
	@override String get paragraph1 => 'Un événement n\'efface pas les pauses, les choix et les observations que tu as déjà faits.';
	@override String get paragraph2 => 'Penser que tout est fichu peut te pousser à abandonner un plan qui reste pourtant utile.';
}

// Path: learningModules.continueAfterSetback.sections.adjust
class _Translations$learningModules$continueAfterSetback$sections$adjust$fr extends Translations$learningModules$continueAfterSetback$sections$adjust$en {
	_Translations$learningModules$continueAfterSetback$sections$adjust$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ajuster plutôt que te punir';
	@override String get paragraph1 => 'Regarde ce qui a précédé : l\'heure, la fatigue, l\'émotion, l\'appareil ou le contexte général.';
	@override String get paragraph2 => 'Choisis ensuite un ajustement limité. Une punition ou un objectif irréaliste apporte rarement une information utile.';
}

// Path: learningModules.continueAfterSetback.sections.help
class _Translations$learningModules$continueAfterSetback$sections$help$fr extends Translations$learningModules$continueAfterSetback$sections$help$en {
	_Translations$learningModules$continueAfterSetback$sections$help$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Savoir quand demander de l\'aide';
	@override String get paragraph1 => 'Si la perte de contrôle persiste, provoque une forte souffrance ou entraîne des conséquences importantes, en parler à un professionnel qualifié peut aider.';
	@override String get paragraph2 => 'Demander de l\'aide peut faire partie de ton plan et n\'enlève rien aux progrès déjà accomplis.';
}

// Path: learningModules.mapTerrain.sections.states
class _Translations$learningModules$mapTerrain$sections$states$fr extends Translations$learningModules$mapTerrain$sections$states$en {
	_Translations$learningModules$mapTerrain$sections$states$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Les moments et les états';
	@override String get paragraph1 => 'L\'heure et le lieu peuvent devenir des repères de contexte récurrents. Le stress, l\'ennui ou l\'envie de prendre de la distance avec une émotion difficile peuvent aussi apparaître dans tes observations.';
	@override String get paragraph2 => 'Considère ces répétitions comme des hypothèses, pas comme des causes : plusieurs observations dans le temps sont plus utiles qu\'une coïncidence isolée.';
}

// Path: learningModules.mapTerrain.sections.routines
class _Translations$learningModules$mapTerrain$sections$routines$fr extends Translations$learningModules$mapTerrain$sections$routines$en {
	_Translations$learningModules$mapTerrain$sections$routines$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Les appareils et les routines';
	@override String get paragraph1 => 'Un appareil disponible au même endroit et au même moment peut faciliter une réponse automatique.';
	@override String get paragraph2 => 'Si tes notes montrent que les réseaux sociaux ou une routine du soir précèdent souvent un moment difficile, considère-les comme des repères utiles, pas forcément comme sa seule cause.';
}

// Path: learningModules.mapTerrain.sections.map
class _Translations$learningModules$mapTerrain$sections$map$fr extends Translations$learningModules$mapTerrain$sections$map$en {
	_Translations$learningModules$mapTerrain$sections$map$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Une carte, pas un verdict';
	@override String get paragraph1 => 'Cartographier ton terrain sert à préparer des options, pas à éviter toutes les situations difficiles.';
	@override String get paragraph2 => 'Quelques observations générales suffisent : aucun détail explicite ni historique de navigation n\'est utile.';
}

// Path: learningModules.prepareEnvironment.sections.friction
class _Translations$learningModules$prepareEnvironment$sections$friction$fr extends Translations$learningModules$prepareEnvironment$sections$friction$en {
	_Translations$learningModules$prepareEnvironment$sections$friction$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rendre l\'accès moins automatique';
	@override String get paragraph1 => 'Laisser le téléphone hors de la chambre, fixer certains horaires ou utiliser le mode de concentration du système peut ajouter une friction volontaire.';
	@override String get paragraph2 => 'Un bloqueur peut compléter ton plan, mais il ne règle pas une difficulté à lui seul.';
}

// Path: learningModules.prepareEnvironment.sections.moments
class _Translations$learningModules$prepareEnvironment$sections$moments$fr extends Translations$learningModules$prepareEnvironment$sections$moments$en {
	_Translations$learningModules$prepareEnvironment$sections$moments$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Préparer les moments plus fragiles';
	@override String get paragraph1 => 'Si les soirées où tu es fatigué reviennent dans tes observations, préparer une routine simple ou charger ton appareil ailleurs peut faciliter l\'action souhaitée.';
	@override String get paragraph2 => 'Si certains comptes ou réseaux précèdent souvent les moments difficiles, tu peux en ajuster l\'accès sans devoir tout supprimer.';
}

// Path: learningModules.prepareEnvironment.sections.alternative
class _Translations$learningModules$prepareEnvironment$sections$alternative$fr extends Translations$learningModules$prepareEnvironment$sections$alternative$en {
	_Translations$learningModules$prepareEnvironment$sections$alternative$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rendre l\'alternative visible';
	@override String get paragraph1 => 'Prépare une autre action facile d\'accès : un livre à proximité, une courte marche ou une tâche choisie à l\'avance.';
	@override String get paragraph2 => 'Ton environnement est surtout utile lorsqu\'il soutient une intention précise.';
}

// Path: learningModules.rideUrge.sections.delay
class _Translations$learningModules$rideUrge$sections$delay$fr extends Translations$learningModules$rideUrge$sections$delay$en {
	_Translations$learningModules$rideUrge$sections$delay$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'T\'accorder un instant';
	@override String get paragraph1 => 'Une impulsion ne t\'oblige pas à prendre une décision immédiate ou définitive.';
	@override String get paragraph2 => 'Attendre un peu te permet d\'observer si son intensité monte, baisse ou reste stable.';
}

// Path: learningModules.rideUrge.sections.concrete
class _Translations$learningModules$rideUrge$sections$concrete$fr extends Translations$learningModules$rideUrge$sections$concrete$en {
	_Translations$learningModules$rideUrge$sections$concrete$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Changer quelque chose de concret';
	@override String get paragraph1 => 'Changer de pièce, poser le téléphone ou commencer une toute petite tâche peut interrompre une réponse automatique.';
	@override String get paragraph2 => 'Choisis une action assez simple pour rester possible même lorsque ton énergie est basse.';
}

// Path: learningModules.rideUrge.sections.expectations
class _Translations$learningModules$rideUrge$sections$expectations$fr extends Translations$learningModules$rideUrge$sections$expectations$en {
	_Translations$learningModules$rideUrge$sections$expectations$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ne pas exiger que la sensation disparaisse';
	@override String get paragraph1 => 'Une stratégie peut être utile même si la sensation ne disparaît pas tout de suite.';
	@override String get paragraph2 => 'L\'objectif est de t\'entraîner à choisir, pas d\'obtenir un résultat parfait à chaque fois.';
}

// Path: learningModules.understandLoop.sections.sequence
class _Translations$learningModules$understandLoop$sections$sequence$fr extends Translations$learningModules$understandLoop$sections$sequence$en {
	_Translations$learningModules$understandLoop$sections$sequence$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Un enchaînement à observer';
	@override String get paragraph1 => 'Une habitude peut parfois se décrire ainsi : situation → émotion → impulsion → comportement → effet ou soulagement immédiat → conséquences.';
	@override String get paragraph2 => 'C\'est un modèle pratique pour observer, pas un enchaînement dont l\'application à tout le monde est démontrée. Certaines étapes peuvent être très rapides ou difficiles à remarquer.';
}

// Path: learningModules.understandLoop.sections.action
class _Translations$learningModules$understandLoop$sections$action$fr extends Translations$learningModules$understandLoop$sections$action$en {
	_Translations$learningModules$understandLoop$sections$action$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Trouver un point d\'appui';
	@override String get paragraph1 => 'Tu n\'as pas besoin de maîtriser toute la boucle. Changer de lieu, attendre quelques minutes ou choisir une autre action peut ouvrir une marge de manœuvre.';
	@override String get paragraph2 => 'Observer la situation et l\'émotion peut t\'aider à choisir une action réaliste.';
}

// Path: learningModules.understandLoop.sections.observe
class _Translations$learningModules$understandLoop$sections$observe$fr extends Translations$learningModules$understandLoop$sections$observe$en {
	_Translations$learningModules$understandLoop$sections$observe$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Observer sans poser de diagnostic';
	@override String get paragraph1 => 'Les notes de StopCorn sont des repères personnels, pas un diagnostic.';
	@override String get paragraph2 => 'Le but est de mieux voir les enchaînements qui reviennent afin d\'ajuster ton plan.';
}

// Path: learningModules.whyChange.sections.direction
class _Translations$learningModules$whyChange$sections$direction$fr extends Translations$learningModules$whyChange$sections$direction$en {
	_Translations$learningModules$whyChange$sections$direction$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Une direction qui vient de toi';
	@override String get paragraph1 => 'Un changement a plus de chances de durer lorsqu\'il correspond à ce qui compte pour toi, et pas seulement à ce que les autres attendent.';
	@override String get paragraph2 => 'Tu peux vouloir arrêter, réduire, éviter certaines situations ou commencer par observer. Aucun de ces choix ne définit ta valeur.';
}

// Path: learningModules.whyChange.sections.benefits
class _Translations$learningModules$whyChange$sections$benefits$fr extends Translations$learningModules$whyChange$sections$benefits$en {
	_Translations$learningModules$whyChange$sections$benefits$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ce que tu veux retrouver';
	@override String get paragraph1 => 'Essaie de nommer ce que tu aimerais retrouver : du temps, de la disponibilité mentale, du sommeil, une relation plus sereine ou le sentiment de décider.';
	@override String get paragraph2 => 'Une raison personnelle et précise peut servir de repère lorsque l\'impulsion devient forte.';
}

// Path: learningModules.whyChange.sections.changes
class _Translations$learningModules$whyChange$sections$changes$fr extends Translations$learningModules$whyChange$sections$changes$en {
	_Translations$learningModules$whyChange$sections$changes$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get title => 'Une motivation variable';
	@override String get paragraph1 => 'La motivation change d\'un jour à l\'autre. Cela ne signifie ni que tu as échoué, ni que ton objectif est mauvais.';
	@override String get paragraph2 => 'Lorsqu\'elle baisse, une petite action préparée à l\'avance peut prendre le relais.';
}

// Path: settings.data.delete.confirmation
class _Translations$settings$data$delete$confirmation$fr extends Translations$settings$data$delete$confirmation$en {
	_Translations$settings$data$delete$confirmation$fr._(TranslationsFr root) : this._root = root, super.internal(root);

	final TranslationsFr _root; // ignore: unused_field

	// Translations
	@override String get semantics => 'Suppression définitive';
	@override String get title => 'Dernière confirmation';
	@override String get action => 'Supprimer définitivement';
	@override String get keep => 'Garder mes données';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'StopCorn',
			'app.logoSemantics' => 'Logo en forme d\'épi de maïs de StopCorn',
			'app.urgeCueSemantics' => 'ce contenu',
			'app.loading' => 'Chargement…',
			'app.retry' => 'Réessayer',
			'app.cancel' => 'Annuler',
			'app.close' => 'Fermer',
			'app.continueLabel' => 'Continuer',
			'app.back' => 'Retour',
			'app.backHome' => 'Retour à l\'accueil',
			'app.save' => 'Enregistrer',
			'app.saving' => 'Enregistrement…',
			'app.noChoice' => 'Aucun choix',
			'app.unknown' => 'Inconnu',
			'app.minutes' => ({required Object count}) => '${count} min',
			'app.notMedicalDisclaimer' => 'StopCorn n\'est pas un outil de prise en charge médicale. Il ne pose aucun diagnostic et ne remplace pas un professionnel de santé. Si ce comportement entraîne une forte souffrance, une perte de contrôle persistante ou des conséquences importantes dans ta vie, il peut être utile d\'en parler à un professionnel qualifié.',
			'app.technicalDetails.show' => 'Afficher le détail technique',
			'app.technicalDetails.hide' => 'Masquer le détail technique',
			'app.splash.preparing' => 'Préparation de StopCorn…',
			'app.splash.error' => 'StopCorn n\'a pas pu démarrer. Tes données n\'ont pas été modifiées.',
			'app.score.unanswered' => 'Facultatif — non renseigné',
			'app.score.outOfTen' => ({required Object value}) => '${value} / 10',
			'app.score.clear' => ({required Object label}) => 'Effacer ${label}',
			'app.score.unansweredSemantics' => ({required Object label}) => '${label} : non renseigné',
			'app.score.answeredSemantics' => ({required Object label, required Object value}) => '${label} : ${value} sur 10',
			'app.moduleNumber' => ({required Object order}) => 'Module n°${order}',
			'checkIn.title' => 'Bilan du jour',
			'checkIn.intro.create' => 'Un repère rapide, en moins d\'une minute.',
			'checkIn.intro.edit' => 'Modifier le bilan d\'aujourd\'hui.',
			'checkIn.mood.label' => 'Humeur',
			'checkIn.mood.scale' => '0 = très difficile, 10 = très bonne',
			'checkIn.control.label' => 'Sentiment de contrôle',
			'checkIn.control.scale' => '0 = aucun contrôle, 10 = contrôle complet',
			'checkIn.urge.count' => 'Nombre approximatif d\'envies (facultatif)',
			'checkIn.urge.hint' => 'Exemple : 3',
			'checkIn.urge.negative' => 'Le nombre ne peut pas être négatif.',
			'checkIn.consumption.recorded' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, one: '${count} consommation enregistrée ce jour-là.', other: '${count} consommations enregistrées ce jour-là.', ), 
			'checkIn.consumption.none' => 'Aucune consommation enregistrée ce jour-là.',
			'checkIn.sleep.label' => 'Qualité du sommeil (facultatif)',
			'checkIn.sleep.scale' => '0 = très mauvaise, 10 = excellente',
			'checkIn.note.label' => 'Note facultative',
			'checkIn.note.hint' => 'Ce qui a marqué ta journée…',
			'checkIn.saved.title' => 'Bilan enregistré.',
			'checkIn.saved.body' => 'Ces repères aideront à observer les tendances dans le temps.',
			'checkIn.error.load' => 'Le bilan du jour n\'a pas pu être chargé.',
			'checkIn.error.save' => 'Impossible d\'enregistrer pour le moment. Réessaie dans quelques instants.',
			'consumption.title' => 'Noter une consommation',
			'consumption.intro' => 'Quelques informations suffisent. Tu peux ignorer toutes les questions facultatives.',
			'consumption.date' => 'Date',
			'consumption.time' => 'Heure',
			'consumption.factors.label' => 'Facteurs déclenchants (facultatif)',
			'consumption.factors.trigger' => 'Déclencheur',
			'consumption.factors.emotion' => 'Émotion',
			'consumption.control.label' => 'Sentiment de contrôle (facultatif)',
			'consumption.control.scale' => '0 = aucun contrôle, 10 = contrôle complet',
			'consumption.context.label' => 'Contexte très court (facultatif)',
			'consumption.context.hint' => 'Exemple : seul le soir',
			'consumption.context.description' => 'Reste général : aucun site, recherche ou détail explicite.',
			'consumption.contextualGoal.title' => 'Tes contextes protégés',
			'consumption.contextualGoal.description' => 'Sélectionne les contextes de ton objectif qui correspondaient à la situation. Ils apparaîtront ainsi dans ta progression, sans remplacer la note facultative ci-dessous.',
			'consumption.contextualGoal.label' => 'Contextes de mon objectif (facultatif)',
			'consumption.note.label' => 'Note facultative',
			'consumption.note.hint' => 'Un repère utile pour la suite…',
			'consumption.saved.title' => 'C\'est enregistré.',
			'consumption.saved.body' => 'L\'objectif est de mieux comprendre la situation, pas de te juger.',
			'consumption.edit.title' => 'Corriger cette consommation',
			'consumption.error.load' => 'Le formulaire n\'a pas pu être préparé.',
			'consumption.error.save' => 'Impossible d\'enregistrer pour le moment. Réessaie dans quelques instants.',
			'consumption.error.missingEvent' => 'Cette consommation n\'existe plus.',
			'context.lateEvening' => 'Tard le soir',
			'context.bedroom' => 'Dans la chambre',
			'context.homeAlone' => 'Seul à la maison',
			'context.afterSocialMedia' => 'Après les réseaux sociaux',
			'context.duringStress' => 'Pendant une période de stress',
			'emotion.calm' => 'Calme',
			'emotion.bored' => 'Ennui',
			'emotion.stressed' => 'Stress',
			'emotion.lonely' => 'Solitude',
			'emotion.sad' => 'Tristesse',
			'emotion.angry' => 'Colère',
			'emotion.anxious' => 'Anxiété',
			'emotion.tired' => 'Fatigue',
			'emotion.excited' => 'Excitation',
			'emotion.frustrated' => 'Frustration',
			'emotion.other' => 'Autre',
			'export.title' => 'Exporter mes données',
			'export.confirm' => 'Je comprends que ce fichier peut être sensible',
			'export.backSettings' => 'Retour aux réglages',
			'export.error' => 'L\'export n\'a pas pu être créé. Aucune donnée n\'a été envoyée.',
			'export.warning.title' => 'Avant de continuer',
			'export.warning.sensitive' => 'Le fichier JSON peut contenir des informations personnelles sensibles : notes, objectifs et observations que tu as choisi d\'enregistrer.',
			'export.warning.share' => 'StopCorn ne l\'envoie nulle part automatiquement. Après sa création, seule la feuille de partage du système s\'ouvrira.',
			'export.create.action' => 'Créer et ouvrir le partage',
			'export.create.progress' => 'Création du fichier…',
			'export.share.subject' => 'Export des données StopCorn',
			'export.share.title' => 'Export StopCorn',
			'goal.abstinence.title' => 'Arrêter',
			'goal.abstinence.description' => 'Je souhaite ne plus consommer.',
			'goal.reduction.title' => 'Réduire',
			'goal.reduction.description' => 'Je souhaite diminuer progressivement la fréquence.',
			'goal.contextual.title' => 'Éviter certains contextes',
			'goal.contextual.description' => 'Je veux reprendre le contrôle dans certaines situations.',
			'goal.observation.title' => 'Observer d\'abord',
			'goal.observation.description' => 'Je veux comprendre mes habitudes avant de fixer une cible.',
			'harvest.label' => 'Récolte',
			'harvest.explanationAction' => 'C\'est quoi ?',
			'harvest.cornPoints.title' => 'Corn points',
			'harvest.cornPoints.todayCollected' => 'Le corn point du jour a été collecté.',
			'harvest.cornPoints.todayAvailable' => 'Un geste constructif suffit pour récolter le corn point du jour.',
			'harvest.momentum.title' => 'Élan',
			'harvest.momentum.currentMomentum' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Élan actuel : ${count} jours de suite.', one: 'Élan actuel : ${count} jour de suite.', other: 'Élan actuel : ${count} jours de suite.', ), 
			'harvest.momentum.bestMomentum' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Meilleur élan : ${count} jours de suite.', one: 'Meilleur élan : ${count} jour de suite.', other: 'Meilleur élan : ${count} jours de suite.', ), 
			'harvest.momentum.dayCollected' => 'Corn point collecté ce jour',
			'harvest.momentum.dayNotCollected' => 'Aucun corn point récolté ce jour',
			'harvest.momentum.dayUpcoming' => 'Journée à venir',
			'harvest.reward.title' => 'Corn point récolté !',
			'harvest.reward.body' => 'Ton geste constructif fait avancer ta récolte.',
			'harvest.reward.pointsSemantics' => ({required Object gain, required Object total}) => '${gain} corn point ajouté. Nouveau total : ${total}.',
			'harvest.reward.momentumSemantics' => ({required num total, required Object gain}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(total, one: 'Élan augmenté de ${gain}. Nouvel élan : ${total} jour.', other: 'Élan augmenté de ${gain}. Nouvel élan : ${total} jours.', ), 
			'harvest.reward.gain' => ({required Object count}) => '+${count}',
			'harvest.reward.continueAction' => 'Continuer',
			'harvest.sheet.title' => 'Comment fonctionne la récolte ?',
			'harvest.sheet.intro' => 'La récolte met en valeur les gestes qui t\'aident à avancer. Elle ne mesure pas l\'abstinence et ne juge jamais le résultat d\'une journée.',
			'harvest.sheet.onePerDay' => 'Tu peux récolter au maximum un corn point par jour. Une seule action constructive suffit.',
			'harvest.sheet.urge' => 'Terminer un parcours d\'aide compte, quel que soit son résultat.',
			'harvest.sheet.checkIn' => 'Faire un bilan quotidien compte.',
			'harvest.sheet.observation' => 'Noter honnêtement une consommation compte également : la sincérité n\'est jamais pénalisée.',
			'harvest.sheet.learning' => 'Terminer un module pédagogique compte.',
			'harvest.sheet.goal' => 'Créer ou mettre à jour ton objectif compte.',
			'harvest.sheet.momentumTitle' => 'Et l\'élan ?',
			'harvest.sheet.momentumBody' => 'L\'élan correspond aux jours cultivés à la suite. La journée en cours reste une période de grâce. Si l\'élan s\'interrompt, ta récolte ne diminue jamais et tous tes corn points restent acquis.',
			'home.load.error' => 'Les données d\'aujourd\'hui n\'ont pas pu être chargées.',
			'home.sections.today' => 'Aujourd\'hui',
			'home.sections.metrics' => 'Métriques',
			'home.sections.lastThirtyDays' => 'Ces 30 derniers jours',
			'home.sections.quickActions' => 'Actions rapides',
			'home.goal.title' => 'Objectif',
			'home.goal.undefined' => 'Objectif à définir',
			'home.goal.weeklyLimit' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Limite souhaitée : ${count} événement par semaine.', one: 'Limite souhaitée : ${count} événement par semaine.', other: 'Limite souhaitée : ${count} événements par semaine.', ), 
			'home.goal.contexts' => ({required Object contexts}) => 'Contextes protégés : ${contexts}.',
			'home.checkIn.title' => 'Bilan quotidien',
			'home.checkIn.completed' => 'Bilan quotidien enregistré.',
			'home.checkIn.available' => 'Bilan quotidien à faire quand tu le souhaites.\nTape pour l\'enregistrer.',
			'home.checkIn.action.done' => 'Éditer mon bilan quotidien',
			'home.checkIn.action.pending' => 'Faire mon bilan quotidien',
			'home.urge.today' => 'Envies aujourd\'hui',
			'home.urge.count' => ({required num count, required InlineSpan Function(num) countBuilder}) => RichPluralResolvers.bridge( n: count, resolver: _root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'), zero: () => TextSpan(children: [ const TextSpan(text: 'Aucune envie enregistrée aujourd\'hui.'), ]), one: () => TextSpan(children: [ countBuilder(count), const TextSpan(text: ' envie enregistrée aujourd\'hui.'), ]), other: () => TextSpan(children: [ countBuilder(count), const TextSpan(text: ' envies enregistrées aujourd\'hui.'), ]), ), 
			'home.urge.semantics' => 'J\'ai envie de consulter du contenu, faire une pause',
			'home.urge.action' => ({required InlineSpan corn}) => TextSpan(children: [ const TextSpan(text: 'J\'ai une envie de '), corn, ]), 
			'home.urge.subtitle' => 'Faire une pause',
			'home.strategy.lastHelpful' => 'Dernière stratégie utile',
			'home.metrics.daysWithout' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'jours sans consommation enregistrée', one: 'jour sans consommation enregistrée', other: 'jours sans consommation enregistrée', ), 
			'home.metrics.traversedUrges' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'envies surpassées ou réduites', one: 'envie surpassée ou réduite', other: 'envies surpassées ou réduites', ), 
			'home.metrics.averageControl' => 'taux de contrôle moyen déclaré',
			'home.metrics.empty' => 'Tes premières observations apparaîtront ici. Il n\'est pas nécessaire de tout noter parfaitement : quelques repères suffisent pour commencer.',
			'home.actions.openJournal' => 'Ouvrir mon journal',
			'home.actions.logConsumption' => 'Noter une consommation',
			'home.actions.reviewPlan' => 'Revoir mon plan',
			'home.learningRecommendation.title' => 'À découvrir',
			'home.learningRecommendation.action' => 'Poursuivre la lecture',
			'journal.history.title' => 'Journal',
			'journal.history.intro' => 'Retrouve les consommations, les sessions d\'aide et les bilans quotidiens que tu as choisi d\'enregistrer, regroupés par date.',
			'journal.history.error' => 'Le journal n\'a pas pu être chargé.',
			'journal.history.empty.title' => 'Ton journal est encore vide',
			'journal.history.empty.body' => 'Les consommations et les bilans que tu enregistreras apparaîtront ici.',
			'journal.history.date.today' => 'Aujourd\'hui',
			'journal.history.date.yesterday' => 'Hier',
			'journal.history.entry.consumption' => 'Consommation',
			'journal.history.entry.checkIn' => 'Bilan quotidien',
			'journal.history.entry.time' => ({required Object time}) => 'À ${time}',
			'journal.history.entry.checkInSummary' => ({required Object mood, required Object control}) => 'Humeur : ${mood}/10 · Contrôle : ${control}/10',
			'journal.history.entry.noText' => 'Aucun contexte ni aucune note.',
			'journal.history.entry.entries' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Aucune entrée', one: '${count} entrée', other: '${count} entrées', ), 
			'journal.history.entry.urge' => 'Session d\'aide',
			'journal.history.entry.urgeSummary' => ({required Object initial, required Object finalValue}) => 'Intensité ${initial} → ${finalValue}',
			'journal.history.entry.urgeSummaryPartial' => ({required Object initial}) => 'Intensité de départ ${initial}',
			'journal.history.details.cornUrges' => ({required num count, required InlineSpan Function(num) countBuilder, required InlineSpan corn}) => RichPluralResolvers.bridge( n: count, resolver: _root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'), zero: () => TextSpan(children: [ const TextSpan(text: 'aucune envie de '), corn, ]), one: () => TextSpan(children: [ countBuilder(count), const TextSpan(text: ' envie de '), corn, ]), other: () => TextSpan(children: [ countBuilder(count), const TextSpan(text: ' envies de '), corn, ]), ), 
			'journal.history.details.initialIntensity' => 'Intensité de départ',
			'journal.history.details.finalIntensity' => 'Intensité à la fin',
			'journal.history.details.outcome' => 'Issue',
			'journal.history.details.strategy' => 'Action essayée',
			'journal.history.details.pause' => 'Pause guidée',
			'journal.history.details.pauseSeconds' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count} secondes', one: '${count} seconde', other: '${count} secondes', ), 
			'journal.history.details.reflection' => 'Ta réflexion',
			'journal.edit.action' => 'Corriger',
			'journal.delete.action' => 'Supprimer',
			'journal.delete.title' => 'Supprimer cette entrée ?',
			'journal.delete.consumption' => 'Cette entrée et sa note privée seront définitivement retirées de ton journal. Tes statistiques seront recalculées sans elle.',
			'journal.delete.checkIn' => 'Ce bilan quotidien et sa note privée seront définitivement retirés de ton journal. Tes statistiques seront recalculées sans lui.',
			'journal.delete.urge' => 'Cette séance de soutien et la réflexion écrite à la fin seront définitivement retirées. La stratégie essayée pendant la séance cesse d\'être comptée ; une consommation notée depuis cette séance est conservée.',
			'journal.delete.irreversible' => 'Cette action est irréversible.',
			'journal.delete.confirm' => 'Supprimer définitivement',
			'journal.error.delete' => 'Cette entrée n\'a pas pu être supprimée. Rien n\'a été modifié.',
			'learning.subtitle' => 'Six modules courts, disponibles hors ligne et sans diagnostic.',
			'learning.semantics' => 'Modules pédagogiques',
			'learning.evidence.title' => 'Sur quoi reposent ces modules ?',
			'learning.evidence.sheetTitle' => 'Sources et limites',
			'learning.evidence.principles' => 'Chaque module cite des travaux scientifiques sur des principes généraux liés à la motivation, aux habitudes, à la maîtrise de soi, à la pleine conscience ou à l\'autocompassion.',
			'learning.evidence.limitations' => 'Ces sources ne valident pas cliniquement StopCorn. Certaines portent sur le comportement en général ou le tabagisme, et les études consacrées à la pornographie peuvent reposer sur des échantillons limités. Les modules proposent des repères éducatifs prudents, pas un diagnostic ni un traitement.',
			'learning.sources.title' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count} sources scientifiques', one: '${count} source scientifique', other: '${count} sources scientifiques', ), 
			'learning.sources.shortDescription' => 'Références et portée des résultats',
			'learning.sources.sheetTitle' => 'Sources scientifiques',
			'learning.sources.scope' => 'Chaque résultat doit être replacé dans sa population et sa méthode : une association ne prouve pas une cause, et un résultat obtenu sur un autre comportement ou un échantillon limité n\'est pas forcément généralisable. Ces références ne prouvent pas que ce module ou StopCorn constitue un traitement.',
			'learning.module.line' => ({required Object minutes, required Object status}) => '${minutes} min · ${status}',
			'learning.module.progress' => ({required Object title}) => 'Progression du module ${title}',
			'learning.module.pageTitle' => 'Module',
			'learning.module.loadError' => 'Ce module n\'a pas pu être chargé.',
			'learning.status.completed' => 'Terminé',
			'learning.status.reviewing' => 'Relecture en cours',
			'learning.status.resume' => 'Poursuivre la lecture',
			'learning.status.discover' => 'Découvrir',
			'learning.reading.progress' => 'Progression de lecture du module',
			'learning.reading.part' => ({required Object current, required Object total}) => 'Partie ${current} sur ${total}',
			'learning.reading.previous' => 'Précédent',
			'learning.reflection.optional' => 'Réflexion facultative',
			'learning.reflection.label' => 'Ma réflexion',
			'learning.reflection.hint' => 'Quelques mots pour toi-même…',
			'learning.reflection.localNote' => 'Cette note reste uniquement sur ton appareil.',
			'learning.reflection.continueAction' => 'Passer à la réflexion',
			'learning.reflection.yours' => 'Ta réflexion',
			'learning.completion.title' => 'Module terminé',
			'learning.completion.finish' => 'Terminer le module',
			'learning.completion.restart' => 'Recommencer le module',
			'learning.completion.back' => 'Retour aux modules',
			'learning.error.load' => 'Les modules n\'ont pas pu être chargés.',
			'learning.error.save' => 'Impossible d\'enregistrer ta progression pour le moment. Réessaie.',
			'learningModules.continueAfterSetback.title' => 'Continuer après un écart',
			'learningModules.continueAfterSetback.summary' => 'Transforme un événement en information utile, sans te juger.',
			'learningModules.continueAfterSetback.sections.perspective.title' => 'Sortir du « tout est fichu »',
			'learningModules.continueAfterSetback.sections.perspective.paragraph1' => 'Un événement n\'efface pas les pauses, les choix et les observations que tu as déjà faits.',
			'learningModules.continueAfterSetback.sections.perspective.paragraph2' => 'Penser que tout est fichu peut te pousser à abandonner un plan qui reste pourtant utile.',
			'learningModules.continueAfterSetback.sections.adjust.title' => 'Ajuster plutôt que te punir',
			'learningModules.continueAfterSetback.sections.adjust.paragraph1' => 'Regarde ce qui a précédé : l\'heure, la fatigue, l\'émotion, l\'appareil ou le contexte général.',
			'learningModules.continueAfterSetback.sections.adjust.paragraph2' => 'Choisis ensuite un ajustement limité. Une punition ou un objectif irréaliste apporte rarement une information utile.',
			'learningModules.continueAfterSetback.sections.help.title' => 'Savoir quand demander de l\'aide',
			'learningModules.continueAfterSetback.sections.help.paragraph1' => 'Si la perte de contrôle persiste, provoque une forte souffrance ou entraîne des conséquences importantes, en parler à un professionnel qualifié peut aider.',
			'learningModules.continueAfterSetback.sections.help.paragraph2' => 'Demander de l\'aide peut faire partie de ton plan et n\'enlève rien aux progrès déjà accomplis.',
			'learningModules.continueAfterSetback.reflectionPrompt' => 'Quelle information utile peux-tu tirer du dernier événement sans te juger ?',
			'learningModules.mapTerrain.title' => 'Cartographier ton terrain',
			'learningModules.mapTerrain.summary' => 'Repère les situations qui reviennent dans tes observations.',
			'learningModules.mapTerrain.sections.states.title' => 'Les moments et les états',
			'learningModules.mapTerrain.sections.states.paragraph1' => 'L\'heure et le lieu peuvent devenir des repères de contexte récurrents. Le stress, l\'ennui ou l\'envie de prendre de la distance avec une émotion difficile peuvent aussi apparaître dans tes observations.',
			'learningModules.mapTerrain.sections.states.paragraph2' => 'Considère ces répétitions comme des hypothèses, pas comme des causes : plusieurs observations dans le temps sont plus utiles qu\'une coïncidence isolée.',
			'learningModules.mapTerrain.sections.routines.title' => 'Les appareils et les routines',
			'learningModules.mapTerrain.sections.routines.paragraph1' => 'Un appareil disponible au même endroit et au même moment peut faciliter une réponse automatique.',
			'learningModules.mapTerrain.sections.routines.paragraph2' => 'Si tes notes montrent que les réseaux sociaux ou une routine du soir précèdent souvent un moment difficile, considère-les comme des repères utiles, pas forcément comme sa seule cause.',
			'learningModules.mapTerrain.sections.map.title' => 'Une carte, pas un verdict',
			'learningModules.mapTerrain.sections.map.paragraph1' => 'Cartographier ton terrain sert à préparer des options, pas à éviter toutes les situations difficiles.',
			'learningModules.mapTerrain.sections.map.paragraph2' => 'Quelques observations générales suffisent : aucun détail explicite ni historique de navigation n\'est utile.',
			'learningModules.mapTerrain.reflectionPrompt' => 'Quelle situation revient le plus souvent dans tes observations ?',
			'learningModules.prepareEnvironment.title' => 'Préparer ton environnement',
			'learningModules.prepareEnvironment.summary' => 'Ajoute de la friction et facilite les actions que tu as choisies.',
			'learningModules.prepareEnvironment.sections.friction.title' => 'Rendre l\'accès moins automatique',
			'learningModules.prepareEnvironment.sections.friction.paragraph1' => 'Laisser le téléphone hors de la chambre, fixer certains horaires ou utiliser le mode de concentration du système peut ajouter une friction volontaire.',
			'learningModules.prepareEnvironment.sections.friction.paragraph2' => 'Un bloqueur peut compléter ton plan, mais il ne règle pas une difficulté à lui seul.',
			'learningModules.prepareEnvironment.sections.moments.title' => 'Préparer les moments plus fragiles',
			'learningModules.prepareEnvironment.sections.moments.paragraph1' => 'Si les soirées où tu es fatigué reviennent dans tes observations, préparer une routine simple ou charger ton appareil ailleurs peut faciliter l\'action souhaitée.',
			'learningModules.prepareEnvironment.sections.moments.paragraph2' => 'Si certains comptes ou réseaux précèdent souvent les moments difficiles, tu peux en ajuster l\'accès sans devoir tout supprimer.',
			'learningModules.prepareEnvironment.sections.alternative.title' => 'Rendre l\'alternative visible',
			'learningModules.prepareEnvironment.sections.alternative.paragraph1' => 'Prépare une autre action facile d\'accès : un livre à proximité, une courte marche ou une tâche choisie à l\'avance.',
			'learningModules.prepareEnvironment.sections.alternative.paragraph2' => 'Ton environnement est surtout utile lorsqu\'il soutient une intention précise.',
			'learningModules.prepareEnvironment.reflectionPrompt' => 'Quel petit changement pourrais-tu apporter à ton environnement aujourd\'hui ?',
			'learningModules.rideUrge.title' => 'Laisser passer l\'impulsion',
			'learningModules.rideUrge.summary' => 'Crée un peu d\'espace avant de choisir la suite.',
			'learningModules.rideUrge.sections.delay.title' => 'T\'accorder un instant',
			'learningModules.rideUrge.sections.delay.paragraph1' => 'Une impulsion ne t\'oblige pas à prendre une décision immédiate ou définitive.',
			'learningModules.rideUrge.sections.delay.paragraph2' => 'Attendre un peu te permet d\'observer si son intensité monte, baisse ou reste stable.',
			'learningModules.rideUrge.sections.concrete.title' => 'Changer quelque chose de concret',
			'learningModules.rideUrge.sections.concrete.paragraph1' => 'Changer de pièce, poser le téléphone ou commencer une toute petite tâche peut interrompre une réponse automatique.',
			'learningModules.rideUrge.sections.concrete.paragraph2' => 'Choisis une action assez simple pour rester possible même lorsque ton énergie est basse.',
			'learningModules.rideUrge.sections.expectations.title' => 'Ne pas exiger que la sensation disparaisse',
			'learningModules.rideUrge.sections.expectations.paragraph1' => 'Une stratégie peut être utile même si la sensation ne disparaît pas tout de suite.',
			'learningModules.rideUrge.sections.expectations.paragraph2' => 'L\'objectif est de t\'entraîner à choisir, pas d\'obtenir un résultat parfait à chaque fois.',
			'learningModules.rideUrge.reflectionPrompt' => 'Quelle stratégie réaliste pourrais-tu essayer lors du prochain moment difficile ?',
			'learningModules.understandLoop.title' => 'Comprendre la boucle',
			'learningModules.understandLoop.summary' => 'Repère les étapes qui peuvent entretenir une habitude.',
			'learningModules.understandLoop.sections.sequence.title' => 'Un enchaînement à observer',
			'learningModules.understandLoop.sections.sequence.paragraph1' => 'Une habitude peut parfois se décrire ainsi : situation → émotion → impulsion → comportement → effet ou soulagement immédiat → conséquences.',
			'learningModules.understandLoop.sections.sequence.paragraph2' => 'C\'est un modèle pratique pour observer, pas un enchaînement dont l\'application à tout le monde est démontrée. Certaines étapes peuvent être très rapides ou difficiles à remarquer.',
			'learningModules.understandLoop.sections.action.title' => 'Trouver un point d\'appui',
			'learningModules.understandLoop.sections.action.paragraph1' => 'Tu n\'as pas besoin de maîtriser toute la boucle. Changer de lieu, attendre quelques minutes ou choisir une autre action peut ouvrir une marge de manœuvre.',
			'learningModules.understandLoop.sections.action.paragraph2' => 'Observer la situation et l\'émotion peut t\'aider à choisir une action réaliste.',
			'learningModules.understandLoop.sections.observe.title' => 'Observer sans poser de diagnostic',
			'learningModules.understandLoop.sections.observe.paragraph1' => 'Les notes de StopCorn sont des repères personnels, pas un diagnostic.',
			'learningModules.understandLoop.sections.observe.paragraph2' => 'Le but est de mieux voir les enchaînements qui reviennent afin d\'ajuster ton plan.',
			'learningModules.understandLoop.reflectionPrompt' => 'À quel moment de la boucle pourrais-tu agir le plus facilement cette semaine ?',
			'learningModules.whyChange.title' => 'Pourquoi changer ?',
			'learningModules.whyChange.summary' => 'Précise ce que tu aimerais retrouver ou préserver.',
			'learningModules.whyChange.sections.direction.title' => 'Une direction qui vient de toi',
			'learningModules.whyChange.sections.direction.paragraph1' => 'Un changement a plus de chances de durer lorsqu\'il correspond à ce qui compte pour toi, et pas seulement à ce que les autres attendent.',
			'learningModules.whyChange.sections.direction.paragraph2' => 'Tu peux vouloir arrêter, réduire, éviter certaines situations ou commencer par observer. Aucun de ces choix ne définit ta valeur.',
			'learningModules.whyChange.sections.benefits.title' => 'Ce que tu veux retrouver',
			'learningModules.whyChange.sections.benefits.paragraph1' => 'Essaie de nommer ce que tu aimerais retrouver : du temps, de la disponibilité mentale, du sommeil, une relation plus sereine ou le sentiment de décider.',
			'learningModules.whyChange.sections.benefits.paragraph2' => 'Une raison personnelle et précise peut servir de repère lorsque l\'impulsion devient forte.',
			'learningModules.whyChange.sections.changes.title' => 'Une motivation variable',
			'learningModules.whyChange.sections.changes.paragraph1' => 'La motivation change d\'un jour à l\'autre. Cela ne signifie ni que tu as échoué, ni que ton objectif est mauvais.',
			'learningModules.whyChange.sections.changes.paragraph2' => 'Lorsqu\'elle baisse, une petite action préparée à l\'avance peut prendre le relais.',
			'learningModules.whyChange.reflectionPrompt' => 'Qu\'aimerais-tu retrouver ou préserver en faisant évoluer cette habitude ?',
			'licenses.title' => 'Licences open source',
			'licenses.intro' => 'StopCorn utilise des composants open source. Sélectionne une entrée pour lire son texte de licence.',
			'licenses.loadError' => 'Les licences n\'ont pas pu être chargées.',
			'licenses.otherComponent' => 'Autre composant',
			'locale.label' => 'Langue de l\'application',
			'locale.english' => 'Anglais',
			'locale.french' => 'Français',
			'locale.section.title' => 'Langue',
			'locale.section.description' => 'Choisis la langue utilisée dans toute l\'application.',
			'navigation.home.item' => 'Accueil',
			'navigation.home.title' => 'Bonjour',
			'navigation.progress' => 'Progression',
			'navigation.learn' => 'Apprendre',
			'navigation.settings' => 'Réglages',
			'notifications.dailyCheckIn.title' => 'Ton bilan StopCorn t\'attend',
			'notifications.dailyCheckIn.body' => 'Prends un moment pour noter comment s\'est passée ta journée.',
			'notifications.dailyCheckIn.channelName' => 'Rappels du bilan quotidien',
			'notifications.dailyCheckIn.channelDescription' => 'Un rappel local à 20 h lorsque le bilan du jour est encore vide.',
			'onboarding.pageTitle' => 'Configuration',
			'onboarding.step' => ({required Object current, required Object total}) => 'Étape ${current} sur ${total}',
			'onboarding.welcome.title' => 'Reprendre le contrôle, sans jugement',
			'onboarding.welcome.subtitle' => 'StopCorn t\'aide à comprendre tes habitudes, à traverser les moments difficiles et à construire un plan adapté à ton objectif.',
			'onboarding.welcome.noAccount' => 'Aucune création de compte',
			'onboarding.welcome.localData' => 'Données conservées sur l\'appareil',
			'onboarding.welcome.noAds' => 'Aucune publicité',
			'onboarding.welcome.selfHelp' => 'Un outil d\'auto-accompagnement',
			'onboarding.welcome.privacyAction' => 'En savoir plus sur la confidentialité',
			'onboarding.welcome.privacyTitle' => 'Confidentialité dès le départ',
			'onboarding.welcome.privacyBody' => 'Aucune donnée de journal n\'est envoyée à StopCorn. L\'application ne lit ni ton navigateur, ni tes recherches, ni le contenu consulté. Tu choisis uniquement les repères généraux que tu souhaites noter. En cas de plantage, un rapport technique anonyme peut être envoyé pour que le problème soit corrigé ; il ne contient aucune de tes saisies et reste désactivable dans les réglages.',
			'onboarding.goal.title' => 'Qu\'aimerais-tu changer ?',
			'onboarding.goal.subtitle' => 'Choisis un cap qui te ressemble. Tu pourras le modifier plus tard.',
			'onboarding.goal.semantics' => 'Choix de l\'objectif',
			'onboarding.goal.weeklyLimit' => 'Limite hebdomadaire souhaitée',
			'onboarding.goal.weeklyHint' => 'Exemple : 2',
			'onboarding.goal.contexts' => 'Contextes à éviter',
			'onboarding.goal.motivation' => 'Motivation personnelle',
			'onboarding.goal.motivationHint' => 'Ce que tu aimerais retrouver ou protéger…',
			'onboarding.baseline.title' => 'Ton point de départ',
			'onboarding.baseline.subtitle' => 'Ce repère n\'est pas un test médical. Il servira seulement à observer ton évolution.',
			'onboarding.baseline.frequency' => 'Fréquence approximative sur les 7 derniers jours',
			'onboarding.baseline.control' => 'Sentiment de contrôle',
			'onboarding.baseline.impact' => 'Impact négatif ressenti',
			'onboarding.baseline.confidence' => 'Confiance dans ta capacité à changer',
			'onboarding.strategies.title' => 'Prépare ton plan de secours',
			'onboarding.strategies.subtitle' => 'Choisis idéalement trois actions réalistes. Une seule suffit pour continuer.',
			'onboarding.strategies.selected' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Aucune stratégie sélectionnée', one: '${count} stratégie sélectionnée', other: '${count} stratégies sélectionnées', ), 
			'onboarding.strategies.semantics' => 'Stratégies de secours',
			'onboarding.privacy.title' => 'Tes données restent sous ton contrôle',
			'onboarding.privacy.subtitle' => 'StopCorn fonctionne sans compte et sans serveur dans cette version.',
			'onboarding.privacy.local' => 'Données enregistrées uniquement sur cet appareil.',
			'onboarding.privacy.noHistory' => 'Aucune URL ni recherche n\'est enregistrée.',
			'onboarding.privacy.control' => 'Un export volontaire et une suppression totale sont possibles.',
			'onboarding.privacy.backup' => 'Les sauvegardes système du téléphone peuvent inclure les données selon tes réglages système.',
			'onboarding.privacy.dailyCheckInReminder' => 'Me rappeler de faire mon bilan',
			'onboarding.privacy.dailyCheckInReminderDescription' => 'À 20 h, reçois un rappel local uniquement si le bilan du jour est encore vide. Tu pourras modifier ce choix plus tard.',
			'onboarding.privacy.reminderPermissionDenied' => 'Les notifications n\'ont pas été autorisées. Désactive cette option pour continuer, ou autorise-les puis réessaie.',
			'onboarding.privacy.reminderUnavailable' => 'Les rappels quotidiens ne sont pas disponibles sur cet appareil.',
			'onboarding.privacy.reminderError' => 'Le rappel quotidien n\'a pas pu être préparé. Réessaie ou désactive-le pour continuer.',
			'onboarding.privacy.crashReports' => 'Les rapports d\'erreur anonymes aident à corriger les bugs, et sont désactivables dans les réglages.',
			'onboarding.start' => 'Commencer',
			'onboarding.finish' => 'Terminer la configuration',
			'onboarding.error.load' => 'La configuration n\'a pas pu être chargée.',
			'onboarding.error.save' => 'Impossible d\'enregistrer pour le moment. Réessaie dans quelques instants.',
			'onboarding.error.complete' => 'La configuration n\'a pas pu être terminée. Aucune donnée n\'a été envoyée.',
			'onboarding.error.notReady' => 'L\'onboarding n\'est pas encore prêt.',
			'onboarding.error.invalidDraft' => 'Le brouillon de configuration enregistré est invalide.',
			'onboarding.validation.goal' => 'Choisis un objectif.',
			'onboarding.validation.weeklyLimit' => 'Indique une limite hebdomadaire positive.',
			'onboarding.validation.context' => 'Choisis au moins un contexte.',
			'onboarding.validation.strategy' => 'Choisis au moins une stratégie.',
			'onboarding.validation.scoreRange' => 'Les scores doivent être compris entre 0 et 10.',
			'outcome.passed' => 'L\'envie est passée',
			'outcome.reduced' => 'Elle a diminué',
			'outcome.delayed' => 'Je vais attendre',
			'outcome.consumed' => 'Je vais consommer',
			'outcome.abandoned' => 'Je préfère arrêter le parcours ici',
			'period.sevenDays' => '7 jours',
			'period.thirtyDays' => '30 jours',
			'period.ninetyDays' => '90 jours',
			'period.all' => 'Tout',
			'progress.subtitle' => 'Des repères descriptifs construits uniquement à partir de ce que tu as choisi d\'enregistrer.',
			'progress.error.load' => 'Les données de progression n\'ont pas pu être chargées.',
			'progress.overview.title' => 'Vue d\'ensemble',
			'progress.overview.events' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'consommations enregistrées', one: 'consommation enregistrée', other: 'consommations enregistrées', ), 
			'progress.overview.daysWithout' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'jours sans consommation enregistrée', one: 'jour sans consommation enregistrée', other: 'jours sans consommation enregistrée', ), 
			'progress.overview.completedUrges' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'sessions d\'aide terminées', one: 'session d\'aide terminée', other: 'sessions d\'aide terminées', ), 
			'progress.overview.averageDecrease' => 'diminution moyenne de l\'intensité',
			'progress.overview.notEnough' => 'Pas encore assez de données',
			'progress.overview.decreaseDetail' => 'Différence entre l\'intensité ressentie au début et celle ressentie à la fin',
			'progress.overview.goal.abstinence' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count} consommation enregistrée volontairement sur la période sélectionnée. Une absence d\'observation ne prouve jamais qu\'aucun événement n\'a eu lieu.', one: '${count} consommation enregistrée volontairement sur la période sélectionnée. Une absence d\'observation ne prouve jamais qu\'aucun événement n\'a eu lieu.', other: '${count} consommations enregistrées volontairement sur la période sélectionnée. Une absence d\'observation ne prouve jamais qu\'aucun événement n\'a eu lieu.', ), 
			'progress.overview.goal.reduction' => ({required num count, required Object limit}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Cette semaine : ${count} événement enregistré sur une limite souhaitée de ${limit}.', one: 'Cette semaine : ${count} événement enregistré sur une limite souhaitée de ${limit}.', other: 'Cette semaine : ${count} événements enregistrés sur une limite souhaitée de ${limit}.', ), 
			'progress.overview.goal.contextual' => ({required num count, required Object contexts}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count} consommation enregistrée correspondait à l\'un de tes contextes protégés sur la période sélectionnée : ${contexts}.', one: '${count} consommation enregistrée correspondait à l\'un de tes contextes protégés sur la période sélectionnée : ${contexts}.', other: '${count} consommations enregistrées correspondaient à l\'un de tes contextes protégés sur la période sélectionnée : ${contexts}.', ), 
			'progress.overview.goal.observation' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count} repère volontaire enregistré sur la période sélectionnée. Chaque observation honnête aide à faire apparaître les tendances.', one: '${count} repère volontaire enregistré sur la période sélectionnée. Chaque observation honnête aide à faire apparaître les tendances.', other: '${count} repères volontaires enregistrés sur la période sélectionnée. Chaque observation honnête aide à faire apparaître les tendances.', ), 
			'progress.overview.empty' => 'Pas encore assez de données. Quelques repères suffiront pour faire apparaître des tendances.',
			'progress.events.title' => 'Évolution des événements',
			'progress.events.weeklyTitle' => 'Évolution hebdomadaire',
			'progress.events.empty' => 'Aucun événement enregistré sur cette période.',
			'progress.events.weekOf' => ({required Object date}) => 'Semaine du ${date}',
			'progress.events.summary' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count} événements volontairement enregistrés, répartis par semaine.', one: '${count} événement volontairement enregistré, réparti par semaine.', other: '${count} événements volontairement enregistrés, répartis par semaine.', ), 
			'progress.urges.title' => ({required InlineSpan corn}) => TextSpan(children: [ const TextSpan(text: 'Envies de '), corn, ]), 
			'progress.urges.averageIntensity' => 'Intensité moyenne',
			'progress.urges.empty' => 'Pas encore assez de sessions terminées avec une intensité finale.',
			'progress.urges.initial' => 'Initiale',
			'progress.urges.observationHours' => 'Heures des observations',
			'progress.urges.noHours' => 'Aucune heure de parcours d\'aide ou d\'événement n\'est disponible.',
			'progress.urges.comparison.unavailable' => 'Pas encore assez de données pour comparer le début et la fin des parcours d\'aide.',
			'progress.urges.comparison.decrease' => ({required num count, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'L\'intensité a diminué en moyenne de ${value} points pendant les sessions complètes.', one: 'L\'intensité a diminué en moyenne de ${value} point pendant les sessions complètes.', other: 'L\'intensité a diminué en moyenne de ${value} points pendant les sessions complètes.', ), 
			'progress.urges.comparison.increase' => ({required num count, required Object value}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'L\'intensité a augmenté en moyenne de ${value} points pendant les sessions complètes.', one: 'L\'intensité a augmenté en moyenne de ${value} point pendant les sessions complètes.', other: 'L\'intensité a augmenté en moyenne de ${value} points pendant les sessions complètes.', ), 
			'progress.urges.hourSummary' => ({required Object label}) => 'La tranche ${label} contient le plus d\'observations enregistrées.',
			'progress.urges.timeBucket.midnight' => ({required Object start}) => '${start}h – minuit',
			'progress.urges.timeBucket.range' => ({required Object start, required Object end}) => '${start}h – ${end}h',
			'progress.urges.finalLabel' => 'Finale',
			'progress.patterns.title' => 'Déclencheurs et émotions',
			'progress.patterns.triggers.title' => 'Déclencheurs les plus notés',
			'progress.patterns.triggers.kind' => 'déclencheur',
			'progress.patterns.triggers.empty' => 'Aucun déclencheur n\'a encore été noté.',
			'progress.patterns.emotions.title' => 'Émotions les plus notées',
			'progress.patterns.emotions.kind' => 'émotion',
			'progress.patterns.emotions.empty' => 'Aucune émotion n\'a encore été notée.',
			'progress.patterns.rankingSummary' => ({required Object label, required Object kind}) => '${label} est le ${kind} le plus souvent noté sur cette période.',
			'progress.strategies.title' => 'Stratégies',
			'progress.strategies.effectiveness' => 'Efficacité perçue',
			'progress.strategies.empty' => 'Aucune stratégie évaluée sur cette période. L\'échelle va de −5 à +5.',
			'progress.strategies.evaluations' => ({required num count, required Object effect}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${effect} (${count} évaluations)', one: '${effect} (${count} évaluation)', other: '${effect} (${count} évaluations)', ), 
			'progress.strategies.threshold' => 'Utilise et évalue une stratégie au moins trois fois pour obtenir un repère plus solide.',
			'progress.strategies.best' => ({required Object strategy}) => '${strategy} est la stratégie la mieux évaluée parmi celles utilisées au moins trois fois.',
			'progress.checkIns.title' => 'Bilans',
			'progress.checkIns.count' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'bilans quotidiens', one: 'bilan quotidien', other: 'bilans quotidiens', ), 
			'progress.checkIns.averageMood' => 'note d\'humeur moyenne',
			'progress.checkIns.averageControl' => 'taux de contrôle moyen',
			'progress.checkIns.outOfTen' => 'Sur 10',
			'progress.comparison.unavailable' => 'Pas encore assez de données comparables',
			'progress.comparison.stable' => 'Stable par rapport à la période précédente',
			'progress.comparison.value' => ({required Object value, required Object direction}) => '${value} % ${direction} que la période précédente',
			'progress.comparison.more' => 'de plus',
			'progress.comparison.less' => 'de moins',
			'progress.startingPoint.sectionTitle' => 'Comparaison avec mon point de départ',
			'progress.startingPoint.screenTitle' => 'Mon point de départ',
			'progress.startingPoint.intro' => 'Ces réponses ont été enregistrées lors de ta configuration initiale. Elles constituent un repère personnel, pas un diagnostic.',
			'progress.startingPoint.recordedOn' => ({required Object date}) => 'Bilan initial enregistré le ${date}.',
			'progress.startingPoint.goalTitle' => 'Ton objectif initial',
			'progress.startingPoint.goalUnavailable' => 'L’objectif initial n’est plus disponible.',
			'progress.startingPoint.weeklyLimit' => ({required Object count}) => 'Limite souhaitée : ${count} par semaine',
			'progress.startingPoint.contexts' => ({required Object contexts}) => 'Contextes choisis : ${contexts}',
			'progress.startingPoint.motivationTitle' => 'Ta motivation initiale',
			'progress.startingPoint.markersTitle' => 'Tes repères initiaux',
			'progress.startingPoint.frequency' => 'Fréquence approximative sur les 7 jours précédents',
			'progress.startingPoint.frequencyValue' => ({required Object count}) => '${count} sur 7 jours',
			'progress.startingPoint.control' => 'Sentiment de contrôle',
			'progress.startingPoint.impact' => 'Impact négatif ressenti',
			'progress.startingPoint.confidence' => 'Confiance dans ta capacité à changer',
			'progress.startingPoint.score' => ({required Object value}) => '${value} / 10',
			'progress.startingPoint.disclaimer' => 'Ces valeurs reflètent uniquement ton ressenti au moment du bilan initial.',
			'progress.startingPoint.comparison.intro' => 'Comparaison avec les observations de la période sélectionnée.',
			'progress.startingPoint.comparison.control' => 'Sentiment de contrôle',
			'progress.startingPoint.comparison.initial' => 'Initiale',
			'progress.startingPoint.comparison.finalLabel' => 'Finale',
			'progress.startingPoint.comparison.controlDetail' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Moyenne calculée à partir de ${count} bilan quotidien.', one: 'Moyenne calculée à partir de ${count} bilan quotidien.', other: 'Moyenne calculée à partir de ${count} bilans quotidiens.', ), 
			'progress.startingPoint.comparison.controlPending' => 'Au moins cinq bilans quotidiens sont nécessaires pour proposer une comparaison.',
			'progress.startingPoint.comparison.frequency' => 'Fréquence hebdomadaire',
			'progress.startingPoint.comparison.frequencyPending' => 'Une semaine complète d’observation est nécessaire pour proposer une comparaison.',
			'progress.startingPoint.comparison.frequencyDetail' => 'La valeur actuelle ne compte que les consommations volontairement enregistrées et peut donc différer de la fréquence réelle.',
			'progress.startingPoint.comparison.open' => 'Voir mon point de départ',
			'progress.startingPoint.empty' => 'Aucun bilan initial n’est disponible.',
			'progress.startingPoint.error' => 'Le point de départ n’a pas pu être chargé.',
			'progress.harvest' => 'Récolte',
			'settings.support.title' => 'Un projet libre, pour rester accessible',
			'settings.support.body' => 'StopCorn est né d\'un constat simple : les outils comparables finissent souvent derrière un abonnement ou des fonctionnalités limitées. L\'application est donc gratuite et open source, sans publicité ni traqueur, afin que chacun puisse avancer sans barrière.',
			'settings.support.values.free' => 'Gratuit',
			'settings.support.values.openSource' => 'Open source',
			'settings.support.values.noAds' => 'Sans publicité',
			'settings.support.values.noTracking' => 'Sans traqueur',
			'settings.support.contribution' => 'Si StopCorn t\'est utile, tu peux soutenir son développement. Ce geste est entièrement facultatif et ne débloque aucune fonctionnalité.',
			'settings.support.supportAction' => 'Soutenir le développement',
			'settings.support.collapseAction' => 'Réduire la carte du projet',
			'settings.support.expandAction' => 'Déployer la carte du projet',
			'settings.support.sourceAction' => 'Code source',
			'settings.support.websiteAction' => 'Site web',
			'settings.support.thanks' => 'Merci ! Ton soutien aide StopCorn à rester gratuit et indépendant.',
			'settings.support.error.link' => 'Impossible d\'ouvrir ce lien pour le moment.',
			'settings.support.error.notConfigured' => 'Le soutien intégré n\'est pas encore configuré sur cette version.',
			'settings.support.error.paywall' => 'Impossible d\'afficher la page de soutien pour le moment.',
			'settings.appearance.title' => 'Apparence',
			'settings.appearance.description' => 'Choisis un thème ou suis le réglage du système.',
			'settings.reminders.title' => 'Rappels',
			'settings.reminders.description' => 'Choisis si StopCorn doit te proposer un petit bilan en fin de journée.',
			'settings.reminders.daily.label' => 'Rappel du bilan quotidien',
			'settings.reminders.daily.description' => 'À 20 h, me prévenir uniquement si le bilan du jour est encore vide.',
			'settings.reminders.daily.unavailable' => 'Les rappels quotidiens ne sont pas disponibles sur cet appareil.',
			'settings.reminders.error.permissionDenied' => 'Les notifications n\'ont pas été autorisées dans les réglages du système.',
			'settings.reminders.error.save' => 'Le rappel quotidien n\'a pas pu être mis à jour.',
			'settings.progress.title' => 'Progression',
			'settings.progress.description' => 'Adapte les indicateurs à ce qui t\'est utile.',
			'settings.progress.defaultPeriod' => 'Période par défaut',
			'settings.progress.harvest.label' => 'Récolte',
			'settings.progress.harvest.description' => 'Récolte au maximum un corn point par journée constructive. Ta récolte ne diminue jamais.',
			'settings.personalPlan.title' => 'Plan personnel',
			'settings.personalPlan.description' => 'Garde à portée de main les options qui pourront t\'aider quand tu en as besoin.',
			'settings.personalPlan.goal.label' => 'Mon objectif',
			'settings.personalPlan.goal.none' => 'Aucun objectif actif',
			'settings.personalPlan.backup.title' => 'Mon plan de secours',
			'settings.personalPlan.backup.description' => 'Place en priorité les actions que tu peux réellement essayer dans un moment difficile.',
			'settings.personalPlan.backup.summary' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Aucune action sélectionnée', one: '${count} action sélectionnée', other: '${count} actions sélectionnées', ), 
			'settings.personalPlan.history.title' => 'Historique des objectifs',
			'settings.personalPlan.history.subtitle' => 'Les directions que tu as choisies jusqu’ici',
			'settings.personalPlan.history.open' => 'Voir l\'historique',
			'settings.personalPlan.history.current' => 'En cours',
			'settings.personalPlan.history.ended' => ({required Object date}) => 'Terminé le ${date}',
			'settings.personalPlan.history.started' => ({required Object date}) => 'Commencé le ${date}',
			'settings.personalPlan.history.empty' => 'Tu n\'as pas encore défini d\'objectif.',
			'settings.personalPlan.history.error' => 'L\'historique des objectifs n\'a pas pu être chargé.',
			'settings.personalPlan.history.count' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count} objectifs', one: '${count} objectif', other: '${count} objectifs', ), 
			'settings.personalPlan.history.weeklyLimit' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count} événements par semaine', one: '${count} événement par semaine', other: '${count} événements par semaine', ), 
			'settings.personalPlan.history.contexts' => ({required Object contexts}) => 'Contextes protégés : ${contexts}',
			_ => null,
		} ?? switch (path) {
			'settings.data.title' => 'Données',
			'settings.data.description' => 'Tes données restent locales sauf export volontaire.',
			'settings.data.errorReporting.label' => 'Rapports d\'erreur anonymes',
			'settings.data.errorReporting.description' => 'Envoie un rapport technique lorsque StopCorn plante, afin que le problème puisse être corrigé. Il ne contient aucun objectif, entrée de journal, note ou réglage. Désactive cette option pour ne rien envoyer du tout.',
			'settings.data.export.title' => 'Exporter mes données',
			'settings.data.export.description' => 'Créer un fichier JSON versionné.',
			'settings.data.stored.title' => 'Ce qui est stocké',
			'settings.data.stored.description' => 'Comprendre les données locales.',
			'settings.data.stored.body1' => 'StopCorn conserve localement tes objectifs, bilans, parcours d\'aide, événements volontaires, stratégies utilisées et progression pédagogique.',
			'settings.data.stored.body2' => 'L\'application ne collecte jamais les URL, l\'historique du navigateur, les recherches, les captures d\'écran, les contacts ou la position.',
			'settings.data.stored.body3' => 'Selon les réglages du système, une sauvegarde du téléphone peut éventuellement inclure les données de l\'application.',
			'settings.data.delete.action' => 'Supprimer toutes mes données',
			'settings.data.delete.description' => 'Action définitive en deux étapes.',
			'settings.data.delete.progress' => 'Suppression en cours…',
			'settings.data.delete.semantics' => 'Confirmer la suppression',
			'settings.data.delete.title' => 'Supprimer toutes les données ?',
			'settings.data.delete.body' => 'Les objectifs, observations, notes, bilans, progressions, préférences et exports en cache seront effacés de cet appareil. Cette action est définitive.',
			'settings.data.delete.error' => 'La suppression n\'a pas pu être terminée. Certaines données sont peut-être déjà effacées ; réessaie pour terminer.',
			'settings.data.delete.confirmation.semantics' => 'Suppression définitive',
			'settings.data.delete.confirmation.title' => 'Dernière confirmation',
			'settings.data.delete.confirmation.action' => 'Supprimer définitivement',
			'settings.data.delete.confirmation.keep' => 'Garder mes données',
			'settings.developer.title' => 'Outils de développement',
			'settings.developer.description' => 'Utilitaires disponibles uniquement dans les versions de débogage.',
			'settings.developer.sample.action' => 'Charger des données d\'exemple',
			'settings.developer.sample.description' => 'Ajoute un historique local cohérent sur 60 jours sans effacer tes données existantes.',
			'settings.developer.sample.progress' => 'Chargement des données d\'exemple…',
			'settings.developer.sample.loaded' => 'Données d\'exemple chargées. Tu peux les recharger à tout moment.',
			'settings.developer.sample.error' => 'Les données d\'exemple n\'ont pas pu être chargées.',
			'settings.developer.cornPoint.action' => 'Donner un Corn point',
			'settings.developer.cornPoint.description' => 'Ajoute un point bonus et ouvre le dialogue animé, même si le Corn point du jour est déjà récolté.',
			'settings.developer.supportThanks.label' => 'Afficher le remerciement de soutien',
			'settings.developer.supportThanks.description' => 'Affiche localement la note de remerciement dans la carte de soutien, sans achat RevenueCat.',
			'settings.about.title' => 'À propos',
			'settings.about.description' => 'Informations sur StopCorn et son cadre d\'utilisation.',
			'settings.about.version' => ({required Object version}) => 'Version ${version}.',
			'settings.about.body' => 'StopCorn est un outil d\'auto-accompagnement gratuit, privé et sans jugement.',
			'settings.about.privacy.title' => 'Confidentialité',
			'settings.about.privacy.body1' => 'Aucun compte StopCorn n\'est créé et l\'accompagnement quotidien n\'utilise ni suivi d\'usage, ni mesure d\'audience, ni publicité.',
			'settings.about.privacy.body2' => 'Toutes les observations restent sur cet appareil, sauf si tu choisis explicitement de créer puis partager un export.',
			'settings.about.privacy.body3' => 'StopCorn ne contacte RevenueCat que si tu ouvres toi-même la page de soutien : afficher les Réglages reste une opération locale. Après cette ouverture, l\'application vérifie au lancement si un soutien existe, afin de pouvoir te remercier. RevenueCat et la boutique de ton appareil traitent alors les informations nécessaires à l\'achat, sans tes notes privées. StopCorn désactive les diagnostics et la collecte d\'identifiants publicitaires.',
			'settings.about.privacy.body4' => 'La suppression totale efface les données utilisateur et les préférences StopCorn, puis remet l\'application à son état initial.',
			'settings.about.privacy.policyAction' => 'Voir la politique de confidentialité',
			'settings.about.privacy.policyError' => 'Impossible d\'ouvrir la politique de confidentialité pour le moment.',
			'settings.about.privacy.body5' => 'Des rapports d\'erreur anonymes sont envoyés via Sentry afin que les plantages puissent être corrigés. Ils contiennent l\'erreur technique et l\'endroit où elle s\'est produite, jamais un objectif, une entrée de journal, une note ou une valeur de la base. L\'option de la section Données les arrête complètement.',
			'settings.about.licenses' => 'Licences open source',
			'settings.about.professionalHelp' => 'Trouver une aide professionnelle',
			'settings.about.help.title' => 'Aide professionnelle',
			'settings.about.help.body1' => 'Un médecin généraliste, un psychologue ou un autre professionnel qualifié peut aider à évaluer la situation et proposer un accompagnement adapté.',
			'settings.about.help.body2' => 'Demander de l\'aide peut être pertinent si la souffrance est forte, si la perte de contrôle persiste ou si les conséquences deviennent importantes.',
			'settings.about.help.body3' => 'StopCorn ne fournit pas de diagnostic et ne remplace pas cet accompagnement.',
			'settings.goalEditor.title' => 'Choisir un nouvel objectif',
			'settings.goalEditor.history' => 'L\'objectif actuel restera dans ton historique.',
			'settings.goalEditor.activate' => 'Activer cet objectif',
			'settings.goalEditor.error' => 'L\'objectif n\'a pas pu être enregistré.',
			'settings.goalEditor.validation.weeklyLimit' => 'Indique une limite hebdomadaire positive.',
			'settings.goalEditor.validation.context' => 'Choisis au moins un contexte.',
			'settings.error.load' => 'Les réglages n\'ont pas pu être chargés.',
			'settings.error.save' => 'Impossible d\'enregistrer ce réglage pour le moment.',
			'strategy.putPhoneAway' => 'Poser le téléphone hors de portée',
			'strategy.leaveRoom' => 'Quitter la pièce',
			'strategy.walkFiveMinutes' => 'Marcher cinq minutes',
			'strategy.slowBreathing' => 'Respirer lentement pendant 90 secondes',
			'strategy.waterAndSwitch' => 'Boire un verre d\'eau et changer d\'activité',
			'strategy.messageSomeone' => 'Envoyer un message à une personne choisie',
			'strategy.twoMinuteTask' => 'Lancer une tâche de deux minutes',
			'strategy.takeShower' => 'Prendre une douche',
			'strategy.waitTenMinutes' => 'Attendre dix minutes avant de décider',
			'strategy.personal' => 'Stratégie personnelle',
			'strategy.genericDescription' => 'Une action simple à essayer quand tu en as besoin.',
			'strategy.timerSeconds' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Minuteur proposé : ${count} secondes.', one: 'Minuteur proposé : ${count} seconde.', other: 'Minuteur proposé : ${count} secondes.', ), 
			'strategy.timerMinutes' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Minuteur proposé : ${count} minutes.', one: 'Minuteur proposé : ${count} minute.', other: 'Minuteur proposé : ${count} minutes.', ), 
			'theme.system' => 'Suivre le système',
			'theme.light' => 'Clair',
			'theme.dark' => 'Sombre',
			'trigger.boredom' => 'Ennui',
			'trigger.stress' => 'Stress',
			'trigger.loneliness' => 'Solitude',
			'trigger.fatigue' => 'Fatigue',
			'trigger.habit' => 'Habitude',
			'trigger.arousal' => 'Excitation',
			'trigger.socialMedia' => 'Réseaux sociaux',
			'trigger.relationshipDifficulty' => 'Difficulté relationnelle',
			'trigger.alcoholOrSubstance' => 'Alcool ou autre substance',
			'trigger.bedtimePhone' => 'Téléphone au lit',
			'trigger.other' => 'Autre',
			'urge.pauseTitle' => 'Faire une pause',
			'urge.quit' => 'Quitter',
			'urge.support.pageTitle' => 'Choisir une aide',
			'urge.support.title' => 'Qu\'est-ce qui t\'aiderait maintenant ?',
			'urge.support.subtitle' => 'Choisis l\'option qui te paraît la plus accessible. Tu gardes la main sur le rythme.',
			'urge.support.semantics' => 'Formes de soutien disponibles',
			'urge.support.guidedTitle' => 'Pause guidée',
			'urge.support.guidedDescription' => 'Prends un court moment pour souffler, puis fais à nouveau le point.',
			'urge.support.planTitle' => 'Plan de secours',
			'urge.support.planDescription' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Aucune action n\'a encore été préparée.', one: 'Choisis l\'action que tu avais préparée.', other: 'Choisis parmi les ${count} actions que tu avais préparées.', ), 
			'urge.support.ideasTitle' => 'Autres idées',
			'urge.support.ideasDescription' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: 'Aucune autre action n\'est disponible.', one: 'Découvre une autre action.', other: 'Découvre ${count} autres actions.', ), 
			'urge.grounding.feet' => 'Pose les pieds au sol.',
			'urge.grounding.inhale' => 'Inspire lentement.',
			'urge.grounding.observe' => 'Observe ce que tu ressens sans chercher à le chasser.',
			'urge.grounding.exhale' => 'Expire plus longtemps que tu n\'inspires.',
			'urge.grounding.change' => 'Observe simplement si cela monte, baisse ou reste stable.',
			'urge.grounding.title' => 'Accorde-toi un instant.',
			'urge.grounding.subtitle' => 'Cette courte pause est une aide à la décontraction, elle ne constitue pas une règle médicale.',
			'urge.grounding.semantics' => 'Progression de la pause',
			'urge.grounding.skip' => 'Passer',
			'urge.strategy.pageTitle' => 'Choisir une action',
			'urge.strategy.title' => 'Quelle action peux-tu essayer maintenant ?',
			'urge.strategy.subtitle' => 'Une petite action réaliste suffit. Elle n\'a pas besoin de faire disparaître ce que tu ressens.',
			'urge.strategy.planTitle' => 'Ton plan de secours',
			'urge.strategy.planSubtitle' => 'Choisis l\'une des actions que tu avais préparées pour ce moment.',
			'urge.strategy.ideasTitle' => 'Autres idées',
			'urge.strategy.ideasSubtitle' => 'Choisis une autre action simple qui te paraît faisable maintenant.',
			'urge.strategy.loadError' => 'Les stratégies n\'ont pas pu être chargées.',
			'urge.strategy.empty' => 'Aucune action n\'est disponible dans cette liste.',
			'urge.strategy.semantics' => 'Stratégies disponibles',
			'urge.strategy.start' => 'Je lance cette action',
			'urge.strategy.started' => ({required Object strategy}) => 'Action lancée : ${strategy}.',
			'urge.strategy.timerTitle' => 'Durée indicative',
			'urge.strategy.timerGuidance' => 'Ce minuteur est seulement indicatif : tu peux terminer plus tôt ou prendre tout le temps dont tu as besoin.',
			'urge.strategy.timerSemantics' => 'Minuteur indicatif de l\'action',
			'urge.strategy.timerComplete' => 'La durée indicative est écoulée.',
			'urge.strategy.reassess' => 'Faire le point à nouveau',
			'urge.strategy.effect' => 'Utilité perçue de la stratégie',
			'urge.result.pageTitle' => 'Faire le point',
			'urge.result.title' => TextSpan(children: [ const TextSpan(text: 'Comment évalues-tu ton envie maintenant ?'), ]), 
			'urge.result.subtitle' => 'Elle peut avoir augmenté, diminué ou être restée stable.',
			'urge.result.outcome.title' => 'Et maintenant ?',
			'urge.result.outcome.subtitle' => 'N\'hésite pas à être honnête. Comme toujours, pas de jugement !',
			'urge.result.outcome.label' => 'Résultat',
			'urge.result.note' => 'Note facultative',
			'urge.result.noteHint' => 'Un repère utile pour la prochaine fois.',
			'urge.result.finish' => 'Terminer le parcours',
			'urge.complete.title' => 'Parcours terminé',
			'urge.complete.consumedHeadline' => 'Pas de souci.',
			'urge.complete.otherHeadline' => 'Super !',
			'urge.complete.consumedBody' => 'Cet événement n\'efface pas tes progrès.',
			'urge.complete.otherBody' => 'Tu as espacé ton envie et ton choix.',
			'urge.complete.log' => 'Noter ce qui s\'est passé',
			'urge.intensity.title' => TextSpan(children: [ const TextSpan(text: 'Quelle est l\'intensité de ton envie ?'), ]), 
			'urge.intensity.subtitle' => 'Évalue-la sur 10. Il n\'y a pas de mauvaise réponse : ce repère permettra de voir comment elle évolue.',
			'urge.intensity.label' => 'Intensité actuelle',
			'urge.factors.title' => 'D\'autres détails ?',
			'urge.factors.subtitle' => 'Ces informations facultatives peuvent t\'aider à mieux comprendre ces moments.',
			'urge.factors.label' => 'Facteurs déclenchants (facultatif)',
			'urge.factors.trigger' => 'Déclencheur',
			'urge.factors.emotion' => 'Émotion',
			'urge.timer.count' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('fr'))(count, zero: '${count}s restantes', one: '${count}s restante', other: '${count}s restantes', ), 
			'urge.error.start' => 'Impossible de démarrer ce parcours pour le moment. Réessaie.',
			'urge.error.missingSession' => 'Cette session n\'est plus disponible.',
			'urge.error.strategySave' => 'La stratégie n\'a pas pu être enregistrée. Réessaie.',
			'urge.error.outcomeRequired' => 'Choisis le résultat qui décrit le mieux la situation.',
			'urge.error.save' => 'Impossible d\'enregistrer pour le moment. Réessaie dans quelques instants.',
			_ => null,
		};
	}
}
