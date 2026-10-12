-- ==============================================================================
-- DURGA MEDICAL HALL - Medicine Product Catalogue Seed (Canonical 28 Categories)
-- Location: Village Kubri, Post Kubri, Panchayat Makdiha, Giridih, Jharkhand 825418
--
-- File: supabase/medicine_catalog_seed.sql
-- Idempotent: Yes (Uses ON CONFLICT (slug) DO UPDATE)
-- Total Products: 194 entries covering all 28 canonical health categories
-- ==============================================================================

-- 1. Ensure the Canonical 28 Health Categories Exist
INSERT INTO public.categories (name, slug, description, icon_name, display_order, status)
VALUES
  ('Fever & Pain Relief', 'fever-pain-relief', 'Medicines for temperature control, headaches, body ache, and inflammatory pain', 'Thermometer', 1, 'active'),
  ('Cough, Cold & Flu', 'cough-cold-flu', 'Syrups, tablets, and lozenges for seasonal allergies, sore throat, and congestion', 'Wind', 2, 'active'),
  ('Antibiotics & Anti-infectives', 'antibiotics-anti-infectives', 'Prescription antimicrobials to fight bacterial, fungal, and parasitic infections', 'ShieldAlert', 3, 'active'),
  ('Digestion & Stomach Care', 'digestion-stomach-care', 'Antacids, digestive enzymes, anti-spasmodic, and gas/acidity formulations', 'Pill', 4, 'active'),
  ('Vitamins, Minerals & Supplements', 'vitamins-supplements', 'Multivitamins, Vitamin D3, B-Complex, Calcium, and nutritional boosters', 'Sparkles', 5, 'active'),
  ('Skin Care & Dermatologicals', 'skin-care-dermatology', 'Topical antifungals, antibacterial ointments, soothing creams, and moisturizers', 'Sparkles', 6, 'active'),
  ('Diabetes Care', 'diabetes-care', 'Blood glucose management tablets, testing strips, insulin accessories', 'Activity', 7, 'active'),
  ('Heart & Blood Pressure', 'heart-blood-pressure', 'Prescription antihypertensives, cholesterol regulators, and cardiovascular care', 'Heart', 8, 'active'),
  ('Respiratory & Asthma', 'respiratory-asthma', 'Bronchodilators, inhalers, rotacaps, and anti-allergic respiratory syrups', 'Wind', 9, 'active'),
  ('Eye, Ear & Nasal Drops', 'eye-ear-nasal-drops', 'Soothing and antibacterial drops for allergies, irritation, and dryness', 'Eye', 10, 'active'),
  ('Mother & Baby Care', 'mother-baby-care', 'Baby nutrition, diaper rash creams, lactation support, and gentle pediatric care', 'Baby', 11, 'active'),
  ('Women''s Health', 'womens-health', 'Period care, hormonal balance, pregnancy test strips, iron supplements', 'Heart', 12, 'active'),
  ('Men''s Health', 'mens-health', 'Nutritional vitality, daily endurance, prostate support, and vigor care', 'Activity', 13, 'active'),
  ('Elderly Care & Mobility', 'elderly-care-mobility', 'Joint lubricants, walking aids, heating belts, calcium formulations', 'Users', 14, 'active'),
  ('First Aid & Wound Care', 'first-aid-wound-care', 'Sterile bandages, antiseptics, povidone-iodine, surgical tape, and dressings', 'Cross', 15, 'active'),
  ('Pain Relief Sprays & Ointments', 'pain-sprays-ointments', 'Topical analgesic gels, hot rub ointments, liniments, and herbal spray formulas', 'Flame', 16, 'active'),
  ('Oral Care', 'oral-care', 'Medicated toothpastes, chlorhexidine mouthwashes, gum astringents', 'Smile', 17, 'active'),
  ('Immunity & General Wellness', 'immunity-general-wellness', 'Chyawanprash, herbal extracts, zinc tablets, daily immune defense', 'ShieldCheck', 18, 'active'),
  ('Ayurvedic & Herbal Care', 'ayurvedic-herbal-care', 'Traditional classical ayurvedic syrups, churnas, and botanical extracts', 'Leaf', 19, 'active'),
  ('Kidney & Urinary Care', 'kidney-urinary-care', 'Alkalizers, urinary antiseptics, herbal stone formulations, hydration salts', 'Droplet', 20, 'active'),
  ('Liver Care', 'liver-care', 'Hepatoprotective syrups, silymarin extracts, digestive tonics', 'Activity', 21, 'active'),
  ('Mental Wellness & Sleep Support', 'mental-wellness-sleep', 'Stress adaptogens, melatonin supplements, nerve calming tonics', 'Moon', 22, 'active'),
  ('Orthopedic Supports & Braces', 'orthopedic-supports-braces', 'Knee caps, crepe bandages, lumbar belts, cervical collars, wrist wraps', 'Shield', 23, 'active'),
  ('Medical Devices & Monitors', 'medical-devices-monitors', 'Digital thermometers, BP monitors, glucometers, vaporizers, pulse oximeters', 'Activity', 24, 'active'),
  ('Surgicals & Disposables', 'surgicals-disposables', 'Gloves, syringes, IV sets, cotton rolls, urine bags, surgical masks', 'Stethoscope', 25, 'active'),
  ('Personal Hygiene & Sanitisers', 'personal-hygiene-sanitisers', 'Alcohol hand rubs, antiseptic washes, wet wipes, personal cleanliness products', 'Sparkles', 26, 'active'),
  ('Nutritional Drinks & Powders', 'nutritional-drinks-powders', 'Protein powders, diabetic health drinks, pediatric nutritional formulations', 'Coffee', 27, 'active'),
  ('Emergency & Critical OTC Support', 'emergency-otc-support', 'Oral rehydration salts (ORS), emergency antiallergics, wound washes', 'AlertTriangle', 28, 'active')
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  icon_name = EXCLUDED.icon_name,
  display_order = EXCLUDED.display_order,
  status = 'active';

-- Deactivate any redundant category slugs
UPDATE public.categories
SET status = 'inactive'
WHERE slug NOT IN (
  'fever-pain-relief',
  'cough-cold-flu',
  'antibiotics-anti-infectives',
  'digestion-stomach-care',
  'vitamins-supplements',
  'skin-care-dermatology',
  'diabetes-care',
  'heart-blood-pressure',
  'respiratory-asthma',
  'eye-ear-nasal-drops',
  'mother-baby-care',
  'womens-health',
  'mens-health',
  'elderly-care-mobility',
  'first-aid-wound-care',
  'pain-sprays-ointments',
  'oral-care',
  'immunity-general-wellness',
  'ayurvedic-herbal-care',
  'kidney-urinary-care',
  'liver-care',
  'mental-wellness-sleep',
  'orthopedic-supports-braces',
  'medical-devices-monitors',
  'surgicals-disposables',
  'personal-hygiene-sanitisers',
  'nutritional-drinks-powders',
  'emergency-otc-support'
);

