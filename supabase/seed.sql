-- ==============================================================================
-- DURGA MEDICAL HALL - Initial Seed Data
-- 28 Health Categories + Demo Medicines + Initial Settings
-- Village Kubri, Post Kubri, Panchayat Makdiha, Giridih, Jharkhand 825418
-- ==============================================================================

-- 1. SEED CATEGORIES (All 28 Categories)
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
    display_order = EXCLUDED.display_order;

-- 2. SEED INITIAL SITE SETTINGS
INSERT INTO public.site_settings (key, value)
VALUES
('shop_profile', '{
    "shopName": "Durga Medical Hall",
    "village": "Village – Kubri",
    "post": "Post – Kubri",
    "panchayat": "Panchayat – Makdiha",
    "district": "District – Giridih",
    "state": "Jharkhand",
    "pincode": "825418",
    "country": "India",
    "phone": "[ADD PHONE NUMBER]",
    "whatsapp": "[ADD WHATSAPP NUMBER]",
    "email": "[ADD EMAIL ADDRESS]",
    "gstNumber": "[ADD GST NUMBER]",
    "drugLicenseNumber": "[ADD DRUG LICENSE NUMBER]",
    "operatingHours": "Monday to Sunday: 8:00 AM – 9:00 PM",
    "emergencyNotice": "Open 7 days a week for Kubri & neighbouring villages in Makdiha Panchayat. For immediate urgent medicine availability, call ahead or visit store directly.",
    "googleMapsEmbedUrl": ""
}'::jsonb)
ON CONFLICT (key) DO UPDATE SET
    value = EXCLUDED.value;
