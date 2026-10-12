import { Category, Medicine, ShopSettings, Order, PrescriptionRequest, CustomerEnquiry, InventoryBatch } from '@/types';
import verifiedCatalog from './verifiedCatalogue.json';

export const initialShopSettings: ShopSettings = {
  shopName: 'Durga Medical Hall',
  tagline: 'Quality Medicines & Healthcare Products in Village Kubri',
  addressVillage: 'Village – Kubri',
  addressPost: 'Post – Kubri',
  addressPanchayat: 'Panchayat – Makdiha',
  addressDistrict: 'District – Giridih',
  addressState: 'Jharkhand',
  pincode: '825418',
  country: 'India',
  phone: '9939183629',
  whatsapp: '919939183629',
  pharmacistName: 'Dr. Ravindra Kumar Rana',
  email: '[ADD EMAIL]',
  openingTime: '[ADD OPENING TIME - e.g. 8:00 AM]',
  closingTime: '[ADD CLOSING TIME - e.g. 9:00 PM]',
  weeklyHoliday: '[ADD WEEKLY HOLIDAY - e.g. Open 7 Days / Sunday Half Day]',
  googleMapsUrl: 'https://maps.google.com/?q=Kubri,Giridih,Jharkhand,825418',
  gstNumber: '[TO BE PROVIDED IF APPLICABLE]',
  drugLicenseNumber: '[TO BE PROVIDED IF APPLICABLE]',
  homeDeliveryAvailable: true,
  deliveryArea: 'Village Kubri, Makdiha Panchayat & adjacent villages within 5-8 km',
  deliveryCharge: 'Free for Kubri center / Nominal for peripheral areas (To be confirmed on order)',
  onlinePaymentAvailable: false, // In-store cash / UPI on delivery
  socialFacebook: '[TO BE PROVIDED]',
  socialInstagram: '[TO BE PROVIDED]',
  seoTitle: 'Durga Medical Hall | Medical Store in Kubri, Giridih, Jharkhand',
  seoDescription: 'Durga Medical Hall, Kubri, Giridih, Jharkhand – medicines, healthcare products, medicine enquiry, prescription upload and local pharmacy services.',
  googleAnalyticsId: '',
  googleSearchConsoleTag: '',
};

const categorySlugToId: Record<string, string> = {
  "fever-pain-relief": "cat-1",
  "cough-cold-flu": "cat-2",
  "antibiotics-anti-infectives": "cat-3",
  "digestion-stomach-care": "cat-4",
  "vitamins-supplements": "cat-5",
  "skin-care-dermatology": "cat-6",
  "diabetes-care": "cat-7",
  "heart-blood-pressure": "cat-8",
  "respiratory-asthma": "cat-9",
  "eye-ear-nasal-drops": "cat-10",
  "mother-baby-care": "cat-11",
  "womens-health": "cat-12",
  "mens-health": "cat-13",
  "elderly-care-mobility": "cat-14",
  "first-aid-wound-care": "cat-15",
  "pain-sprays-ointments": "cat-16",
  "oral-care": "cat-17",
  "immunity-general-wellness": "cat-18",
  "ayurvedic-herbal-care": "cat-19",
  "kidney-urinary-care": "cat-20",
  "liver-care": "cat-21",
  "mental-wellness-sleep": "cat-22",
  "orthopedic-supports-braces": "cat-23",
  "medical-devices-monitors": "cat-24",
  "surgicals-disposables": "cat-25",
  "personal-hygiene-sanitisers": "cat-26",
  "nutritional-drinks-powders": "cat-27",
  "emergency-otc-support": "cat-28"
};

