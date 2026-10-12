import fs from 'fs';

const verifiedCatalogue = JSON.parse(fs.readFileSync('src/data/verifiedCatalogue.json', 'utf8'));

// Slug to Category ID mapping in mockData
const categorySlugToId = {
  'fever-body-pain': 'cat-1',
  'cough-cold': 'cat-2',
  'headache-migraine': 'cat-3',
  'acidity-gas': 'cat-4',
  'stomach-digestion': 'cat-5',
  'allergy-care': 'cat-6',
  'diabetes-care': 'cat-7',
  'blood-pressure-heart-care': 'cat-8',
  'thyroid-care': 'cat-9',
  'vitamin-nutrition': 'cat-10',
  'immunity-wellness': 'cat-11',
  'skin-care': 'cat-12',
  'hair-care': 'cat-13',
  'eye-care': 'cat-14',
  'ear-nose-care': 'cat-15',
  'dental-oral-care': 'cat-16',
  'baby-care': 'cat-17',
  'womens-healthcare': 'cat-18',
  'mens-healthcare': 'cat-19',
  'pregnancy-mother-care': 'cat-20',
  'pain-relief': 'cat-21',
  'orthopedic-care': 'cat-22',
  'first-aid': 'cat-23',
  'surgical-products': 'cat-24',
  'medical-devices': 'cat-25',
  'ayurvedic-herbal-products': 'cat-26',
  'personal-care': 'cat-27',
  'hygiene-products': 'cat-28',
};

// Map into Medicine type
const medicines = verifiedCatalogue.map((item, idx) => {
  const catId = categorySlugToId[item.categorySlug] || 'cat-1';
  // Keep med-1, med-2, med-4 IDs for demo orders or assign med-(idx+1)
  const medId = `med-${idx + 1}`;
  return {
    id: medId,
    name: item.name,
    slug: item.slug,
    brand: item.brand,
    genericName: item.genericName,
    composition: item.composition,
    categoryId: catId,
    categoryName: item.categoryName,
    manufacturer: item.manufacturer,
    packSize: item.packSize,
    mrp: item.mrp,
    sellingPrice: item.sellingPrice,
    stockQuantity: 0, // Unverified initial inventory - shop owner verification required
    batchNumber: 'CATALOGUE-VERIFIED',
    expiryDate: '2028-12-31',
    prescriptionRequired: item.prescriptionRequired,
    description: item.description,
    dosageGuidelines: item.dosageGuidelines,
    storageInstructions: item.storageInstructions,
    status: 'active',
    isDemo: true,
    featured: idx < 10, // feature first 10 items on homepage
  };
});

// Calculate product count per category
const countsPerCat = {};
for (const m of medicines) {
  countsPerCat[m.categoryId] = (countsPerCat[m.categoryId] || 0) + 1;
}

console.log('Product counts per category:', countsPerCat);

// Let's generate the updated mockData.ts content
const existingContent = fs.readFileSync('src/data/mockData.ts', 'utf8');

// We need to keep:
// 1. imports
// 2. initialShopSettings
// 3. initialCategories with accurate counts
// 4. initialMedicines with the 194 verified items
// 5. initialOrders (ensure medicineId references valid med IDs)
// 6. initialPrescriptions, initialEnquiries, initialInventory

const updatedOrders = `export const initialOrders: Order[] = [
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
];`;

// Extract parts of mockData
const shopSettingsMatch = existingContent.match(/export const initialShopSettings: ShopSettings = \{[\s\S]*?\};\n/);
const categoriesDefMatch = existingContent.match(/export const initialCategories: Category\[\] = \[([\s\S]*?)\];\n\nexport const initialMedicines/);
const prescriptionsMatch = existingContent.match(/export const initialPrescriptions: PrescriptionRequest\[\] = \[[\s\S]*?$/);

if (!shopSettingsMatch || !categoriesDefMatch || !prescriptionsMatch) {
  console.error('Could not match sections in mockData.ts');
  process.exit(1);
}

// Update category productCounts
const rawCategories = categoriesDefMatch[1];
const updatedCategories = rawCategories.replace(/id: '(cat-\d+)',[\s\S]*?productCount: \d+,/g, (match, catId) => {
  const count = countsPerCat[catId] || 0;
  return match.replace(/productCount: \d+,/, `productCount: ${count},`);
});

const newMockData = `import { Category, Medicine, ShopSettings, Order, PrescriptionRequest, CustomerEnquiry, InventoryBatch } from '@/types';

${shopSettingsMatch[0]}
export const initialCategories: Category[] = [${updatedCategories}];

export const initialMedicines: Medicine[] = ${JSON.stringify(medicines, null, 2)};

${updatedOrders}

${prescriptionsMatch[0]}`;

fs.writeFileSync('src/data/mockData.ts', newMockData, 'utf8');
console.log('Successfully updated src/data/mockData.ts with 194 verified medicines and accurate category counts!');
