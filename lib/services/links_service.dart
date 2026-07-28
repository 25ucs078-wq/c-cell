import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class LinksService {
  static final LinksService _instance = LinksService._internal();
  factory LinksService() => _instance;
  LinksService._internal();

  static const String _hostedJsonUrl =
      'https://raw.githubusercontent.com/25ucs078-wq/c-cell/main/docs/links.json';

  Map<String, String>? _cachedLinks;
  bool _isFetching = false;

  // Fallback defaults to ensure app functionality offline or before first fetch
  static const Map<String, String> _fallbackLinks = {
    'mess_menu_drive_url':
        'https://drive.google.com/drive/folders/1vCqyE7QiiFn6ExJsw3PdktB4wD_Q_5vo',
    'campus_map_drive_url':
        'https://drive.google.com/drive/folders/18zdpGIb9xHHeh_wqrYYRfFeSHWsv4yIF',
    'bus_schedule_url': 'https://lnmiit.ac.in/transportation/',
    'hostel_contacts_url': 'https://lnmiit.ac.in/office-and-administration/',
    'sem1_notes_drive_url':
        'https://drive.google.com/drive/folders/1R8MWh7VAa1TAMuv2pTFzVQh_u1ALcx9y?usp=drive_link',
    'sem2_notes_drive_url':
        'https://drive.google.com/drive/folders/1CYAcO9cEk8r8bQwXmsHF8dvxXme80D8z?usp=drive_link',
    'lnmiit_official_website': 'https://www.lnmiit.ac.in',
    'erp_portal': 'https://erp.lnmiit.ac.in',
    'moodle_portal': 'https://moodle.lnmiit.ac.in',
    'scholarship_policy': 'https://lnmiit.ac.in/scholarships-assistantships/',
    'placement_cell': 'https://placements.lnmiit.ac.in',
    'fee_structure_ug': 'https://lnmiit.ac.in/admissions/fee_structure_ug/',
    'curriculum_aids_url': 'https://lnmiit.ac.in/department/ai-ds/programs/',
    'tedx_instagram': 'https://www.instagram.com/tedxlnmiit/',
    'tedx_youtube': 'https://www.youtube.com/@TEDxLNMIIT',
    'tedx_website': 'https://tedxlnmiit.in/',
    'esummit_instagram': 'https://www.instagram.com/esummitlnmiit/',
    'desportivos_instagram': 'https://www.instagram.com/desportivos.lnmiit/',
    'desportivos_youtube': 'https://www.youtube.com/@DesportivosLNMIIT',
    'desportivos_website': 'https://desportivos.lnmiit.ac.in/',
    'plinth_instagram': 'https://www.instagram.com/plinth.lnmiit/',
    'plinth_youtube': 'https://www.youtube.com/@plinth.lnmiit',
    'plinth_website': 'https://plinth.lnmiit.ac.in/',
    'vivacity_instagram': 'https://www.instagram.com/vivacity_lnmiit/',
    'vivacity_youtube': 'https://www.youtube.com/@VivacityLNMIIT',
    'vivacity_website': 'https://vivacity.lnmiit.ac.in/',
    'aaveg_instagram': 'https://www.instagram.com/aaveg_lnmiit/',
    'capriccio_instagram': 'https://www.instagram.com/capriccio.lnmiit/',
    'eminence_instagram': 'https://www.instagram.com/eminence.lnmiit/',
    'fundoo_instagram': 'https://www.instagram.com/fundoo.lnmiit/',
    'imagination_instagram': 'https://www.instagram.com/imagination.lnmiit/',
    'insignia_instagram': 'https://www.instagram.com/insignia_lnm/',
    'literary_instagram': 'https://www.instagram.com/literary_lnmiit/',
    'mediacell_instagram': 'https://www.instagram.com/mediacell_lnmiit/',
    'rendition_instagram': 'https://www.instagram.com/rendition_lnmiit/',
    'sankalp_instagram': 'https://www.instagram.com/sankalp.lnmiit/',
    'vignette_instagram': 'https://www.instagram.com/vignette_lnmiit/',
    'astronomy_instagram': 'https://www.instagram.com/astronomylnmiit/',
    'cipher_instagram': 'https://www.instagram.com/cipher.lnmiit/',
    'cybros_instagram': 'https://www.instagram.com/cybros_lnmiit/',
    'debsoc_instagram': 'https://www.instagram.com/thedebatesocietylnmiit/',
    'ecell_instagram': 'https://www.instagram.com/ecell.lnmiit/',
    'finlogue_instagram': 'https://www.instagram.com/finlogue.lnmiit/',
    'phoenix_instagram': 'https://www.instagram.com/phoenix.lnmiit/',
    'qbit_instagram': 'https://www.instagram.com/qbit_lnmiit/',
    'quizzinga_instagram': 'https://www.instagram.com/quizzingalnm/',
    'badminton_instagram': 'https://www.instagram.com/badminton_lnmiit/',
    'basketball_instagram': 'https://www.instagram.com/lnmiit_basketball/',
    'chess_instagram': 'https://www.instagram.com/lnmiit.chess/',
    'cricket_instagram': 'https://www.instagram.com/_cricket_lnmiit/',
    'football_instagram': 'https://www.instagram.com/football.lnmiit/',
    'kabaddi_instagram': 'https://www.instagram.com/lnmiit_kabaddi/',
    'volleyball_instagram': 'https://www.instagram.com/lnmiit.volleyball/',
    'zenith_instagram': 'https://www.instagram.com/zenith_lnmiit/',
    'krishna_instagram': 'https://instagram.com/the.whitehairedguy/',
    'krishna_linkedin': 'https://linkedin.com/in/krishna-khairnar-229291318/',
    'harshita_instagram': 'https://instagram.com/harshitajain_1812/',
    'harshita_linkedin': 'https://linkedin.com/in/harshitajain-1812-alegria/',
    'rahul_instagram': 'https://instagram.com/_rahul.mukhi_/',
    'rahul_linkedin': 'https://linkedin.com/in/rahul-sanjay-mukhi-2410b3323/',
    'nishra_instagram': 'https://instagram.com/nishra_kothari/',
    'nishra_linkedin': 'https://linkedin.com/in/nishra-kothari-b6735a3a7/',
    'shashwat_instagram': 'https://instagram.com/_shashwat_kanoongo/',
    'shashwat_linkedin': 'https://linkedin.com/in/shashwat-kanoongo-465370370/',
    'parth_instagram': 'https://instagram.com/parth_arora._/',
    'parth_linkedin': 'https://linkedin.com/in/parth-arora19/',
    'krishangee_instagram': 'https://instagram.com/krishangeetayal/',
    'krishangee_linkedin': 'https://linkedin.com/in/krishangee-tayal-96a861242/',
    'yug_instagram': 'https://instagram.com/yugnahar/',
    'yug_linkedin': 'https://linkedin.com/in/yug-nahar-32538a317/',
    'plaksha_instagram': 'https://instagram.com/_.plaksha._/',
    'plaksha_linkedin': 'https://linkedin.com/in/plaksha-gulati-7b8685313/',
    'ayush_instagram': 'https://instagram.com/_ayu_sh95/',
    'ayush_linkedin': 'https://linkedin.com/in/ayush-sharma-799bba41b/',
    'dhwani_instagram': 'https://instagram.com/dhwani21_/',
    'harsh_instagram': 'https://instagram.com/itz_harsh_9000/',
    'harsh_linkedin': 'https://linkedin.com/in/harsh-kumar-5819b4374/',
    'khushi_instagram': 'https://instagram.com/khushibajaj62/',
    'kunal_instagram': 'https://instagram.com/kunal_a_23/',
    'sakshi_instagram': 'https://instagram.com/sakshi_j2908/',
    'saumya_instagram': 'https://instagram.com/saumya._gaur/',
    'saumya_linkedin': 'https://linkedin.com/in/saumya-gaur-b60811418/',
    'vaniya_instagram': 'https://instagram.com/vaniyachopraa/',
    'vaniya_linkedin': 'https://linkedin.com/in/vaniya-chopra-7b17b53a4/',
  };

  /// Fetch remote JSON once and cache it
  Future<void> fetchRemoteLinks() async {
    if (_cachedLinks != null || _isFetching) return;
    _isFetching = true;
    try {
      final response = await http
          .get(Uri.parse(_hostedJsonUrl))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body) as Map<String, dynamic>;
        _cachedLinks = decoded.map((key, value) => MapEntry(key, value.toString()));
        if (kDebugMode) {
          debugPrint('LinksService: Successfully fetched remote links');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('LinksService: Failed to fetch remote links ($e), using fallbacks.');
      }
    } finally {
      _isFetching = false;
    }
  }

  /// Get URL string for a given key, falling back to local defaults if remote isn't loaded
  Future<String> getLink(String key) async {
    if (_cachedLinks == null) {
      await fetchRemoteLinks();
    }
    final url = _cachedLinks?[key] ?? _fallbackLinks[key];
    if (url == null || url.isEmpty) {
      throw Exception('Link for key "$key" not found');
    }
    return url;
  }

  /// Get synchronous link with fallback
  String getLinkSync(String key) {
    return _cachedLinks?[key] ?? _fallbackLinks[key] ?? '';
  }

  /// Helper to fetch and launch a URL for a given key via LaunchMode.externalApplication
  Future<bool> launchLink(String key) async {
    try {
      final urlString = await getLink(key);
      final uri = Uri.parse(urlString);
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('LinksService: Could not launch link for key "$key": $e');
      }
      return false;
    }
  }
}