export const initialMedicines: Medicine[] = (verifiedCatalog as Array<{
  name: string;
  slug: string;
  brand: string;
  genericName: string;
  composition: string;
  categorySlug: string;
  categoryName: string;
  manufacturer: string;
  packSize: string;
  mrp: number;
  sellingPrice: number;
  prescriptionRequired: boolean;
  description: string;
  dosageGuidelines: string;
  storageInstructions: string;
}>).map((item, idx) => ({
  id: `med-${idx + 1}`,
  name: item.name,
  slug: item.slug,
  brand: item.brand,
  genericName: item.genericName,
  composition: item.composition,
  categoryId: categorySlugToId[item.categorySlug] || 'cat-1',
  categoryName: item.categoryName,
  manufacturer: item.manufacturer,
  packSize: item.packSize,
  mrp: item.mrp,
  sellingPrice: item.sellingPrice,
  stockQuantity: 0,
  batchNumber: 'CATALOGUE-VERIFIED',
  expiryDate: '2028-12-31',
  prescriptionRequired: item.prescriptionRequired,
  description: item.description,
  dosageGuidelines: item.dosageGuidelines,
  storageInstructions: item.storageInstructions,
  status: 'active',
  isDemo: true,
  featured: idx < 10,
}));

// Pre-calculate accurate product counts
const categoryCounts: Record<string, number> = {};
initialMedicines.forEach((m) => {
  categoryCounts[m.categoryId] = (categoryCounts[m.categoryId] || 0) + 1;
});

