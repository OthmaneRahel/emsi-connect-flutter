import 'dart:io';
import 'dart:async';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';

class MultimediaPage extends StatefulWidget {
  const MultimediaPage({super.key});

  @override
  State<MultimediaPage> createState() => _MultimediaPageState();
}

class _MultimediaPageState extends State<MultimediaPage> {

  final ImagePicker _picker = ImagePicker();
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();

  XFile? _image;
  String? _audioPath;

  int? _imageSize;

  bool _recording = false;
  bool _busy = false;


  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  int _recordingSeconds = 0;


  void _message(String text) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }


  Future<void> _chooseImage(ImageSource source) async {
    if (_busy) return;

    setState(() => _busy = true);

    try {
      final XFile? selected = await _picker.pickImage(
        source: source,
        imageQuality: 75,
      );

      if (!mounted) return;

      if (selected == null) {
        _message('Sélection annulée.');
        return;
      }

      final size = await selected.length();

      if (!mounted) return;

      setState(() {
        _image = selected;
        _imageSize = size;
      });

      _message('Image sélectionnée avec succès.');
    } catch (e) {
      _message('Impossible de récupérer l’image : $e');
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }


  void _clearImage() {
    setState(() {
      _image = null;
      _imageSize = null;
    });

    _message('Image supprimée.');
  }


  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }


  Future<bool> _ensureMicrophonePermission() async {
    // Sur web : pas de permission native à gérer via permission_handler
    if (kIsWeb) {
      return true;
    }

    if (!Platform.isAndroid && !Platform.isIOS) {
      return true;
    }

    PermissionStatus status = await Permission.microphone.status;

    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    debugPrint('Permission microphone : $status');

    // Cas 1 : permission définitivement refusée
    if (status.isPermanentlyDenied) {
      if (!mounted) return false;

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Permission microphone refusée'),
            content: const Text(
              'Vous avez définitivement refusé l’accès au microphone.\n\n'
              'Pour enregistrer une question vocale, veuillez autoriser '
              'le microphone dans les paramètres de l’application.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Annuler'),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.settings),
                label: const Text('Ouvrir les réglages'),
                onPressed: () async {
                  Navigator.pop(dialogContext);
                  await openAppSettings();
                },
              ),
            ],
          );
        },
      );

      return false;
    }

    // Cas 2 : refusée normalement
    if (status.isDenied) {
      _message('Permission microphone non autorisée.');
      return false;
    }

    // Cas 3 : restreinte
    if (status.isRestricted) {
      _message('Permission microphone restreinte.');
      return false;
    }

    return status.isGranted;
  }


  Future<void> _startRecording() async {
    if (_busy || _recording) return;

    setState(() => _busy = true);

    try {
      // Vérification de la permission (bonus inclus)
      if (!await _ensureMicrophonePermission()) {
        return;
      }

      // Vérifier l'autorisation du recorder
      if (!await _recorder.hasPermission()) {
        _message('Autorisation microphone indisponible.');
        return;
      }

      // Chemin du fichier audio selon la plateforme
      final String path = kIsWeb
          ? 'question_emsi.webm'
          : '${Directory.systemTemp.path}/question_emsi.m4a';

      // Démarrer l'enregistrement
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
        ),
        path: path,
      );

      if (!mounted) return;

      setState(() {
        _recording = true;
        _recordingSeconds = 0;
        _audioPath = null;
      });

      _stopwatch
        ..reset()
        ..start();

      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (mounted) {
            setState(() {
              _recordingSeconds = _stopwatch.elapsed.inSeconds;
            });
          }
        },
      );

      _message('Enregistrement démarré.');
    } catch (e) {
      _message('Enregistrement impossible : $e');
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }


  Future<void> _stopRecording() async {
    if (!_recording || _busy) return;

    setState(() => _busy = true);

    try {
      // Arrêter le recorder : retourne un chemin (mobile) ou une blob URL (web)
      final path = await _recorder.stop();

      _stopwatch.stop();

      _timer?.cancel();
      _timer = null;

      if (!mounted) return;

      setState(() {
        _recording = false;
        _audioPath = path;
        _recordingSeconds = _stopwatch.elapsed.inSeconds;
      });

      _message(
        path == null
            ? 'Aucun fichier enregistré.'
            : 'Question vocale enregistrée.',
      );
    } catch (e) {
      _message('Erreur lors de l’arrêt : $e');
    } finally {
      _stopwatch.stop();
      _timer?.cancel();
      _timer = null;

      if (mounted) {
        setState(() {
          _recording = false;
          _busy = false;
        });
      }
    }
  }


  Future<void> _playAudio() async {
    if (_audioPath == null || _recording || _busy) return;

    try {
      await _player.stop();

      if (kIsWeb) {
        // Sur web, _audioPath est une blob URL → UrlSource
        await _player.play(UrlSource(_audioPath!));
      } else {
        await _player.play(DeviceFileSource(_audioPath!));
      }
    } catch (e) {
      _message('Lecture impossible : $e');
    }
  }


  @override
  void dispose() {
    _timer?.cancel();
    _stopwatch.stop();

    _recorder.dispose();
    _player.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_recording,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _recording) {
          _message('Veuillez arrêter l’enregistrement avant de quitter.');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Espace multimédia'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            const Text(
              'Image',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _chooseImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Prendre une photo'),
                ),
                OutlinedButton.icon(
                  onPressed: _busy
                      ? null
                      : () => _chooseImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galerie'),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (_image != null) ...[
              kIsWeb
                  ? Image.network(
                      _image!.path,
                      height: 190,
                    )
                  : Image.file(
                      File(_image!.path),
                      height: 190,
                    ),

              const SizedBox(height: 10),

              Text('Nom : ${_image!.name}'),

              Text('Taille : ${_imageSize ?? 0} octets'),

              const SizedBox(height: 8),

              TextButton.icon(
                onPressed: _clearImage,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Effacer l’image'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ],

            const Divider(height: 40),


            const Text(
              'Question vocale',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: _busy
                  ? null
                  : (_recording ? _stopRecording : _startRecording),
              icon: Icon(_recording ? Icons.stop : Icons.mic),
              label: Text(_recording ? 'Arrêter' : 'Enregistrer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _recording ? Colors.red : null,
                foregroundColor: _recording ? Colors.white : null,
              ),
            ),

            if (_recording || _recordingSeconds > 0) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: _recording ? Colors.red : Colors.grey,
                    size: 12,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _recording
                        ? 'Enregistrement en cours'
                        : 'Durée de l’enregistrement',
                  ),
                  const Spacer(),
                  Text(
                    _formatDuration(_recordingSeconds),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _recording ? Colors.red : Colors.black,
                    ),
                  ),
                ],
              ),
            ],

            if (_audioPath != null)
              OutlinedButton.icon(
                onPressed: _playAudio,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Écouter l’enregistrement'),
              ),

            if (_busy) ...[
              const SizedBox(height: 12),
              const LinearProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }
}