-- 2. Populate / Update Verified Medicines Catalogue

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dolo 650 Tablet',
  'dolo-650-tablet',
  'Dolo 650',
  'Paracetamol IP 650mg',
  'Paracetamol IP 650mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Micro Labs Ltd',
  'Strip of 15 Tablets',
  33.60,
  31.00,
  0,
  FALSE,
  'Widely used antipyretic and analgesic tablet for symptomatic relief of fever, headache and muscular body aches.',
  'As advised by doctor or pharmacist. Typical adult dosage is 1 tablet every 6 to 8 hours. Do not exceed 4000mg in 24 hours.',
  'Store in a cool and dry place below 30°C. Protect from direct sunlight.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Crocin 650 Advance Tablet',
  'crocin-650-advance-tablet',
  'Crocin',
  'Paracetamol IP 650mg with Optizorb',
  'Paracetamol IP 650mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Haleon India (GlaxoSmithKline)',
  'Strip of 15 Tablets',
  35.00,
  32.50,
  0,
  FALSE,
  'Fast-releasing paracetamol formulation providing swift reduction of fever and relief from body aches.',
  '1 tablet every 4 to 6 hours as required. Do not take with other paracetamol products.',
  'Store in moisture-free packaging below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Calpol 500mg Tablet',
  'calpol-500mg-tablet',
  'Calpol',
  'Paracetamol IP 500mg',
  'Paracetamol IP 500mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'GlaxoSmithKline Pharmaceuticals',
  'Strip of 15 Tablets',
  17.50,
  16.00,
  0,
  FALSE,
  'Trusted antipyretic for mild to moderate fever and body aches.',
  '1 tablet 3 to 4 times daily as directed by doctor.',
  'Keep in dry container away from sunlight.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Combiflam Tablet',
  'combiflam-tablet',
  'Combiflam',
  'Ibuprofen 400mg + Paracetamol 325mg',
  'Ibuprofen IP 400mg, Paracetamol IP 325mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Sanofi India Ltd',
  'Strip of 20 Tablets',
  48.00,
  44.00,
  0,
  TRUE,
  'Combination non-steroidal anti-inflammatory and antipyretic for inflammatory fever, toothache and muscular pain.',
  'Schedule H prescription medicine. Take strictly with or after meals to prevent gastric irritation.',
  'Store below 25°C in a dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Meftal-Spas Tablet',
  'meftal-spas-tablet',
  'Meftal-Spas',
  'Mefenamic Acid 250mg + Dicyclomine HCl 10mg',
  'Mefenamic Acid IP 250mg, Dicyclomine Hydrochloride IP 10mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Blue Cross Laboratories',
  'Strip of 10 Tablets',
  53.00,
  48.00,
  0,
  TRUE,
  'Antispasmodic and analgesic formulation prescribed for abdominal cramps, colicky pain and menstrual discomfort.',
  'Schedule H prescription medicine. Strictly as prescribed by a medical doctor.',
  'Store protected from light and moisture below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Paracip 650 Tablet',
  'paracip-650-tablet',
  'Paracip',
  'Paracetamol IP 650mg',
  'Paracetamol IP 650mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Cipla Ltd',
  'Strip of 10 Tablets',
  22.00,
  20.00,
  0,
  FALSE,
  'High-strength generic paracetamol formulation providing effective fever management and pain relief.',
  '1 tablet 3 times a day or as recommended by registered practitioner.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Sumo Tablet',
  'sumo-tablet',
  'Sumo',
  'Nimesulide 100mg + Paracetamol 325mg',
  'Nimesulide BP 100mg, Paracetamol IP 325mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Alkem Laboratories Ltd',
  'Strip of 15 Tablets',
  145.00,
  132.00,
  0,
  TRUE,
  'Potent combination painkiller for acute inflammatory conditions, osteoarthritis flare-ups and post-operative pain.',
  'Schedule H drug. Take after food. Not recommended for children below 12 years.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Benadryl Cough Syrup 100ml',
  'benadryl-cough-syrup-100ml',
  'Benadryl',
  'Diphenhydramine HCl, Ammonium Chloride, Sodium Citrate',
  'Diphenhydramine HCl 14.05mg, Ammonium Chloride 138mg, Sodium Citrate 57.03mg per 5ml',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Johnson & Johnson Pvt Ltd',
  '100ml Bottle',
  135.00,
  124.00,
  0,
  FALSE,
  'Soothing cough formula that eases throat tickle, loosens phlegm and calms persistent cough.',
  'Adults: 5ml to 10ml up to 4 times a day. May cause drowsiness.',
  'Keep bottle tightly closed in cool place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Ascoril D Plus Syrup 100ml',
  'ascoril-d-plus-syrup-100ml',
  'Ascoril D Plus',
  'Dextromethorphan + Phenylephrine + Chlorpheniramine',
  'Dextromethorphan HBr 10mg, Phenylephrine HCl 5mg, Chlorpheniramine Maleate 2mg per 5ml',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Glenmark Pharmaceuticals',
  '100ml Bottle',
  129.00,
  118.00,
  0,
  TRUE,
  'Prescription dry cough syrup with nasal decongestant and antihistamine action.',
  'Schedule H prescription medicine. Measure with dosing cup as advised by doctor.',
  'Store below 25°C. Do not freeze.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Cheston Cold Tablet',
  'cheston-cold-tablet',
  'Cheston Cold',
  'Cetirizine 5mg + Paracetamol 325mg + Phenylephrine 10mg',
  'Cetirizine Dihydrochloride 5mg, Paracetamol IP 325mg, Phenylephrine HCl 10mg',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Cipla Ltd',
  'Strip of 10 Tablets',
  48.00,
  44.00,
  0,
  TRUE,
  'Triple active tablet for multi-symptom cold, runny nose, sneezing, congestion and fever.',
  'Schedule H prescription drug. 1 tablet twice daily or as advised.',
  'Store protected from light and moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Alex Cough Syrup 100ml',
  'alex-cough-syrup-100ml',
  'Alex',
  'Dextromethorphan + Chlorpheniramine + Phenylephrine',
  'Dextromethorphan HBr 10mg, Chlorpheniramine Maleate 2mg, Phenylephrine HCl 5mg per 5ml',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Glenmark Pharmaceuticals',
  '100ml Bottle',
  138.00,
  125.00,
  0,
  TRUE,
  'Relieves unproductive dry allergic cough, nasal block and watery eyes.',
  'Schedule H drug. Take under medical guidance.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Grilinctus BM Syrup 100ml',
  'grilinctus-bm-syrup-100ml',
  'Grilinctus BM',
  'Terbutaline Sulphate + Bromhexine HCl',
  'Terbutaline Sulphate 1.25mg, Bromhexine HCl 4mg per 5ml',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Franco-Indian Pharmaceuticals',
  '100ml Bottle',
  110.00,
  99.00,
  0,
  TRUE,
  'Bronchodilator and mucolytic syrup for productive wet cough, bronchitis and chest congestion.',
  'Schedule H prescription medicine. Follow prescribed dosage.',
  'Store in dry place protected from heat.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Vicks VapoRub 50g',
  'vicks-vaporub-50g',
  'Vicks',
  'Ayurvedic Menthol, Camphor & Eucalyptus Vaporub',
  'Pudinah ke phool (Menthol) 2.82%, Karpoor (Camphor) 5.25%, Nilgiri tel (Eucalyptus Oil) 1.49%',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Procter & Gamble Hygiene and Health Care',
  '50g Tub',
  165.00,
  155.00,
  0,
  FALSE,
  'Topical vaporizing ointment for multi-symptom cold relief on chest, neck and back or for steam inhalation.',
  'Apply gently over chest and throat. Can be added to hot water for steam inhalation. For external use only.',
  'Keep lid tightly closed below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Vicks Inhaler 0.5ml',
  'vicks-inhaler-05ml',
  'Vicks',
  'Camphor, Menthol & Wintergreen Inhaler Stick',
  'Menthol 41.54%, Camphor 41.54%, Wintergreen Oil 12.27%',
  (SELECT id FROM public.categories WHERE slug = 'respiratory-asthma' LIMIT 1),
  'Procter & Gamble',
  '0.5ml Inhaler Stick',
  65.00,
  62.00,
  0,
  FALSE,
  'Pocket inhaler providing rapid relief from nasal congestion and blocked sinuses.',
  'Place tip gently at the nostril while holding other side closed, inhale deeply. Use as needed.',
  'Keep cap tightly screwed on.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Saridon Tablet',
  'saridon-tablet',
  'Saridon',
  'Paracetamol, Propyphenazone & Caffeine',
  'Paracetamol IP 250mg, Propyphenazone IP 150mg, Caffeine IP 50mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Piramal Pharma Ltd',
  'Strip of 10 Tablets',
  42.00,
  39.00,
  0,
  FALSE,
  'Specialist triple-active formulation engineered for fast relief from severe headache and toothache.',
  'Adults: 1 tablet with water. Do not exceed 3 tablets within 24 hours.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Vasograin Tablet',
  'vasograin-tablet',
  'Vasograin',
  'Ergotamine + Caffeine + Paracetamol + Prochlorperazine',
  'Ergotamine Tartrate 1mg, Caffeine 100mg, Paracetamol 250mg, Prochlorperazine Maleate 2.5mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Cadila Pharmaceuticals',
  'Strip of 14 Tablets',
  88.00,
  79.00,
  0,
  TRUE,
  'Prescription migraine treatment providing anti-nausea, cranial vasoconstrictor and analgesic action.',
  'Schedule H prescription medicine. Take 1 tablet at the earliest warning of a migraine attack.',
  'Store protected from light and heat.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Disprin Regular 350mg',
  'disprin-regular-350mg',
  'Disprin',
  'Aspirin / Acetylsalicylic Acid 350mg Soluble',
  'Aspirin (Acetylsalicylic Acid IP) 350mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Reckitt Benckiser India',
  'Strip of 10 Effervescent Tablets',
  12.50,
  12.00,
  0,
  FALSE,
  'Fast-dissolving effervescent soluble aspirin tablet for quick pain and headache alleviation.',
  'Dissolve tablet completely in half a glass of clean water before drinking. Take after food.',
  'Keep strip away from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Migranil EC Tablet',
  'migranil-ec-tablet',
  'Migranil',
  'Ergotamine Tartrate & Caffeine Tablet',
  'Ergotamine Tartrate IP 1mg, Caffeine IP 100mg',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Sun Pharmaceutical Industries',
  'Strip of 10 Tablets',
  75.00,
  68.00,
  0,
  TRUE,
  'Specific anti-migraine therapy used for acute relief during vascular headache episodes.',
  'Schedule H drug. Strictly under prescription of a medical practitioner.',
  'Store below 25°C in cool and dark place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Amrutanjan Strong Pain Balm 30g',
  'amrutanjan-strong-pain-balm-30g',
  'Amrutanjan',
  'Ayurvedic Menthol & Wintergreen Headache Balm',
  'Menthol 14%, Methyl Salicylate / Wintergreen Oil 14%, Camphor base',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Amrutanjan Health Care Ltd',
  '30g Jar',
  105.00,
  98.00,
  0,
  FALSE,
  'Ayurvedic herbal balm with penetrating warmth for headache, sinus pressure and stiff neck.',
  'Massage gently onto forehead and temples. For external application only.',
  'Store in cool place. Keep lid tightly closed.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Zandu Balm 25ml',
  'zandu-balm-25ml',
  'Zandu',
  'Menthol & Gaultheria Ayurvedic Balm',
  'Mentha sp. (Pudina Satva) 14.3%, Gaultheria fragrantissima (Gandhapura Patra Taila) 12.2%',
  (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
  'Emami Ltd',
  '25ml Jar',
  90.00,
  85.00,
  0,
  FALSE,
  'India''s historic pain balm providing fast soothing comfort from stress headaches and body fatigue.',
  'Apply softly to forehead or affected area. External use only.',
  'Store away from direct heat.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Pan 40 Tablet',
  'pan-40-tablet',
  'Pan',
  'Pantoprazole Gastro-Resistant 40mg',
  'Pantoprazole Sodium IP equivalent to Pantoprazole 40mg',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Alkem Laboratories Ltd',
  'Strip of 15 Tablets',
  165.00,
  150.00,
  0,
  TRUE,
  'Proton-pump inhibitor that inhibits stomach acid secretion for GERD, gastric ulcers and hyperacidity.',
  'Schedule H prescription medicine. Take 1 tablet daily before breakfast or as prescribed.',
  'Store protected from moisture below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Pantocid DSR Capsule',
  'pantocid-dsr-capsule',
  'Pantocid DSR',
  'Pantoprazole 40mg + Domperidone 30mg SR',
  'Pantoprazole Sodium 40mg, Domperidone 30mg (Sustained Release)',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Sun Pharmaceutical Industries',
  'Strip of 15 Capsules',
  295.00,
  265.00,
  0,
  TRUE,
  'Combined anti-reflux capsule reducing stomach acid while improving digestive motility to treat nausea and reflux.',
  'Schedule H prescription medicine. Take on an empty stomach 30-60 minutes before breakfast.',
  'Store below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Rantac 150 Tablet',
  'rantac-150-tablet',
  'Rantac',
  'Ranitidine Hydrochloride 150mg',
  'Ranitidine Hydrochloride IP equivalent to Ranitidine 150mg',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'J.B. Chemicals & Pharmaceuticals',
  'Strip of 30 Tablets',
  44.00,
  40.00,
  0,
  TRUE,
  'H2-receptor antagonist that lowers gastric acid production for heartburn and acid indigestion.',
  'Schedule H prescription medicine. 1 tablet twice daily before meals or at bedtime.',
  'Store protected from light and moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Omee Capsule',
  'omee-capsule',
  'Omee',
  'Omeprazole Gastro-Resistant 20mg',
  'Omeprazole IP 20mg (Enteric-coated pellets)',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Alkem Laboratories Ltd',
  'Strip of 20 Capsules',
  68.00,
  62.00,
  0,
  TRUE,
  'Effective proton pump inhibitor capsule for quick relief from acute heartburn and sour burps.',
  'Schedule H prescription drug. Swallow capsule whole with water before food.',
  'Store below 25°C in dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Gelusil MPS Antacid Liquid 200ml',
  'gelusil-mps-antacid-liquid-200ml',
  'Gelusil MPS',
  'Aluminium Hydroxide + Magnesium Hydroxide + Simethicone',
  'Aluminium Hydroxide 250mg, Magnesium Hydroxide 250mg, Activated Dimethicone (Simethicone) 50mg per 5ml',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Pfizer India Ltd',
  '200ml Mint Flavour Bottle',
  135.00,
  125.00,
  0,
  FALSE,
  'Dual-action soothing antacid and antiflatulent liquid providing rapid relief from heartburn and gas bloating.',
  '1 to 2 teaspoonfuls (5-10ml) between meals and at bedtime. Shake bottle well.',
  'Keep in cool place. Do not freeze.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Eno Fruit Salt Lemon 100g',
  'eno-fruit-salt-lemon-100g',
  'Eno',
  'Svarjiksara & Nimbukamlam Effervescent Antacid',
  'Svarjiksara (Sodium Bicarbonate) 2.91g, Nimbukamlam (Citric Acid) 2.04g per 5g dose',
  (SELECT id FROM public.categories WHERE slug = 'kidney-urinary-care' LIMIT 1),
  'Haleon India (GlaxoSmithKline)',
  '100g Bottle',
  170.00,
  160.00,
  0,
  FALSE,
  'Fast-dissolving effervescent antacid powder acting within 6 seconds on acute acidity and gastric discomfort.',
  'Dissolve 1 level teaspoonful (5g) in a glass of cold water. Drink immediately.',
  'Keep bottle tightly closed to protect from ambient moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Digene Antacid Chewable Tablets',
  'digene-antacid-chewable-tablets',
  'Digene',
  'Magnesium & Aluminium Hydroxide with Simethicone Chewable',
  'Dried Aluminium Hydroxide Gel 300mg, Magnesium Aluminium Silicate 50mg, Magnesium Hydroxide 25mg, Simethicone 25mg',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Abbott India Ltd',
  'Strip of 15 Chewable Tablets',
  26.00,
  24.00,
  0,
  FALSE,
  'Sugar-free chewable antacid tablets for fast portability and soothing relief from burning stomach.',
  'Chew 1 to 2 tablets thoroughly after meals or as discomfort arises.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Pudin Hara Pearls',
  'pudin-hara-pearls',
  'Dabur Pudin Hara',
  'Pudina Satva / Mentha Oil Herbal Pearls',
  'Pudina Satva (Mentha piperita oil) 0.0337ml per pearl',
  (SELECT id FROM public.categories WHERE slug = 'liver-care' LIMIT 1),
  'Dabur India Ltd',
  'Strip of 10 Pearls',
  30.00,
  28.00,
  0,
  FALSE,
  'Natural herbal carminative pearls for instant cooling relief from stomach ache, gas and indigestion.',
  'Adults: 1 to 2 pearls with a glass of water. Swallow whole.',
  'Store in cool dry place away from heat.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Electral ORS Powder 21.8g',
  'electral-ors-powder-218g',
  'Electral',
  'Oral Rehydration Salts WHO Formula IP',
  'Sodium Chloride 2.60g, Potassium Chloride 1.50g, Sodium Citrate 2.90g, Anhydrous Dextrose 13.50g',
  (SELECT id FROM public.categories WHERE slug = 'emergency-otc-support' LIMIT 1),
  'FDC Ltd',
  '21.8g Sachet (Makes 1 Litre)',
  22.50,
  21.00,
  0,
  FALSE,
  'WHO-recommended low osmolarity formula for fast restoration of fluids and electrolytes lost during diarrhea and vomiting.',
  'Dissolve entire sachet contents in exactly 1 litre of clean boiled and cooled drinking water.',
  'Use reconstituted solution within 24 hours. Keep unused powder dry.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Sporlac DS Tablet',
  'sporlac-ds-tablet',
  'Sporlac DS',
  'Lactic Acid Bacillus 120 Million Spores',
  'Lactic Acid Bacillus (Lactobacillus sporogenes) not less than 120 million spores',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Sanzyme Biogenics',
  'Strip of 20 Tablets',
  125.00,
  115.00,
  0,
  FALSE,
  'Probiotic formulation for restoration of intestinal microflora balance after antibiotic therapy or stomach upset.',
  '1 tablet twice daily with water or as suggested by healthcare provider.',
  'Store in a cool dry place below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Norflox TZ Tablet',
  'norflox-tz-tablet',
  'Norflox TZ',
  'Norfloxacin 400mg + Tinidazole 600mg',
  'Norfloxacin IP 400mg, Tinidazole IP 600mg',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'Cipla Ltd',
  'Strip of 10 Tablets',
  115.00,
  104.00,
  0,
  TRUE,
  'Prescription antimicrobial combination indicated for acute bacterial and amoebic diarrheas and dysentery.',
  'Schedule H prescription medicine. Complete entire prescribed course. Do not stop midway.',
  'Store protected from light and moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Cremaffin Plus Syrup 225ml',
  'cremaffin-plus-syrup-225ml',
  'Cremaffin Plus',
  'Liquid Paraffin + Milk of Magnesia + Sodium Picosulfate',
  'Liquid Paraffin 3.75ml, Milk of Magnesia 11.25ml, Sodium Picosulfate 3.33mg per 15ml',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Abbott India Ltd',
  '225ml Bottle',
  310.00,
  280.00,
  0,
  TRUE,
  'Triple-action osmotic, stool-softening and stimulant laxative suspension for chronic and painful constipation.',
  'Schedule H prescription medicine. Take at bedtime with a glass of water under medical guidance.',
  'Store in cool place. Shake well before use.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Unienzyme Tablet',
  'unienzyme-tablet',
  'Unienzyme',
  'Fungal Diastase + Papain + Activated Charcoal',
  'Fungal Diastase (1:2000) 100mg, Papain 60mg, Activated Charcoal 75mg',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Torrent Pharmaceuticals',
  'Strip of 15 Tablets',
  72.00,
  65.00,
  0,
  FALSE,
  'Digestive enzyme tablet that breaks down carbohydrates and proteins while activated charcoal adsorbs intestinal gas.',
  '1 tablet immediately after meals with water.',
  'Store below 25°C in dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Cyclopam Tablet',
  'cyclopam-tablet',
  'Cyclopam',
  'Dicyclomine HCl 20mg + Paracetamol 500mg',
  'Dicyclomine Hydrochloride IP 20mg, Paracetamol IP 500mg',
  (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
  'Indoco Remedies Ltd',
  'Strip of 10 Tablets',
  58.00,
  52.00,
  0,
  TRUE,
  'Antispasmodic and pain relieving tablet for spasmodic pain in the gastrointestinal, biliary or ureteric tracts.',
  'Schedule H prescription medicine. Strictly as directed by doctor.',
  'Store protected from heat and moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Allegra 120mg Tablet',
  'allegra-120mg-tablet',
  'Allegra',
  'Fexofenadine Hydrochloride 120mg',
  'Fexofenadine Hydrochloride IP 120mg',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Sanofi India Ltd',
  'Strip of 10 Tablets',
  225.00,
  205.00,
  0,
  TRUE,
  'Non-sedating second-generation antihistamine for allergic rhinitis, seasonal allergies and chronic hives.',
  'Schedule H prescription medicine. 1 tablet once daily with water. Non-drowsy formulation.',
  'Store protected from moisture below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Cetzine 10mg Tablet',
  'cetzine-10mg-tablet',
  'Cetzine',
  'Cetirizine Dihydrochloride 10mg',
  'Cetirizine Dihydrochloride IP 10mg',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Dr. Reddy''s Laboratories',
  'Strip of 15 Tablets',
  92.00,
  82.00,
  0,
  TRUE,
  'Trusted anti-allergic tablet providing long-lasting control of runny nose, skin itching and allergic conjunctivitis.',
  'Schedule H drug. 1 tablet daily, preferably in the evening. May cause mild drowsiness.',
  'Store in dry place below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Okacet 10mg Tablet',
  'okacet-10mg-tablet',
  'Okacet',
  'Cetirizine Hydrochloride 10mg',
  'Cetirizine Hydrochloride IP 10mg',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Cipla Ltd',
  'Strip of 10 Tablets',
  21.00,
  19.00,
  0,
  TRUE,
  'Affordable generic cetirizine for relief from pollen allergy, dust allergy and urticaria.',
  'Schedule H prescription medicine. 1 tablet once a day.',
  'Store protected from light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Levocet 5mg Tablet',
  'levocet-5mg-tablet',
  'Levocet',
  'Levocetirizine Dihydrochloride 5mg',
  'Levocetirizine Dihydrochloride IP 5mg',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Hetero Healthcare',
  'Strip of 10 Tablets',
  55.00,
  49.00,
  0,
  TRUE,
  'Pure active enantiomer antihistamine providing potent allergy relief with minimal sedative liability.',
  'Schedule H prescription drug. 1 tablet daily at bedtime.',
  'Store below 25°C in dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Montair-LC Tablet',
  'montair-lc-tablet',
  'Montair-LC',
  'Montelukast Sodium 10mg + Levocetirizine 5mg',
  'Montelukast Sodium IP equivalent to Montelukast 10mg, Levocetirizine Dihydrochloride IP 5mg',
  (SELECT id FROM public.categories WHERE slug = 'respiratory-asthma' LIMIT 1),
  'Cipla Ltd',
  'Strip of 15 Tablets',
  340.00,
  305.00,
  0,
  TRUE,
  'Dual leukotriene receptor antagonist and antihistamine tablet for allergic asthma and persistent allergic rhinitis.',
  'Schedule H prescription medicine. Take 1 tablet once daily at night as prescribed.',
  'Store below 25°C protected from light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Avil 25mg Tablet',
  'avil-25mg-tablet',
  'Avil',
  'Pheniramine Maleate 25mg',
  'Pheniramine Maleate IP 25mg',
  (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
  'Sanofi India Ltd',
  'Strip of 15 Tablets',
  11.50,
  10.50,
  0,
  TRUE,
  'Classic antihistamine for sudden allergic flare-ups, insect stings, drug allergies and motion sickness.',
  'Schedule H prescription medicine. May cause significant drowsiness; avoid driving.',
  'Store protected from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Atarax 25mg Tablet',
  'atarax-25mg-tablet',
  'Atarax',
  'Hydroxyzine Hydrochloride 25mg',
  'Hydroxyzine Hydrochloride IP 25mg',
  (SELECT id FROM public.categories WHERE slug = 'mental-wellness-sleep' LIMIT 1),
  'Dr. Reddy''s Laboratories',
  'Strip of 15 Tablets',
  95.00,
  85.00,
  0,
  TRUE,
  'Prescription antipruritic tablet for acute pruritus, generalized dermatitis and eczema with nighttime itching.',
  'Schedule H prescription drug. Strictly as directed by physician.',
  'Store below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Glycomet 500 SR Tablet',
  'glycomet-500-sr-tablet',
  'Glycomet',
  'Metformin Hydrochloride 500mg Sustained Release',
  'Metformin Hydrochloride IP 500mg (Sustained Release form)',
  (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
  'USV Pvt Ltd',
  'Strip of 20 Tablets',
  48.00,
  43.00,
  0,
  TRUE,
  'First-line biguanide anti-diabetic medication improving insulin sensitivity and reducing hepatic glucose output.',
  'Schedule H prescription medicine. Take with meals to reduce gastrointestinal side effects.',
  'Store below 25°C in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Glycomet GP 1 Tablet',
  'glycomet-gp-1-tablet',
  'Glycomet GP',
  'Glimepiride 1mg + Metformin 500mg SR',
  'Glimepiride IP 1mg, Metformin Hydrochloride IP 500mg SR',
  (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
  'USV Pvt Ltd',
  'Strip of 15 Tablets',
  122.00,
  110.00,
  0,
  TRUE,
  'Combination sulfonylurea and biguanide anti-diabetic tablet for glycemic control in Type 2 Diabetes Mellitus.',
  'Schedule H prescription drug. Take once daily with breakfast as prescribed.',
  'Store protected from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Janumet 50mg/500mg Tablet',
  'janumet-50mg-500mg-tablet',
  'Janumet',
  'Sitagliptin 50mg + Metformin 500mg',
  'Sitagliptin Phosphate Monohydrate 50mg, Metformin Hydrochloride 500mg',
  (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
  'MSD Pharmaceuticals',
  'Strip of 15 Tablets',
  390.00,
  350.00,
  0,
  TRUE,
  'Advanced DPP-4 inhibitor and metformin combination for tight blood sugar control without hypoglycemia.',
  'Schedule H prescription medicine. Take twice daily with meals as directed.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Galvus Met 50mg/500mg Tablet',
  'galvus-met-50mg-500mg-tablet',
  'Galvus Met',
  'Vildagliptin 50mg + Metformin 500mg',
  'Vildagliptin 50mg, Metformin Hydrochloride 500mg',
  (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
  'Novartis India Ltd',
  'Strip of 10 Tablets',
  270.00,
  242.00,
  0,
  TRUE,
  'Incretin enhancer anti-hyperglycemic agent regulating glucagon and insulin in response to meals.',
  'Schedule H prescription medicine. Under strict advice of an endocrinologist/physician.',
  'Store in moisture-proof blister below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Accu-Chek Active Test Strips 50s',
  'accu-chek-active-test-strips-50s',
  'Accu-Chek',
  'Quantitative Blood Glucose Test Strips',
  'Enzyme glucose dehydrogenase (GDH) chemical indicator test strips',
  (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
  'Roche Diagnostics India',
  'Pack of 50 Strips',
  1025.00,
  920.00,
  0,
  FALSE,
  'High-precision blood glucose monitoring strips compatible with Accu-Chek Active meters for home diabetes tracking.',
  'For in-vitro diagnostic self-monitoring. Use only with Accu-Chek Active meter.',
  'Close vial immediately after taking a strip. Store between 2°C and 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'OneTouch Select Plus Test Strips 50s',
  'onetouch-select-plus-test-strips-50s',
  'OneTouch',
  'Blood Glucose Test Strips 50 Units',
  'Glucose oxidase test strips with ColorSure technology',
  (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
  'LifeScan India',
  'Pack of 50 Strips',
  1190.00,
  1050.00,
  0,
  FALSE,
  'Rapid, precise capillary blood glucose testing strips for OneTouch Select Plus meters.',
  'Apply small blood sample to test zone. Read result on meter in 5 seconds.',
  'Store between 5°C and 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Human Mixtard 30/70 100IU/ml',
  'human-mixtard-30-70-100iu-ml',
  'Human Mixtard',
  'Biphasic Isophane Insulin Injection IP',
  '30% Soluble Insulin IP and 70% Isophane Insulin IP 100 IU/ml',
  (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
  'Novo Nordisk India',
  '10ml Vial',
  190.00,
  175.00,
  0,
  TRUE,
  'Human insulin suspension combining rapid and intermediate action for diabetes mellitus management.',
  'Schedule G / H prescription drug. Subcutaneous injection strictly as prescribed. Do not freeze.',
  'Store in refrigerator between 2°C and 8°C. Protect from freezing and direct light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Telma 40 Tablet',
  'telma-40-tablet',
  'Telma',
  'Telmisartan IP 40mg',
  'Telmisartan IP 40mg',
  (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
  'Glenmark Pharmaceuticals',
  'Strip of 30 Tablets',
  270.00,
  240.00,
  0,
  TRUE,
  'Angiotensin II receptor antagonist (ARB) for essential hypertension and reduction of cardiovascular risk.',
  'Schedule H prescription medicine. Take 1 tablet once daily, preferably at the same time each day.',
  'Store below 30°C in original packaging.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Telma-H Tablet',
  'telma-h-tablet',
  'Telma-H',
  'Telmisartan 40mg + Hydrochlorothiazide 12.5mg',
  'Telmisartan IP 40mg, Hydrochlorothiazide IP 12.5mg',
  (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
  'Glenmark Pharmaceuticals',
  'Strip of 15 Tablets',
  220.00,
  198.00,
  0,
  TRUE,
  'Fixed-dose ARB and thiazide diuretic combination providing synergistic blood pressure reduction.',
  'Schedule H prescription medicine. Take in the morning with water.',
  'Store protected from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Amlong 5mg Tablet',
  'amlong-5mg-tablet',
  'Amlong',
  'Amlodipine Besylate 5mg',
  'Amlodipine Besylate IP equivalent to Amlodipine 5mg',
  (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
  'Micro Labs Ltd',
  'Strip of 15 Tablets',
  45.00,
  40.00,
  0,
  TRUE,
  'Dihydropyridine calcium channel blocker for systemic hypertension and chronic stable angina.',
  'Schedule H prescription medicine. 1 tablet once daily.',
  'Store below 25°C in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Aten 50mg Tablet',
  'aten-50mg-tablet',
  'Aten',
  'Atenolol IP 50mg',
  'Atenolol IP 50mg',
  (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
  'Zydus Cadila Healthcare',
  'Strip of 14 Tablets',
  38.00,
  34.00,
  0,
  TRUE,
  'Cardioselective beta-1 blocker used to manage hypertension, angina pectoris and heart rhythm stabilization.',
  'Schedule H prescription medicine. Do not stop abruptly without doctor advice.',
  'Store protected from heat and light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Concor 5mg Tablet',
  'concor-5mg-tablet',
  'Concor',
  'Bisoprolol Fumarate 5mg',
  'Bisoprolol Fumarate IP 5mg',
  (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
  'Merck Ltd / Procter & Gamble',
  'Strip of 10 Tablets',
  110.00,
  98.00,
  0,
  TRUE,
  'Highly selective beta-blocker prescribed for high blood pressure and chronic stable heart failure.',
  'Schedule H prescription medicine. 1 tablet daily in the morning.',
  'Store below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Ecosprin 75mg Tablet',
  'ecosprin-75mg-tablet',
  'Ecosprin',
  'Enteric Coated Aspirin 75mg',
  'Aspirin (Acetylsalicylic Acid) IP 75mg (Enteric-coated)',
  (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
  'USV Pvt Ltd',
  'Strip of 14 Tablets',
  5.50,
  5.00,
  0,
  TRUE,
  'Low-dose antiplatelet medication preventing thrombus formation, heart attack and ischemic stroke.',
  'Schedule H prescription drug. Swallow tablet whole with water after a meal.',
  'Store below 25°C protected from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Sorbitrate 5mg Sublingual Tablet',
  'sorbitrate-5mg-sublingual-tablet',
  'Sorbitrate',
  'Isosorbide Dinitrate 5mg Sublingual',
  'Isosorbide Dinitrate IP 5mg',
  (SELECT id FROM public.categories WHERE slug = 'emergency-otc-support' LIMIT 1),
  'Abbott India Ltd',
  'Strip of 50 Tablets',
  52.00,
  46.00,
  0,
  TRUE,
  'Fast-acting vasodilator for acute relief and prophylaxis of angina pectoris attacks.',
  'Schedule H prescription medicine. Place 1 tablet under the tongue and allow to dissolve during chest pain.',
  'Keep in airtight container away from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Rosuvas 10mg Tablet',
  'rosuvas-10mg-tablet',
  'Rosuvas',
  'Rosuvastatin Calcium 10mg',
  'Rosuvastatin Calcium IP equivalent to Rosuvastatin 10mg',
  (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
  'Sun Pharmaceutical Industries',
  'Strip of 15 Tablets',
  245.00,
  220.00,
  0,
  TRUE,
  'HMG-CoA reductase inhibitor (statin) that lowers LDL bad cholesterol and triglycerides.',
  'Schedule H prescription medicine. Take 1 tablet once daily at bedtime.',
  'Store below 30°C in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Thyronorm 25mcg Tablet',
  'thyronorm-25mcg-tablet',
  'Thyronorm',
  'Thyroxine Sodium IP 25mcg',
  'Thyroxine Sodium IP 25mcg',
  (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
  'Abbott India Ltd',
  'Bottle of 120 Tablets',
  145.00,
  130.00,
  0,
  TRUE,
  'Synthetic thyroid hormone replacement therapy for primary, secondary or tertiary hypothyroidism.',
  'Schedule H prescription medicine. Take exactly 1 tablet early in the morning on an empty stomach with plain water at least 30-45 minutes before tea or breakfast.',
  'Store in refrigerator or cool dry place below 25°C. Keep bottle tightly closed.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Thyronorm 50mcg Tablet',
  'thyronorm-50mcg-tablet',
  'Thyronorm',
  'Thyroxine Sodium IP 50mcg',
  'Thyroxine Sodium IP 50mcg',
  (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
  'Abbott India Ltd',
  'Bottle of 120 Tablets',
  165.00,
  148.00,
  0,
  TRUE,
  'Standard titration strength for management of underactive thyroid gland and goiter.',
  'Schedule H prescription medicine. Morning empty-stomach administration is critical.',
  'Store protected from light and moisture below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Thyronorm 75mcg Tablet',
  'thyronorm-75mcg-tablet',
  'Thyronorm',
  'Thyroxine Sodium IP 75mcg',
  'Thyroxine Sodium IP 75mcg',
  (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
  'Abbott India Ltd',
  'Bottle of 120 Tablets',
  178.00,
  160.00,
  0,
  TRUE,
  'Medium maintenance strength levothyroxine replacement for optimal TSH normalization.',
  'Schedule H prescription medicine. As prescribed based on regular serum TSH lab tests.',
  'Keep silica gel inside bottle. Close cap tightly.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Thyronorm 100mcg Tablet',
  'thyronorm-100mcg-tablet',
  'Thyronorm',
  'Thyroxine Sodium IP 100mcg',
  'Thyroxine Sodium IP 100mcg',
  (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
  'Abbott India Ltd',
  'Bottle of 120 Tablets',
  195.00,
  175.00,
  0,
  TRUE,
  'High-strength thyroid hormone substitution tablet for post-thyroidectomy or severe hypothyroidism.',
  'Schedule H prescription drug. Take early morning empty stomach.',
  'Store below 25°C in cool and dark conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Eltroxin 50mcg Tablet',
  'eltroxin-50mcg-tablet',
  'Eltroxin',
  'Thyroxine Sodium IP 50mcg',
  'Thyroxine Sodium IP 50mcg',
  (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
  'GlaxoSmithKline Pharmaceuticals',
  'Bottle of 120 Tablets',
  160.00,
  144.00,
  0,
  TRUE,
  'Renowned levothyroxine brand for treating pediatric and adult hypothyroidism.',
  'Schedule H prescription medicine. Take in morning on empty stomach with plain water.',
  'Store in dry place below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Eltroxin 100mcg Tablet',
  'eltroxin-100mcg-tablet',
  'Eltroxin',
  'Thyroxine Sodium IP 100mcg',
  'Thyroxine Sodium IP 100mcg',
  (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
  'GlaxoSmithKline Pharmaceuticals',
  'Bottle of 120 Tablets',
  190.00,
  170.00,
  0,
  TRUE,
  'Full replacement dosage levothyroxine tablet for chronic thyroid insufficiency.',
  'Schedule H prescription medicine. Strict empty-stomach morning schedule required.',
  'Keep tightly closed in original bottle.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Becosules Capsules',
  'becosules-capsules',
  'Becosules',
  'Vitamin B-Complex with Vitamin C Capsules',
  'Thiamine 10mg, Riboflavin 10mg, Nicotinamide 50mg, Pyridoxine 3mg, Calcium Pantothenate 16.3mg, Cyanocobalamin 10mcg, Folic Acid 1mg, Vitamin C 150mg, Biotin 100mcg',
  (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
  'Pfizer India Ltd',
  'Strip of 20 Capsules',
  52.00,
  47.00,
  0,
  FALSE,
  'Classic therapeutic multivitamin formula for mouth ulcers, fatigue, post-fever convalescence and nutritional depletion.',
  '1 capsule daily after food or as directed by doctor.',
  'Store below 25°C in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Neurobion Forte Tablet',
  'neurobion-forte-tablet',
  'Neurobion Forte',
  'High Potency Vitamin B1, B6, B12 Formulation',
  'Vitamin B1 (Thiamine) 10mg, Vitamin B2 (Riboflavin) 10mg, Vitamin B3 (Nicotinamide) 45mg, Vitamin B5 (Calcium Pantothenate) 50mg, Vitamin B6 (Pyridoxine) 3mg, Vitamin B12 (Cyanocobalamin) 15mcg',
  (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
  'Procter & Gamble Health Ltd',
  'Strip of 30 Tablets',
  42.50,
  38.00,
  0,
  FALSE,
  'Nerve-nourishing B-vitamin complex for peripheral tingling, numbness and overall neurological health.',
  '1 tablet daily with a glass of water after food.',
  'Store protected from light and moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Limcee 500mg Chewable Tablet',
  'limcee-500mg-chewable-tablet',
  'Limcee',
  'Vitamin C / Ascorbic Acid 500mg Chewable',
  'Ascorbic Acid IP 100mg, Sodium Ascorbate IP 450mg equivalent to Vitamin C 500mg',
  (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
  'Abbott India Ltd',
  'Strip of 15 Chewable Tablets',
  26.00,
  23.50,
  0,
  FALSE,
  'Tasty orange-flavoured chewable vitamin C providing vital antioxidant protection and wound healing support.',
  'Chew 1 tablet daily or as advised.',
  'Store below 25°C protected from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Shelcal 500 Tablet',
  'shelcal-500-tablet',
  'Shelcal',
  'Calcium 500mg + Vitamin D3 250IU',
  'Calcium Carbonate IP equivalent to Elemental Calcium 500mg, Vitamin D3 (Cholecalciferol) IP 250 IU',
  (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
  'Torrent Pharmaceuticals',
  'Strip of 15 Tablets',
  135.00,
  122.00,
  0,
  FALSE,
  'Essential calcium and vitamin D3 combination for strong bones, teeth and prevention of osteopenia.',
  '1 tablet daily after food, preferably with water.',
  'Store below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Supradyn Daily Multivitamin Tablet',
  'supradyn-daily-multivitamin-tablet',
  'Supradyn',
  'Multivitamins, Minerals and Trace Elements',
  '12 Essential Vitamins, 5 Minerals, and Trace Elements with Zinc',
  (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
  'Bayer Pharmaceuticals India',
  'Strip of 15 Tablets',
  59.00,
  53.00,
  0,
  FALSE,
  'Comprehensive daily multivitamin for cellular energy, immune stamina and combating daily physical fatigue.',
  '1 tablet daily after breakfast or lunch.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Evion 400mg Capsule',
  'evion-400mg-capsule',
  'Evion',
  'Vitamin E / Tocopheryl Acetate 400mg',
  'Tocopheryl Acetate IP 400mg',
  (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
  'Merck Ltd / Procter & Gamble',
  'Strip of 10 Green Capsules',
  38.50,
  35.00,
  0,
  FALSE,
  'Potent fat-soluble antioxidant vitamin capsule supporting skin health, muscle recovery and cellular protection.',
  '1 capsule daily with water after meals.',
  'Store below 25°C in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Uprise-D3 60K Capsule',
  'uprise-d3-60k-capsule',
  'Uprise-D3',
  'Cholecalciferol / Vitamin D3 60,000 IU',
  'Cholecalciferol IP 60,000 IU (in soft gelatin base)',
  (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
  'Alkem Laboratories Ltd',
  'Strip of 4 Capsules',
  128.00,
  115.00,
  0,
  TRUE,
  'High-strength weekly vitamin D3 booster for correcting severe vitamin D deficiency and strengthening bone matrix.',
  'Schedule H prescription medicine. Take 1 capsule once a week with warm milk as directed by doctor.',
  'Store below 25°C in a cool dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dabur Chyawanprash 1kg',
  'dabur-chyawanprash-1kg',
  'Dabur',
  'Classical Ayurvedic Amla & Herbal Immunity Formulation',
  'Amla (Indian Gooseberry), Ashwagandha, Pippali, Yashtimadhu, Gokshura and over 40 rejuvenating Ayurvedic herbs',
  (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
  'Dabur India Ltd',
  '1kg Jar',
  415.00,
  385.00,
  0,
  FALSE,
  'Time-tested Ayurvedic formulation clinically proven to boost natural immunity, fight seasonal illness and strengthen stamina.',
  'Adults: 1 teaspoonful (approx. 12g) twice daily, ideally followed with warm milk.',
  'Store in cool and dry place. Do not use wet spoon.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Baidyanath Chyawanprash Special 1kg',
  'baidyanath-chyawanprash-special-1kg',
  'Baidyanath',
  'Enriched Silver & Saffron Ayurvedic Immunity Paste',
  'Fresh Amla pulp, Kesar (Saffron), Chandi Bhasma (Silver), Cardamom and fortified herbal extracts',
  (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
  'Shree Baidyanath Ayurved Bhawan',
  '1kg Jar',
  425.00,
  395.00,
  0,
  FALSE,
  'Fortified Ayurvedic health recipe that nourishes respiratory vitality and builds seasonal resistance.',
  '1 to 2 spoonfuls daily with milk.',
  'Keep lid tightly closed.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dabur Honey 500g',
  'dabur-honey-500g',
  'Dabur',
  '100% Pure NMR Tested Raw Forest Honey',
  'Pure Natural Honey meeting FSSAI and international NMR purity benchmarks',
  (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
  'Dabur India Ltd',
  '500g Squeeze Bottle',
  230.00,
  215.00,
  0,
  FALSE,
  'Pure natural honey rich in natural antioxidants and enzymes; aids digestion, soothe throat and supports weight wellness.',
  'Consume 1 tablespoon daily with warm water or lemon water.',
  'Do not refrigerate. Store at room temperature.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Patanjali Pure Honey 500g',
  'patanjali-pure-honey-500g',
  'Patanjali',
  'Pure Natural Multi-Flora Honey',
  'Pure Multi-Flora Bee Honey',
  (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
  'Patanjali Ayurved Ltd',
  '500g Bottle',
  200.00,
  190.00,
  0,
  FALSE,
  'Pure floral honey processed under strict hygienic conditions for daily morning health regimen.',
  '1 to 2 teaspoons daily.',
  'Store in cool dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Giloy Ghanvati Tablets',
  'giloy-ghanvati-tablets',
  'Patanjali',
  'Tinospora Cordifolia (Guduchi) Pure Extract',
  'Giloy aqueous extract (Tinospora cordifolia) 500mg per tablet',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Patanjali Ayurved Ltd',
  'Bottle of 60 Tablets',
  110.00,
  105.00,
  0,
  FALSE,
  'Classical Ayurvedic rasayana that helps balance body temperature, cleanse blood toxins and enhance natural immunity.',
  '1 to 2 tablets twice daily with lukewarm water.',
  'Store in dry place away from direct light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Celin 500mg Tablet',
  'celin-500mg-tablet',
  'Celin',
  'Ascorbic Acid / Vitamin C 500mg',
  'Ascorbic Acid IP 500mg',
  (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
  'Koye Pharmaceuticals / Abbott',
  'Strip of 25 Tablets',
  41.00,
  38.00,
  0,
  FALSE,
  'Water-soluble antioxidant vitamin tablet essential for collagen synthesis, immune barrier integrity and wound repair.',
  '1 tablet daily after food.',
  'Store protected from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Zincovit Tablet',
  'zincovit-tablet',
  'Zincovit',
  'Multivitamin, Multimineral with Grape Seed Extract & Zinc',
  'Zinc, Selenium, Vitamin A, B-Complex, C, D3, E and Grape Seed Extract',
  (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
  'Apex Laboratories Pvt Ltd',
  'Strip of 15 Tablets',
  115.00,
  104.00,
  0,
  FALSE,
  'High-potency zinc and multimineral tablet formulated to accelerate post-infection recovery and strengthen immune response.',
  '1 tablet daily with water after meals.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Betnovate-C Cream 30g',
  'betnovate-c-cream-30g',
  'Betnovate-C',
  'Betamethasone Valerate + Clioquinol Cream',
  'Betamethasone Valerate IP 0.1% w/w, Clioquinol IP 3.0% w/w',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'GlaxoSmithKline Pharmaceuticals',
  '30g Tube',
  65.00,
  59.00,
  0,
  TRUE,
  'Prescription anti-inflammatory and antifungal topical cream for responsive infected eczemas and dermatitis.',
  'Schedule H prescription medicine. Apply sparingly to affected area 1-2 times daily. Do not use on face or for long durations without doctor prescription.',
  'Store below 25°C. Do not freeze.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Betnovate-N Cream 20g',
  'betnovate-n-cream-20g',
  'Betnovate-N',
  'Betamethasone Valerate + Neomycin Sulphate Cream',
  'Betamethasone Valerate IP 0.1% w/w, Neomycin Sulphate IP 0.5% w/w',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'GlaxoSmithKline Pharmaceuticals',
  '20g Tube',
  45.00,
  40.00,
  0,
  TRUE,
  'Topical steroid and antibiotic cream for inflammatory dermatoses with secondary bacterial complication.',
  'Schedule H prescription medicine. Strictly as directed by a dermatologist.',
  'Store in dry place below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Fourderm Cream 15g',
  'fourderm-cream-15g',
  'Fourderm',
  'Clobetasol + Neomycin + Miconazole Cream',
  'Clobetasol Propionate 0.05%, Neomycin Sulphate 0.5%, Miconazole Nitrate 2.0%, Chlorocresol 0.1%',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'Cipla Ltd',
  '15g Tube',
  110.00,
  99.00,
  0,
  TRUE,
  'Potent quadruple-action topical cream for severe mixed fungal, bacterial and inflammatory skin lesions.',
  'Schedule H prescription drug. External use only.',
  'Keep tube tightly capped below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Candid-B Cream 20g',
  'candid-b-cream-20g',
  'Candid-B',
  'Clotrimazole 1% + Beclomethasone 0.025% Cream',
  'Clotrimazole IP 1.0% w/w, Beclomethasone Dipropionate IP 0.025% w/w',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'Glenmark Pharmaceuticals',
  '20g Tube',
  145.00,
  130.00,
  0,
  TRUE,
  'Antifungal and corticosteroid cream indicated for ringworm (tinea corporis), jock itch and athlete''s foot.',
  'Schedule H prescription medicine. Apply gently twice daily to clean dry skin.',
  'Store below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Boroline Antiseptic Ayurvedic Cream 20g',
  'boroline-antiseptic-ayurvedic-cream-20g',
  'Boroline',
  'Ayurvedic Boric Acid & Zinc Oxide Healing Cream',
  'Boric Acid IP 1.0% w/w, Zinc Oxide IP 3.0% w/w, Anhydrous Lanolin in mineral oil base',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'G.D. Pharmaceuticals Pvt Ltd',
  '20g Tube',
  45.00,
  42.00,
  0,
  FALSE,
  'Iconic Ayurvedic protective cream for cracked lips, cracked heels, minor cuts and severely chapped skin.',
  'Apply generously to affected area after washing. Leave overnight for best healing.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Vicco Turmeric WSO Skin Cream 30g',
  'vicco-turmeric-wso-skin-cream-30g',
  'Vicco Turmeric',
  'Pure Turmeric Extract Ayurvedic Cream',
  'Turmeric (Curcuma longa rhizome extract) 16% w/w in non-greasy base',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'Vicco Laboratories',
  '30g Tube',
  95.00,
  88.00,
  0,
  FALSE,
  'Pure Ayurvedic skin cream with natural antibacterial turmeric for acne spots, blemishes and minor skin abrasions.',
  'Apply softly to clean skin twice daily.',
  'Store in dry place away from heat.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Caladryl Calamine Skin Lotion 120ml',
  'caladryl-calamine-skin-lotion-120ml',
  'Caladryl',
  'Calamine & Pramoxine Anti-Itch Lotion',
  'Calamine IP 8.0% w/v, Pramoxine Hydrochloride IP 1.0% w/v',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'Piramal Pharma Ltd',
  '120ml Bottle',
  190.00,
  175.00,
  0,
  FALSE,
  'Soothing anti-itch and cooling calamine lotion for prickly heat, insect bites, chickenpox rash and sunburn.',
  'Shake well before use. Apply to affected area with clean cotton pad.',
  'Store below 25°C. For external use only.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Scalpe Plus Anti-Dandruff Shampoo 100ml',
  'scalpe-plus-anti-dandruff-shampoo-100ml',
  'Scalpe Plus',
  'Ketoconazole 2% + Zinc Pyrithione (ZPTO) 1%',
  'Ketoconazole IP 2.0% w/v, Zinc Pyrithione 1.0% w/v',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'Glenmark Pharmaceuticals',
  '100ml Bottle',
  290.00,
  260.00,
  0,
  TRUE,
  'Therapeutic anti-dandruff formulation eliminating Malassezia fungus while relieving intense scalp flaking and itching.',
  'Schedule H prescription medicine. Apply to wet scalp, massage into lather, leave for 3 to 5 minutes before rinsing.',
  'Store in cool place. Shake well before use.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Nizral 2% Anti-Dandruff Solution 100ml',
  'nizral-2-anti-dandruff-solution-100ml',
  'Nizral',
  'Ketoconazole IP 2% Medicated Scalp Wash',
  'Ketoconazole IP 2.0% w/v',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'Johnson & Johnson / Janssen',
  '100ml Bottle',
  340.00,
  305.00,
  0,
  TRUE,
  'Gold-standard clinical antifungal scalp solution for stubborn seborrheic dermatitis and pityriasis capitis.',
  'Schedule H prescription medicine. Use twice weekly for 2 to 4 weeks.',
  'Store protected from light below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Selsun Suspension Shampoo 120ml',
  'selsun-suspension-shampoo-120ml',
  'Selsun',
  'Selenium Sulfide USP 2.5% Scalp Suspension',
  'Selenium Sulfide USP 2.5% w/v in buffered suspension',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'Abbott India Ltd',
  '120ml Bottle',
  350.00,
  315.00,
  0,
  FALSE,
  'Cytostatic and anti-keratolysing medicated shampoo tackling deep-rooted dandruff and greasy scalp scale.',
  'Shake well. Massage into wet hair, allow 2-3 minutes of contact time and rinse thoroughly.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Bajaj Almond Drops Hair Oil 200ml',
  'bajaj-almond-drops-hair-oil-200ml',
  'Bajaj Almond Drops',
  'Sweet Almond Oil Enriched with Vitamin E',
  'Sweet Almond Oil 10%, Vitamin E acetate, Light liquid paraffin base',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'Bajaj Consumer Care Ltd',
  '200ml Bottle',
  165.00,
  152.00,
  0,
  FALSE,
  'Light, non-sticky almond hair oil that deeply conditions hair strands to reduce hair breakage and split ends.',
  'Massage gently into scalp and hair lengths before or after hair wash.',
  'Store in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Parachute Pure Coconut Oil 250ml',
  'parachute-pure-coconut-oil-250ml',
  'Parachute',
  '100% Pure Edible Grade Coconut Oil',
  '100% Pure Virgin Grade Cold-Filtered Coconut Oil',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'Marico Ltd',
  '250ml Bottle',
  115.00,
  108.00,
  0,
  FALSE,
  'Pure, multi-stage filtered coconut oil providing natural nourishment and deep moisture to hair roots.',
  'Warm slightly and massage onto scalp for 10-15 minutes.',
  'Store away from moisture. Solidifies below 24°C naturally.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Kesh King Ayurvedic Hair Oil 100ml',
  'kesh-king-ayurvedic-hair-oil-100ml',
  'Kesh King',
  'Tel Pak Vidhi Ayurvedic Hair Therapy Oil',
  'Bhringraj, Amalaki, Methi, Brahmi, Jatamansi and 21 rare medicinal herbs boiled in sesame oil',
  (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
  'Emami Ltd',
  '100ml Bottle with Deep Root Comb',
  170.00,
  155.00,
  0,
  FALSE,
  'Proprietary Ayurvedic hair therapy that stimulates hair follicles, promotes growth and reduces chronic hair fall.',
  'Apply using attached root applicator directly to scalp before bedtime.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Ciplox Eye Drops 10ml',
  'ciplox-eye-drops-10ml',
  'Ciplox',
  'Ciprofloxacin Ophthalmic Solution 0.3%',
  'Ciprofloxacin Hydrochloride IP equivalent to Ciprofloxacin 0.3% w/v',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'Cipla Ltd',
  '10ml Dropper Bottle',
  19.50,
  18.00,
  0,
  TRUE,
  'Fluoroquinolone antibiotic eye drops indicated for acute bacterial conjunctivitis, corneal ulcers and blepharitis.',
  'Schedule H prescription medicine. Instill 1 to 2 drops into affected eye(s) every 4 to 6 hours as prescribed. Do not touch dropper tip.',
  'Store below 25°C. Discard 1 month after opening vial.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Refresh Tears Eye Drops 10ml',
  'refresh-tears-eye-drops-10ml',
  'Refresh Tears',
  'Carboxymethylcellulose Sodium 0.5% Lubricant',
  'Carboxymethylcellulose Sodium IP 0.5% w/v, Purite preservative',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Allergan India / AbbVie',
  '10ml Dropper Bottle',
  160.00,
  145.00,
  0,
  FALSE,
  'Gentle lubricating artificial tears providing long-lasting soothing relief from dry, irritated, tired eyes.',
  'Instill 1 to 2 drops in the affected eye(s) as needed for lubrication.',
  'Store below 25°C. Keep bottle tightly closed.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Systane Ultra Lubricant Eye Drops 10ml',
  'systane-ultra-lubricant-eye-drops-10ml',
  'Systane Ultra',
  'Polyethylene Glycol 400 + Propylene Glycol Eye Drops',
  'Polyethylene Glycol 400 0.4%, Propylene Glycol 0.3%, HP-Guar gelling agent',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Alcon Laboratories India',
  '10ml Dropper Bottle',
  470.00,
  420.00,
  0,
  FALSE,
  'High-performance ocular lubricant for intense dry eye discomfort, screen fatigue and burning sensation.',
  'Instill 1 or 2 drops in the affected eye(s) as needed.',
  'Store between 15°C and 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Tobastar Eye Drops 5ml',
  'tobastar-eye-drops-5ml',
  'Tobastar',
  'Tobramycin Ophthalmic Solution 0.3%',
  'Tobramycin IP 0.3% w/v',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'Mankind Pharma Ltd',
  '5ml Dropper Bottle',
  55.00,
  49.00,
  0,
  TRUE,
  'Aminoglycoside antibiotic ophthalmic drops for superficial external ocular infections caused by susceptible pathogens.',
  'Schedule H prescription medicine. Strictly as directed by an ophthalmologist.',
  'Store below 25°C protected from light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Moxicip Eye Drops 5ml',
  'moxicip-eye-drops-5ml',
  'Moxicip',
  'Moxifloxacin Ophthalmic Solution 0.5%',
  'Moxifloxacin Hydrochloride equivalent to Moxifloxacin 0.5% w/v',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'Cipla Ltd',
  '5ml Dropper Bottle',
  110.00,
  99.00,
  0,
  TRUE,
  'Broad-spectrum 4th-generation fluoroquinolone eye drops for severe bacterial eye infections.',
  'Schedule H prescription medicine. 1 drop 3 times daily as prescribed.',
  'Store below 25°C. Discard within 30 days of opening.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Itone Herbal Eye Drops 10ml',
  'itone-herbal-eye-drops-10ml',
  'Itone',
  'Ayurvedic Sterile Soothing Herbal Eye Drops',
  'Nimba, Sobhanjana, Bhringaraj, Punarnava, Tulsi, Rose Water and Camphor in sterile aqueous base',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Dey''s Medical Stores',
  '10ml Dropper Bottle',
  75.00,
  70.00,
  0,
  FALSE,
  'Pure Ayurvedic cooling eye wash that relieves redness, dust strain, screen glare and pollution irritation.',
  '1 to 2 drops twice daily or as needed.',
  'Keep dropper sterile. Store in cool place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Otrivin Adult Nasal Drops 10ml',
  'otrivin-adult-nasal-drops-10ml',
  'Otrivin',
  'Xylometazoline Hydrochloride 0.1% Nasal Solution',
  'Xylometazoline Hydrochloride IP 0.1% w/v',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Haleon India (GlaxoSmithKline)',
  '10ml Dropper Bottle',
  115.00,
  105.00,
  0,
  FALSE,
  'Fast decongestant nasal drops opening congested nasal passages within 2 minutes for up to 10 hours.',
  'Adults: 2 to 3 drops in each nostril 2-3 times daily. Do not use for more than 5 consecutive days.',
  'Store below 30°C. Protect from heat.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Otrivin Oxy Fast Relief Spray 10ml',
  'otrivin-oxy-fast-relief-spray-10ml',
  'Otrivin Oxy',
  'Oxymetazoline Hydrochloride 0.05% Nasal Spray',
  'Oxymetazoline Hydrochloride IP 0.05% w/v',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Haleon India',
  '10ml Metered Spray Bottle',
  125.00,
  115.00,
  0,
  FALSE,
  'Metered dose nasal spray delivering precise fine mist for rapid relief of blocked nasal airways.',
  '1 spray in each nostril every 10 to 12 hours. Do not exceed 2 sprays in 24 hours.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Nasivion Adult Nasal Drops 10ml',
  'nasivion-adult-nasal-drops-10ml',
  'Nasivion',
  'Oxymetazoline Hydrochloride 0.05% Nasal Drops',
  'Oxymetazoline Hydrochloride IP 0.05% w/v',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Merck Ltd / Procter & Gamble',
  '10ml Dropper Bottle',
  105.00,
  96.00,
  0,
  FALSE,
  'Fast-action nasal decongestant relieving sinus pressure and allergic nasal blockade.',
  '1 to 2 drops in each nostril twice daily. Do not use continuously for over a week.',
  'Store below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Soliwax Ear Drops 10ml',
  'soliwax-ear-drops-10ml',
  'Soliwax',
  'Ear Wax Dissolving & Pain Relief Drops',
  'Paradichlorobenzene 2.0%, Benzocaine 2.7%, Chlorbutol 5.0%, Turpentine Oil 15.0%',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Entod Pharmaceuticals',
  '10ml Dropper Bottle',
  88.00,
  80.00,
  0,
  TRUE,
  'Cerumenolytic ear drops that dissolve hardened, impacted ear wax while numbing canal pain.',
  'Schedule H prescription medicine. Instill 4 to 5 drops into affected ear, keep head tilted for 10 minutes.',
  'Store protected from heat and light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Clearwax Ear Drops 10ml',
  'clearwax-ear-drops-10ml',
  'Clearwax',
  'Cerumenolytic & Antiseptic Ear Solution',
  'Paradichlorobenzene 2.0%, Benzocaine 2.7%, Chlorbutol 5.0%, Turpentine Oil 15.0%',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Cipla Ltd',
  '10ml Dropper Bottle',
  95.00,
  86.00,
  0,
  TRUE,
  'Fast-acting ear wax softening drops that facilitate gentle natural removal and prevent syringing injury.',
  'Schedule H prescription medicine. Instill as prescribed by ENT physician.',
  'Keep bottle tightly closed.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Waxolve Ear Drops 10ml',
  'waxolve-ear-drops-10ml',
  'Waxolve',
  'Wax Softening Ear Drops with Local Anaesthetic',
  'Paradichlorobenzene IP 2.0%, Benzocaine IP 2.7%, Chlorbutol IP 5.0%, Turpentine Oil BP 15.0%',
  (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
  'Laborate Pharmaceuticals',
  '10ml Dropper Bottle',
  65.00,
  58.00,
  0,
  TRUE,
  'Affordable cerumenolytic solution easing ear fullness, reduced hearing and hardened wax discomfort.',
  'Schedule H prescription medicine. For otic use only.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Sensodyne Fresh Mint Toothpaste 75g',
  'sensodyne-fresh-mint-toothpaste-75g',
  'Sensodyne',
  'Potassium Nitrate 5% Desensitizing Toothpaste',
  'Potassium Nitrate 5.0% w/w, Sodium Fluoride 0.221% w/w in foaming gel base',
  (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
  'Haleon India (GlaxoSmithKline)',
  '75g Tube',
  160.00,
  148.00,
  0,
  FALSE,
  'Clinically proven daily toothpaste calming exposed dentine nerve fibers to provide lasting hypersensitivity relief.',
  'Brush thoroughly twice daily with a soft toothbrush. Do not swallow.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Thermoseal Pro Toothpaste 100g',
  'thermoseal-pro-toothpaste-100g',
  'Thermoseal',
  'Potassium Nitrate & Fluoride Medicated Toothpaste',
  'Potassium Nitrate 5% w/w, Sodium Monofluorophosphate 0.7% w/w',
  (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
  'ICPA Health Products Ltd',
  '100g Tube',
  155.00,
  140.00,
  0,
  FALSE,
  'Dentist-recommended desensitizing toothpaste shielding teeth from sharp pain induced by hot, cold, sweet or sour food.',
  'Use small pea-sized amount on soft brush twice daily.',
  'Keep cap closed after use.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Clohex Plus Mouthwash 150ml',
  'clohex-plus-mouthwash-150ml',
  'Clohex Plus',
  'Chlorhexidine Gluconate 0.2% Antiseptic Rinse',
  'Chlorhexidine Gluconate Solution IP equivalent to Chlorhexidine Gluconate 0.2% w/v',
  (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
  'Dr. Reddy''s Laboratories',
  '150ml Bottle',
  120.00,
  108.00,
  0,
  FALSE,
  'Gold-standard antimicrobial oral rinse inhibiting plaque bacteria, gingivitis and periodontal bleeding.',
  'Rinse mouth vigorously with 10ml undiluted for 1 minute twice daily after brushing. Do not swallow.',
  'Store below 25°C away from direct sunlight.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Rexidin Plus Mouthwash 150ml',
  'rexidin-plus-mouthwash-150ml',
  'Rexidin Plus',
  'Chlorhexidine + Fluoride + Zinc Dental Rinse',
  'Chlorhexidine Gluconate 0.2% w/v, Sodium Fluoride 0.05% w/v, Zinc Chloride 0.09% w/v',
  (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
  'Indoco Remedies Ltd',
  '150ml Bottle',
  125.00,
  112.00,
  0,
  FALSE,
  'Comprehensive triple-action medicated oral rinse protecting gums, freshening breath and remineralizing enamel.',
  'Swish 10ml in mouth for 30-60 seconds after meals.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dologel CT Mouth Gel 10g',
  'dologel-ct-mouth-gel-10g',
  'Dologel CT',
  'Choline Salicylate & Cetalkonium Chloride Oral Gel',
  'Choline Salicylate 8.7% w/w, Cetalkonium Chloride 0.01% w/w',
  (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
  'Dr. Reddy''s Laboratories',
  '10g Tube',
  85.00,
  78.00,
  0,
  FALSE,
  'Fast-numbing soothing gel for mouth ulcers, denture irritation, inflamed gums and aphthous sores.',
  'Apply with clean finger directly to ulcerated spot 3 to 4 times a day before meals.',
  'Store below 25°C. For oral application only.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Zytee RB Gel 10ml',
  'zytee-rb-gel-10ml',
  'Zytee RB',
  'Choline Salicylate & Benzalkonium Chloride Gel',
  'Choline Salicylate 8.7% w/w, Benzalkonium Chloride 0.01% w/w',
  (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
  'Raptakos Brett & Co',
  '10ml Tube',
  98.00,
  90.00,
  0,
  FALSE,
  'Topical analgesic oral gel delivering quick relief from painful cheek bites, canker sores and orthodontic irritation.',
  'Massage small quantity gently over painful mouth lesions.',
  'Store in cool place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dabur Red Toothpaste 150g',
  'dabur-red-toothpaste-150g',
  'Dabur Red',
  'Ayurvedic Clove, Mint & Tomar Herbal Toothpaste',
  'Laung (Clove Oil), Pudina Satva, Tomar Beej, Sunthi and Maricha in traditional clay base',
  (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
  'Dabur India Ltd',
  '150g Tube',
  115.00,
  105.00,
  0,
  FALSE,
  'Scientifically validated Ayurvedic toothpaste protecting against toothache, bad breath, plaque and bleeding gums.',
  'Brush twice daily morning and night.',
  'Keep tube closed in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Johnson''s Baby Soap 100g',
  'johnsons-baby-soap-100g',
  'Johnson''s Baby',
  'Gentle Baby Cleansing Bar with Moisturizer',
  'Mild syndet surfactant blend with Vitamin E and 1/4th moisturizing baby lotion',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Johnson & Johnson Pvt Ltd',
  '100g Bar',
  75.00,
  70.00,
  0,
  FALSE,
  'Clinically proven mild baby bathing soap enriched with moisture to preserve natural skin lipid barrier.',
  'Lather gently over baby''s body and rinse with lukewarm water.',
  'Keep in dry soap dish after use.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Johnson''s Baby Powder 200g',
  'johnsons-baby-powder-200g',
  'Johnson''s Baby',
  'Hypoallergenic Pure Baby Talc',
  'Purified cosmetic talc with gentle floral fragrance',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Johnson & Johnson Pvt Ltd',
  '200g Dispenser Bottle',
  170.00,
  158.00,
  0,
  FALSE,
  'Pure, gentle talcum powder that absorbs excess moisture and friction to keep baby''s skin dry and comfortable.',
  'Dust lightly onto hands away from baby''s face and smooth over skin after bath and diaper change.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Sebamed Baby Wash Extra Soft 200ml',
  'sebamed-baby-wash-extra-soft-200ml',
  'Sebamed',
  'Soap-Free Baby Body Wash pH 5.5',
  'Sugar-tenside cleansing complex, Squalane, Allantoin in physiological pH 5.5 formulation',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Sebapharma Germany / USV Pvt Ltd',
  '200ml Bottle',
  450.00,
  410.00,
  0,
  FALSE,
  '100% soap and alkali-free ultra-mild baby wash maintaining the protective acid mantle of delicate infant skin.',
  'Apply few drops to wet sponge, lather softly and wash baby gently.',
  'Store below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Himalaya Baby Massage Oil 200ml',
  'himalaya-baby-massage-oil-200ml',
  'Himalaya Baby',
  'Olive Oil & Winter Cherry Baby Massage Oil',
  'Olive Oil, Winter Cherry (Ashwagandha), Aloe Vera, Khus Khus in light herbal oil base',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Himalaya Wellness Company',
  '200ml Bottle',
  195.00,
  180.00,
  0,
  FALSE,
  'Nourishing daily baby massage oil that strengthens limbs, improves muscle tone and keeps infant skin soft.',
  'Warm a small amount in palms and massage gently all over baby before bath.',
  'Store in dry place away from heat.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Himalaya Baby Diaper Rash Cream 50g',
  'himalaya-baby-diaper-rash-cream-50g',
  'Himalaya Baby',
  'Yashada Bhasma & Nirgundi Diaper Rash Cream',
  'Yashada Bhasma (Zinc Calx), Nirgundi (Five-leaved Chaste tree), Almond Oil, Aloe Vera',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Himalaya Wellness Company',
  '50g Tube',
  125.00,
  115.00,
  0,
  FALSE,
  'Protective barrier cream providing rapid soothing and healing of diaper erythema and chafing friction.',
  'Apply generously to clean and dry diaper area during every diaper change.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Woodward''s Gripe Water 130ml',
  'woodwards-gripe-water-130ml',
  'Woodward''s',
  'Dill Seed Oil & Sarjikakshara Gripe Water',
  'Terpeneless Dill Seed Oil 0.005ml, Sarjikakshara (Sodium Bicarbonate) 52.5mg per 5ml',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'TTK Healthcare Ltd',
  '130ml Bottle',
  60.00,
  56.00,
  0,
  FALSE,
  'Time-honoured alcohol-free formulation providing natural relief from infant colic, trapped gas and teething distress.',
  'Administer according to age recommendations on pack using a measuring spoon.',
  'Keep in cool dry place away from sunlight.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Bonnisan Baby Drops 30ml',
  'bonnisan-baby-drops-30ml',
  'Himalaya',
  'Ayurvedic Digestive Tonic Drops for Infants',
  'Dill Oil, Cardamom (Elaichi), Tinospora cordifolia (Guduchi), Pippali, Amalaki',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Himalaya Wellness Company',
  '30ml Dropper Bottle',
  65.00,
  60.00,
  0,
  FALSE,
  'Herbal digestive drops that combat common infant tummy aches, improve appetite and regulate bowel movements.',
  'Administer with dropper 15 minutes before feed as directed by pediatrician.',
  'Store in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Stayfree Secure Cottony Soft XL 18s',
  'stayfree-secure-cottony-soft-xl-18s',
  'Stayfree',
  'Cottony Soft Sanitary Napkins with Wings XL',
  'Cellulose absorbent core with gel lock technology and cottony soft cover',
  (SELECT id FROM public.categories WHERE slug = 'womens-health' LIMIT 1),
  'Johnson & Johnson Pvt Ltd',
  'Pack of 18 Pads',
  145.00,
  135.00,
  0,
  FALSE,
  'Extra-long sanitary napkins with odor control and deep channels for leak-proof comfort during heavy menstrual flow.',
  'Change pad every 4 to 6 hours for optimal feminine hygiene.',
  'Store in clean, dry sanitary place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Whisper Choice Ultra XL 20s',
  'whisper-choice-ultra-xl-20s',
  'Whisper',
  'Ultra Thin Sanitary Pads with Wings XL',
  'Super absorbent polymer (SAP) core with dri-weave top layer',
  (SELECT id FROM public.categories WHERE slug = 'womens-health' LIMIT 1),
  'Procter & Gamble Hygiene and Health Care',
  'Pack of 20 Pads',
  135.00,
  125.00,
  0,
  FALSE,
  'Ultra-thin menstrual hygiene pads with up to 100% stain protection and all-day odor neutralizing freshness.',
  'Dispose wrapped in paper. Do not flush.',
  'Store in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Meftal-Spas DS Tablet',
  'meftal-spas-ds-tablet',
  'Meftal-Spas DS',
  'Mefenamic Acid 500mg + Dicyclomine 20mg',
  'Mefenamic Acid IP 500mg, Dicyclomine Hydrochloride IP 20mg',
  (SELECT id FROM public.categories WHERE slug = 'womens-health' LIMIT 1),
  'Blue Cross Laboratories',
  'Strip of 10 Tablets',
  72.00,
  65.00,
  0,
  TRUE,
  'Double-strength antispasmodic and analgesic tablet for severe dysmenorrhea, uterine cramps and pelvic colic.',
  'Schedule H prescription medicine. Take after meals as prescribed by gynecologist.',
  'Store protected from light below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'VWash Plus Intimate Hygiene Wash 100ml',
  'vwash-plus-intimate-hygiene-wash-100ml',
  'VWash Plus',
  'Lactic Acid & Tea Tree Oil Intimate Cleanser pH 3.5',
  'Lactic Acid 1.2% w/v, Tea Tree Oil, Sea Buckthorn Oil in gentle cleansing base',
  (SELECT id FROM public.categories WHERE slug = 'womens-health' LIMIT 1),
  'Glenmark Pharmaceuticals',
  '100ml Bottle',
  195.00,
  175.00,
  0,
  FALSE,
  'Feminine intimate wash maintaining the natural 3.5 pH balance to prevent dryness, irritation and intimate bacterial infections.',
  'Pour few drops onto wet palm, gently wash intimate area and rinse thoroughly with water.',
  'Store below 30°C in cool place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Candid V3 Vaginal Tablet',
  'candid-v3-vaginal-tablet',
  'Candid V3',
  'Clotrimazole 200mg Vaginal Pessaries',
  'Clotrimazole IP 200mg per vaginal tablet with applicator',
  (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
  'Glenmark Pharmaceuticals',
  'Strip of 3 Tablets with Applicator',
  98.00,
  88.00,
  0,
  TRUE,
  'Prescription 3-day targeted antifungal therapy for vaginal candidiasis (yeast infection) and vulvovaginitis.',
  'Schedule H prescription medicine. Insert 1 tablet deeply into vagina using applicator at bedtime for 3 consecutive nights.',
  'Store below 25°C in dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Autrin Capsule',
  'autrin-capsule',
  'Autrin',
  'Ferrous Fumarate, Folic Acid & Vitamin B12',
  'Ferrous Fumarate 300mg (Elemental Iron 98.6mg), Folic Acid 1.5mg, Cyanocobalamin 15mcg',
  (SELECT id FROM public.categories WHERE slug = 'nutritional-drinks-powders' LIMIT 1),
  'Pfizer India Ltd',
  'Strip of 30 Capsules',
  148.00,
  135.00,
  0,
  FALSE,
  'Comprehensive iron, folate and B12 hematinic for treatment of iron-deficiency anemia in adolescent and adult women.',
  '1 capsule daily after a main meal.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dexorange Syrup 200ml',
  'dexorange-syrup-200ml',
  'Dexorange',
  'Ferric Ammonium Citrate, Cyanocobalamin & Folic Acid',
  'Ferric Ammonium Citrate IP 160mg (Elemental Iron 32.8mg), Cyanocobalamin IP 7.5mcg, Folic Acid IP 0.5mg per 15ml',
  (SELECT id FROM public.categories WHERE slug = 'nutritional-drinks-powders' LIMIT 1),
  'Franco-Indian Pharmaceuticals',
  '200ml Orange Flavour Bottle',
  172.00,
  155.00,
  0,
  FALSE,
  'India''s leading haematinic syrup replenishing hemoglobin levels, reversing fatigue and improving red blood cell production.',
  'Adults: 1 tablespoonful (15ml) twice daily after food.',
  'Store in cool and dark place. Shake bottle before use.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Revital H Men Capsule',
  'revital-h-men-capsule',
  'Revital H',
  'Ginseng, 10 Vitamins & 9 Minerals Men''s Daily Formula',
  'Ginseng Extract 42.5mg, 10 Vitamins, 9 Minerals and Zinc in soft gelatin capsule',
  (SELECT id FROM public.categories WHERE slug = 'nutritional-drinks-powders' LIMIT 1),
  'Sun Pharmaceutical Industries',
  'Strip of 30 Capsules',
  350.00,
  315.00,
  0,
  FALSE,
  'Daily health supplement providing stamina, mental alertness and active energy for demanding working routines.',
  '1 capsule daily after breakfast or lunch with water.',
  'Store in a cool and dry place below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dabur Shilajit Gold Capsule',
  'dabur-shilajit-gold-capsule',
  'Dabur Shilajit Gold',
  'Shuddha Shilajit, Swarna Bhasma, Kesar & Ashwagandha',
  'Purified Shilajit 50mg, Swarna Bhasma 2.4mg, Kesar 25mg, Ashwagandha 100mg, Kaunch Beej, Safed Musli',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Dabur India Ltd',
  'Strip of 10 Capsules',
  275.00,
  250.00,
  0,
  FALSE,
  'Premium Ayurvedic revitalizer formulated with pure gold calx and shilajit to combat physical weakness and boost vigor.',
  '1 capsule twice daily, preferably with warm milk.',
  'Store in cool place away from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Baidyanath Musli Pak Special 100g',
  'baidyanath-musli-pak-special-100g',
  'Baidyanath',
  'Safed Musli & Classical Rasayana Granules',
  'Safed Musli (Chlorophytum borivilianum), Ashwagandha, Shatavari, Jaiphal, Javitri, Vang Bhasma',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Shree Baidyanath Ayurved Bhawan',
  '100g Jar',
  220.00,
  200.00,
  0,
  FALSE,
  'Classical Ayurvedic nutritive rasayana promoting endurance, muscle strength and vital physical resilience.',
  '1 to 2 teaspoonfuls twice daily with warm milk.',
  'Keep lid tightly closed.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Manforce 50mg Tablet',
  'manforce-50mg-tablet',
  'Manforce',
  'Sildenafil Citrate 50mg',
  'Sildenafil Citrate IP equivalent to Sildenafil 50mg',
  (SELECT id FROM public.categories WHERE slug = 'mens-health' LIMIT 1),
  'Mankind Pharma Ltd',
  'Strip of 4 Tablets',
  110.00,
  98.00,
  0,
  TRUE,
  'PDE5 inhibitor prescribed for erectile dysfunction in adult men.',
  'Schedule H prescription medicine. Take approximately 1 hour before sexual activity as prescribed. Strictly contraindicated with nitrate cardiac medications.',
  'Store below 30°C protected from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Himalaya Confido Tablet',
  'himalaya-confido-tablet',
  'Himalaya Confido',
  'Gokshura & Kapikacchu Ayurvedic Formula',
  'Gokshura (Tribulus terrestris), Kapikacchu (Mucuna pruriens), Jeevanti, Shaileyam',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Himalaya Wellness Company',
  'Bottle of 60 Tablets',
  180.00,
  165.00,
  0,
  FALSE,
  'Ayurvedic non-hormonal androgenic support that regulates reproductive performance and alleviates performance anxiety.',
  '1 tablet twice daily or as advised by Ayurvedic physician.',
  'Store in cool and dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Durex Extra Thin Condoms 10s',
  'durex-extra-thin-condoms-10s',
  'Durex',
  'Ultra Thin Lubricated Natural Rubber Latex Condoms',
  'Natural rubber latex, silicone lubricant, reservoir teats',
  (SELECT id FROM public.categories WHERE slug = 'mens-health' LIMIT 1),
  'Reckitt Benckiser Healthcare',
  'Pack of 10 Condoms',
  240.00,
  220.00,
  0,
  FALSE,
  'Ultra-thin condoms offering heightened tactile sensation while ensuring 100% dermatologically tested barrier protection.',
  'Single use only. Read enclosed leaflet carefully.',
  'Store in cool, dry place away from heat and direct sunlight.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Manforce Extra Dotted Condoms 10s',
  'manforce-extra-dotted-condoms-10s',
  'Manforce',
  'Contoured Dotted Latex Lubricated Condoms',
  'Premium natural rubber latex with textured dotting and reservoir tip',
  (SELECT id FROM public.categories WHERE slug = 'mens-health' LIMIT 1),
  'Mankind Pharma Ltd',
  'Pack of 10 Condoms',
  90.00,
  82.00,
  0,
  FALSE,
  'Electronically tested dotted condoms for intimate pleasure, family planning and STI prevention.',
  'Use once per sexual intercourse. Store safely.',
  'Keep in dry conditions below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Folvite 5mg Tablet',
  'folvite-5mg-tablet',
  'Folvite',
  'Folic Acid IP 5mg',
  'Folic Acid IP 5mg',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Pfizer India Ltd',
  'Strip of 45 Tablets',
  80.00,
  72.00,
  0,
  FALSE,
  'Essential peri-conceptional folate supplement preventing neural tube birth defects and maternal megaloblastic anemia.',
  '1 tablet daily before conception and during first trimester as advised by obstetrician.',
  'Store protected from light and moisture below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Orofer XT Tablet',
  'orofer-xt-tablet',
  'Orofer XT',
  'Ferrous Ascorbate 100mg + Folic Acid 1.5mg',
  'Ferrous Ascorbate equivalent to Elemental Iron 100mg, Folic Acid IP 1.5mg',
  (SELECT id FROM public.categories WHERE slug = 'nutritional-drinks-powders' LIMIT 1),
  'Emcure Pharmaceuticals',
  'Strip of 10 Tablets',
  175.00,
  158.00,
  0,
  TRUE,
  'High-absorption iron ascorbate with folate for managing pregnancy-related iron deficiency and supporting fetal development.',
  'Schedule H prescription medicine. Take 1 tablet daily after food.',
  'Store below 25°C in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Prega News Pregnancy Test Kit',
  'prega-news-pregnancy-test-kit',
  'Prega News',
  'One Step Urine HCG Pregnancy Detection Device',
  'Monoclonal anti-hCG antibody coated membrane test cassette with dropper',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Mankind Pharma Ltd',
  'Single Test Device Kit',
  60.00,
  55.00,
  0,
  FALSE,
  'Accurate home pregnancy test detecting presence of human Chorionic Gonadotropin (hCG) in urine within 5 minutes.',
  'Collect first morning urine sample. Add 3 drops to sample well (S). Read results between 3 to 5 minutes: 2 lines indicate positive.',
  'Store pouch sealed at room temperature (4°C-30°C). Do not freeze.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'i-can One Step Pregnancy Test Kit',
  'i-can-one-step-pregnancy-test-kit',
  'i-can',
  'Rapid HCG Chromatographic Immunoassay Device',
  'Colloidal gold conjugated anti-hCG test strip device',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Piramal Pharma Ltd',
  'Single Test Device Kit',
  55.00,
  50.00,
  0,
  FALSE,
  'High sensitivity rapid pregnancy detection cassette delivering 99% reliable results from day one of missed period.',
  'Use first urine of morning for highest accuracy.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Palmagel Stretch Mark Cream 125g',
  'palmagel-stretch-mark-cream-125g',
  'Palmagel',
  'Cocoa Butter, Vitamin E & Collagen Stretch Mark Formula',
  'Pure Cocoa Butter, Shea Butter, Vitamin E, Lutein, Bio-Elaste (Collagen & Elastin)',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Cipla Ltd',
  '125g Tube',
  475.00,
  425.00,
  0,
  FALSE,
  'Dermatologically tested massage cream improving skin elasticity and reducing pregnancy stretch mark formation.',
  'Massage gently in circular motions over abdomen, hips, thighs and breasts twice daily.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Lactare Capsule',
  'lactare-capsule',
  'Lactare',
  'Ayurvedic Galactagogue Shatavari & Herbal Capsules',
  'Asparagus racemosus (Shatavari) 200mg, Withania somnifera 100mg, Trigonella foenum-graecum (Methi) 50mg, Yashtimadhu',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Alkem Laboratories Ltd',
  'Strip of 10 Capsules',
  140.00,
  128.00,
  0,
  FALSE,
  'Natural Ayurvedic galactagogue supporting healthy breast milk secretion and post-partum maternal stamina.',
  '2 capsules twice daily with warm milk or as directed by doctor.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Doxinate Tablet',
  'doxinate-tablet',
  'Doxinate',
  'Doxylamine Succinate 10mg + Pyridoxine 10mg',
  'Doxylamine Succinate IP 10mg, Pyridoxine Hydrochloride IP 10mg',
  (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
  'Mankind Pharma Ltd',
  'Strip of 30 Tablets',
  215.00,
  195.00,
  0,
  TRUE,
  'First-line anti-emetic therapy specifically prescribed for morning sickness, nausea and vomiting in pregnancy (NVP).',
  'Schedule H prescription medicine. Take 2 tablets at bedtime on an empty stomach as prescribed.',
  'Store below 25°C protected from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Volini Pain Relief Spray 40g',
  'volini-pain-relief-spray-40g',
  'Volini',
  'Diclofenac Diethylamine, Linseed Oil & Menthol Spray',
  'Diclofenac Diethylamine 1.16% w/w, Virgin Linseed Oil 3.0%, Methyl Salicylate 10.0%, Menthol 5.0%',
  (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
  'Sun Pharmaceutical Industries',
  '40g Aerosol Spray',
  160.00,
  148.00,
  0,
  FALSE,
  'Rapid-penetrating aerosol pain spray delivering instant relief from neck strain, sprains, joint pain and sports injuries.',
  'Shake well. Spray from 5cm distance onto painful area 3 to 4 times a day. Do not spray on open cuts or face.',
  'Pressurized container. Keep away from heat and open flame.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Volini Pain Relief Gel 30g',
  'volini-pain-relief-gel-30g',
  'Volini',
  'Diclofenac Diethylamine Topical Pain Gel',
  'Diclofenac Diethylamine 1.16% w/w, Linseed Oil 3.0%, Methyl Salicylate 10.0%, Menthol 5.0%',
  (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
  'Sun Pharmaceutical Industries',
  '30g Tube',
  125.00,
  114.00,
  0,
  FALSE,
  'Deep micro-gel technology that targets source of inflammation to provide prolonged joint and muscle comfort.',
  'Apply gently to affected area. Do not rub vigorously. Wash hands after application.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Moov Pain Relief Specialist Cream 50g',
  'moov-pain-relief-specialist-cream-50g',
  'Moov',
  'Ayurvedic Nilgiri & Wintergreen Back Pain Cream',
  'Oil of Wintergreen 15%, Pudina ka Phool (Menthol) 5%, Tarpin ka Tel 3%, Nilgiri Tel (Eucalyptus) 2%',
  (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
  'Reckitt Benckiser India',
  '50g Tube',
  195.00,
  180.00,
  0,
  FALSE,
  'Specialist warm-action cream fortified with 4 active Ayurvedic oils for backache, neck pain and muscular spasms.',
  'Massage gently onto affected area until absorbed. Use twice to thrice daily.',
  'Keep cap tightly closed in cool place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Moov Pain Relief Spray 50g',
  'moov-pain-relief-spray-50g',
  'Moov',
  'Fast Acting Ayurvedic Back Pain Aerosol Spray',
  'Wintergreen Oil, Pudina Satva, Eucalyptus Oil, Turpentine Oil',
  (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
  'Reckitt Benckiser India',
  '50g Spray Can',
  185.00,
  170.00,
  0,
  FALSE,
  'Instant touch-free spray providing deep warm sensation for stiff neck, muscle pulls and acute low back pain.',
  'Hold can 5cm away and spray on affected site.',
  'Store away from sunlight and temperatures exceeding 50°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Fastum Gel 30g',
  'fastum-gel-30g',
  'Fastum',
  'Ketoprofen 2.5% Non-Steroidal Topical Gel',
  'Ketoprofen BP 2.5% w/w in hydroalcoholic gel base',
  (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
  'Menarini India Pvt Ltd',
  '30g Tube',
  145.00,
  130.00,
  0,
  TRUE,
  'Prescription topical NSAID gel for acute tendonitis, tenosynovitis, bursitis and post-traumatic soft-tissue contusions.',
  'Schedule H prescription medicine. Apply thin film twice daily.',
  'Store below 25°C. Avoid exposing treated skin to sunlight.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Omnigel 30g',
  'omnigel-30g',
  'Omnigel',
  'Diclofenac, Virgin Linseed Oil, Methyl Salicylate Gel',
  'Diclofenac Diethylamine 1.16% w/w, Virgin Linseed Oil 3%, Methyl Salicylate 10%, Menthol 5%',
  (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
  'Cipla Ltd',
  '30g Tube',
  110.00,
  100.00,
  0,
  FALSE,
  'Quick absorption topical pain relief gel easing arthritis pain, stiffness, sprains and muscle fatigue.',
  'Apply softly to site of pain 3-4 times daily.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Zerodol-P Tablet',
  'zerodol-p-tablet',
  'Zerodol-P',
  'Aceclofenac 100mg + Paracetamol 325mg',
  'Aceclofenac IP 100mg, Paracetamol IP 325mg',
  (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
  'Ipca Laboratories Ltd',
  'Strip of 10 Tablets',
  65.00,
  58.00,
  0,
  TRUE,
  'Prescription NSAID pain reliever formulated for osteoarthritis, rheumatoid arthritis, ankylosing spondylitis and dental pain.',
  'Schedule H prescription drug. 1 tablet twice daily after food.',
  'Store below 30°C in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Flamingo Crepe Bandage 10cm x 4m',
  'flamingo-crepe-bandage-10cm-4m',
  'Flamingo',
  '100% Woven Cotton Compression Crepe Bandage',
  'Pure woven elastic cotton with fast non-fraying edges and clips',
  (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
  'Ascent Meditech Ltd (Flamingo)',
  '1 Roll with Fastening Clips',
  175.00,
  155.00,
  0,
  FALSE,
  'Hospital-grade elastic crepe bandage providing uniform compression and support for joint sprains, varicose veins and muscle strains.',
  'Wrap smoothly with overlapping spirals without impeding blood flow. Hand wash with mild warm water.',
  'Store in dry sanitary package.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Flamingo Crepe Bandage 15cm x 4m',
  'flamingo-crepe-bandage-15cm-4m',
  'Flamingo',
  'Wide Elastic Compression Bandage 15cm',
  'High-stretch 100% cotton woven compression fabric',
  (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
  'Ascent Meditech Ltd',
  '1 Roll with Fastening Clips',
  245.00,
  220.00,
  0,
  FALSE,
  'Extra-wide compression bandage engineered for thigh, knee, ribcage and chest support following orthopedic injuries.',
  'Fasten with attached metal clips.',
  'Keep in dry clean pack.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Flamingo Knee Cap Elastic Medium',
  'flamingo-knee-cap-elastic-medium',
  'Flamingo',
  'Tubular Elastic Knee Compression Support',
  'Cotton-coated rubber yarn with circular knitting technology',
  (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
  'Ascent Meditech Ltd',
  '1 Pair (2 Units) Medium',
  350.00,
  310.00,
  0,
  FALSE,
  'Four-way stretch knee cap delivering even compression, warmth and stability to arthritic, weak or injured knee joints.',
  'Pull over foot up to knee with center seated comfortably on kneecap.',
  'Hand wash in cold water with mild detergent.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Tynor Knee Support Open Patella Large',
  'tynor-knee-support-open-patella-large',
  'Tynor',
  'Neoprene Open Patella Knee Stabilizer Brace',
  'Four-way stretch neoprene fabric with silicone patellar ring cushion',
  (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
  'Tynor Orthotics Pvt Ltd',
  'Single Unit Large',
  490.00,
  440.00,
  0,
  FALSE,
  'Orthopedic knee brace with open patella opening that relieves patellar pressure and stabilizes anterior cruciate ligament.',
  'Position patellar opening directly over knee cap and secure hook-and-loop straps firmly.',
  'Store in clean pouch.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Tynor Cervical Collar Soft with Eyelets Medium',
  'tynor-cervical-collar-soft-medium',
  'Tynor',
  'High-Density Polyurethane Soft Neck Collar',
  'High-density PU foam core covered with hypoallergenic cotton stockinette with ventilation eyelets',
  (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
  'Tynor Orthotics Pvt Ltd',
  'Single Unit Medium',
  340.00,
  300.00,
  0,
  FALSE,
  'Anatomically contoured cervical collar providing gentle immobilization and warm support for cervical spondylosis and neck stiffness.',
  'Wrap collar comfortably around neck and fasten velcro strap at back.',
  'Store in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Flamingo Lumbar Sacro Support Belt Large',
  'flamingo-lumbar-sacro-support-belt-large',
  'Flamingo',
  'Lumbosacral Orthopedic Back Support Belt',
  'Breathable porous elastic webbing with flexible back splints and double-pull velcro straps',
  (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
  'Ascent Meditech Ltd',
  'Single Unit Large',
  780.00,
  699.00,
  0,
  FALSE,
  'Therapeutic lumbar belt immobilizing lumbosacral joint to relieve sciatica, slipped disc pressure and postural lower backache.',
  'Wrap around waist in standing position, align back splints along spine and fasten primary and secondary straps.',
  'Do not iron or dry clean.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Tynor Arm Sling Pouch',
  'tynor-arm-sling-pouch',
  'Tynor',
  'Adjustable Shoulder Immobilization Arm Sling',
  'Durable 3-layered bonded fabric pouch with adjustable shoulder strap and thumb cradle',
  (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
  'Tynor Orthotics Pvt Ltd',
  'Single Unit Universal',
  260.00,
  230.00,
  0,
  FALSE,
  'Ergonomic arm sling pouch supporting fractured, dislocated or post-surgical forearm and shoulder.',
  'Place elbow snugly into corner of pouch, adjust strap length so forearm rests slightly above horizontal.',
  'Store in dry bag.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dettol Antiseptic Liquid 250ml',
  'dettol-antiseptic-liquid-250ml',
  'Dettol',
  'Chloroxylenol IP 4.8% Antiseptic Disinfectant',
  'Chloroxylenol IP 4.8% w/v, Terpineol, Absolute Alcohol (denatured) 9% v/v',
  (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
  'Reckitt Benckiser India',
  '250ml Bottle',
  162.00,
  152.00,
  0,
  FALSE,
  'Trusted hospital and domestic antiseptic for wound cleansing, minor cuts, bites, abrasions and hygiene disinfection.',
  'Dilute 1 tablespoonful (15ml) in a glass of water for cleaning wounds. For external use only. Do not swallow.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Savlon Antiseptic Liquid 200ml',
  'savlon-antiseptic-liquid-200ml',
  'Savlon',
  'Chlorhexidine Gluconate & Cetrimide Antiseptic',
  'Chlorhexidine Gluconate Solution IP 0.3% w/v, Cetrimide IP 3.0% w/v',
  (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
  'ITC Ltd',
  '200ml Bottle',
  110.00,
  102.00,
  0,
  FALSE,
  'Non-stinging antiseptic liquid providing gentle germicidal wash for scrapes, cuts and scratches.',
  'Dilute 1 part Savlon in 15 parts clean water for wound dressing.',
  'Store in cool place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Betadine 10% Antiseptic Solution 100ml',
  'betadine-10-antiseptic-solution-100ml',
  'Betadine',
  'Povidone Iodine 10% Topical Solution',
  'Povidone Iodine IP 10% w/v (available iodine 1% w/v)',
  (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
  'Win-Medicare Pvt Ltd',
  '100ml Bottle',
  140.00,
  128.00,
  0,
  FALSE,
  'Broad-spectrum microbicidal topical solution for pre-operative skin preparation and infected cuts, wounds and burns.',
  'Apply full strength directly to affected skin with sterile cotton swab. External use only.',
  'Store below 25°C protected from light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Betadine 5% Antiseptic Ointment 20g',
  'betadine-5-antiseptic-ointment-20g',
  'Betadine',
  'Povidone Iodine 5% First Aid Ointment',
  'Povidone Iodine IP 5% w/w (0.5% available iodine) in water soluble polyethylene glycol base',
  (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
  'Win-Medicare Pvt Ltd',
  '20g Tube',
  68.00,
  62.00,
  0,
  FALSE,
  'Topical microbicidal ointment that creates an antiseptic film over abrasions, minor burns and wounds.',
  'Clean the injured site and apply thin layer of ointment, dress if necessary.',
  'Store below 25°C. Do not freeze.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Hansaplast Regular Band-Aid 20s',
  'hansaplast-regular-band-aid-20s',
  'Hansaplast',
  'Medicated Fabric Adhesive Wound Strips',
  'Breathable fabric backing with antiseptic silver / benzalkonium pad and skin-friendly zinc oxide adhesive',
  (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
  'Beiersdorf India Pvt Ltd',
  'Pack of 20 Strips',
  55.00,
  50.00,
  0,
  FALSE,
  'Flexible fabric adhesive bandages protecting minor cuts and nicks from dust, bacteria and friction.',
  'Clean cut with antiseptic, peel backing and position pad directly on wound without stretching strip.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dettol Medicated Plasters 10s',
  'dettol-medicated-plasters-10s',
  'Dettol',
  'Washproof Antiseptic First Aid Plasters',
  'Water-resistant perforated plastic backing with antiseptic medicated wound pad',
  (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
  'Reckitt Benckiser India',
  'Pack of 10 Plasters',
  35.00,
  32.00,
  0,
  FALSE,
  'Washproof medicated plasters that seal out water and dirt while promoting clean wound healing.',
  'Replace daily or if wet.',
  'Store in dry envelope.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Absorbent Cotton Wool IP 100g',
  'absorbent-cotton-wool-ip-100g',
  'Bengal Chemicals / Standard',
  '100% Pure Bleached Absorbent Cotton Wool IP',
  'Pure bleached medical-grade absorbent cotton complying with Indian Pharmacopoeia standards',
  (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
  'Bengal Chemicals & Pharmaceuticals Ltd',
  '100g Roll',
  60.00,
  52.00,
  0,
  FALSE,
  'High-absorbency sterilized surgical cotton wool for cleaning wounds, padding dressings and applying antiseptic lotion.',
  'Tear required amount with clean hands.',
  'Store in dry place in original wrapper.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Roller Gauze Bandage 7.5cm x 3m 10s',
  'roller-gauze-bandage-75cm-3m-10s',
  'SurgeCare / Standard',
  'Woven Cotton Gauze Roller Bandage',
  '100% Bleached absorbent woven cotton open-mesh gauze',
  (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
  'Standard Surgical Dressings',
  'Pack of 10 Rolls',
  85.00,
  75.00,
  0,
  FALSE,
  'Soft, breathable surgical gauze bandages for securing primary wound pads, compresses and splints.',
  'Wrap firmly over primary dressing and pin or tape securely.',
  'Keep in dry sanitary storage.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  '3M Micropore Surgical Tape 1 inch',
  '3m-micropore-surgical-tape-1-inch',
  '3M Micropore',
  'Hypoallergenic Surgical Paper Tape 1 inch x 9.1m',
  'Non-woven rayon paper backing with hypoallergenic pressure-sensitive acrylate adhesive',
  (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
  '3M India Ltd',
  '1 Roll with Dispenser',
  85.00,
  75.00,
  0,
  FALSE,
  'Gentle, breathable medical paper tape that adheres reliably to damp skin while permitting painless removal.',
  'Apply to clean, dry skin. Tear cleanly by hand.',
  'Store below 25°C in clean conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  '3M Micropore Surgical Tape 2 inch',
  '3m-micropore-surgical-tape-2-inch',
  '3M Micropore',
  'Wide Hypoallergenic Medical Tape 2 inch',
  'Porous rayon surgical paper tape with skin-friendly adhesive',
  (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
  '3M India Ltd',
  '1 Roll',
  160.00,
  145.00,
  0,
  FALSE,
  'Double-width surgical tape for securing large post-operative dressings, tubing and ostomy devices.',
  'Cut or tear desired length.',
  'Store away from moisture and dust.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Romsons Disposable Latex Gloves Medium 100s',
  'romsons-disposable-latex-gloves-medium-100s',
  'Romsons',
  'Pre-Powdered Medical Examination Gloves Medium',
  'Medical-grade natural rubber latex, lightly powdered with bio-absorbable cornstarch',
  (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
  'Romsons Group of Industries',
  'Box of 100 Gloves (50 Pairs)',
  550.00,
  480.00,
  0,
  FALSE,
  'Tear-resistant medical examination gloves ensuring high tactile sensitivity and microbiological barrier protection.',
  'Single patient use only. Discard into biohazard receptacle after use.',
  'Store below 30°C away from direct sunlight, ozone and fluorescent lamps.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Nitrile Powder-Free Medical Gloves Medium 100s',
  'nitrile-powder-free-medical-gloves-medium-100s',
  'SurgeCare Nitrile',
  'Latex-Free Powder-Free Examination Gloves',
  '100% Synthetic Nitrile Butadiene Rubber polymer (Latex-Free)',
  (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
  'SurgeCare Laboratories',
  'Box of 100 Gloves',
  680.00,
  590.00,
  0,
  FALSE,
  'Hypoallergenic non-latex medical gloves offering superior puncture resistance and chemical barrier for latex-allergic caregivers.',
  'Single use. Non-sterile examination use.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  '3-Ply Surgical Face Mask with Nose Clip 50s',
  '3-ply-surgical-face-mask-with-nose-clip-50s',
  'Venus / SurgeCare',
  '3-Ply Meltblown Bacterial Filtration Face Masks',
  'Outer non-woven spunbond, middle meltblown bacterial filter (BFE >98%), inner soft absorbent skin layer',
  (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
  'Venus Safety & Health Pvt Ltd',
  'Box of 50 Masks',
  150.00,
  120.00,
  0,
  FALSE,
  'ISI certified 3-layer protective face masks with adjustable nose wire and soft ultrasonic-welded ear loops.',
  'Cover nose and mouth completely, pinch nose clip for secure fit. Discard after single day use.',
  'Store in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'N95 Particulate Respirator Mask ISI 5s',
  'n95-particulate-respirator-mask-isi-5s',
  'Venus N95',
  'ISI Certified 5-Layer Particulate Respirator',
  '5-Layer electrostatically charged micro-fiber meltblown filter media with aluminum nose bridge',
  (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
  'Venus Safety & Health Pvt Ltd',
  'Pack of 5 Masks',
  225.00,
  185.00,
  0,
  FALSE,
  'High-filtration respiratory mask filtering >=95% airborne particulates, viruses, bacteria and hazardous dust.',
  'Ensure tight perimeter facial seal. Replace when breathing resistance increases.',
  'Store in resealable pouch.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dispovan Sterile Syringe 2ml with Needle 10s',
  'dispovan-sterile-syringe-2ml-with-needle-10s',
  'Dispovan',
  '2ml Single-Use Sterile Syringe with 24G Needle',
  'Medical-grade polypropylene barrel and plunger with stainless steel 24G siliconized needle',
  (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
  'Hindustan Syringes & Medical Devices Ltd (HMD)',
  'Pack of 10 Sterile Blister Units',
  65.00,
  55.00,
  0,
  FALSE,
  'Precision ethylene-oxide sterilized disposable syringes with ribbon-packed hypodermic needle for clinical injections.',
  'Do not use if blister package is broken or damaged. Single use only. Destroy needle after use.',
  'Store in clean dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dispovan Sterile Syringe 5ml with Needle 10s',
  'dispovan-sterile-syringe-5ml-with-needle-10s',
  'Dispovan',
  '5ml Disposable Sterile Syringe with 23G Needle',
  'Polypropylene medical barrel with high-clarity graduation and 23G hypodermic needle',
  (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
  'Hindustan Syringes & Medical Devices Ltd (HMD)',
  'Pack of 10 Units',
  80.00,
  70.00,
  0,
  FALSE,
  'EO-sterilized single-use 5ml syringes for antibiotics, vaccine reconstitutions and parenteral medications.',
  'Single use only. Dispose in designated sharps container.',
  'Store away from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dr. Morepen Digital Thermometer MT-100',
  'dr-morepen-digital-thermometer-mt-100',
  'Dr. Morepen',
  'High Accuracy Digital Fever Thermometer',
  'Micro-electronic thermistor probe with LCD display, beeper alarm and automatic memory recall',
  (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
  'Morepen Laboratories Ltd',
  'Single Device with Protective Case',
  145.00,
  125.00,
  0,
  FALSE,
  'Fast 60-second digital thermometer providing 100% mercury-free oral, axillary and rectal temperature readings with fever alarm.',
  'Clean probe tip with alcohol swab before and after use. Hold firmly under armpit or under tongue until beep sounds.',
  'Store in hard clear case away from direct sunlight.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Omron Digital Thermometer MC-246',
  'omron-digital-thermometer-mc-246',
  'Omron',
  'Water Resistant Digital Clinical Thermometer',
  'High-precision sensor with water-resistant casing, battery replacement and Celsius/Fahrenheit toggle',
  (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
  'Omron Healthcare India',
  'Single Device in Box',
  250.00,
  220.00,
  0,
  FALSE,
  'Japanese-engineered clinical fever thermometer with waterproof probe for hygienic family monitoring.',
  'Place probe tip in mouth or axilla until beeper sounds.',
  'Keep dry in supplied case.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Omron HEM 7120 Blood Pressure Monitor',
  'omron-hem-7120-blood-pressure-monitor',
  'Omron',
  'Fully Automatic Digital Upper Arm BP Monitor',
  'IntelliSense oscillometric inflation sensor, wide cuff (22-32cm) and digital LCD panel',
  (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
  'Omron Healthcare India',
  '1 Device Unit with Cuff & 4 AA Batteries',
  2150.00,
  1850.00,
  0,
  FALSE,
  'Gold-standard one-touch automatic blood pressure meter with hypertension indicator and body movement detection.',
  'Sit comfortably with feet flat for 5 minutes before measurement. Wrap cuff around upper arm at heart level and press Start.',
  'Store in carrying bag away from moisture and impact.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dr. Trust USA Signature Pulse Oximeter',
  'dr-trust-usa-signature-pulse-oximeter',
  'Dr. Trust',
  'Fingertip SpO2 & Pulse Rate Monitor with OLED',
  'Dual-wavelength photodiode optical sensor with multi-directional OLED display and plethysmograph',
  (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
  'Nureca Ltd (Dr. Trust)',
  '1 Device Unit with Lanyard & Batteries',
  1499.00,
  1199.00,
  0,
  FALSE,
  'High-accuracy medical oximeter displaying arterial blood oxygen saturation (SpO2), pulse rate and perfusion index (PI).',
  'Clamp onto clean, nail polish-free fingertip. Keep hand still for 10 seconds while reading displays.',
  'Remove batteries if unused for long periods.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dr. Morepen PO-09 Pulse Oximeter',
  'dr-morepen-po-09-pulse-oximeter',
  'Dr. Morepen',
  'Portable Fingertip Pulse Oximeter',
  'Optical sensor with bright dual-color LED screen and auto power-off',
  (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
  'Morepen Laboratories Ltd',
  '1 Device Unit',
  999.00,
  799.00,
  0,
  FALSE,
  'Compact fingertip oximeter providing instant oxygen saturation checks for asthma, respiratory infections and cardiac monitoring.',
  'Place index finger into chamber. View reading.',
  'Store in dry drawer.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'All-in-One Steam Inhaler & Facial Vaporizer',
  'all-in-one-steam-inhaler-facial-vaporizer',
  'Wonder Steam',
  'Electric 3-in-1 Steam Inhaler Vaporizer',
  'Shock-resistant food-grade plastic body with copper heating element, inhaler mask and nasal nozzle',
  (SELECT id FROM public.categories WHERE slug = 'respiratory-asthma' LIMIT 1),
  'Wonder Healthcare',
  '1 Device Unit with Attachments',
  399.00,
  320.00,
  0,
  FALSE,
  'Heavy-duty warm steam vaporizer designed for relieving sinus congestion, bronchitic cough, dry throat and facial steaming.',
  'Fill clean tap water up to max level mark. Plug into 220V socket. Inhale warm steam gently from safe distance.',
  'Empty leftover water after cooling. Store dry.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dr. Morepen CN-06 Compressor Nebulizer',
  'dr-morepen-cn-06-compressor-nebulizer',
  'Dr. Morepen',
  'Piston Compressor Medication Nebulizer System',
  'Oil-free piston compressor pump, nebulizer medicine cup chamber, tubing, adult and child masks',
  (SELECT id FROM public.categories WHERE slug = 'respiratory-asthma' LIMIT 1),
  'Morepen Laboratories Ltd',
  '1 Device Unit with Adult & Pediatric Masks',
  1690.00,
  1390.00,
  0,
  FALSE,
  'Compact medical nebulizer converting liquid respiratory medicines into ultrafine aerosols (<5 micron) for direct bronchial delivery.',
  'Add prescribed respiratory solution into medication cup. Secure mask and run compressor until vapor ceases.',
  'Wash medicine chamber and masks in warm water after each use.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dabur Ashwagandha Tablets 60s',
  'dabur-ashwagandha-tablets-60s',
  'Dabur',
  'Pure Withania Somnifera (Ashwagandha) Extract',
  'Ashwagandha root dry extract (Withania somnifera) 500mg per tablet',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Dabur India Ltd',
  'Bottle of 60 Tablets',
  175.00,
  160.00,
  0,
  FALSE,
  'Standardized pure Ayurvedic adaptogen promoting cortisol balance, deep restorative sleep, vitality and stress relief.',
  '1 tablet twice daily with water or warm milk.',
  'Store in cool and dry place away from direct light.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Himalaya Ashvagandha Tablets 60s',
  'himalaya-ashvagandha-tablets-60s',
  'Himalaya Pure Herbs',
  'Organic Ashvagandha Root Extract Tablets',
  'Ashvagandha root extract (Withania somnifera) 250mg per tablet',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Himalaya Wellness Company',
  'Bottle of 60 Tablets',
  190.00,
  172.00,
  0,
  FALSE,
  'Pure herb extract helping the body adapt to daily physiological stress, enhancing endurance and rejuvenating cellular energy.',
  '1 tablet twice daily before meals.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Baidyanath Triphala Churna 100g',
  'baidyanath-triphala-churna-100g',
  'Baidyanath',
  'Amla, Haritaki & Bibhitaki Classical Churna',
  'Equal parts of Haritaki (Terminalia chebula), Bibhitaki (Terminalia bellirica), Amalaki (Emblica officinalis)',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Shree Baidyanath Ayurved Bhawan',
  '100g Pack',
  65.00,
  60.00,
  0,
  FALSE,
  'Classical Ayurvedic bowel cleanser and detoxifier that relieves habitual constipation, flatulence and purifies digestion.',
  '1 to 2 teaspoonfuls (3-6g) at bedtime with lukewarm water.',
  'Keep in airtight container away from moisture.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dabur Honitus Herbal Cough Syrup 100ml',
  'dabur-honitus-herbal-cough-syrup-100ml',
  'Dabur Honitus',
  'Honey & Ayurvedic Herbs Cough Formula',
  'Tulsi, Mulethi, Banapsha, Kantkari, Talispatra, Sunthi, Pippali, Vasaka and pure Honey',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Dabur India Ltd',
  '100ml Bottle',
  105.00,
  95.00,
  0,
  FALSE,
  '100% Ayurvedic non-drowsy cough syrup soothing irritated throat, clearing phlegm and relieving bronchial irritation.',
  'Adults: 2 teaspoonfuls (10ml) 3-4 times daily.',
  'Store in cool and dry place. Shake well before use.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Patanjali Dant Kanti Toothpaste 200g',
  'patanjali-dant-kanti-toothpaste-200g',
  'Patanjali',
  'Complete Ayurvedic Herbal Toothpaste',
  'Akarkara, Neem, Babool, Tomar, Pudina, Laung, Pippali, Vajradanti and Meswak',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Patanjali Ayurved Ltd',
  '200g Tube',
  115.00,
  108.00,
  0,
  FALSE,
  'Ayurvedic oral formulation that strengthens gums, eliminates halitosis and defends against dental caries.',
  'Brush teeth twice daily morning and before bed.',
  'Store in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Baidyanath Mahabhringraj Tel 100ml',
  'baidyanath-mahabhringraj-tel-100ml',
  'Baidyanath',
  'Pure Bhringraj Classical Ayurvedic Hair Oil',
  'Pure Bhringraj juice processed with Manjistha, Padmaka, Lodhra, Chandan, Gairik, Bala in pure Sesame Oil',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Shree Baidyanath Ayurved Bhawan',
  '100ml Bottle',
  185.00,
  168.00,
  0,
  FALSE,
  'Authentic Ayurvedic hair treatment strengthening hair roots, cooling the scalp and preventing premature greying.',
  'Warm slightly and massage into scalp roots with fingertips at night.',
  'Store in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Zandu Kesari Jivan Chyawanprash 450g',
  'zandu-kesari-jivan-chyawanprash-450g',
  'Zandu Kesari Jivan',
  'Kesar, Moti & Amla Ayurvedic Vitality Blend',
  'Kesar (Saffron), Moti Pishti (Pearl Calx), Fresh Amla pulp, Ashwagandha and herbal rejuvenation herbs',
  (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
  'Emami Ltd',
  '450g Jar',
  395.00,
  360.00,
  0,
  FALSE,
  'Enriched saffron and pearl Ayurvedic vitality recipe for senior wellness, joint strength and youthful energy.',
  '1 to 2 teaspoonfuls every morning with milk.',
  'Store in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Vaseline Petroleum Jelly 100g',
  'vaseline-petroleum-jelly-100g',
  'Vaseline',
  '100% Pure Triple-Purified White Petrolatum',
  '100% Pure White Petroleum Jelly (Petrolatum USP)',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Hindustan Unilever Ltd',
  '100g Jar',
  115.00,
  105.00,
  0,
  FALSE,
  'Triple-purified hypoallergenic skin protectant locking in moisture to heal severely dry, cracked skin, lips and heels.',
  'Apply over dry skin, lips or elbows as often as needed.',
  'Store at room temperature below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Boroplus Antiseptic Body Cream 80ml',
  'boroplus-antiseptic-body-cream-80ml',
  'Boroplus',
  'Neem, Tulsi & Aloe Vera Antiseptic Skin Cream',
  'Neem (Azadirachta indica), Tulsi (Holy Basil), Chandan (Sandalwood), Haridra (Turmeric), Aloe Vera',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Emami Ltd',
  '80ml Tube',
  95.00,
  88.00,
  0,
  FALSE,
  'Multi-benefit antiseptic cream providing 24-hour winter moisture, softening dry elbows and protecting chapped skin.',
  'Smooth onto face, hands and body twice daily.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Nivea Soft Light Moisturizer 100ml',
  'nivea-soft-light-moisturizer-100ml',
  'Nivea',
  'Jojoba Oil & Vitamin E Refreshing Cream',
  'Aqua, Glycerin, Myristyl Alcohol, Jojoba Seed Oil (Simmondsia Chinensis), Tocopheryl Acetate (Vitamin E)',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Nivea India Pvt Ltd',
  '100ml Jar',
  199.00,
  175.00,
  0,
  FALSE,
  'Fast-absorbing non-greasy light moisturizing cream leaving skin supple, refreshed and smooth all year round.',
  'Apply liberally onto face, hands and body.',
  'Store below 25°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dettol Original Liquid Handwash 175ml Refill',
  'dettol-original-liquid-handwash-175ml',
  'Dettol',
  'Pine Fragrance Antibacterial Hand Wash Refill',
  'Active antibacterial surfactant blend with natural pine fragrance and skin emollients',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Reckitt Benckiser India',
  '175ml Refill Pouch',
  55.00,
  50.00,
  0,
  FALSE,
  'Dermatologically tested germ-protection hand wash protecting against 100 illness-causing bacteria and viruses.',
  'Dispense onto wet hands, lather for 20 seconds covering palms, fingers and nails, then rinse with water.',
  'Store in dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Lifebuoy Total 10 Handwash 180ml Refill',
  'lifebuoy-total-10-handwash-180ml',
  'Lifebuoy',
  'Activ Silver+ Formula Germ Protection Hand Wash',
  'Sodium Laureth Sulfate, Cocamidopropyl Betaine, Silver Oxide, Thymol, Terpineol',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Hindustan Unilever Ltd',
  '180ml Refill Pouch',
  48.00,
  44.00,
  0,
  FALSE,
  'Fast-acting handwash with Silver formula providing 99.9% germ protection in just 10 seconds.',
  'Wash hands before meals and after outdoor contact.',
  'Store in cool place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Colgate Strong Teeth Toothpaste 200g',
  'colgate-strong-teeth-toothpaste-200g',
  'Colgate',
  'Calcium & Fluoride Amino Shakti Toothpaste',
  'Precipitated Calcium Carbonate, Sodium Monofluorophosphate 0.76% w/w (1000 ppm F), Arginine',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Colgate-Palmolive (India) Ltd',
  '200g Tube',
  125.00,
  114.00,
  0,
  FALSE,
  'India''s champion cavity-fighting toothpaste that replenishes natural calcium in enamel for stronger teeth.',
  'Brush thoroughly at least twice daily. Spit and rinse after brushing.',
  'Store at room temperature.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Pepsodent Germi Check 150g',
  'pepsodent-germi-check-150g',
  'Pepsodent',
  'Zinc & Fluoride 12-Hour Germ Protection Toothpaste',
  'Calcium Carbonate, Water, Sorbitol, Hydrated Silica, Zinc Sulphate, Sodium Monofluorophosphate',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Hindustan Unilever Ltd',
  '150g Tube',
  98.00,
  88.00,
  0,
  FALSE,
  'Advanced dental formula fighting cavity germs for up to 12 hours after brushing.',
  'Brush twice a day for 2 minutes.',
  'Keep cap closed.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Harpic Power Plus Toilet Cleaner 500ml',
  'harpic-power-plus-toilet-cleaner-500ml',
  'Harpic',
  'Hydrochloric Acid Disinfectant Toilet Cleaner',
  'Hydrochloric Acid 10.5% w/w, Hydroxyethyl Oleylamine, Cetyl Trimethyl Ammonium Chloride, Methyl Salicylate',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Reckitt Benckiser India',
  '500ml Angled Bottle',
  99.00,
  92.00,
  0,
  FALSE,
  '10x stain-removing disinfectant toilet bowl cleaner destroying 99.9% germs, limescale and tough yellow stains.',
  'Direct nozzle under rim, squeeze evenly around bowl. Leave for 20 minutes, brush lightly and flush.',
  'Keep bottle upright in a safe place away from children. Do not mix with bleach or other chemicals.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Lizol Disinfectant Surface Cleaner 500ml',
  'lizol-disinfectant-surface-cleaner-500ml',
  'Lizol',
  'Benzalkonium Chloride Citrus Floor Disinfectant',
  'Benzalkonium Chloride Solution (50%) 4.0% w/w, Non-ionic surfactant, Citrus fragrance',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Reckitt Benckiser India',
  '500ml Citrus Bottle',
  115.00,
  105.00,
  0,
  FALSE,
  'Triple-action floor and tile sanitizer eliminating 99.9% germs, removing stubborn kitchen grease and leaving a citrus aroma.',
  'Dilute 1 capful in half a bucket (4 litres) of water for mopping surfaces. For external sanitary use only.',
  'Store below 30°C.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Dettol Disinfectant Floor Cleaner 500ml',
  'dettol-disinfectant-floor-cleaner-500ml',
  'Dettol Disinfectant',
  'Multi-Surface Antibacterial Cleaning Liquid',
  'Benzalkonium chloride, non-ionic surfactants, fragrance, preservative',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Reckitt Benckiser India',
  '500ml Bottle',
  110.00,
  100.00,
  0,
  FALSE,
  'High-efficacy surface cleaner killing viruses and bacteria on floors, kitchen slabs and bathroom tiles.',
  'Dilute 1 capful in 4 litres of water for mopping.',
  'Store in cool and dry place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Godrej aer pocket Bathroom Fragrance 10g',
  'godrej-aer-pocket-bathroom-fragrance-10g',
  'Godrej aer',
  'Slim Gel Bathroom Air Freshener Pocket',
  'Unique slim gel technology with aromatic fragrance oils (Morning Misty Meadows)',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Godrej Consumer Products Ltd',
  '10g Pocket Sachet',
  60.00,
  55.00,
  0,
  FALSE,
  'Power-pocket bathroom fragrance that neutralizes unpleasant odors and keeps bathrooms fresh for up to 30 days.',
  'Tear outer pouch, pull out aer pocket and hang on wall hook in bathroom.',
  'Store unopened pack in cool place.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Odonil Room Air Freshener Blocks 50g',
  'odonil-room-air-freshener-blocks-50g',
  'Odonil',
  'Long-Lasting Floral Air Freshening Block',
  'Paradichlorobenzene 99% w/w with concentrated lavender perfume',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Dabur India Ltd',
  '50g Pack with Hanger',
  55.00,
  50.00,
  0,
  FALSE,
  'Classic room and wardrobe freshening block providing constant pleasant floral fragrance and repelling damp odors.',
  'Place in attached hanger and position in room, wardrobe or bathroom.',
  'Keep unopened blocks in cool dry conditions.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Care4 Hand Sanitizer 70% Alcohol 100ml',
  'care4-hand-sanitizer-70-alcohol-100ml',
  'Care4 Hygiene',
  '70% Isopropyl Alcohol Instant Hand Sanitizer',
  'Isopropyl Alcohol IP 70% v/v, Hydrogen Peroxide 0.125% v/v, Glycerol 1.45% v/v in aqueous base',
  (SELECT id FROM public.categories WHERE slug = 'emergency-otc-support' LIMIT 1),
  'Standard Hygiene Care India',
  '100ml Flip-Top Bottle',
  50.00,
  45.00,
  0,
  FALSE,
  'WHO-recommended formulation instant hand sanitizer killing 99.9% germs without water or towel.',
  'Apply 3ml onto dry palms, rub thoroughly over all surfaces of hands until dry.',
  'Highly flammable. Store below 30°C away from sparks and flame.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;

INSERT INTO public.medicines (
  name, slug, brand, generic_name, composition, category_id, manufacturer,
  pack_size, mrp, selling_price, stock_quantity, prescription_required,
  description, dosage_guidelines, storage_instructions, is_demo, is_featured, status
)
VALUES (
  'Origami Soft Facial Tissues 100s',
  'origami-soft-facial-tissues-100s',
  'Origami',
  '2-Ply 100% Virgin Wood Pulp Facial Tissues',
  '100% Virgin bleached wood pulp 2-ply soft cellulose paper',
  (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
  'Origami Cellulose Ltd',
  'Box of 100 Pulls',
  85.00,
  75.00,
  0,
  FALSE,
  'Ultra-soft, highly absorbent 2-ply facial tissues suitable for delicate skin, cold sneezes and personal hygiene.',
  'Pull single tissue from box top. Single use.',
  'Keep in dry clean dispenser.',
  TRUE,
  FALSE,
  'active'
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  brand = EXCLUDED.brand,
  generic_name = EXCLUDED.generic_name,
  composition = EXCLUDED.composition,
  category_id = EXCLUDED.category_id,
  manufacturer = EXCLUDED.manufacturer,
  pack_size = EXCLUDED.pack_size,
  mrp = EXCLUDED.mrp,
  selling_price = EXCLUDED.selling_price,
  prescription_required = EXCLUDED.prescription_required,
  description = EXCLUDED.description,
  dosage_guidelines = EXCLUDED.dosage_guidelines,
  storage_instructions = EXCLUDED.storage_instructions,
  is_demo = EXCLUDED.is_demo,
  updated_at = CURRENT_TIMESTAMP;