export const initialCategories: Category[] = [
  {
    "id": "cat-1",
    "name": "Fever & Pain Relief",
    "slug": "fever-pain-relief",
    "description": "Medicines for temperature control, headaches, body ache, and inflammatory pain",
    "iconName": "Thermometer",
    "productCount": 13,
    "displayOrder": 1,
    "status": "active"
  },
  {
    "id": "cat-2",
    "name": "Cough, Cold & Flu",
    "slug": "cough-cold-flu",
    "description": "Syrups, tablets, and lozenges for seasonal allergies, sore throat, and congestion",
    "iconName": "Wind",
    "productCount": 11,
    "displayOrder": 2,
    "status": "active"
  },
  {
    "id": "cat-3",
    "name": "Antibiotics & Anti-infectives",
    "slug": "antibiotics-anti-infectives",
    "description": "Prescription antimicrobials to fight bacterial, fungal, and parasitic infections",
    "iconName": "ShieldAlert",
    "productCount": 9,
    "displayOrder": 3,
    "status": "active"
  },
  {
    "id": "cat-4",
    "name": "Digestion & Stomach Care",
    "slug": "digestion-stomach-care",
    "description": "Antacids, digestive enzymes, anti-spasmodic, and gas/acidity formulations",
    "iconName": "Pill",
    "productCount": 10,
    "displayOrder": 4,
    "status": "active"
  },
  {
    "id": "cat-5",
    "name": "Vitamins, Minerals & Supplements",
    "slug": "vitamins-supplements",
    "description": "Multivitamins, Vitamin D3, B-Complex, Calcium, and nutritional boosters",
    "iconName": "Sparkles",
    "productCount": 7,
    "displayOrder": 5,
    "status": "active"
  },
  {
    "id": "cat-6",
    "name": "Skin Care & Dermatologicals",
    "slug": "skin-care-dermatology",
    "description": "Topical antifungals, antibacterial ointments, soothing creams, and moisturizers",
    "iconName": "Sparkles",
    "productCount": 9,
    "displayOrder": 6,
    "status": "active"
  },
  {
    "id": "cat-7",
    "name": "Diabetes Care",
    "slug": "diabetes-care",
    "description": "Blood glucose management tablets, testing strips, insulin accessories",
    "iconName": "Activity",
    "productCount": 7,
    "displayOrder": 7,
    "status": "active"
  },
  {
    "id": "cat-8",
    "name": "Heart & Blood Pressure",
    "slug": "heart-blood-pressure",
    "description": "Prescription antihypertensives, cholesterol regulators, and cardiovascular care",
    "iconName": "Heart",
    "productCount": 7,
    "displayOrder": 8,
    "status": "active"
  },
  {
    "id": "cat-9",
    "name": "Respiratory & Asthma",
    "slug": "respiratory-asthma",
    "description": "Bronchodilators, inhalers, rotacaps, and anti-allergic respiratory syrups",
    "iconName": "Wind",
    "productCount": 4,
    "displayOrder": 9,
    "status": "active"
  },
  {
    "id": "cat-10",
    "name": "Eye, Ear & Nasal Drops",
    "slug": "eye-ear-nasal-drops",
    "description": "Soothing and antibacterial drops for allergies, irritation, and dryness",
    "iconName": "Eye",
    "productCount": 9,
    "displayOrder": 10,
    "status": "active"
  },
  {
    "id": "cat-11",
    "name": "Mother & Baby Care",
    "slug": "mother-baby-care",
    "description": "Baby nutrition, diaper rash creams, lactation support, and gentle pediatric care",
    "iconName": "Baby",
    "productCount": 13,
    "displayOrder": 11,
    "status": "active"
  },
  {
    "id": "cat-12",
    "name": "Women's Health",
    "slug": "womens-health",
    "description": "Period care, hormonal balance, pregnancy test strips, iron supplements",
    "iconName": "Heart",
    "productCount": 4,
    "displayOrder": 12,
    "status": "active"
  },
  {
    "id": "cat-13",
    "name": "Men's Health",
    "slug": "mens-health",
    "description": "Nutritional vitality, daily endurance, prostate support, and vigor care",
    "iconName": "Activity",
    "productCount": 3,
    "displayOrder": 13,
    "status": "active"
  },
  {
    "id": "cat-14",
    "name": "Elderly Care & Mobility",
    "slug": "elderly-care-mobility",
    "description": "Joint lubricants, walking aids, heating belts, calcium formulations",
    "iconName": "Users",
    "productCount": 6,
    "displayOrder": 14,
    "status": "active"
  },
  {
    "id": "cat-15",
    "name": "First Aid & Wound Care",
    "slug": "first-aid-wound-care",
    "description": "Sterile bandages, antiseptics, povidone-iodine, surgical tape, and dressings",
    "iconName": "Cross",
    "productCount": 8,
    "displayOrder": 15,
    "status": "active"
  },
  {
    "id": "cat-16",
    "name": "Pain Relief Sprays & Ointments",
    "slug": "pain-sprays-ointments",
    "description": "Topical analgesic gels, hot rub ointments, liniments, and herbal spray formulas",
    "iconName": "Flame",
    "productCount": 7,
    "displayOrder": 16,
    "status": "active"
  },
  {
    "id": "cat-17",
    "name": "Oral Care",
    "slug": "oral-care",
    "description": "Medicated toothpastes, chlorhexidine mouthwashes, gum astringents",
    "iconName": "Smile",
    "productCount": 7,
    "displayOrder": 17,
    "status": "active"
  },
  {
    "id": "cat-18",
    "name": "Immunity & General Wellness",
    "slug": "immunity-general-wellness",
    "description": "Chyawanprash, herbal extracts, zinc tablets, daily immune defense",
    "iconName": "ShieldCheck",
    "productCount": 6,
    "displayOrder": 18,
    "status": "active"
  },
  {
    "id": "cat-19",
    "name": "Ayurvedic & Herbal Care",
    "slug": "ayurvedic-herbal-care",
    "description": "Traditional classical ayurvedic syrups, churnas, and botanical extracts",
    "iconName": "Leaf",
    "productCount": 11,
    "displayOrder": 19,
    "status": "active"
  },
  {
    "id": "cat-20",
    "name": "Kidney & Urinary Care",
    "slug": "kidney-urinary-care",
    "description": "Alkalizers, urinary antiseptics, herbal stone formulations, hydration salts",
    "iconName": "Droplet",
    "productCount": 1,
    "displayOrder": 20,
    "status": "active"
  },
  {
    "id": "cat-21",
    "name": "Liver Care",
    "slug": "liver-care",
    "description": "Hepatoprotective syrups, silymarin extracts, digestive tonics",
    "iconName": "Activity",
    "productCount": 1,
    "displayOrder": 21,
    "status": "active"
  },
  {
    "id": "cat-22",
    "name": "Mental Wellness & Sleep Support",
    "slug": "mental-wellness-sleep",
    "description": "Stress adaptogens, melatonin supplements, nerve calming tonics",
    "iconName": "Moon",
    "productCount": 1,
    "displayOrder": 22,
    "status": "active"
  },
  {
    "id": "cat-23",
    "name": "Orthopedic Supports & Braces",
    "slug": "orthopedic-supports-braces",
    "description": "Knee caps, crepe bandages, lumbar belts, cervical collars, wrist wraps",
    "iconName": "Shield",
    "productCount": 7,
    "displayOrder": 23,
    "status": "active"
  },
  {
    "id": "cat-24",
    "name": "Medical Devices & Monitors",
    "slug": "medical-devices-monitors",
    "description": "Digital thermometers, BP monitors, glucometers, vaporizers, pulse oximeters",
    "iconName": "Activity",
    "productCount": 5,
    "displayOrder": 24,
    "status": "active"
  },
  {
    "id": "cat-25",
    "name": "Surgicals & Disposables",
    "slug": "surgicals-disposables",
    "description": "Gloves, syringes, IV sets, cotton rolls, urine bags, surgical masks",
    "iconName": "Stethoscope",
    "productCount": 8,
    "displayOrder": 25,
    "status": "active"
  },
  {
    "id": "cat-26",
    "name": "Personal Hygiene & Sanitisers",
    "slug": "personal-hygiene-sanitisers",
    "description": "Alcohol hand rubs, antiseptic washes, wet wipes, personal cleanliness products",
    "iconName": "Sparkles",
    "productCount": 13,
    "displayOrder": 26,
    "status": "active"
  },
  {
    "id": "cat-27",
    "name": "Nutritional Drinks & Powders",
    "slug": "nutritional-drinks-powders",
    "description": "Protein powders, diabetic health drinks, pediatric nutritional formulations",
    "iconName": "Coffee",
    "productCount": 4,
    "displayOrder": 27,
    "status": "active"
  },
  {
    "id": "cat-28",
    "name": "Emergency & Critical OTC Support",
    "slug": "emergency-otc-support",
    "description": "Oral rehydration salts (ORS), emergency antiallergics, wound washes",
    "iconName": "AlertTriangle",
    "productCount": 3,
    "displayOrder": 28,
    "status": "active"
  }
];

