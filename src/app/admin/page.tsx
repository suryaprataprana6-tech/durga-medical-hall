'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import {
  LayoutDashboard,
  Pill,
  Folders,
  ShoppingBag,
  FileText,
  Users,
  MessageSquare,
  Boxes,
  Settings,
  LogOut,
  Plus,
  Trash2,
  Edit2,
  CheckCircle,
  Search,
  Eye,
  X,
  Save,
  RefreshCw,
  ExternalLink,
} from 'lucide-react';
import Logo from '@/components/Logo';
import {
  Category,
  Medicine,
  Order,
  PrescriptionRequest,
  ShopSettings,
  OrderStatus,
  PrescriptionStatus,
  EnquiryStatus,
} from '@/types';
import {
  saveCategory,
  saveMedicine,
  deleteMedicine,
  updateOrderStatus,
  updatePrescriptionStatus,
  updateEnquiryStatus,
  saveSettings,
  setAdminAuthenticated,
  useCategories,
  useMedicines,
  useOrders,
  usePrescriptions,
  useEnquiries,
  useInventory,
  useShopSettings,
  useIsAdminAuthenticated,
} from '@/lib/store';
import {
  adminLoginAction,
  adminLogoutAction,
  adminGetDashboardDataAction,
  adminUpdateOrderStatusAction,
  adminUpdatePrescriptionStatusAction,
  adminUpdateEnquiryStatusAction,
  adminSaveMedicineAction,
  adminDeleteMedicineAction,
  adminSaveCategoryAction,
  adminSaveSettingsAction,
} from '@/app/actions/admin';

type AdminTab =
  | 'overview'
  | 'medicines'
  | 'categories'
  | 'orders'
  | 'prescriptions'
  | 'customers'
  | 'enquiries'
  | 'inventory'
  | 'settings';

