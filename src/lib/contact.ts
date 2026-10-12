/**
 * Central Business Contact Information & Helpers
 * Durga Medical Hall, Village Kubri, Giridih, Jharkhand
 */

export const CONTACT_CONFIG = {
  businessName: 'Durga Medical Hall',
  rawPhone: '9939183629',
  displayPhone: '+91 9939183629',
  phoneHref: 'tel:+919939183629',

  rawWhatsApp: '919939183629',
  displayWhatsApp: '+91 9939183629',
  defaultWhatsAppMessage: 'Hello Durga Medical Hall, I would like to enquire about medicine availability.',
  whatsAppHref: 'https://wa.me/919939183629?text=Hello%20Durga%20Medical%20Hall%2C%20I%20would%20like%20to%20enquire%20about%20medicine%20availability.',

  // Exact pharmacist / chemist attribution supplied by owner
  pharmacistChemistTitle: 'Pharmacist/Chemist: Dr. Ravindra Kumar Rana',
  pharmacistName: 'Dr. Ravindra Kumar Rana',

  // Address
  address: {
    village: 'Village – Kubri',
    post: 'Post – Kubri',
    panchayat: 'Panchayat – Makdiha',
    district: 'District – Giridih',
    state: 'Jharkhand',
    pincode: '825418',
    country: 'India',
    short: 'Village Kubri, Post Kubri, Makdiha, Giridih 825418',
  },
} as const;

/**
 * Normalizes phone numbers for WhatsApp to ensure valid international format with country code (e.g. 919939183629)
 */
export function formatWhatsAppNumber(phone?: string): string {
  if (!phone) return CONTACT_CONFIG.rawWhatsApp;
  const digits = phone.replace(/[^0-9]/g, '');
  if (digits.length === 10) return `91${digits}`;
  return digits || CONTACT_CONFIG.rawWhatsApp;
}

/**
 * Generate a WhatsApp URL with an optional custom message or medicine query
 */
export function getWhatsAppUrl(customMessage?: string, phone?: string): string {
  const targetNumber = formatWhatsAppNumber(phone);
  const message = customMessage || CONTACT_CONFIG.defaultWhatsAppMessage;
  return `https://wa.me/${targetNumber}?text=${encodeURIComponent(message)}`;
}