// Re-assign accurate calculated product counts
initialCategories.forEach(c => {
  c.productCount = categoryCounts[c.id] || 0;
});

export const initialOrders: Order[] = [
  {
    id: 'ord-101',
    orderNumber: 'DMH-2026-001',
    customerName: 'Ramesh Kumar Verma',
    mobile: '98XXXXXXXX',
    email: 'ramesh.verma@example.com',
    items: [
      {
        medicineId: 'med-1',
        medicineName: 'Dolo 650 Tablet',
        quantity: 2,
        priceEstimate: 62.0,
      },
      {
        medicineId: 'med-8',
        medicineName: 'Benadryl Cough Syrup 100ml',
        quantity: 1,
        priceEstimate: 124.0,
      },
    ],
    preference: 'Pickup at Kubri Store',
    address: 'Near Makdiha Panchayat Bhavan, Kubri, Giridih',
    status: 'Confirmed',
    createdAt: '2026-10-06T10:30:00.000Z',
    internalNotes: 'Customer will pick up after 5 PM. Verified in stock.',
  },
  {
    id: 'ord-102',
    orderNumber: 'DMH-2026-002',
    customerName: 'Sunita Devi',
    mobile: '94XXXXXXXX',
    items: [
      {
        medicineId: 'med-4',
        medicineName: 'Combiflam Tablet',
        quantity: 1,
        priceEstimate: 44.0,
      },
    ],
    prescriptionFileName: 'dr_prescription_sunita.jpg',
    preference: 'Local Home Delivery (Subject to Area)',
    address: 'Village Kubri, Middle Tola, Giridih 825418',
    status: 'Pending',
    createdAt: '2026-10-06T14:15:00.000Z',
    internalNotes: 'Prescription verification required before dispatch.',
  },
];