export default function AdminPage() {
  const authenticated = useIsAdminAuthenticated();
  const [authEmail, setAuthEmail] = useState('');
  const [authPassword, setAuthPassword] = useState('');
  const [authError, setAuthError] = useState('');
  const [isLoggingIn, setIsLoggingIn] = useState(false);

  const [currentTab, setCurrentTab] = useState<AdminTab>('overview');
  const categories = useCategories();
  const medicines = useMedicines();
  const orders = useOrders();
  const prescriptions = usePrescriptions();
  const enquiries = useEnquiries();
  const inventory = useInventory();
  const settings = useShopSettings();

  // Search & Filter local states
  const [medSearch, setMedSearch] = useState('');
  const [selectedOrder, setSelectedOrder] = useState<Order | null>(null);
  const [selectedRx, setSelectedRx] = useState<PrescriptionRequest | null>(null);
  const [isEditingMed, setIsEditingMed] = useState<boolean>(false);
  const [currentMedForm, setCurrentMedForm] = useState<Partial<Medicine>>({});
  const [isEditingCat, setIsEditingCat] = useState<boolean>(false);
  const [currentCatForm, setCurrentCatForm] = useState<Partial<Category>>({});
  const [settingsForm, setSettingsForm] = useState<ShopSettings>(settings);
  const [settingsSaved, setSettingsSaved] = useState(false);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!authEmail.trim() || !authPassword) {
      setAuthError('Please enter both admin email and password.');
      return;
    }

    setIsLoggingIn(true);
    setAuthError('');

    try {
      const fd = new FormData();
      fd.append('email', authEmail.trim());
      fd.append('password', authPassword);

      const res = await adminLoginAction(fd);

      if (res.success) {
        setAdminAuthenticated(true);
        setAuthError('');
      } else {
        setAuthError(res.error || 'Authentication failed. Please verify admin credentials.');
      }
    } catch (err: unknown) {
      console.error(err);
      setAuthError('An unexpected server error occurred during login.');
    } finally {
      setIsLoggingIn(false);
    }
  };

  const handleLogout = async () => {
    await adminLogoutAction();
    setAdminAuthenticated(false);
  };

  if (!authenticated) {
    return (
      <div className="min-h-screen bg-slate-950 flex flex-col justify-center items-center p-4">
        <div className="w-full max-w-md bg-slate-900 border border-slate-800 rounded-3xl p-8 shadow-2xl space-y-6">
          <div className="text-center space-y-2">
            <div className="flex justify-center mb-2">
              <Logo size="md" light={true} />
            </div>
            <h1 className="text-xl font-bold text-white tracking-tight">Pharmacist & Admin Portal</h1>
            <p className="text-xs text-slate-400">
              Sign in to manage Durga Medical Hall dispensary operations
            </p>
          </div>

          <form onSubmit={handleLogin} className="space-y-4">
            <div>
              <label className="block text-xs font-semibold text-slate-300 mb-1">
                Admin / Pharmacist Email
              </label>
              <input
                type="email"
                required
                value={authEmail}
                onChange={(e) => setAuthEmail(e.target.value)}
                placeholder="admin@durgamedical.com"
                className="w-full py-2.5 px-3.5 bg-slate-800 border border-slate-700 rounded-xl text-white text-sm placeholder-slate-500 focus:border-teal-500 focus:outline-hidden"
              />
            </div>

            <div>
              <label className="block text-xs font-semibold text-slate-300 mb-1">
                Password / Secure PIN
              </label>
              <input
                type="password"
                required
                value={authPassword}
                onChange={(e) => setAuthPassword(e.target.value)}
                placeholder="Enter your secure admin password"
                className="w-full py-2.5 px-3.5 bg-slate-800 border border-slate-700 rounded-xl text-white text-sm placeholder-slate-500 focus:border-teal-500 focus:outline-hidden"
              />
            </div>

            {authError && (
              <div className="p-3 rounded-xl bg-rose-950/50 border border-rose-800 text-rose-300 text-xs">
                {authError}
              </div>
            )}

            <button
              type="submit"
              disabled={isLoggingIn}
              className="w-full py-3 px-4 rounded-xl bg-teal-600 hover:bg-teal-500 disabled:opacity-50 text-white font-bold text-sm shadow-md transition-colors"
            >
              {isLoggingIn ? 'Authenticating...' : 'Sign In to Dashboard'}
            </button>
          </form>

          <div className="pt-4 border-t border-slate-800 text-center space-y-2 text-xs text-slate-500">
            <p className="text-slate-400">
              Secured with Supabase Authentication & Row-Level Security
            </p>
            <Link href="/" className="text-teal-400 hover:text-white underline block">
              ← Return to Durga Medical Hall Public Website
            </Link>
          </div>
        </div>
      </div>
    );
  }

  // Analytics KPI counts
  const totalMedicines = medicines.length;
  const activeMedicines = medicines.filter((m) => m.status === 'active').length;
  const pendingOrders = orders.filter((o) => o.status === 'Pending' || o.status === 'Under Verification').length;
  const pendingRx = prescriptions.filter((p) => p.status === 'Pending Review').length;
  const newEnquiries = enquiries.filter((e) => e.status === 'New').length;
  const lowStockCount = medicines.filter((m) => m.stockQuantity < 10).length;

  return (
    <div className="min-h-screen bg-slate-900 text-slate-100 flex flex-col lg:flex-row">
      {/* Sidebar Navigation */}
      <aside className="w-full lg:w-64 bg-slate-950 border-r border-slate-800 flex flex-col justify-between shrink-0">
        <div>
          {/* Logo Bar */}
          <div className="p-6 border-b border-slate-800 flex items-center justify-between">
            <Logo size="sm" light={true} />
          </div>

          {/* Navigation Links */}
          <nav className="p-3 space-y-1">
            {[
              { id: 'overview', label: 'Dashboard Overview', icon: LayoutDashboard },
              { id: 'medicines', label: `Medicines (${totalMedicines})`, icon: Pill },
              { id: 'categories', label: `Categories (${categories.length})`, icon: Folders },
              { id: 'orders', label: `Orders (${orders.length})`, icon: ShoppingBag, badge: pendingOrders },
              { id: 'prescriptions', label: `Prescriptions (${prescriptions.length})`, icon: FileText, badge: pendingRx },
              { id: 'inventory', label: 'Inventory & Expiry', icon: Boxes, badge: lowStockCount },
              { id: 'customers', label: 'Customers', icon: Users },
              { id: 'enquiries', label: `Enquiries (${enquiries.length})`, icon: MessageSquare, badge: newEnquiries },
              { id: 'settings', label: 'Settings & Contact', icon: Settings },
            ].map((item) => {
              const Icon = item.icon;
              const active = currentTab === item.id;
              return (
                <button
                  key={item.id}
                  onClick={() => {
                    setCurrentTab(item.id as AdminTab);
                    setSelectedOrder(null);
                    setSelectedRx(null);
                  }}
                  className={`w-full flex items-center justify-between px-3.5 py-2.5 rounded-xl text-xs font-semibold transition-all ${
                    active
                      ? 'bg-teal-700 text-white shadow-xs'
                      : 'text-slate-400 hover:text-white hover:bg-slate-900'
                  }`}
                >
                  <div className="flex items-center gap-3">
                    <Icon className="w-4 h-4" />
                    <span>{item.label}</span>
                  </div>
                  {item.badge && item.badge > 0 ? (
                    <span className="bg-rose-600 text-white text-[10px] px-1.5 py-0.5 rounded-full font-bold">
                      {item.badge}
                    </span>
                  ) : null}
                </button>
              );
            })}
          </nav>
        </div>

        {/* Bottom Bar: Quick links & Logout */}
        <div className="p-4 border-t border-slate-800 space-y-2">
          <Link
            href="/"
            target="_blank"
            className="flex items-center gap-2 text-xs text-teal-400 hover:underline px-2 py-1"
          >
            <ExternalLink className="w-3.5 h-3.5" />
            <span>Open Public Storefront</span>
          </Link>

          <button
            onClick={handleLogout}
            className="w-full flex items-center gap-2 px-3 py-2 rounded-xl text-xs font-semibold text-rose-400 hover:bg-rose-950/40 border border-rose-900/40 transition-colors"
          >
            <LogOut className="w-4 h-4" />
            <span>Sign Out</span>
          </button>
        </div>
      </aside>

      {/* Main Content Area */}
      <main className="flex-1 p-4 sm:p-8 overflow-y-auto">
        {/* ==================== 1. OVERVIEW TAB ==================== */}
        {currentTab === 'overview' && (
          <div className="space-y-8 max-w-7xl">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
              <div>
                <h1 className="text-2xl font-black text-white tracking-tight">Dispensary Overview</h1>
                <p className="text-xs text-slate-400 mt-1">
                  Durga Medical Hall • Village Kubri, Makdiha, Giridih 825418
                </p>
              </div>

              <div className="flex items-center gap-2">
                <button
                  onClick={async () => {
                    await adminGetDashboardDataAction();
                    window.dispatchEvent(new Event('dmh_storage_updated'));
                  }}
                  className="px-3 py-2 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-semibold flex items-center gap-1.5 border border-slate-700"
                >
                  <RefreshCw className="w-3.5 h-3.5" />
                  <span>Refresh DB Data</span>
                </button>
              </div>
            </div>

            {/* Analytics KPI Cards */}
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
              <div className="bg-slate-800/80 p-5 rounded-2xl border border-slate-700/80 space-y-2">
                <span className="text-xs text-slate-400 font-medium">Total Medicines</span>
                <div className="flex items-baseline justify-between">
                  <span className="text-2xl font-black text-white">{totalMedicines}</span>
                  <span className="text-xs text-teal-400 font-semibold">{activeMedicines} Active</span>
                </div>
              </div>

              <div className="bg-slate-800/80 p-5 rounded-2xl border border-slate-700/80 space-y-2">
                <span className="text-xs text-slate-400 font-medium">Pending Orders</span>
                <div className="flex items-baseline justify-between">
                  <span className="text-2xl font-black text-amber-400">{pendingOrders}</span>
                  <span className="text-xs text-slate-400">Total: {orders.length}</span>
                </div>
              </div>

              <div className="bg-slate-800/80 p-5 rounded-2xl border border-slate-700/80 space-y-2">
                <span className="text-xs text-slate-400 font-medium">Prescription Requests</span>
                <div className="flex items-baseline justify-between">
                  <span className="text-2xl font-black text-rose-400">{pendingRx}</span>
                  <span className="text-xs text-slate-400">Needs Review</span>
                </div>
              </div>

              <div className="bg-slate-800/80 p-5 rounded-2xl border border-slate-700/80 space-y-2">
                <span className="text-xs text-slate-400 font-medium">Low Stock Alerts</span>
                <div className="flex items-baseline justify-between">
                  <span className="text-2xl font-black text-red-400">{lowStockCount}</span>
                  <span className="text-xs text-slate-400">&lt; 10 Units</span>
                </div>
              </div>
            </div>

            {/* Recent Orders & Prescriptions Quick Lists */}
            <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
              {/* Recent Orders */}
              <div className="bg-slate-800/80 p-6 rounded-3xl border border-slate-700/80 space-y-4">
                <div className="flex items-center justify-between">
                  <h3 className="font-bold text-white text-sm">Recent Order Requests</h3>
                  <button
                    onClick={() => setCurrentTab('orders')}
                    className="text-xs text-teal-400 hover:underline font-semibold"
                  >
                    View All Orders →
                  </button>
                </div>

                <div className="divide-y divide-slate-700">
                  {orders.slice(0, 4).map((ord) => (
                    <div key={ord.id} className="py-3 flex items-center justify-between gap-3 text-xs">
                      <div>
                        <span className="font-bold text-white block">{ord.customerName}</span>
                        <span className="text-slate-400 text-[11px]">
                          {ord.items[0]?.medicineName || ord.medicineNameText} ({ord.preference})
                        </span>
                      </div>
                      <div className="text-right">
                        <span
                          className={`inline-block px-2 py-0.5 rounded-full text-[10px] font-bold ${
                            ord.status === 'Confirmed' || ord.status === 'Ready'
                              ? 'bg-emerald-950 text-emerald-300 border border-emerald-800'
                              : 'bg-amber-950 text-amber-300 border border-amber-800'
                          }`}
                        >
                          {ord.status}
                        </span>
                        <span className="block text-[10px] text-slate-500 mt-0.5">
                          {ord.createdAt.split('T')[0]}
                        </span>
                      </div>
                    </div>
                  ))}
                </div>
              </div>

              {/* Pending Prescriptions */}
              <div className="bg-slate-800/80 p-6 rounded-3xl border border-slate-700/80 space-y-4">
                <div className="flex items-center justify-between">
                  <h3 className="font-bold text-white text-sm">Prescription Verifications</h3>
                  <button
                    onClick={() => setCurrentTab('prescriptions')}
                    className="text-xs text-teal-400 hover:underline font-semibold"
                  >
                    Manage Prescriptions →
                  </button>
                </div>

                <div className="divide-y divide-slate-700">
                  {prescriptions.slice(0, 4).map((rx) => (
                    <div key={rx.id} className="py-3 flex items-center justify-between gap-3 text-xs">
                      <div>
                        <span className="font-bold text-white block">{rx.customerName}</span>
                        <span className="text-slate-400 text-[11px]">
                          File: {rx.fileName} • {rx.mobile}
                        </span>
                      </div>
                      <div className="text-right">
                        <span
                          className={`inline-block px-2 py-0.5 rounded-full text-[10px] font-bold ${
                            rx.status === 'Verified'
                              ? 'bg-emerald-950 text-emerald-300 border border-emerald-800'
                              : 'bg-rose-950 text-rose-300 border border-rose-800'
                          }`}
                        >
                          {rx.status}
                        </span>
                        <span className="block text-[10px] text-slate-500 mt-0.5">{rx.requestId}</span>
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            </div>
          </div>
        )}

        {/* ==================== 2. MEDICINES TAB ==================== */}
        {currentTab === 'medicines' && (
          <div className="space-y-6 max-w-7xl">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
              <div>
                <h1 className="text-2xl font-black text-white">Medicine Catalogue Management</h1>
                <p className="text-xs text-slate-400">
                  Add, update, or remove medicines and set stock and pricing
                </p>
              </div>

              <button
                onClick={() => {
                  setCurrentMedForm({
                    id: 'med-' + Date.now(),
                    name: '',
                    slug: '',
                    brand: '',
                    genericName: '',
                    composition: '',
                    categoryId: categories[0]?.id || 'cat-1',
                    categoryName: categories[0]?.name || 'Fever & Body Pain',
                    manufacturer: '',
                    packSize: '10 Tablets',
                    mrp: 100,
                    sellingPrice: 90,
                    stockQuantity: 50,
                    batchNumber: 'BT-2026-01',
                    expiryDate: '2027-12-31',
                    prescriptionRequired: false,
                    description: '',
                    status: 'active',
                    isDemo: false,
                  });
                  setIsEditingMed(true);
                }}
                className="px-4 py-2.5 rounded-xl bg-teal-600 hover:bg-teal-500 text-white font-bold text-xs flex items-center gap-1.5 shadow-md"
              >
                <Plus className="w-4 h-4" />
                <span>Add New Medicine</span>
              </button>
            </div>

            {/* Medicine Search filter */}
            <div className="relative">
              <Search className="absolute left-3.5 top-3 w-4 h-4 text-slate-500" />
              <input
                type="text"
                value={medSearch}
                onChange={(e) => setMedSearch(e.target.value)}
                placeholder="Search catalogued medicine by name, salt, or brand..."
                className="w-full pl-10 pr-4 py-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white text-xs placeholder-slate-500 focus:outline-hidden focus:border-teal-500"
              />
            </div>

            {/* Medicines Table */}
            <div className="bg-slate-800/80 rounded-3xl border border-slate-700 overflow-hidden shadow-xs">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs text-slate-300">
                  <thead className="bg-slate-900/80 text-slate-400 uppercase tracking-wider text-[10px]">
                    <tr>
                      <th className="p-4">Medicine Name</th>
                      <th className="p-4">Category</th>
                      <th className="p-4">Composition</th>
                      <th className="p-4">MRP / Price</th>
                      <th className="p-4">Stock</th>
                      <th className="p-4">Type</th>
                      <th className="p-4 text-right">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-700">
                    {medicines
                      .filter((m) =>
                        medSearch
                          ? m.name.toLowerCase().includes(medSearch.toLowerCase()) ||
                            m.brand.toLowerCase().includes(medSearch.toLowerCase()) ||
                            m.composition.toLowerCase().includes(medSearch.toLowerCase())
                          : true
                      )
                      .map((med) => (
                        <tr key={med.id} className="hover:bg-slate-700/40">
                          <td className="p-4">
                            <span className="font-bold text-white block">{med.name}</span>
                            <span className="text-slate-400 text-[11px] font-mono">
                              {med.brand} • {med.packSize}
                            </span>
                          </td>
                          <td className="p-4 text-slate-300">{med.categoryName}</td>
                          <td className="p-4 font-mono text-[11px] max-w-xs truncate text-slate-400">
                            {med.composition}
                          </td>
                          <td className="p-4">
                            <span className="font-bold text-white">₹{med.sellingPrice}</span>
                            <span className="block text-[10px] text-slate-500">MRP ₹{med.mrp}</span>
                          </td>
                          <td className="p-4">
                            <span
                              className={`font-semibold ${
                                med.stockQuantity < 10 ? 'text-rose-400' : 'text-emerald-400'
                              }`}
                            >
                              {med.stockQuantity} units
                            </span>
                          </td>
                          <td className="p-4">
                            {med.prescriptionRequired ? (
                              <span className="px-2 py-0.5 rounded-full bg-rose-950 text-rose-300 text-[10px] font-bold border border-rose-800">
                                Rx Only
                              </span>
                            ) : (
                              <span className="px-2 py-0.5 rounded-full bg-emerald-950 text-emerald-300 text-[10px] font-semibold border border-emerald-800">
                                OTC
                              </span>
                            )}
                          </td>
                          <td className="p-4 text-right">
                            <div className="flex items-center justify-end gap-2">
                              <button
                                onClick={() => {
                                  setCurrentMedForm({ ...med });
                                  setIsEditingMed(true);
                                }}
                                className="p-1.5 rounded-lg bg-slate-700 hover:bg-slate-600 text-teal-300"
                                title="Edit"
                              >
                                <Edit2 className="w-3.5 h-3.5" />
                              </button>
                              <button
                                onClick={async () => {
                                  if (confirm(`Delete ${med.name}?`)) {
                                    await adminDeleteMedicineAction(med.id);
                                    deleteMedicine(med.id);
                                  }
                                }}
                                className="p-1.5 rounded-lg bg-slate-700 hover:bg-rose-900/80 text-rose-300"
                                title="Delete"
                              >
                                <Trash2 className="w-3.5 h-3.5" />
                              </button>
                            </div>
                          </td>
                        </tr>
                      ))}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Edit / Add Modal */}
            {isEditingMed && (
              <div className="fixed inset-0 z-50 bg-black/70 flex items-center justify-center p-4">
                <div className="bg-slate-900 rounded-3xl border border-slate-700 p-6 sm:p-8 max-w-2xl w-full max-h-[90vh] overflow-y-auto space-y-4">
                  <div className="flex items-center justify-between pb-3 border-b border-slate-800">
                    <h3 className="font-bold text-white text-base">
                      {currentMedForm.id ? 'Edit Medicine' : 'Add Medicine'}
                    </h3>
                    <button
                      onClick={() => setIsEditingMed(false)}
                      className="text-slate-400 hover:text-white"
                    >
                      <X className="w-5 h-5" />
                    </button>
                  </div>

                  <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Medicine Name</label>
                      <input
                        type="text"
                        value={currentMedForm.name || ''}
                        onChange={(e) => {
                          const val = e.target.value;
                          setCurrentMedForm({
                            ...currentMedForm,
                            name: val,
                            slug: val.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, ''),
                          });
                        }}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Brand / Trade Name</label>
                      <input
                        type="text"
                        value={currentMedForm.brand || ''}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, brand: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Generic Name / Salt</label>
                      <input
                        type="text"
                        value={currentMedForm.genericName || ''}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, genericName: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Category</label>
                      <select
                        value={currentMedForm.categoryId || ''}
                        onChange={(e) => {
                          const cat = categories.find((c) => c.id === e.target.value);
                          setCurrentMedForm({
                            ...currentMedForm,
                            categoryId: e.target.value,
                            categoryName: cat?.name || '',
                          });
                        }}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      >
                        {categories.map((c) => (
                          <option key={c.id} value={c.id}>
                            {c.name}
                          </option>
                        ))}
                      </select>
                    </div>

                    <div className="sm:col-span-2">
                      <label className="block text-slate-300 mb-1 font-semibold">Detailed Composition</label>
                      <input
                        type="text"
                        value={currentMedForm.composition || ''}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, composition: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Pack Size</label>
                      <input
                        type="text"
                        value={currentMedForm.packSize || ''}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, packSize: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Manufacturer</label>
                      <input
                        type="text"
                        value={currentMedForm.manufacturer || ''}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, manufacturer: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">MRP (₹)</label>
                      <input
                        type="number"
                        value={currentMedForm.mrp || 0}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, mrp: parseFloat(e.target.value) || 0 })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Selling Price (₹)</label>
                      <input
                        type="number"
                        value={currentMedForm.sellingPrice || 0}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, sellingPrice: parseFloat(e.target.value) || 0 })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Stock Quantity</label>
                      <input
                        type="number"
                        value={currentMedForm.stockQuantity || 0}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, stockQuantity: parseInt(e.target.value) || 0 })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Batch Number</label>
                      <input
                        type="text"
                        value={currentMedForm.batchNumber || ''}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, batchNumber: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Expiry Date</label>
                      <input
                        type="date"
                        value={currentMedForm.expiryDate || ''}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, expiryDate: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div className="flex items-center gap-2 pt-6">
                      <input
                        type="checkbox"
                        id="rxReq"
                        checked={currentMedForm.prescriptionRequired || false}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, prescriptionRequired: e.target.checked })}
                        className="rounded text-teal-600"
                      />
                      <label htmlFor="rxReq" className="text-slate-300 font-semibold cursor-pointer">
                        Prescription Required (Schedule H/Rx)
                      </label>
                    </div>

                    <div className="sm:col-span-2">
                      <label className="block text-slate-300 mb-1 font-semibold">Description</label>
                      <textarea
                        rows={2}
                        value={currentMedForm.description || ''}
                        onChange={(e) => setCurrentMedForm({ ...currentMedForm, description: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>
                  </div>

                  <div className="flex items-center justify-end gap-3 pt-4 border-t border-slate-800">
                    <button
                      onClick={() => setIsEditingMed(false)}
                      className="px-4 py-2 rounded-xl text-slate-400 hover:text-white text-xs font-semibold"
                    >
                      Cancel
                    </button>
                    <button
                      onClick={async () => {
                        if (!currentMedForm.name) {
                          alert('Please enter medicine name');
                          return;
                        }
                        const med = currentMedForm as Medicine;
                        await adminSaveMedicineAction(med);
                        saveMedicine(med);
                        setIsEditingMed(false);
                      }}
                      className="px-5 py-2.5 rounded-xl bg-teal-600 hover:bg-teal-500 text-white font-bold text-xs shadow-md"
                    >
                      Save Medicine
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {/* ==================== 3. CATEGORIES TAB ==================== */}
        {currentTab === 'categories' && (
          <div className="space-y-6 max-w-7xl">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4">
              <div>
                <h1 className="text-2xl font-black text-white">Health Categories ({categories.length})</h1>
                <p className="text-xs text-slate-400">
                  Organize pharmacy catalogue into therapeutic and wellness segments
                </p>
              </div>

              <button
                onClick={() => {
                  setCurrentCatForm({
                    id: 'cat-' + Date.now(),
                    name: '',
                    slug: '',
                    description: '',
                    iconName: 'Pill',
                    productCount: 0,
                    displayOrder: categories.length + 1,
                    status: 'active',
                  });
                  setIsEditingCat(true);
                }}
                className="px-4 py-2.5 rounded-xl bg-teal-600 hover:bg-teal-500 text-white font-bold text-xs flex items-center gap-1.5"
              >
                <Plus className="w-4 h-4" />
                <span>Add Category</span>
              </button>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
              {categories.map((cat) => (
                <div
                  key={cat.id}
                  className="bg-slate-800/80 p-5 rounded-2xl border border-slate-700 flex flex-col justify-between"
                >
                  <div>
                    <div className="flex items-center justify-between mb-2">
                      <span className="text-[10px] uppercase font-bold text-teal-400 bg-teal-950/80 px-2 py-0.5 rounded border border-teal-800">
                        Order #{cat.displayOrder}
                      </span>
                      <span className="text-xs text-slate-400">{cat.productCount} Items</span>
                    </div>
                    <h3 className="font-bold text-white text-sm mb-1">{cat.name}</h3>
                    <p className="text-xs text-slate-400 line-clamp-2">{cat.description}</p>
                  </div>

                  <div className="mt-4 pt-3 border-t border-slate-700 flex items-center justify-end gap-2">
                    <button
                      onClick={() => {
                        setCurrentCatForm({ ...cat });
                        setIsEditingCat(true);
                      }}
                      className="p-1.5 rounded-lg bg-slate-700 hover:bg-slate-600 text-teal-300 text-xs flex items-center gap-1"
                    >
                      <Edit2 className="w-3.5 h-3.5" />
                      <span>Edit</span>
                    </button>
                  </div>
                </div>
              ))}
            </div>

            {/* Edit Category Modal */}
            {isEditingCat && (
              <div className="fixed inset-0 z-50 bg-black/70 flex items-center justify-center p-4">
                <div className="bg-slate-900 rounded-3xl border border-slate-700 p-6 max-w-md w-full space-y-4">
                  <div className="flex items-center justify-between pb-3 border-b border-slate-800">
                    <h3 className="font-bold text-white text-base">
                      {currentCatForm.id ? 'Edit Category' : 'Add Category'}
                    </h3>
                    <button
                      onClick={() => setIsEditingCat(false)}
                      className="text-slate-400 hover:text-white"
                    >
                      <X className="w-5 h-5" />
                    </button>
                  </div>

                  <div className="space-y-3 text-xs">
                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Category Name</label>
                      <input
                        type="text"
                        value={currentCatForm.name || ''}
                        onChange={(e) => {
                          const val = e.target.value;
                          setCurrentCatForm({
                            ...currentCatForm,
                            name: val,
                            slug: val.toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, ''),
                          });
                        }}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>

                    <div>
                      <label className="block text-slate-300 mb-1 font-semibold">Short Description</label>
                      <textarea
                        rows={3}
                        value={currentCatForm.description || ''}
                        onChange={(e) => setCurrentCatForm({ ...currentCatForm, description: e.target.value })}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>
                  </div>

                  <div className="flex items-center justify-end gap-3 pt-3 border-t border-slate-800">
                    <button
                      onClick={() => setIsEditingCat(false)}
                      className="px-4 py-2 rounded-xl text-slate-400 hover:text-white text-xs"
                    >
                      Cancel
                    </button>
                    <button
                      onClick={async () => {
                        if (!currentCatForm.name) return;
                        const cat = currentCatForm as Category;
                        await adminSaveCategoryAction(cat);
                        saveCategory(cat);
                        setIsEditingCat(false);
                      }}
                      className="px-5 py-2.5 rounded-xl bg-teal-600 hover:bg-teal-500 text-white font-bold text-xs"
                    >
                      Save Category
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {/* ==================== 4. ORDERS TAB ==================== */}
        {currentTab === 'orders' && (
          <div className="space-y-6 max-w-7xl">
            <div>
              <h1 className="text-2xl font-black text-white">Order Requests Management</h1>
              <p className="text-xs text-slate-400">
                Verify stock availability, update order status, and track counter collections
              </p>
            </div>

            <div className="bg-slate-800/80 rounded-3xl border border-slate-700 overflow-hidden shadow-xs">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs text-slate-300">
                  <thead className="bg-slate-900/80 text-slate-400 uppercase tracking-wider text-[10px]">
                    <tr>
                      <th className="p-4">Order #</th>
                      <th className="p-4">Customer</th>
                      <th className="p-4">Medicine / Items</th>
                      <th className="p-4">Preference & Address</th>
                      <th className="p-4">Status</th>
                      <th className="p-4 text-right">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-700">
                    {orders.map((ord) => (
                      <tr key={ord.id} className="hover:bg-slate-700/40">
                        <td className="p-4 font-mono font-bold text-teal-300">
                          {ord.orderNumber}
                          <span className="block text-[10px] text-slate-500">
                            {ord.createdAt.split('T')[0]}
                          </span>
                        </td>
                        <td className="p-4">
                          <span className="font-bold text-white block">{ord.customerName}</span>
                          <span className="text-slate-400 font-mono text-[11px]">{ord.mobile}</span>
                        </td>
                        <td className="p-4 text-slate-200">
                          {ord.items.map((i) => (
                            <span key={i.medicineName} className="block">
                              • {i.medicineName} (Qty: {i.quantity})
                            </span>
                          ))}
                          {ord.prescriptionFileName && (
                            <span className="inline-block mt-1 text-[10px] px-1.5 py-0.5 rounded bg-teal-950 text-teal-300 border border-teal-800">
                              Rx Attached: {ord.prescriptionFileName}
                            </span>
                          )}
                        </td>
                        <td className="p-4 text-slate-400 max-w-xs">
                          <span className="font-semibold text-slate-300 block">{ord.preference}</span>
                          <span className="text-[11px] truncate block">{ord.address}</span>
                        </td>
                        <td className="p-4">
                          <select
                            value={ord.status}
                            onChange={async (e) => {
                              const newStatus = e.target.value as OrderStatus;
                              await adminUpdateOrderStatusAction(ord.id, newStatus);
                              updateOrderStatus(ord.id, newStatus);
                            }}
                            className="bg-slate-900 border border-slate-700 rounded-lg p-1.5 text-xs text-white"
                          >
                            <option value="Pending">Pending</option>
                            <option value="Under Verification">Under Verification</option>
                            <option value="Confirmed">Confirmed</option>
                            <option value="Preparing">Preparing</option>
                            <option value="Ready">Ready</option>
                            <option value="Out for Delivery">Out for Delivery</option>
                            <option value="Delivered">Delivered</option>
                            <option value="Cancelled">Cancelled</option>
                          </select>
                        </td>
                        <td className="p-4 text-right">
                          <button
                            onClick={() => setSelectedOrder(ord)}
                            className="px-3 py-1.5 rounded-lg bg-teal-700 hover:bg-teal-600 text-white font-semibold text-xs"
                          >
                            Details
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Order Details Modal */}
            {selectedOrder && (
              <div className="fixed inset-0 z-50 bg-black/70 flex items-center justify-center p-4">
                <div className="bg-slate-900 rounded-3xl border border-slate-700 p-6 sm:p-8 max-w-lg w-full space-y-4">
                  <div className="flex items-center justify-between pb-3 border-b border-slate-800">
                    <h3 className="font-bold text-white text-base">
                      Order Details: {selectedOrder.orderNumber}
                    </h3>
                    <button
                      onClick={() => setSelectedOrder(null)}
                      className="text-slate-400 hover:text-white"
                    >
                      <X className="w-5 h-5" />
                    </button>
                  </div>

                  <div className="space-y-3 text-xs text-slate-300">
                    <div>
                      <strong className="text-white block">Customer:</strong>
                      <span>{selectedOrder.customerName} ({selectedOrder.mobile})</span>
                    </div>

                    <div>
                      <strong className="text-white block">Address & Preference:</strong>
                      <span>{selectedOrder.preference} — {selectedOrder.address}</span>
                    </div>

                    {selectedOrder.additionalMessage && (
                      <div>
                        <strong className="text-white block">Customer Note:</strong>
                        <span className="italic">{selectedOrder.additionalMessage}</span>
                      </div>
                    )}

                    <div className="pt-2">
                      <strong className="text-white block mb-1">Internal Pharmacist Notes:</strong>
                      <textarea
                        rows={3}
                        defaultValue={selectedOrder.internalNotes || ''}
                        placeholder="Add private dispensary notes (not shown to customer)..."
                        onBlur={(e) => {
                          updateOrderStatus(selectedOrder.id, selectedOrder.status, e.target.value);
                        }}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>
                  </div>

                  <div className="flex justify-end pt-3 border-t border-slate-800">
                    <button
                      onClick={() => setSelectedOrder(null)}
                      className="px-4 py-2 rounded-xl bg-teal-600 text-white font-bold text-xs"
                    >
                      Done
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {/* ==================== 5. PRESCRIPTIONS TAB ==================== */}
        {currentTab === 'prescriptions' && (
          <div className="space-y-6 max-w-7xl">
            <div>
              <h1 className="text-2xl font-black text-white">Prescription Verification Portal</h1>
              <p className="text-xs text-slate-400">
                Securely inspect doctor prescriptions, verify patient medications, and update compliance review status
              </p>
            </div>

            <div className="bg-slate-800/80 rounded-3xl border border-slate-700 overflow-hidden shadow-xs">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs text-slate-300">
                  <thead className="bg-slate-900/80 text-slate-400 uppercase tracking-wider text-[10px]">
                    <tr>
                      <th className="p-4">Request ID</th>
                      <th className="p-4">Customer</th>
                      <th className="p-4">Prescription File</th>
                      <th className="p-4">Order Notes</th>
                      <th className="p-4">Verification Status</th>
                      <th className="p-4 text-right">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-700">
                    {prescriptions.map((rx) => (
                      <tr key={rx.id} className="hover:bg-slate-700/40">
                        <td className="p-4 font-mono font-bold text-teal-300">
                          {rx.requestId}
                          <span className="block text-[10px] text-slate-500">
                            {rx.createdAt.split('T')[0]}
                          </span>
                        </td>
                        <td className="p-4">
                          <span className="font-bold text-white block">{rx.customerName}</span>
                          <span className="text-slate-400 font-mono text-[11px]">{rx.mobile}</span>
                        </td>
                        <td className="p-4 text-slate-200">
                          <span className="font-mono text-[11px] block text-teal-300 font-semibold">
                            {rx.fileName}
                          </span>
                          <span className="text-[10px] text-slate-500">
                            {(rx.fileSize / 1024).toFixed(1)} KB • {rx.fileType || 'Document'}
                          </span>
                        </td>
                        <td className="p-4 text-slate-400 max-w-xs truncate">
                          {rx.orderDetails || rx.deliveryAddress}
                        </td>
                        <td className="p-4">
                          <select
                            value={rx.status}
                            onChange={async (e) => {
                              const newStatus = e.target.value as PrescriptionStatus;
                              await adminUpdatePrescriptionStatusAction(rx.id, newStatus);
                              updatePrescriptionStatus(rx.id, newStatus);
                            }}
                            className="bg-slate-900 border border-slate-700 rounded-lg p-1.5 text-xs text-white"
                          >
                            <option value="Pending Review">Pending Review</option>
                            <option value="Verified">Verified</option>
                            <option value="Clarification Required">Clarification Required</option>
                            <option value="Rejected">Rejected</option>
                            <option value="Completed">Completed</option>
                          </select>
                        </td>
                        <td className="p-4 text-right">
                          <button
                            onClick={() => setSelectedRx(rx)}
                            className="px-3 py-1.5 rounded-lg bg-teal-700 hover:bg-teal-600 text-white font-semibold text-xs flex items-center gap-1 ml-auto"
                          >
                            <Eye className="w-3.5 h-3.5" />
                            <span>Inspect</span>
                          </button>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>

            {/* Prescription Preview & Clinical Review Modal */}
            {selectedRx && (
              <div className="fixed inset-0 z-50 bg-black/80 flex items-center justify-center p-4">
                <div className="bg-slate-900 rounded-3xl border border-slate-700 p-6 sm:p-8 max-w-xl w-full max-h-[90vh] overflow-y-auto space-y-4">
                  <div className="flex items-center justify-between pb-3 border-b border-slate-800">
                    <h3 className="font-bold text-white text-base">
                      Prescription Review: {selectedRx.requestId}
                    </h3>
                    <button
                      onClick={() => setSelectedRx(null)}
                      className="text-slate-400 hover:text-white"
                    >
                      <X className="w-5 h-5" />
                    </button>
                  </div>

                  <div className="space-y-3 text-xs text-slate-300">
                    <div className="p-3 bg-slate-800 rounded-xl space-y-1">
                      <p>
                        <strong className="text-white">Customer:</strong> {selectedRx.customerName} ({selectedRx.mobile})
                      </p>
                      <p>
                        <strong className="text-white">Delivery Landmark:</strong> {selectedRx.deliveryAddress}
                      </p>
                      <p>
                        <strong className="text-white">Details:</strong> {selectedRx.orderDetails}
                      </p>
                    </div>

                    {/* Secure File View Box */}
                    <div className="p-4 bg-slate-950 rounded-2xl border border-slate-800 text-center space-y-3">
                      <span className="text-xs text-slate-400 block font-semibold">
                        Prescription Document: {selectedRx.fileName}
                      </span>
                      {selectedRx.signedUrl || selectedRx.fileData ? (
                        <div className="space-y-3">
                          <div className="max-h-64 overflow-hidden rounded-xl border border-slate-800 bg-black/50">
                            {/* eslint-disable-next-line @next/next/no-img-element */}
                            <img
                              src={selectedRx.signedUrl || selectedRx.fileData}
                              alt="Prescription preview"
                              className="w-full object-contain max-h-64 mx-auto"
                            />
                          </div>
                          {selectedRx.signedUrl && (
                            <a
                              href={selectedRx.signedUrl}
                              target="_blank"
                              rel="noopener noreferrer"
                              className="inline-flex items-center gap-1.5 text-xs text-teal-400 hover:text-teal-300 font-semibold underline"
                            >
                              <ExternalLink className="w-3.5 h-3.5" />
                              <span>Open Secure High-Resolution Prescription</span>
                            </a>
                          )}
                        </div>
                      ) : (
                        <div className="p-8 bg-slate-900 rounded-xl text-slate-400 text-xs flex flex-col items-center">
                          <FileText className="w-10 h-10 text-teal-400 mb-2" />
                          <span>PDF Prescription Document Attached</span>
                          <span className="text-[10px] text-slate-500 mt-1">
                            Stored in private Supabase Storage bucket with encrypted access
                          </span>
                        </div>
                      )}
                    </div>

                    <div>
                      <label className="block text-white font-semibold mb-1">
                        Internal Pharmacist Verification Notes:
                      </label>
                      <textarea
                        rows={2}
                        defaultValue={selectedRx.internalNotes || ''}
                        placeholder="Add notes: e.g. Verified Dr. stamp, 15 days antibiotic course approved..."
                        onBlur={async (e) => {
                          const note = e.target.value;
                          await adminUpdatePrescriptionStatusAction(selectedRx.id, selectedRx.status, note);
                          updatePrescriptionStatus(selectedRx.id, selectedRx.status, note);
                        }}
                        className="w-full p-2.5 bg-slate-800 border border-slate-700 rounded-xl text-white"
                      />
                    </div>
                  </div>

                  <div className="flex items-center justify-between pt-3 border-t border-slate-800">
                    <div className="flex gap-2">
                      <button
                        onClick={async () => {
                          await adminUpdatePrescriptionStatusAction(selectedRx.id, 'Verified');
                          updatePrescriptionStatus(selectedRx.id, 'Verified');
                          setSelectedRx(null);
                        }}
                        className="px-3 py-1.5 rounded-xl bg-emerald-600 hover:bg-emerald-500 text-white font-bold text-xs"
                      >
                        Approve & Verify
                      </button>
                      <button
                        onClick={async () => {
                          await adminUpdatePrescriptionStatusAction(selectedRx.id, 'Clarification Required');
                          updatePrescriptionStatus(selectedRx.id, 'Clarification Required');
                          setSelectedRx(null);
                        }}
                        className="px-3 py-1.5 rounded-xl bg-amber-600 hover:bg-amber-500 text-white font-bold text-xs"
                      >
                        Clarification Needed
                      </button>
                    </div>

                    <button
                      onClick={() => setSelectedRx(null)}
                      className="px-4 py-1.5 rounded-xl bg-slate-800 text-slate-300 text-xs font-semibold"
                    >
                      Close
                    </button>
                  </div>
                </div>
              </div>
            )}
          </div>
        )}

        {/* ==================== 6. INVENTORY TAB ==================== */}
        {currentTab === 'inventory' && (
          <div className="space-y-6 max-w-7xl">
            <div>
              <h1 className="text-2xl font-black text-white">Dispensary Inventory & Expiry Tracking</h1>
              <p className="text-xs text-slate-400">
                Track batch numbers, manufacturing dates, expiry alerts, and stock balances
              </p>
            </div>

            <div className="bg-slate-800/80 rounded-3xl border border-slate-700 overflow-hidden shadow-xs">
              <div className="overflow-x-auto">
                <table className="w-full text-left text-xs text-slate-300">
                  <thead className="bg-slate-900/80 text-slate-400 uppercase tracking-wider text-[10px]">
                    <tr>
                      <th className="p-4">Batch Number</th>
                      <th className="p-4">Medicine</th>
                      <th className="p-4">Expiry Date</th>
                      <th className="p-4">In-Stock Qty</th>
                      <th className="p-4">Cost / Selling</th>
                      <th className="p-4">Status</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-700">
                    {inventory.map((inv) => (
                      <tr key={inv.id} className="hover:bg-slate-700/40">
                        <td className="p-4 font-mono font-bold text-teal-300">{inv.batchNumber}</td>
                        <td className="p-4 font-bold text-white">{inv.medicineName}</td>
                        <td className="p-4 font-mono">{inv.expiryDate}</td>
                        <td className="p-4 font-semibold text-emerald-300">{inv.stockQuantity} units</td>
                        <td className="p-4">
                          <span>₹{inv.sellingPrice}</span>
                          <span className="block text-[10px] text-slate-500">Cost ₹{inv.purchasePrice}</span>
                        </td>
                        <td className="p-4">
                          <span
                            className={`px-2 py-0.5 rounded-full text-[10px] font-bold ${
                              inv.status === 'In Stock'
                                ? 'bg-emerald-950 text-emerald-300 border border-emerald-800'
                                : 'bg-amber-950 text-amber-300 border border-amber-800'
                            }`}
                          >
                            {inv.status}
                          </span>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        )}

        {/* ==================== 7. CUSTOMERS TAB ==================== */}
        {currentTab === 'customers' && (
          <div className="space-y-6 max-w-7xl">
            <div>
              <h1 className="text-2xl font-black text-white">Registered Customer Profiles</h1>
              <p className="text-xs text-slate-400">
                Directory of customers in Village Kubri and surrounding panchayats
              </p>
            </div>

            <div className="bg-slate-800/80 rounded-3xl border border-slate-700 p-6 space-y-4">
              <div className="divide-y divide-slate-700">
                {orders.map((ord) => (
                  <div key={ord.id} className="py-4 flex flex-col sm:flex-row sm:items-center justify-between gap-3 text-xs">
                    <div>
                      <h4 className="font-bold text-white text-sm">{ord.customerName}</h4>
                      <p className="text-slate-400 mt-0.5">
                        Mobile: <span className="font-mono text-teal-300">{ord.mobile}</span> • Address: {ord.address}
                      </p>
                    </div>
                    <span className="text-[11px] text-slate-400 bg-slate-900 px-3 py-1 rounded-xl border border-slate-800">
                      Order: {ord.orderNumber}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* ==================== 8. ENQUIRIES TAB ==================== */}
        {currentTab === 'enquiries' && (
          <div className="space-y-6 max-w-7xl">
            <div>
              <h1 className="text-2xl font-black text-white">Customer Enquiries ({enquiries.length})</h1>
              <p className="text-xs text-slate-400">
                Inquiries and messages submitted from the public contact page
              </p>
            </div>

            <div className="bg-slate-800/80 rounded-3xl border border-slate-700 overflow-hidden shadow-xs">
              <div className="divide-y divide-slate-700">
                {enquiries.map((enq) => (
                  <div key={enq.id} className="p-5 space-y-2 hover:bg-slate-700/30 text-xs">
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-2">
                        <span className="font-bold text-white text-sm">{enq.customerName}</span>
                        <span className="text-slate-400 font-mono">({enq.mobile})</span>
                      </div>
                      <select
                        value={enq.status}
                        onChange={async (e) => {
                          const newStatus = e.target.value as EnquiryStatus;
                          await adminUpdateEnquiryStatusAction(enq.id, newStatus);
                          updateEnquiryStatus(enq.id, newStatus);
                        }}
                        className="bg-slate-900 border border-slate-700 rounded-lg p-1 text-[11px] text-white"
                      >
                        <option value="New">New</option>
                        <option value="Contacted">Contacted</option>
                        <option value="Resolved">Resolved</option>
                      </select>
                    </div>

                    {enq.medicineInterested && (
                      <p className="text-teal-300 font-semibold">
                        Interested in: {enq.medicineInterested}
                      </p>
                    )}

                    <p className="text-slate-300 bg-slate-900/60 p-3 rounded-xl border border-slate-800">
                      &ldquo;{enq.message}&rdquo;
                    </p>

                    <span className="text-[10px] text-slate-500 block">
                      Submitted on {enq.createdAt.split('T')[0]}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {/* ==================== 9. SETTINGS TAB (Requirement #27 & #41) ==================== */}
        {currentTab === 'settings' && (
          <div className="space-y-6 max-w-4xl">
            <div>
              <h1 className="text-2xl font-black text-white">Dispensary & Website Settings</h1>
              <p className="text-xs text-slate-400">
                Configure shopkeeper details, phone, WhatsApp, timings, and legal placeholders
              </p>
            </div>

            {settingsSaved && (
              <div className="p-4 rounded-2xl bg-emerald-950 border border-emerald-800 text-emerald-300 text-xs flex items-center gap-2">
                <CheckCircle className="w-4 h-4 text-emerald-400" />
                <span>Settings updated successfully! Changes are live on the public website.</span>
              </div>
            )}

            <div className="bg-slate-800/80 rounded-3xl border border-slate-700 p-6 sm:p-8 space-y-6 text-xs">
              {/* Shop Basics */}
              <div>
                <h3 className="font-bold text-white text-sm mb-3 pb-2 border-b border-slate-700">
                  Shop Identity & Physical Address
                </h3>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Shop Name</label>
                    <input
                      type="text"
                      value={settingsForm.shopName}
                      onChange={(e) => setSettingsForm({ ...settingsForm, shopName: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Tagline</label>
                    <input
                      type="text"
                      value={settingsForm.tagline}
                      onChange={(e) => setSettingsForm({ ...settingsForm, tagline: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Village</label>
                    <input
                      type="text"
                      value={settingsForm.addressVillage}
                      onChange={(e) => setSettingsForm({ ...settingsForm, addressVillage: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Post</label>
                    <input
                      type="text"
                      value={settingsForm.addressPost}
                      onChange={(e) => setSettingsForm({ ...settingsForm, addressPost: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Panchayat</label>
                    <input
                      type="text"
                      value={settingsForm.addressPanchayat}
                      onChange={(e) => setSettingsForm({ ...settingsForm, addressPanchayat: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">District & Pincode</label>
                    <input
                      type="text"
                      value={`${settingsForm.addressDistrict}, ${settingsForm.pincode}`}
                      onChange={(e) => setSettingsForm({ ...settingsForm, addressDistrict: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>
                </div>
              </div>

              {/* Contact Placeholders & Integrations */}
              <div>
                <h3 className="font-bold text-white text-sm mb-3 pb-2 border-b border-slate-700">
                  Shopkeeper Contact & WhatsApp Numbers
                </h3>
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">
                      Shop Mobile Number
                    </label>
                    <input
                      type="text"
                      value={settingsForm.phone}
                      onChange={(e) => setSettingsForm({ ...settingsForm, phone: e.target.value })}
                      placeholder="e.g. +91 98765 43210"
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white font-mono"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">
                      WhatsApp Number (for direct chat)
                    </label>
                    <input
                      type="text"
                      value={settingsForm.whatsapp}
                      onChange={(e) => setSettingsForm({ ...settingsForm, whatsapp: e.target.value })}
                      placeholder="e.g. 919876543210"
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white font-mono"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Email Address</label>
                    <input
                      type="text"
                      value={settingsForm.email}
                      onChange={(e) => setSettingsForm({ ...settingsForm, email: e.target.value })}
                      placeholder="e.g. contact@durgamedicalhall.com"
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white font-mono"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Google Maps URL</label>
                    <input
                      type="text"
                      value={settingsForm.googleMapsUrl}
                      onChange={(e) => setSettingsForm({ ...settingsForm, googleMapsUrl: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white font-mono"
                    />
                  </div>
                </div>
              </div>

              {/* Timings & Licenses */}
              <div>
                <h3 className="font-bold text-white text-sm mb-3 pb-2 border-b border-slate-700">
                  Shop Timings & Licensing
                </h3>
                <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Opening Time</label>
                    <input
                      type="text"
                      value={settingsForm.openingTime}
                      onChange={(e) => setSettingsForm({ ...settingsForm, openingTime: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Closing Time</label>
                    <input
                      type="text"
                      value={settingsForm.closingTime}
                      onChange={(e) => setSettingsForm({ ...settingsForm, closingTime: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Weekly Schedule</label>
                    <input
                      type="text"
                      value={settingsForm.weeklyHoliday}
                      onChange={(e) => setSettingsForm({ ...settingsForm, weeklyHoliday: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Drug License #</label>
                    <input
                      type="text"
                      value={settingsForm.drugLicenseNumber}
                      onChange={(e) => setSettingsForm({ ...settingsForm, drugLicenseNumber: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white font-mono"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">GST #</label>
                    <input
                      type="text"
                      value={settingsForm.gstNumber}
                      onChange={(e) => setSettingsForm({ ...settingsForm, gstNumber: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white font-mono"
                    />
                  </div>

                  <div>
                    <label className="block text-slate-300 mb-1 font-semibold">Delivery Charge Info</label>
                    <input
                      type="text"
                      value={settingsForm.deliveryCharge}
                      onChange={(e) => setSettingsForm({ ...settingsForm, deliveryCharge: e.target.value })}
                      className="w-full p-2.5 bg-slate-900 border border-slate-700 rounded-xl text-white"
                    />
                  </div>
                </div>
              </div>

              {/* Save Settings Button */}
              <div className="pt-4 border-t border-slate-700 flex justify-end">
                <button
                  type="button"
                  onClick={async () => {
                    await adminSaveSettingsAction(settingsForm);
                    saveSettings(settingsForm);
                    setSettingsSaved(true);
                    setTimeout(() => setSettingsSaved(false), 3000);
                  }}
                  className="px-6 py-3 rounded-xl bg-teal-600 hover:bg-teal-500 text-white font-bold text-xs flex items-center gap-2 shadow-lg"
                >
                  <Save className="w-4 h-4" />
                  <span>{settingsSaved ? 'Saved to Database!' : 'Save All Settings'}</span>
                </button>
              </div>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
