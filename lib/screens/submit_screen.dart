import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  int _currentStep = 0;
  final _titleCtrl = TextEditingController();
  final _directorCtrl = TextEditingController();
  final _synopsisCtrl = TextEditingController();
  String _selectedYear = '2024';
  String _selectedTheme = 'Environment';
  final List<String> _tags = ['sustainability', 'rural life', 'environment'];

  // ── Video file state ───────────────────────────────────────────────────────
  String? _videoFileName;
  String? _videoFilePath;
  int? _videoFileSize;

  final List<String> _steps = ['Upload Video', 'Metadata', 'Review', 'Submit'];

  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _videoFileName = file.name;
        _videoFilePath = file.path;
        _videoFileSize = file.size;
      });
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1F17),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1F17),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('PSAUniFilms',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white)),
            Text('Submit Your Documentary',
                style: TextStyle(fontSize: 11, color: Colors.white54)),
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.close, color: Colors.white54),
              onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildCurrentStep(),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: List.generate(_steps.length, (i) {
          final isCompleted = i < _currentStep;
          final isActive = i == _currentStep;
          return Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isCompleted || isActive
                            ? const Color(0xFF4CAF50)
                            : const Color(0xFF1A2E22),
                        border: Border.all(
                            color: isCompleted || isActive
                                ? const Color(0xFF4CAF50)
                                : Colors.white24),
                      ),
                      child: Center(
                        child: isCompleted
                            ? const Icon(Icons.check,
                                color: Colors.white, size: 14)
                            : Text('${i + 1}',
                                style: TextStyle(
                                    color: isActive
                                        ? Colors.white
                                        : Colors.white38,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(_steps[i],
                        style: TextStyle(
                            color: isActive
                                ? const Color(0xFF4CAF50)
                                : Colors.white38,
                            fontSize: 9)),
                  ],
                ),
                if (i < _steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 18),
                      color: i < _currentStep
                          ? const Color(0xFF4CAF50)
                          : Colors.white12,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildUploadStep();
      case 1:
        return _buildMetadataStep();
      case 2:
        return _buildReviewStep();
      default:
        return _buildUploadStep();
    }
  }

  Widget _buildUploadStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Upload Your Documentary',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),

        // Drop zone
        Container(
          width: double.infinity,
          height: 160,
          decoration: BoxDecoration(
            color: const Color(0xFF1A2E22),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: _videoFileName != null
                    ? const Color(0xFF4CAF50)
                    : Colors.white24,
                style: BorderStyle.solid,
                width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _videoFileName != null
                    ? Icons.check_circle_outline
                    : Icons.cloud_upload_outlined,
                color: _videoFileName != null
                    ? const Color(0xFF4CAF50)
                    : Colors.white38,
                size: 48,
              ),
              const SizedBox(height: 12),
              Text(
                _videoFileName != null
                    ? _videoFileName!
                    : 'Drag and drop your video here',
                style: TextStyle(
                    color: _videoFileName != null
                        ? Colors.white70
                        : Colors.white54,
                    fontSize: 13),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (_videoFileName == null)
                const Text('or',
                    style: TextStyle(color: Colors.white38, fontSize: 12)),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                ),
                onPressed: _pickVideo,
                child: Text(
                    _videoFileName != null ? 'Change File' : 'Choose File'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text('MP4, MOV, AVI  •  Max size: 2GB  •  Max duration: 60 mins',
            style: TextStyle(color: Colors.white38, fontSize: 11),
            textAlign: TextAlign.center),
        const SizedBox(height: 20),

        // Selected file info
        if (_videoFileName != null) ...[
          const Text('Selected File',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: const Color(0xFF1A2E22),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1F17),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.video_file_outlined,
                      color: Color(0xFF4CAF50), size: 28),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_videoFileName!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(
                        _videoFileSize != null
                            ? _formatFileSize(_videoFileSize!)
                            : 'Unknown size',
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close,
                      color: Color(0xFFE53935), size: 18),
                  onPressed: () => setState(() {
                    _videoFileName = null;
                    _videoFilePath = null;
                    _videoFileSize = null;
                  }),
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: const Color(0xFF1A2E22),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white12)),
          child: Row(
            children: const [
              Icon(Icons.info_outline, color: Colors.white38, size: 16),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                    'Please ensure your video does not contain any copyrighted material.',
                    style: TextStyle(color: Colors.white54, fontSize: 11)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetadataStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter Documentary Details',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 20),
        _fieldLabel('Title *'),
        _textField(_titleCtrl, 'Path of Sustainable Living'),
        const SizedBox(height: 14),
        _fieldLabel('Year *'),
        _dropdownField(_selectedYear, ['2022', '2023', '2024'],
            (v) => setState(() => _selectedYear = v!)),
        const SizedBox(height: 14),
        _fieldLabel('Director / Filmmaker *'),
        _textField(_directorCtrl, 'Juan Dela Cruz'),
        const SizedBox(height: 14),
        _fieldLabel('Synopsis *'),
        TextField(
          controller: _synopsisCtrl,
          maxLines: 4,
          maxLength: 500,
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'Describe your documentary...',
            hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
            filled: true,
            fillColor: const Color(0xFF1A2E22),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            counterStyle: const TextStyle(color: Colors.white38),
          ),
        ),
        const SizedBox(height: 14),
        _fieldLabel('Theme *'),
        _dropdownField(
            _selectedTheme,
            ['Agriculture', 'Culture', 'Environment', 'Education', 'Community'],
            (v) => setState(() => _selectedTheme = v!)),
        const SizedBox(height: 14),
        _fieldLabel('Tags (optional)'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._tags.map((tag) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                      color: const Color(0xFF1A2E22),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24)),
                  child: Text(tag,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12)),
                )),
            GestureDetector(
              onTap: () {},
              child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                      color: const Color(0xFF1A2E22),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24)),
                  child:
                      const Icon(Icons.add, color: Colors.white54, size: 16)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Review Your Submission',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 16),

        // File info
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: const Color(0xFF1A2E22),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1F17),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.video_file_outlined,
                    color: Color(0xFF4CAF50), size: 32),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _videoFileName ?? 'No file selected',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _videoFileSize != null
                          ? _formatFileSize(_videoFileSize!)
                          : '',
                      style:
                          const TextStyle(color: Colors.white38, fontSize: 11),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => setState(() => _currentStep = 0),
                      child: const Text('Change File',
                          style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 11,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Details
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: const Color(0xFF1A2E22),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DETAILS',
                  style: TextStyle(
                      color: Colors.white38, fontSize: 11, letterSpacing: 1.2)),
              const SizedBox(height: 12),
              _reviewRow(
                  'Title', _titleCtrl.text.isEmpty ? '—' : _titleCtrl.text),
              _reviewRow('Year', _selectedYear),
              _reviewRow('Director',
                  _directorCtrl.text.isEmpty ? '—' : _directorCtrl.text),
              _reviewRow('Synopsis',
                  _synopsisCtrl.text.isEmpty ? '—' : _synopsisCtrl.text),
              _reviewRow('Theme', _selectedTheme),
              const SizedBox(height: 8),
              const Text('Tags',
                  style: TextStyle(color: Colors.white38, fontSize: 12)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                children: _tags
                    .map((t) => Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              color: const Color(0xFF0D1F17),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(t,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 11)),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Agreement
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: const Color(0xFF1A2E22),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.verified_outlined,
                  color: Color(0xFF4CAF50), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'By submitting, you confirm that this is your original work and you agree to the PSAUniFilms Terms and Submission Agreement.',
                        style: TextStyle(
                            color: Colors.white70, fontSize: 12, height: 1.4)),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {},
                      child: const Text('View Agreement',
                          style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Color(0xFF0D1F17),
          border: Border(top: BorderSide(color: Color(0xFF1E3528)))),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white70,
                  side: const BorderSide(color: Colors.white24),
                  minimumSize: const Size(0, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => setState(() => _currentStep--),
                child: const Text('Back'),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                foregroundColor: Colors.white,
                minimumSize: const Size(0, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (_currentStep == 0 && _videoFileName == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please select a video file first')),
                  );
                  return;
                }
                if (_currentStep < 2) {
                  setState(() => _currentStep++);
                } else {
                  _showSuccessDialog();
                }
              },
              icon: _currentStep == 2
                  ? const Icon(Icons.send_outlined, size: 18)
                  : const SizedBox.shrink(),
              label: Text(_currentStep == 2 ? 'Submit Documentary' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A2E22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF4CAF50)),
              child: const Icon(Icons.check, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 16),
            const Text('Submission Successful!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Your documentary has been submitted for review.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, fontSize: 13)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                minimumSize: const Size(double.infinity, 44),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _currentStep = 0;
                  _videoFileName = null;
                  _videoFilePath = null;
                  _videoFileSize = null;
                });
              },
              child: const Text('Done', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(label,
            style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
      );

  Widget _textField(TextEditingController ctrl, String hint) => TextField(
        controller: ctrl,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
          filled: true,
          fillColor: const Color(0xFF1A2E22),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      );

  Widget _dropdownField(
          String value, List<String> items, void Function(String?) onChanged) =>
      DropdownButtonFormField<String>(
        initialValue: value,
        onChanged: onChanged,
        dropdownColor: const Color(0xFF1A2E22),
        style: const TextStyle(color: Colors.white, fontSize: 13),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFF1A2E22),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
      );

  Widget _reviewRow(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 70,
                child: Text(label,
                    style:
                        const TextStyle(color: Colors.white38, fontSize: 12))),
            Expanded(
                child: Text(value,
                    style: const TextStyle(color: Colors.white, fontSize: 12))),
          ],
        ),
      );
}
