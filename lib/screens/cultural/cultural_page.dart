import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/glass_card.dart';

class CulturalPage extends StatelessWidget {
  const CulturalPage({super.key});

  static List<Map<String, String>> _getCoordinators(String clubName) {
    if (clubName == 'Aaveg') {
      return [
        {
          'name': 'Aditya Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Replace with their actual photo path
          'phone': '+919999999999', // number not updated
          'email': '24ucs220@lnmiit.ac.in',
        },
        {
          'name': 'Shourya Kavadia',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Replace with their actual photo path
          'phone': '+918888888888', // number not updated
          'email': '24ucc064@lnmiit.ac.in',
        },
        {
          'name': 'Tanuj Tulsyan',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Replace with their actual photo path
          'phone': '+917777777777', // number not updated
          'email': '24ucc169@lnmiit.ac.in',
        },
        {
          'name': 'Yash Gupta',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png', // Replace with their actual photo path
          'phone': '+916666666666', // number not updated
          'email': '24ucc099@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Capriccio') {
      return [
        {
          'name': 'Ashmit Dudani',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg', // Replace with their actual photo path
          'phone': '+918849166245',
          'email': '24dcs014@lnmiit.ac.in',
        },
        {
          'name': 'Nandini Sharma',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg', // Replace with their actual photo path
          'phone': '+918955027762',
          'email': '24ucs273@lnmiit.ac.in',
        },
        {
          'name': 'Nilesh Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg', // Replace with their actual photo path
          'phone': '+917296879571',
          'email': '24uec214@lnmiit.ac.in',
        },
        {
          'name': 'Parth Arora',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg', // Replace with their actual photo path
          'phone': '+918949092441',
          'email': '24imai005@lnmiit.ac.in',
        },
      ];
    }
    
    if (clubName == 'Eminence') {
      return [
        {
          'name': 'Avesh Khan',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/eminence/eminence_logo.jpg', // Replace with their actual photo path
          'phone': '+919999999999', // number not updated
          'email': '24ucs127@lnmiit.ac.in',
        },
        {
          'name': 'Kushagra',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/eminence/eminence_logo.jpg', // Replace with their actual photo path
          'phone': '+919265774219', // recheck once
          'email': '24ucs087@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Finlogue') {
      return [
        {
          'name': 'Aditya Tiwari',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/finlogue/aditya.jpeg',
          'phone': '+916268131180',
          'email': '24ucs155@lnmiit.ac.in',
        },
        {
          'name': 'Akshat Thadhani',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/finlogue/akshat.jpeg',
          'phone': '+919468655389',
          'email': '24ucc116@lnmiit.ac.in',
        },
        {
          'name': 'Aryan Mittal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/finlogue/aryan.jpeg',
          'phone': '+919389618050',
          'email': '24ucs152@lnmiit.ac.in',
        },
      ];
    }

    if (clubName == 'Imagination') {
      return [
        {
          'name': 'Aditya Prakash',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/imagination/imagi_logo.jpg', // Replace with their actual photo path
          'phone': '+919639837550',
          'email': '24uec087@lnmiit.ac.in',
        },
        {
          'name': 'Avirat Kaushik',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/imagination/imagi_logo.jpg', // Replace with their actual photo path
          'phone': '+919311148142',
          'email': '24ucs235@lnmiit.ac.in',
        },
        {
          'name': 'Ayush Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/imagination/imagi_logo.jpg', // Replace with their actual photo path
          'phone': '+917355568914',
          'email': '24ucc171@lnmiit.ac.in',
        },
        {
          'name': 'Siddhesh Chintamani',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/imagination/imagi_logo.jpg', // Replace with their actual photo path
          'phone': '+918485829571',
          'email': '24uec119@lnmiit.ac.in',
        },
      ];
    }

    if(clubName == 'Insignia')
    {
      return [
        {
          'name': 'Ananya Surana',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg', // not updated
          'phone': '+919999999999', // not updated
          'email': '24ucc090@lnmiit.ac.in',
        },
        {
          'name': 'Kavin Goyal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg', // not updated
          'phone': '+918888888888', // not updated
          'email': '24dcs010@lnmiit.ac.in',
        },
        {
          'name': 'Shivansh Singh',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg', // not updated
          'phone': '+917777777777', // not updated
          'email': '24dec049@lnmiit.ac.in',
        },
      ];
    }

    if(clubName == 'Literary Committee')
    {
      return [
        {
          'name': 'Armaan Jain',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/lc/armaan.png',
          'phone': '+919509915121',
          'email': '24ucc192@lnmiit.ac.in',
        },
        {
          'name': 'Mriganka Kothari',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/lc/mriganka.jpeg',
          'phone': '+918824950622',
          'email': '24ucs064@lnmiit.ac.in',
        },
        {
          'name': 'Parth Chaturvedi',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/lc/parth.jpeg',
          'phone': '+918949699205',
          'email': '24ucc160@lnmiit.ac.in',
        },
        {
          'name': 'Poorvi Jagga',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/lc/poorvi.jpeg',
          'phone': '+917413870974',
          'email': '24ume078@lnmiit.ac.in',
        },
      ];
    }

    if(clubName == 'Media Cell')
    {
      return [
        {
          'name': 'Pranav Vashisth',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // Replace with their actual photo path
          'phone': '+918445681853',
          'email': '24ucs126@lnmiit.ac.in',
        },
        {
          'name': 'Praneel Dev',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // Replace with their actual photo path
          'phone': '+918955352024',
          'email': '24ucs202@lnmiit.ac.in',
        },
        {
          'name': 'Samar Goyal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // Replace with their actual photo path
          'phone': '+917300458010',
          'email': '24ucs008@lnmiit.ac.in',
        },
        {
          'name': 'Vedha Sinkar',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg', // Replace with their actual photo path
          'phone': '+919588483298',
          'email': '24ume011@lnmiit.ac.in',
        },
      ];
    }
    
    if(clubName == 'Rendition')
    {
      return [
        {
          'name': 'Madhav Agrawal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/rendition/rendition_logo.png', // Replace with their actual photo path
          'phone': '+919530097783',
          'email': '24ucs213@lnmiit.ac.in',
        },
        {
          'name': 'Nikhila S Hari',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/rendition/rendition_logo.png', // Replace with their actual photo path
          'phone': '+919012233022',
          'email': '24uec163@lnmiit.ac.in',
        },
        {
          'name': 'Shah Manav Tarakkumar',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/rendition/rendition_logo.png', // Replace with their actual photo path
          'phone': '+919825361585',
          'email': '24ucc157@lnmiit.ac.in',
        },
      ];
    }
    
    if(clubName == 'Sankalp')
    {
      return [
        {
          'name': 'Amisha Paliwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/amisha.jpeg',
          'phone': '+917880276227',
          'email': '24ucs076@lnmiit.ac.in',
        },
        {
          'name': 'Arnav Dubey',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/arnav.jpeg',
          'phone': '+91919635976',
          'email': '24ucc197@lnmiit.ac.in',
        },
        {
          'name': 'Gaurav Kalal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/gaurav.jpeg',
          'phone': '+918209019947',
          'email': '24ucs223@lnmiit.ac.in',
        },
        {
          'name': 'Lakshya Chandak',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/lakshya.jpeg', 
          'phone': '+919511506144',
          'email': '24ucc205@lnmiit.ac.in',
        },
        {
          'name': 'Raghav Agarwal',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/sankalp/raghav.jpeg',
          'phone': '+918700335877',
          'email': '24ucs045@lnmiit.ac.in',
        },
      ];
    }
    
    if(clubName == 'Vignette')
    {
      return [
        {
          'name': 'Akshat Mishra',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/vignette/akshat.jpeg',
          'phone': '+917000591995',
          'email': '25ume075@lnmiit.ac.in',
        },
        {
          'name': 'Divyansh Patil',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/vignette/divyansh.jpeg',
          'phone': '+917807772650',
          'email': '25ucc074@lnmiit.ac.in',
        },
        {
          'name': 'Hiya Gera',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/vignette/hiya.jpeg',
          'phone': '+919983550196',
          'email': '25uec256@lnmiit.ac.in',
        },
        {
          'name': 'Jahanvi Garg',
          'role': 'Coordinator',
          'image': 'assets/assets/images/cultural/vignette/jahanvi.jpeg',
          'phone': '+918905823513',
          'email': '25ume032@lnmiit.ac.in',
        },
      ];
    }
    
    // Default fallback list for other clubs until you fill them in
    return [
      {
        'name': '$clubName Coordinator 1',
        'role': 'Club Coordinator',
        'image': 'assets/images/logo.jpeg',
        'phone': '+919876543210',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord1@lnmiit.ac.in',
      },
      {
        'name': '$clubName Coordinator 2',
        'role': 'Co-Coordinator',
        'image': 'assets/images/logo.jpeg',
        'phone': '+918765432109',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord2@lnmiit.ac.in',
      },
      {
        'name': '$clubName Coordinator 3',
        'role': 'Co-Coordinator',
        'image': 'assets/images/logo.jpeg',
        'phone': '+917654321098',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord3@lnmiit.ac.in',
      },
      {
        'name': '$clubName Coordinator 4',
        'role': 'Sub-Coordinator',
        'image': 'assets/images/logo.jpeg',
        'phone': '+916543210987',
        'email': '${clubName.toLowerCase().replaceAll(' ', '')}_coord4@lnmiit.ac.in',
      },
    ];
  }

  static List<String> _getGallery(String clubName) {
    if (clubName == 'Aaveg') {
      return [
        'assets/assets/images/cultural/aaveg/aaveg1.JPG',
        'assets/assets/images/cultural/aaveg/aaveg2.jpg',
        'assets/assets/images/cultural/aaveg/aaeg4.jpg',
        'assets/assets/images/cultural/aaveg/aaveg4.JPG',
        'assets/assets/images/cultural/aaveg/aaveg5.jpg',
        'assets/assets/images/cultural/aaveg/aaveg6.JPG',
        'assets/assets/images/cultural/aaveg/aaveg7.jpg',
      ];
    }
    if (clubName == 'Capriccio') {
      return [
        'assets/assets/images/cultural/capriccio/cap1.jpg',
        'assets/assets/images/cultural/capriccio/cap2.jpg',
        'assets/assets/images/cultural/capriccio/cap3.jpg',
        'assets/assets/images/cultural/capriccio/cap4.jpg',
        'assets/assets/images/cultural/capriccio/cap5.jpg',
        'assets/assets/images/cultural/capriccio/cap6.jpg',
        'assets/assets/images/cultural/capriccio/cap7.jpg',
        'assets/assets/images/cultural/capriccio/cap8.jpg',
        'assets/assets/images/cultural/capriccio/cap9.jpg',
        'assets/assets/images/cultural/capriccio/cap10.jpg',
      ];
    }
    if (clubName == 'Eminence') {
      return [
        'assets/assets/images/cultural/eminence/emin1.jpg',
        'assets/assets/images/cultural/eminence/emin2.jpg',
        'assets/assets/images/cultural/eminence/emin3.jpg',
        'assets/assets/images/cultural/eminence/emin4.jpg',
        'assets/assets/images/cultural/eminence/emin5.jpg',
        'assets/assets/images/cultural/eminence/emin6.jpg',
        'assets/assets/images/cultural/eminence/emin7.jpg',
      ];
    }
    if (clubName == 'Finlogue') {
      return [
        'assets/assets/images/cultural/finlogue/finlogue_logo.jpeg',
        'assets/assets/images/cultural/finlogue/aditya.jpeg',
        'assets/assets/images/cultural/finlogue/aryan.jpeg',
        'assets/assets/images/cultural/finlogue/akshat.jpeg',
      ];
    }
    if (clubName == 'Imagination') {
      return [
        'assets/assets/images/cultural/imagination/imagi1.png',
        'assets/assets/images/cultural/imagination/imagi3.jpg',
        'assets/assets/images/cultural/imagination/imagi5.jpg',
        'assets/assets/images/cultural/imagination/imagi8.jpg',
        'assets/assets/images/cultural/imagination/imagi10.jpg',
      ];
    }
    if (clubName == 'Insignia') {
      return [
        'assets/assets/images/cultural/insignia/insignia1.jpg',
        'assets/assets/images/cultural/insignia/insignia2.jpg',
        'assets/assets/images/cultural/insignia/insignia3.jpg',
        'assets/assets/images/cultural/insignia/insignia4.jpg',
        'assets/assets/images/cultural/insignia/insignia5.jpg',
      ];
    }
    if (clubName == 'Literary Committee') {
      return [
        'assets/assets/images/cultural/lc/lc1.jpeg',
        'assets/assets/images/cultural/lc/lc2.jpeg',
        'assets/assets/images/cultural/lc/lc3.jpeg',
        'assets/assets/images/cultural/lc/lc4.jpeg',
        'assets/assets/images/cultural/lc/lc5.jpeg',
        'assets/assets/images/cultural/lc/lc6.jpeg',
      ];
    }
    if (clubName == 'Media Cell') {
      return [
        'assets/assets/images/cultural/mediacell/media1.jpg',
        'assets/assets/images/cultural/mediacell/media2.jpg',
        'assets/assets/images/cultural/mediacell/media3.jpg',
      ];
    }
    if (clubName == 'Rendition') {
      return [
        'assets/assets/images/cultural/rendition/rendition1.jpg',
        'assets/assets/images/cultural/rendition/rendition2.jpg',
        'assets/assets/images/cultural/rendition/rendition3.jpg',
        'assets/assets/images/cultural/rendition/rendition4.jpg',
      ];
    }
    if (clubName == 'Sankalp') {
      return [
        'assets/assets/images/cultural/sankalp/sankalp1.jpg',
        'assets/assets/images/cultural/sankalp/sankalp2.jpg',
        'assets/assets/images/cultural/sankalp/sankalp3.jpg',
        'assets/assets/images/cultural/sankalp/sankalp5.jpg',
        'assets/assets/images/cultural/sankalp/sankalp6.jpg',
        'assets/assets/images/cultural/sankalp/sankalp8.jpg',
        'assets/assets/images/cultural/sankalp/sankalp9.jpg',
        'assets/assets/images/cultural/sankalp/sankalp10.jpg',
      ];
    }
    if (clubName == 'Vignette') {
      return [
        'assets/assets/images/cultural/vignette/vign1.jpg',
        'assets/assets/images/cultural/vignette/vign2.jpg',
        'assets/assets/images/cultural/vignette/vign3.jpg',
        'assets/assets/images/cultural/vignette/vign4.jpg',
        'assets/assets/images/cultural/vignette/vign5.jpg',
        'assets/assets/images/cultural/vignette/vign6.jpg',
        'assets/assets/images/cultural/vignette/vign7.jpg',
        'assets/assets/images/cultural/vignette/vign8.jpg',
        'assets/assets/images/cultural/vignette/vign9.jpg',
        'assets/assets/images/cultural/vignette/vign10.jpg',
      ];
    }

    return [
      'assets/images/hero_new.jpeg',
      'assets/images/team_poster.jpeg',
      'assets/images/photowalk.jpeg',
    ];
  }

  static final List<Map<String, dynamic>> culturalClubs = [
    {
      'name': 'Aaveg',
      'icon': 'assets/assets/images/cultural/aaveg/aaveg_logo.png',
      'subtitle': 'The Nukkad Mandali of LNMIIT',
      'image': 'assets/assets/images/cultural/aaveg/aaveg_logo.png',
      'coordinators': _getCoordinators('Aaveg'),
      'gallery': _getGallery('Aaveg'),
      'description': "Aaveg is the Nukkad Natak (street play) club of our college, dedicated to creating social awareness through powerful performances. With a team of 20–25 members, we bring important societal issues to life through impactful street plays.We perform not only at various inter-college events but also in public with flashmobs at crowded places",
      'instagram': 'https://www.instagram.com/aaveg_lnmiit/',
      'email': 'aaveg@lnmiit.ac.in',
    },
    {
      'name': 'Capriccio',
      'icon': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg',
      'subtitle': 'The Music Club of LNMIIT',
      'image': 'assets/assets/images/cultural/capriccio/capriccio_logo.jpg',
      'coordinators': _getCoordinators('Capriccio'),
      'gallery': _getGallery('Capriccio'),
      'description': "Step into a world where melodies speak, rhythms connect, and music becomes a way of life. At Capriccio, we’re a tight-knit crew of singers, instrumentalists, and producers who vibe, jam, and grow together. With every session, we create memories, share knowledge, and build bonds that last far beyond college. It’s more than music—it’s family!",
      'instagram': 'https://www.instagram.com/capriccio.lnmiit/',
      'email': 'capriccio@lnmiit.ac.in',
    },
    {
      'name': 'Eminence',
      'icon': 'assets/assets/images/cultural/eminence/eminence_logo.jpg',
      'subtitle': 'The Fashion Club of LNMIIT',
      'image': 'assets/assets/images/cultural/eminence/eminence_logo.jpg',
      'coordinators': _getCoordinators('Eminence'),
      'gallery': _getGallery('Eminence'),
      'description': 'Eminence is a fashion-forward club where style meets passion. From choreographed ramp walks to fashion-themed events, we explore all aspects of fashion. Our club is a space for aspiring models, stylists, and fashion enthusiasts to grow and shine. We believe fashion is not just about clothes — it’s about attitude and identity.',
      'instagram': 'https://www.instagram.com/eminence.lnmiit/',
      'email': 'eminence@lnmiit.ac.in',
    },
    {
      'name': 'Finlogue',
      'icon': 'assets/assets/images/cultural/finlogue/finlogue_logo.jpeg',
      'subtitle': 'Fintech club of LNMIIT',
      'image': 'assets/assets/images/cultural/finlogue/finlogue_logo.jpeg',
      'coordinators': _getCoordinators('Finlogue'),
      'gallery': _getGallery('Finlogue'),
      'description': 'The Fintech Club of LNMIIT, Finlogue, bridges the gap between finance and technology, hosting discussions, workshops, and case study competitions on investments, markets, and blockchain.',
      'instagram': 'https://www.instagram.com/finlogue.lnmiit/',
    },
    {
      'name': 'Imagination',
      'icon': 'assets/assets/images/cultural/imagination/imagi_logo.jpg',
      'subtitle': 'Creative photography and cinematography Club',
      'image': 'assets/assets/images/cultural/imagination/imagination_logo.jpeg',
      'coordinators': _getCoordinators('Imagination'),
      'gallery': _getGallery('Imagination'),
      'description': 'IMAGINATION is the creative photography and cinematography club of The LNM Institute of Information Technology. It is a vibrant community of passionate individuals who explore the world through lenses, pixels, and ideas — turning vision into impactful visuals.',
      'instagram': 'https://www.instagram.com/imagination.lnmiit/',
      'email': 'imagination@lnmiit.ac.in',
    },
    {
      'name': 'Insignia',
      'icon': 'assets/assets/images/cultural/insignia/insignia_logo.jpg',
      'subtitle': 'The Dance Club of LNMIIT',
      'image': 'assets/assets/images/cultural/insignia/insignia_logo.jpg',
      'coordinators': _getCoordinators('Insignia'),
      'gallery': _getGallery('Insignia'),
      'description': "INSIGNIA, the official dance club of LNMIIT, is a powerhouse of passion, rhythm, and relentless dedication. We pour our heart and soul into every move, crafting performances that leave a mark. Winning doesn't matter—shining is.",
      'instagram': 'https://www.instagram.com/insignia_lnm/',
      'email': 'insignia@lnmiit.ac.in',
    },
    {
      'name': 'Literary Committee',
      'icon': 'assets/assets/images/cultural/lc/lc_logo.jpg',
      'subtitle': 'Abode of writers of LNMIIT',
      'image': 'assets/assets/images/cultural/lc/lc_logo.jpg',
      'coordinators': _getCoordinators('Literary Committee'),
      'gallery': _getGallery('Literary Committee'),
      'description': 'Putting the CULT in culture, the Literary Committee is a mosh pit fueled by caffeine-riddled fanatics who walk on walls and drink up aquariums. An isle of those who romanticize Sisyphean suffering while thinking of nostalgia as the closest thing to a home. The Literary Committee does it all—with flair and a touch of melancholy.',
      'instagram': 'https://www.instagram.com/literary.lnmiit/',
      'email': 'literary@lnmiit.ac.in',
    },
    {
      'name': 'Media Cell',
      'icon': 'assets/assets/images/cultural/mediacell/media_logo.jpg',
      'subtitle': 'Anchors whose voice fills auditoriums',
      'image': 'assets/assets/images/cultural/mediacell/media_logo.jpg',
      'coordinators': _getCoordinators('Media Cell'),
      'gallery': _getGallery('Media Cell'),
      'description': 'Media Cell isn’t just a club—it’s a platform for expression. Rooted in the idea of “media” as a medium, it offers students a space to build confidence, stage presence, and spontaneous speaking skills through interactive events. From anchoring major college fests to hosting formats like Doulogue and Knockout Ads, it ensures every voice is heard. At its core, Media Cell turns communication into connection—and gives every voice its medium',
      'instagram': 'https://www.instagram.com/mediacell_lnmiit/',
      'email': 'mediacell@lnmiit.ac.in',
    },
    {
      'name': 'Rendition',
      'icon': 'assets/assets/images/cultural/rendition/rendition_logo.png',
      'subtitle': 'The Theatre Society of LNMIIT',
      'image': 'assets/assets/images/cultural/rendition/rendition_logo.png',
      'coordinators': _getCoordinators('Rendition'),
      'gallery': _getGallery('Rendition'),
      'description': 'Rendition is the theatre club of LNMIIT, where stories come alive on stage. From expressive mime performances and powerful monoacts to engaging stage plays, the club celebrates the art of acting in all its forms. We believe in the magic of live performance and the ability of theatre to connect, inspire, and transform. Whether through silent gestures or commanding dialogues, Rendition gives voice to creativity and passion.',
      'instagram': 'https://www.instagram.com/rendition_lnmiit/',
      'email': 'rendition@lnmiit.ac.in',
    },
    {
      'name': 'Sankalp',
      'icon': 'assets/assets/images/cultural/sankalp/sankalp_logo.jpg',
      'subtitle': 'Social WelfareClub of LNMIIT',
      'image': 'assets/assets/images/cultural/sankalp/sankalp_logo.jpg',
      'coordinators': _getCoordinators('Sankalp'),
      'gallery': _getGallery('Sankalp'),
      'description': 'Sankalp is the social club of our college, driven by the spirit of service and compassion. We work to educate underprivileged children in nearby villages, uplift mess workers through literacy programs, and lead initiatives like cloth distribution. At Sankalp, we believe in turning intentions into actions and building a better tomorrow—one life at a time.',
      'instagram': 'https://www.instagram.com/sankalp.lnmiit/',
      'email': 'sankalp@lnmiit.ac.in',
    },
    {
      'name': 'Vignette',
      'icon': 'assets/assets/images/cultural/vignette/logo_unit.png',
      'subtitle': 'Art & Design club of LNMIIT',
      'image': 'assets/assets/images/cultural/vignette/logo_unit.png',
      'coordinators': _getCoordinators('Vignette'),
      'gallery': _getGallery('Vignette'),
      'description': 'Vignette - the Art and Craft Club of LNMIIT, is the creative heart of the campus. Its vibrant artworks bring the campus to life, adding color, energy, and character to every corner. From sketching on sheets to painting walls and even faces, it’s a space where imagination feels at home. With a canvas, a piece of fabric, or just an idea, you are free to create, in your own way.',
      'instagram': 'https://www.instagram.com/vignette_lnmiit/',
      'email': 'vignette@lnmiit.ac.in',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFF050816),
      appBar: AppBar(
        backgroundColor: const Color(0xFF050816),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'CULTURAL CLUBS',
          style: GoogleFonts.playfairDisplay(
            color: Colors.redAccent,
            fontSize: isMobile ? 22 : 38,
            letterSpacing: isMobile ? 2 : 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: isMobile ? 16 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXPLORE CULTURAL CLUBS',
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: isMobile ? 24 : 32,
                      letterSpacing: isMobile ? 1 : 2,
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double parentWidth = constraints.maxWidth;
                      int crossAxisCount = 1;
                      if (parentWidth >= 1100) {
                        crossAxisCount = 4;
                      } else if (parentWidth >= 600) {
                        crossAxisCount = 2;
                      } else {
                        crossAxisCount = 1;
                      }

                      // Calculate item width dynamically
                      double cardWidth = (parentWidth - (crossAxisCount - 1) * 20) / crossAxisCount;

                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: culturalClubs.map((club) {
                          return SizedBox(
                            width: cardWidth,
                            child: _buildClubCard(context, club),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClubCard(BuildContext context, Map<String, dynamic> club) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    final String clubName = club['name'] as String;
    final String clubImage = club['image'] as String;
    final String clubIcon = club['icon'] as String;
    final String clubSubtitle = club['subtitle'] as String;
    final String clubDescription = club['description'] as String? ?? '';
    final List<Map<String, String>> coordinators = List<Map<String, String>>.from(
      (club['coordinators'] as List).map(
        (item) => Map<String, String>.from(item as Map),
      ),
    );
    final List<String> galleryImages = List<String>.from(club['gallery'] as List);
    final String clubInstagram = club['instagram'] as String? ?? 'https://instagram.com/${clubName.toLowerCase().replaceAll(' ', '').replaceAll('-', '')}_lnmiit';
    final String clubEmail = club['email'] as String? ?? '${clubName.toLowerCase().replaceAll(' ', '').replaceAll('-', '')}@lnmiit.ac.in';

    void onCardTap() {
      Navigator.pushNamed(
        context,
        '/cultural_detail',
        arguments: {
          'clubName': clubName,
          'clubImage': clubImage,
          'coordinators': coordinators,
          'galleryImages': galleryImages,
          'description': clubDescription,
          'instagram': clubInstagram,
          'email': clubEmail,
        },
      );
    }

    if (isMobile) {
      // Sleek horizontal list card for mobile app
      return GestureDetector(
        onTap: onCardTap,
        child: GlassCard(
          borderRadius: BorderRadius.circular(16),
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.redAccent, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withValues(alpha: 0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    clubIcon,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: const Icon(
                          Icons.image_not_supported,
                          color: Colors.white54,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      clubName,
                      style: GoogleFonts.playfairDisplay(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      clubSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.redAccent,
                size: 16,
              ),
            ],
          ),
        ),
      );
    }

    // Original vertical layout for desktop/web
    return GestureDetector(
      onTap: onCardTap,
      child: GlassCard(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.redAccent, width: 2.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withValues(alpha: 0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        clubIcon,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.white54,
                              size: 60,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clubName,
                    style: GoogleFonts.playfairDisplay(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    clubSubtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: onCardTap,
                      child: Text(
                        'VIEW CLUB',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

