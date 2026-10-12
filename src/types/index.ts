export interface Category {
  id: string;
  name: string;
  slug: string;
  description: string;
  iconName: string;
  productCount: number;
  displayOrder: number;
  status: 'active' | 'inactive';
}

export interface Medicine {
  id: string;
  name: string;
  slug: string;
  brand: string;
  genericName: string;
  composition: string;
  categoryId: string;
  categoryName: string;
  manufacturer: string;
  packSize: string;
  mrp: number;
  sellingPrice: number;
  stockQuantity: number;
  batchNumber: string;
  expiryDate: string;
  prescriptionRequired: boolean;
  description: string;
  dosageGuidelines?: string;
  storageInstructions?: string;
  sideEffectsNotice?: string;
  imageUrl?: string;
  status: 'active' | 'inactive';
  isDemo: boolean;
  featured?: boolean;
}

export type OrderStatus =
  | 'Pending'
  | 'Under Verification'
  | 'Confirmed'
  | 'Preparing'
  | 'Ready'
  | 'Out for Delivery'
  | 'Delivered'
  | 'Cancelled';

export interface OrderItem {
  medicineId: string;
  medicineName: string;
  quantity: number;
  priceEstimate?: number;
}

export interface Order {
  id: string;
  orderNumber: string;
  customerName: string;
  mobile: string;
  email?: string;
  items: OrderItem[];
  medicineNameText?: string; // If ordered via freeform text
  quantity?: number;
  preference: 'Pickup at Kubri Store' | 'Local Home Delivery (Subject to Area)';
  address: string;
  additionalMessage?: string;
  prescriptionUrl?: string;
  prescriptionFileName?: string;
  status: OrderStatus;
  createdAt: string;
  internalNotes?: string;
}

export type PrescriptionStatus =
  | 'Pending Review'
  | 'Verified'
  | 'Clarification Required'
  | 'Rejected'
  | 'Completed';

export interface PrescriptionRequest {
  id: string;
  requestId: string;
  customerName: string;
  mobile: string;
  email?: string;
  fileData?: string; // Base64 or local URL representation
  fileName: string;
  fileType: string;
  fileSize: number;
  storagePath?: string; // Supabase Storage internal path
  signedUrl?: string; // Short-lived secure signed URL for admin viewing
  orderDetails?: string;
  deliveryAddress: string;
  additionalMessage?: string;
  status: PrescriptionStatus;
  createdAt: string;
  internalNotes?: string;
}

export type EnquiryStatus = 'New' | 'Contacted' | 'Resolved';

export interface CustomerEnquiry {
  id: string;
  customerName: string;
  mobile: string;
  email?: string;
  medicineInterested?: string;
  message: string;
  createdAt: string;
  status: EnquiryStatus;
  adminResponse?: string;
}

export interface InventoryBatch {
  id: string;
  medicineId: string;
  medicineName: string;
  batchNumber: string;
  manufacturingDate: string;
  expiryDate: string;
  stockQuantity: number;
  mrp: number;
  purchasePrice: number;
  sellingPrice: number;
  status: 'In Stock' | 'Low Stock' | 'Expired';
}

export interface ShopSettings {
  shopName: string;
  tagline: string;
  addressVillage: string;
  addressPost: string;
  addressPanchayat: string;
  addressDistrict: string;
  addressState: string;
  pincode: string;
  country: string;
  phone: string;
  whatsapp: string;
  email: string;
  openingTime: string;
  closingTime: string;
  weeklyHoliday: string;
  googleMapsUrl: string;
  gstNumber: string;
  drugLicenseNumber: string;
  homeDeliveryAvailable: boolean;
  deliveryArea: string;
  deliveryCharge: string;
  onlinePaymentAvailable: boolean;
  socialFacebook: string;
  socialInstagram: string;
  seoTitle: string;
  seoDescription: string;
  googleAnalyticsId: string;
  googleSearchConsoleTag: string;
  pharmacistName?: string;
}
