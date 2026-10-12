-- ==============================================================================
-- DURGA MEDICAL HALL - Safe Category Remap Migration
-- Location: Village Kubri, Post Kubri, Panchayat Makdiha, Giridih, Jharkhand 825418
--
-- PURPOSE:
-- 1. Activate the intended 28 customer-facing pharmacy categories from seed.sql.
-- 2. Deactivate (status = 'inactive') the 27 redundant duplicate categories.
-- 3. Remap all 194 medicines to the 28 canonical categories without deleting rows.
-- 4. Preserve all customers, orders, prescriptions, inventory, and foreign keys.
-- ==============================================================================

-- STEP 1: Ensure all 28 canonical categories are active with accurate metadata
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

-- STEP 2: Deactivate the 27 redundant duplicate categories (Non-destructive: No rows deleted)
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

-- STEP 3: Remap each of the 194 medicines to its canonical category in public.categories
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dolo-650-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'crocin-650-advance-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'calpol-500mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'combiflam-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'meftal-spas-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'paracip-650-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'sumo-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'benadryl-cough-syrup-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'ascoril-d-plus-syrup-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'cheston-cold-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'alex-cough-syrup-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'grilinctus-bm-syrup-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'vicks-vaporub-50g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'respiratory-asthma' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'vicks-inhaler-05ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'saridon-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'vasograin-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'disprin-regular-350mg';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'migranil-ec-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'amrutanjan-strong-pain-balm-30g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'fever-pain-relief' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'zandu-balm-25ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'pan-40-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'pantocid-dsr-capsule';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'rantac-150-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'omee-capsule';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'gelusil-mps-antacid-liquid-200ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'kidney-urinary-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'eno-fruit-salt-lemon-100g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'digene-antacid-chewable-tablets';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'liver-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'pudin-hara-pearls';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'emergency-otc-support' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'electral-ors-powder-218g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'sporlac-ds-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'norflox-tz-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'cremaffin-plus-syrup-225ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'unienzyme-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'digestion-stomach-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'cyclopam-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'allegra-120mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'cetzine-10mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'okacet-10mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'levocet-5mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'respiratory-asthma' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'montair-lc-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'cough-cold-flu' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'avil-25mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mental-wellness-sleep' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'atarax-25mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'glycomet-500-sr-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'glycomet-gp-1-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'janumet-50mg-500mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'galvus-met-50mg-500mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'accu-chek-active-test-strips-50s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'onetouch-select-plus-test-strips-50s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'diabetes-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'human-mixtard-30-70-100iu-ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'telma-40-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'telma-h-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'amlong-5mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'aten-50mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'concor-5mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'ecosprin-75mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'emergency-otc-support' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'sorbitrate-5mg-sublingual-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'heart-blood-pressure' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'rosuvas-10mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'thyronorm-25mcg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'thyronorm-50mcg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'thyronorm-75mcg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'thyronorm-100mcg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'eltroxin-50mcg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'elderly-care-mobility' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'eltroxin-100mcg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'becosules-capsules';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'neurobion-forte-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'limcee-500mg-chewable-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'shelcal-500-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'supradyn-daily-multivitamin-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'evion-400mg-capsule';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'vitamins-supplements' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'uprise-d3-60k-capsule';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dabur-chyawanprash-1kg';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'baidyanath-chyawanprash-special-1kg';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dabur-honey-500g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'patanjali-pure-honey-500g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'giloy-ghanvati-tablets';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'celin-500mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'immunity-general-wellness' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'zincovit-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'betnovate-c-cream-30g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'betnovate-n-cream-20g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'fourderm-cream-15g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'candid-b-cream-20g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'boroline-antiseptic-ayurvedic-cream-20g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'vicco-turmeric-wso-skin-cream-30g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'caladryl-calamine-skin-lotion-120ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'scalpe-plus-anti-dandruff-shampoo-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'nizral-2-anti-dandruff-solution-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'selsun-suspension-shampoo-120ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'bajaj-almond-drops-hair-oil-200ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'parachute-pure-coconut-oil-250ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'skin-care-dermatology' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'kesh-king-ayurvedic-hair-oil-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'ciplox-eye-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'refresh-tears-eye-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'systane-ultra-lubricant-eye-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'tobastar-eye-drops-5ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'moxicip-eye-drops-5ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'itone-herbal-eye-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'otrivin-adult-nasal-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'otrivin-oxy-fast-relief-spray-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'nasivion-adult-nasal-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'soliwax-ear-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'clearwax-ear-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'eye-ear-nasal-drops' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'waxolve-ear-drops-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'sensodyne-fresh-mint-toothpaste-75g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'thermoseal-pro-toothpaste-100g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'clohex-plus-mouthwash-150ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'rexidin-plus-mouthwash-150ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dologel-ct-mouth-gel-10g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'zytee-rb-gel-10ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'oral-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dabur-red-toothpaste-150g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'johnsons-baby-soap-100g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'johnsons-baby-powder-200g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'sebamed-baby-wash-extra-soft-200ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'himalaya-baby-massage-oil-200ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'himalaya-baby-diaper-rash-cream-50g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'woodwards-gripe-water-130ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'bonnisan-baby-drops-30ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'womens-health' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'stayfree-secure-cottony-soft-xl-18s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'womens-health' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'whisper-choice-ultra-xl-20s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'womens-health' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'meftal-spas-ds-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'womens-health' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'vwash-plus-intimate-hygiene-wash-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'antibiotics-anti-infectives' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'candid-v3-vaginal-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'nutritional-drinks-powders' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'autrin-capsule';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'nutritional-drinks-powders' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dexorange-syrup-200ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'nutritional-drinks-powders' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'revital-h-men-capsule';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dabur-shilajit-gold-capsule';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'baidyanath-musli-pak-special-100g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mens-health' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'manforce-50mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'himalaya-confido-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mens-health' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'durex-extra-thin-condoms-10s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mens-health' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'manforce-extra-dotted-condoms-10s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'folvite-5mg-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'nutritional-drinks-powders' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'orofer-xt-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'prega-news-pregnancy-test-kit';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'i-can-one-step-pregnancy-test-kit';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'palmagel-stretch-mark-cream-125g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'lactare-capsule';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'mother-baby-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'doxinate-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'volini-pain-relief-spray-40g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'volini-pain-relief-gel-30g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'moov-pain-relief-specialist-cream-50g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'moov-pain-relief-spray-50g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'fastum-gel-30g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'omnigel-30g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'pain-sprays-ointments' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'zerodol-p-tablet';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'flamingo-crepe-bandage-10cm-4m';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'flamingo-crepe-bandage-15cm-4m';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'flamingo-knee-cap-elastic-medium';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'tynor-knee-support-open-patella-large';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'tynor-cervical-collar-soft-medium';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'flamingo-lumbar-sacro-support-belt-large';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'orthopedic-supports-braces' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'tynor-arm-sling-pouch';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dettol-antiseptic-liquid-250ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'savlon-antiseptic-liquid-200ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'betadine-10-antiseptic-solution-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'betadine-5-antiseptic-ointment-20g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'hansaplast-regular-band-aid-20s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dettol-medicated-plasters-10s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'absorbent-cotton-wool-ip-100g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'first-aid-wound-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'roller-gauze-bandage-75cm-3m-10s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = '3m-micropore-surgical-tape-1-inch';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = '3m-micropore-surgical-tape-2-inch';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'romsons-disposable-latex-gloves-medium-100s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'nitrile-powder-free-medical-gloves-medium-100s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = '3-ply-surgical-face-mask-with-nose-clip-50s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'n95-particulate-respirator-mask-isi-5s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dispovan-sterile-syringe-2ml-with-needle-10s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'surgicals-disposables' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dispovan-sterile-syringe-5ml-with-needle-10s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dr-morepen-digital-thermometer-mt-100';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'omron-digital-thermometer-mc-246';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'omron-hem-7120-blood-pressure-monitor';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dr-trust-usa-signature-pulse-oximeter';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'medical-devices-monitors' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dr-morepen-po-09-pulse-oximeter';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'respiratory-asthma' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'all-in-one-steam-inhaler-facial-vaporizer';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'respiratory-asthma' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dr-morepen-cn-06-compressor-nebulizer';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dabur-ashwagandha-tablets-60s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'himalaya-ashvagandha-tablets-60s';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'baidyanath-triphala-churna-100g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dabur-honitus-herbal-cough-syrup-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'patanjali-dant-kanti-toothpaste-200g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'baidyanath-mahabhringraj-tel-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'ayurvedic-herbal-care' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'zandu-kesari-jivan-chyawanprash-450g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'vaseline-petroleum-jelly-100g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'boroplus-antiseptic-body-cream-80ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'nivea-soft-light-moisturizer-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dettol-original-liquid-handwash-175ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'lifebuoy-total-10-handwash-180ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'colgate-strong-teeth-toothpaste-200g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'pepsodent-germi-check-150g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'harpic-power-plus-toilet-cleaner-500ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'lizol-disinfectant-surface-cleaner-500ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'dettol-disinfectant-floor-cleaner-500ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'godrej-aer-pocket-bathroom-fragrance-10g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'odonil-room-air-freshener-blocks-50g';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'emergency-otc-support' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'care4-hand-sanitizer-70-alcohol-100ml';
UPDATE public.medicines
SET category_id = (SELECT id FROM public.categories WHERE slug = 'personal-hygiene-sanitisers' LIMIT 1),
    updated_at = CURRENT_TIMESTAMP
WHERE slug = 'origami-soft-facial-tissues-100s';

-- STEP 4: Verification Queries (Run to confirm exact counts)
-- SELECT count(*) AS active_categories FROM public.categories WHERE status = 'active'; -- Expected: 28
-- SELECT c.name, count(m.id) AS medicine_count 
--   FROM public.categories c 
--   LEFT JOIN public.medicines m ON m.category_id = c.id 
--   WHERE c.status = 'active' 
--   GROUP BY c.id, c.name, c.display_order 
--   ORDER BY c.display_order;