export const initialPrescriptions: PrescriptionRequest[] = [
  {
    id: 'rx-201',
    requestId: 'RX-2026-001',
    customerName: 'Manoj Kumar Sharma',
    mobile: '97XXXXXXXX',
    email: 'manoj.sharma@example.com',
    fileName: 'prescription_manoj_sep26.pdf',
    fileType: 'application/pdf',
    fileSize: 420000,
    orderDetails: 'Need 1 month course of BP tablet and multivitamin prescribed by Dr. Roy, Giridih.',
    deliveryAddress: 'Village Kubri, Post Kubri, Giridih 825418',
    status: 'Verified',
    createdAt: '2026-10-05T14:20:00.000Z',
    internalNotes: 'Prescription valid till Dec 2026. Telephonically confirmed with customer.',
  },
  {
    id: 'rx-202',
    requestId: 'RX-2026-002',
    customerName: 'Pooja Kumari',
    mobile: '96XXXXXXXX',
    fileName: 'clinic_slip_page1.jpg',
    fileType: 'image/jpeg',
    fileSize: 850000,
    orderDetails: 'Ear drops and anti-allergic medication prescribed for child.',
    deliveryAddress: 'Kubri School Tola, Giridih',
    status: 'Pending Review',
    createdAt: '2026-10-07T10:45:00.000Z',
    internalNotes: 'Need to review doctor signature and dosage instructions.',
  },
];

export const initialEnquiries: CustomerEnquiry[] = [
  {
    id: 'enq-301',
    customerName: 'Vikram Singh',
    mobile: '93XXXXXXXX',
    medicineInterested: 'Digital Blood Pressure Monitor',
    message: 'Do you provide warranty on the digital BP machine? Can I pay cash at your Kubri shop?',
    createdAt: '2026-10-06T16:10:00.000Z',
    status: 'Contacted',
    adminResponse: 'Informed customer that 1-year manufacturer warranty is included and cash payment at counter is available.',
  },
  {
    id: 'enq-302',
    customerName: 'Pramod Mandal',
    mobile: '99XXXXXXXX',
    medicineInterested: 'Veterinary / Cattle supplements',
    message: 'Do you keep animal calcium feed supplements or only human medicines?',
    createdAt: '2026-10-07T08:30:00.000Z',
    status: 'New',
  },
];

export const initialInventory: InventoryBatch[] = [
  {
    id: 'inv-1',
    medicineId: 'med-1',
    medicineName: 'Paracetamol 650mg Tablet',
    batchNumber: 'DEMO-BT2026-01',
    manufacturingDate: '2025-08-15',
    expiryDate: '2027-08-31',
    stockQuantity: 120,
    mrp: 35.0,
    purchasePrice: 24.0,
    sellingPrice: 31.5,
    status: 'In Stock',
  },
  {
    id: 'inv-2',
    medicineId: 'med-2',
    medicineName: 'Amoxicillin and Potassium Clavulanate 625mg',
    batchNumber: 'DEMO-CLAV-88',
    manufacturingDate: '2025-05-01',
    expiryDate: '2027-04-30',
    stockQuantity: 45,
    mrp: 210.0,
    purchasePrice: 155.0,
    sellingPrice: 189.0,
    status: 'In Stock',
  },
  {
    id: 'inv-3',
    medicineId: 'med-7',
    medicineName: 'Digital Blood Pressure Monitor',
    batchNumber: 'DEMO-BPM-12',
    manufacturingDate: '2025-10-10',
    expiryDate: '2030-12-31',
    stockQuantity: 4,
    mrp: 1850.0,
    purchasePrice: 1300.0,
    sellingPrice: 1599.0,
    status: 'Low Stock',
  },
  {
    id: 'inv-4',
    medicineId: 'med-6',
    medicineName: 'Accu-Chek Blood Glucose Test Strips (Demo)',
    batchNumber: 'DEMO-STRP-55',
    manufacturingDate: '2025-04-01',
    expiryDate: '2027-03-31',
    stockQuantity: 8,
    mrp: 950.0,
    purchasePrice: 720.0,
    sellingPrice: 840.0,
    status: 'Low Stock',
  },
];
