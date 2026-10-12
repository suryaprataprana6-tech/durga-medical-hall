-- ==============================================================================
-- DURGA MEDICAL HALL - Production PostgreSQL & Supabase Database Schema
-- Location: Village Kubri, Post Kubri, Panchayat Makdiha, Giridih, Jharkhand 825418
-- ==============================================================================

-- 0. EXTENSIONS
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. ADMINS TABLE (Connected to Supabase Auth auth.users)
CREATE TABLE IF NOT EXISTS public.admins (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    role VARCHAR(50) DEFAULT 'admin' CHECK (role IN ('superadmin', 'admin', 'pharmacist')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. CUSTOMERS TABLE
CREATE TABLE IF NOT EXISTS public.customers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    full_name VARCHAR(150) NOT NULL,
    mobile VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255),
    address TEXT,
    village VARCHAR(100) DEFAULT 'Kubri',
    panchayat VARCHAR(100) DEFAULT 'Makdiha',
    district VARCHAR(100) DEFAULT 'Giridih',
    state VARCHAR(50) DEFAULT 'Jharkhand',
    pincode VARCHAR(10) DEFAULT '825418',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. MEDICINE CATEGORIES (The 28 Health Categories)
CREATE TABLE IF NOT EXISTS public.categories (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(150) NOT NULL,
    slug VARCHAR(150) UNIQUE NOT NULL,
    description TEXT,
    icon_name VARCHAR(100),
    display_order INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. MEDICINES CATALOGUE
CREATE TABLE IF NOT EXISTS public.medicines (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    brand VARCHAR(150),
    generic_name VARCHAR(255),
    composition TEXT,
    category_id UUID REFERENCES public.categories(id) ON DELETE SET NULL,
    manufacturer VARCHAR(150),
    pack_size VARCHAR(100),
    mrp NUMERIC(10, 2) NOT NULL,
    selling_price NUMERIC(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    batch_number VARCHAR(100),
    expiry_date DATE,
    prescription_required BOOLEAN DEFAULT FALSE,
    description TEXT,
    dosage_guidelines TEXT,
    storage_instructions TEXT,
    image_url TEXT,
    is_demo BOOLEAN DEFAULT FALSE,
    is_featured BOOLEAN DEFAULT FALSE,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'inactive')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. INVENTORY & BATCHES (Internal Stock & Expiry Tracking)
CREATE TABLE IF NOT EXISTS public.inventory_batches (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    medicine_id UUID REFERENCES public.medicines(id) ON DELETE CASCADE,
    medicine_name VARCHAR(255) NOT NULL,
    batch_number VARCHAR(100) NOT NULL,
    manufacturing_date DATE,
    expiry_date DATE NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    mrp NUMERIC(10, 2) NOT NULL,
    purchase_price NUMERIC(10, 2),
    selling_price NUMERIC(10, 2) NOT NULL,
    status VARCHAR(30) DEFAULT 'In Stock' CHECK (status IN ('In Stock', 'Low Stock', 'Expired')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 6. ORDERS & ORDER ITEMS
CREATE TABLE IF NOT EXISTS public.orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    customer_id UUID REFERENCES public.customers(id) ON DELETE SET NULL,
    customer_name VARCHAR(150) NOT NULL,
    mobile VARCHAR(20) NOT NULL,
    email VARCHAR(255),
    preference VARCHAR(100) NOT NULL CHECK (preference IN ('Pickup at Kubri Store', 'Local Home Delivery (Subject to Area)')),
    delivery_address TEXT NOT NULL,
    additional_message TEXT,
    prescription_file_url TEXT,
    status VARCHAR(50) DEFAULT 'Pending' CHECK (
        status IN (
            'Pending',
            'Under Verification',
            'Confirmed',
            'Preparing',
            'Ready',
            'Out for Delivery',
            'Delivered',
            'Cancelled'
        )
    ),
    internal_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS public.order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE,
    medicine_id UUID REFERENCES public.medicines(id) ON DELETE SET NULL,
    medicine_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    estimated_price NUMERIC(10, 2),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 7. PRESCRIPTIONS (Private, Securely Uploaded)
CREATE TABLE IF NOT EXISTS public.prescriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    request_id VARCHAR(50) UNIQUE NOT NULL,
    customer_name VARCHAR(150) NOT NULL,
    mobile VARCHAR(20) NOT NULL,
    email VARCHAR(255),
    storage_path TEXT NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(100),
    file_size INT,
    order_details TEXT,
    delivery_address TEXT NOT NULL,
    additional_message TEXT,
    status VARCHAR(50) DEFAULT 'Pending Review' CHECK (
        status IN (
            'Pending Review',
            'Verified',
            'Clarification Required',
            'Rejected',
            'Completed'
        )
    ),
    internal_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 8. CUSTOMER ENQUIRIES
CREATE TABLE IF NOT EXISTS public.enquiries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_name VARCHAR(150) NOT NULL,
    mobile VARCHAR(20) NOT NULL,
    email VARCHAR(255),
    medicine_interested VARCHAR(255),
    message TEXT NOT NULL,
    status VARCHAR(30) DEFAULT 'New' CHECK (status IN ('New', 'Contacted', 'Resolved')),
    admin_response TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 9. SITE SETTINGS (Configurable Shop Info - No invented secrets)
CREATE TABLE IF NOT EXISTS public.site_settings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    key VARCHAR(100) UNIQUE NOT NULL,
    value JSONB NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 10. INDEXES FOR PERFORMANCE
CREATE INDEX IF NOT EXISTS idx_medicines_category ON public.medicines(category_id);
CREATE INDEX IF NOT EXISTS idx_medicines_slug ON public.medicines(slug);
CREATE INDEX IF NOT EXISTS idx_medicines_name ON public.medicines(name);
CREATE INDEX IF NOT EXISTS idx_medicines_status ON public.medicines(status);
CREATE INDEX IF NOT EXISTS idx_categories_slug ON public.categories(slug);
CREATE INDEX IF NOT EXISTS idx_orders_order_number ON public.orders(order_number);
CREATE INDEX IF NOT EXISTS idx_orders_status ON public.orders(status);
CREATE INDEX IF NOT EXISTS idx_prescriptions_request_id ON public.prescriptions(request_id);
CREATE INDEX IF NOT EXISTS idx_prescriptions_status ON public.prescriptions(status);
CREATE INDEX IF NOT EXISTS idx_inventory_expiry ON public.inventory_batches(expiry_date);

-- ==============================================================================
-- 11. SUPABASE STORAGE BUCKET CONFIGURATION (PRIVATE PRESCRIPTIONS)
-- ==============================================================================
-- Note: Insert bucket if storage schema exists
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
    'prescriptions',
    'prescriptions',
    false, -- STRICTLY PRIVATE, NEVER PUBLIC
    10485760, -- 10MB limit
    ARRAY['image/jpeg', 'image/png', 'image/webp', 'application/pdf']
)
ON CONFLICT (id) DO UPDATE SET
    public = false,
    file_size_limit = 10485760,
    allowed_mime_types = ARRAY['image/jpeg', 'image/png', 'image/webp', 'application/pdf'];

-- ==============================================================================
-- 12. ROW LEVEL SECURITY (RLS) POLICIES
-- ==============================================================================
ALTER TABLE public.admins ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.medicines ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.inventory_batches ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.prescriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.enquiries ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.site_settings ENABLE ROW LEVEL SECURITY;

-- Helper function to check if current user is an admin
CREATE OR REPLACE FUNCTION public.is_admin()
RETURNS BOOLEAN AS $$
BEGIN
    RETURN EXISTS (
        SELECT 1 FROM public.admins
        WHERE id = auth.uid()
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- CATEGORIES: Public can read active categories; Admins can manage all
CREATE POLICY "Public can view active categories"
    ON public.categories FOR SELECT
    USING (status = 'active');

CREATE POLICY "Admins have full access to categories"
    ON public.categories FOR ALL
    USING (public.is_admin() OR auth.role() = 'service_role');

-- MEDICINES: Public can read active medicines; Admins can manage all
CREATE POLICY "Public can view active medicines"
    ON public.medicines FOR SELECT
    USING (status = 'active');

CREATE POLICY "Admins have full access to medicines"
    ON public.medicines FOR ALL
    USING (public.is_admin() OR auth.role() = 'service_role');

-- ORDERS: Public can insert orders; Customers and anonymous CANNOT read or modify others
CREATE POLICY "Public can submit orders"
    ON public.orders FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Admins have full access to orders"
    ON public.orders FOR ALL
    USING (public.is_admin() OR auth.role() = 'service_role');

-- ORDER ITEMS: Public can insert items alongside orders; Admins have full access
CREATE POLICY "Public can insert order items"
    ON public.order_items FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Admins have full access to order items"
    ON public.order_items FOR ALL
    USING (public.is_admin() OR auth.role() = 'service_role');

-- PRESCRIPTIONS: Public can upload / submit; No customer can view others; Only Admins can view
CREATE POLICY "Public can submit prescriptions"
    ON public.prescriptions FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Admins have full access to prescriptions"
    ON public.prescriptions FOR ALL
    USING (public.is_admin() OR auth.role() = 'service_role');

-- ENQUIRIES: Public can submit enquiries; Only Admins can view/update
CREATE POLICY "Public can submit enquiries"
    ON public.enquiries FOR INSERT
    WITH CHECK (true);

CREATE POLICY "Admins have full access to enquiries"
    ON public.enquiries FOR ALL
    USING (public.is_admin() OR auth.role() = 'service_role');

-- INVENTORY: Strictly internal to admins / pharmacists
CREATE POLICY "Admins have full access to inventory"
    ON public.inventory_batches FOR ALL
    USING (public.is_admin() OR auth.role() = 'service_role');

-- SITE SETTINGS: Public can read site settings; Admins can edit
CREATE POLICY "Public can view site settings"
    ON public.site_settings FOR SELECT
    USING (true);

CREATE POLICY "Admins can update site settings"
    ON public.site_settings FOR ALL
    USING (public.is_admin() OR auth.role() = 'service_role');

-- ADMINS TABLE: Only authenticated admins can read
CREATE POLICY "Admins can view admins list"
    ON public.admins FOR SELECT
    USING (public.is_admin() OR auth.role() = 'service_role');

-- STORAGE RLS:
-- 1. Public can upload prescription files into 'prescriptions' bucket
CREATE POLICY "Public can upload prescriptions"
    ON storage.objects FOR INSERT
    WITH CHECK (bucket_id = 'prescriptions');

-- 2. Only Admins can download/view files in 'prescriptions' bucket directly
CREATE POLICY "Admins can view prescription files"
    ON storage.objects FOR SELECT
    USING (bucket_id = 'prescriptions' AND (public.is_admin() OR auth.role() = 'service_role'));
