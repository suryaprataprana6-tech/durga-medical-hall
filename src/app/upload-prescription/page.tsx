'use client';

import React, { useState } from 'react';
import Link from 'next/link';
import {
  FileUp,
  CheckCircle2,
  ShieldCheck,
  Lock,
} from 'lucide-react';
import { createPrescriptionRequest } from '@/lib/store';
import { submitPrescriptionAction } from '@/app/actions/prescriptions';

export default function PrescriptionUploadPage() {
  const [formData, setFormData] = useState({
    customerName: '',
    mobile: '',
    email: '',
    orderDetails: '',
    deliveryAddress: 'Village Kubri, Giridih',
    additionalMessage: '',
  });

  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [filePreview, setFilePreview] = useState<string | null>(null);
  const [fileError, setFileError] = useState<string | null>(null);
  const [isDragging, setIsDragging] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submittedRequestId, setSubmittedRequestId] = useState<string | null>(null);

  const processFile = (file: File) => {
    setFileError(null);
    const validMimes = ['image/jpeg', 'image/png', 'image/jpg', 'application/pdf'];
    const validExtensions = ['.jpg', '.jpeg', '.png', '.pdf'];

    const hasValidExt = validExtensions.some((ext) =>
      file.name.toLowerCase().endsWith(ext)
    );

    if (!validMimes.includes(file.type) && !hasValidExt) {
      setFileError('Invalid file type. Please upload a JPG, JPEG, PNG, or PDF file.');
      return;
    }

    if (file.size > 10 * 1024 * 1024) {
      setFileError('File exceeds 10MB size limit. Please upload a smaller file or photo.');
      return;
    }

    setSelectedFile(file);

    if (file.type.startsWith('image/')) {
      const reader = new FileReader();
      reader.onload = () => setFilePreview(reader.result as string);
      reader.readAsDataURL(file);
    } else {
      setFilePreview(null);
    }
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(true);
  };

  const handleDragLeave = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);
    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      processFile(e.dataTransfer.files[0]);
    }
  };

  const handleFileInput = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      processFile(e.target.files[0]);
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.customerName.trim() || !formData.mobile.trim()) {
      alert('Please fill in your Customer Name and Mobile Number.');
      return;
    }
    if (!selectedFile) {
      setFileError('Please attach or drop your prescription slip file (JPG, PNG, or PDF).');
      return;
    }

    setIsSubmitting(true);
    try {
      const data = new FormData();
      data.append('customerName', formData.customerName.trim());
      data.append('mobile', formData.mobile.trim());
      if (formData.email.trim()) data.append('email', formData.email.trim());
      data.append('deliveryAddress', formData.deliveryAddress.trim());
      if (formData.orderDetails.trim()) data.append('orderDetails', formData.orderDetails.trim());
      if (formData.additionalMessage.trim()) data.append('additionalMessage', formData.additionalMessage.trim());
      data.append('file', selectedFile);

      const res = await submitPrescriptionAction(data);

      if (!res.success) {
        alert(res.error || 'Failed to upload prescription. Please try again.');
        setIsSubmitting(false);
        return;
      }

      // Also sync to local state store for immediate local display
      createPrescriptionRequest({
        customerName: formData.customerName.trim(),
        mobile: formData.mobile.trim(),
        email: formData.email.trim() || undefined,
        fileName: selectedFile.name,
        fileType: selectedFile.type,
        fileSize: selectedFile.size,
        fileData: filePreview || undefined,
        orderDetails: formData.orderDetails.trim() || 'Prescription as attached by customer',
        deliveryAddress: formData.deliveryAddress.trim(),
        additionalMessage: formData.additionalMessage.trim() || undefined,
      });

      setSubmittedRequestId(res.requestId);
    } catch (err) {
      console.error(err);
      alert('Unable to submit prescription. Please try again or visit our Kubri store.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-50 py-10">
      <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Breadcrumb */}
        <div className="flex items-center gap-2 text-xs text-slate-500 mb-6">
          <Link href="/" className="hover:text-teal-700">
            Home
          </Link>
          <span>/</span>
          <span className="text-slate-800 font-semibold">Prescription Upload</span>
        </div>

        {/* Page Header */}
        <div className="mb-8">
          <h1 className="text-3xl font-extrabold text-slate-900 tracking-tight">
            Upload Doctor Prescription Slip
          </h1>
          <p className="text-sm text-slate-600 mt-1 max-w-2xl">
            Securely upload a photo or document of your prescription. Durga Medical Hall pharmacists will review the doctor recommendation and verify available medicines.
          </p>
        </div>

        {/* Submission Confirmation Screen (Requirement #13) */}
        {submittedRequestId ? (
          <div className="bg-white rounded-3xl p-8 sm:p-12 border border-slate-200 text-center shadow-md animate-in fade-in zoom-in-95 duration-200">
            <div className="w-16 h-16 rounded-full bg-emerald-100 text-emerald-700 flex items-center justify-center mx-auto mb-4">
              <CheckCircle2 className="w-8 h-8" />
            </div>
            <span className="text-xs font-bold uppercase tracking-wider text-emerald-700 bg-emerald-50 px-3 py-1 rounded-full border border-emerald-200">
              Reference ID: {submittedRequestId}
            </span>
            <h2 className="text-2xl font-extrabold text-slate-900 mt-3 mb-2">
              Prescription received.
            </h2>
            <p className="text-base text-slate-700 max-w-md mx-auto mb-6 leading-relaxed">
              It will be reviewed according to applicable pharmacy requirements.
            </p>

            <div className="p-4 rounded-2xl bg-teal-50 border border-teal-200 text-xs text-teal-900 max-w-md mx-auto text-left mb-8 flex items-start gap-2.5">
              <ShieldCheck className="w-4 h-4 text-teal-700 shrink-0 mt-0.5" />
              <span>
                Our pharmacist at Durga Medical Hall Kubri will inspect the dosage, date, and registered medical practitioner stamp, then call you at <strong>{formData.mobile}</strong>.
              </span>
            </div>

            <div className="flex flex-wrap items-center justify-center gap-3">
              <Link
                href="/medicines"
                className="py-3 px-6 rounded-xl bg-teal-700 hover:bg-teal-800 text-white font-bold text-xs sm:text-sm shadow-sm transition-all"
              >
                Browse Healthcare Catalogue
              </Link>
              <Link
                href="/contact"
                className="py-3 px-6 rounded-xl border border-slate-300 text-slate-700 font-semibold text-xs sm:text-sm hover:bg-slate-50 transition-colors"
              >
                Store Details & Address
              </Link>
            </div>
          </div>
        ) : (
          <div className="grid grid-cols-1 lg:grid-cols-12 gap-8">
            {/* Left Col: Upload Form */}
            <div className="lg:col-span-8">
              <form
                onSubmit={handleSubmit}
                className="bg-white rounded-3xl p-6 sm:p-8 border border-slate-200 shadow-xs space-y-6"
              >
                {/* Drag and Drop Zone */}
                <div>
                  <label className="block text-xs font-bold text-slate-900 mb-2">
                    Prescription Document / Photo <span className="text-rose-500">*</span>
                  </label>

                  <div
                    onDragOver={handleDragOver}
                    onDragLeave={handleDragLeave}
                    onDrop={handleDrop}
                    className={`border-2 border-dashed rounded-2xl p-6 sm:p-8 text-center transition-all ${
                      isDragging
                        ? 'border-teal-500 bg-teal-50/50'
                        : selectedFile
                        ? 'border-emerald-400 bg-emerald-50/30'
                        : 'border-slate-300 bg-slate-50 hover:bg-slate-100/50'
                    }`}
                  >
                    <div className="w-14 h-14 rounded-2xl bg-white shadow-xs border border-slate-200 text-teal-700 flex items-center justify-center mx-auto mb-3">
                      <FileUp className="w-7 h-7" />
                    </div>

                    {selectedFile ? (
                      <div className="space-y-1">
                        <span className="text-xs font-bold text-emerald-800 block">
                          ✓ File Attached: {selectedFile.name}
                        </span>
                        <span className="text-[11px] text-slate-500 block">
                          Size: {(selectedFile.size / (1024 * 1024)).toFixed(2)} MB • Type: {selectedFile.type || 'Document'}
                        </span>
                        <label
                          htmlFor="rx-file-change"
                          className="inline-block text-xs text-teal-700 hover:underline cursor-pointer font-semibold pt-2"
                        >
                          Change File
                        </label>
                        <input
                          id="rx-file-change"
                          type="file"
                          accept=".jpg,.jpeg,.png,.pdf"
                          onChange={handleFileInput}
                          className="hidden"
                        />
                      </div>
                    ) : (
                      <div className="space-y-2">
                        <p className="text-sm font-semibold text-slate-800">
                          Drag and drop your prescription here, or{' '}
                          <label
                            htmlFor="rx-file-input"
                            className="text-teal-700 hover:text-teal-800 underline cursor-pointer"
                          >
                            Browse Files
                          </label>
                        </p>
                        <p className="text-xs text-slate-500">
                          Accepted formats: JPG, JPEG, PNG, PDF (Max size: 10MB)
                        </p>
                        <input
                          id="rx-file-input"
                          type="file"
                          accept=".jpg,.jpeg,.png,.pdf"
                          onChange={handleFileInput}
                          className="hidden"
                        />
                      </div>
                    )}

                    {fileError && (
                      <div className="mt-3 p-2 bg-rose-50 text-rose-700 rounded-lg text-xs font-medium border border-rose-200">
                        {fileError}
                      </div>
                    )}
                  </div>
                </div>

                {/* Customer Details */}
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-xs font-semibold text-slate-700 mb-1">
                      Customer Full Name <span className="text-rose-500">*</span>
                    </label>
                    <input
                      type="text"
                      required
                      value={formData.customerName}
                      onChange={(e) => setFormData({ ...formData, customerName: e.target.value })}
                      placeholder="e.g. Anil Soren"
                      className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                    />
                  </div>

                  <div>
                    <label className="block text-xs font-semibold text-slate-700 mb-1">
                      Mobile Number <span className="text-rose-500">*</span>
                    </label>
                    <input
                      type="tel"
                      required
                      value={formData.mobile}
                      onChange={(e) => setFormData({ ...formData, mobile: e.target.value })}
                      placeholder="e.g. 9876543210"
                      className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                    />
                  </div>

                  <div className="sm:col-span-2">
                    <label className="block text-xs font-semibold text-slate-700 mb-1">
                      Email Address <span className="text-slate-400 font-normal">(Optional)</span>
                    </label>
                    <input
                      type="email"
                      value={formData.email}
                      onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                      placeholder="e.g. yourname@example.com"
                      className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                    />
                  </div>

                  <div className="sm:col-span-2">
                    <label className="block text-xs font-semibold text-slate-700 mb-1">
                      Medicine / Order Details
                    </label>
                    <textarea
                      rows={2}
                      value={formData.orderDetails}
                      onChange={(e) => setFormData({ ...formData, orderDetails: e.target.value })}
                      placeholder="e.g. Need 15 days supply of all medicines listed on slip"
                      className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                    />
                  </div>

                  <div className="sm:col-span-2">
                    <label className="block text-xs font-semibold text-slate-700 mb-1">
                      Delivery Address / Village Landmark <span className="text-rose-500">*</span>
                    </label>
                    <textarea
                      required
                      rows={2}
                      value={formData.deliveryAddress}
                      onChange={(e) => setFormData({ ...formData, deliveryAddress: e.target.value })}
                      placeholder="e.g. Village Kubri, Post Kubri, Makdiha, Giridih"
                      className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                    />
                  </div>

                  <div className="sm:col-span-2">
                    <label className="block text-xs font-semibold text-slate-700 mb-1">
                      Additional Message (Optional)
                    </label>
                    <input
                      type="text"
                      value={formData.additionalMessage}
                      onChange={(e) => setFormData({ ...formData, additionalMessage: e.target.value })}
                      placeholder="e.g. Please check if syrup is suitable for 5 year old"
                      className="w-full py-2.5 px-3.5 bg-slate-50 border border-slate-300 rounded-xl text-slate-800 text-sm focus:bg-white focus:border-teal-600 focus:ring-1 focus:ring-teal-600 outline-hidden"
                    />
                  </div>
                </div>

                {/* Submit Button */}
                <div className="pt-2">
                  <button
                    type="submit"
                    disabled={isSubmitting}
                    className="w-full py-3.5 px-6 rounded-xl bg-teal-700 hover:bg-teal-800 text-white font-bold text-sm shadow-md shadow-teal-700/20 text-center transition-all disabled:opacity-50"
                  >
                    {isSubmitting ? 'Submitting Prescription Slip...' : 'Submit Prescription for Verification'}
                  </button>
                </div>
              </form>
            </div>

            {/* Right Col: Privacy & Security Assurances */}
            <div className="lg:col-span-4 space-y-6">
              <div className="bg-white rounded-3xl p-6 border border-slate-200 shadow-xs space-y-4">
                <div className="flex items-center gap-2 text-teal-800 font-bold text-sm">
                  <Lock className="w-4 h-4 text-teal-700" />
                  <span>Prescription Privacy & Security</span>
                </div>
                <p className="text-xs text-slate-600 leading-relaxed">
                  Durga Medical Hall treats all prescription documents with strict medical confidentiality:
                </p>
                <ul className="text-xs text-slate-600 space-y-2 list-disc list-inside">
                  <li>Prescription files are stored securely and never made public.</li>
                  <li>Only licensed dispensary staff review medical slips.</li>
                  <li>Files are strictly used to verify pharmaceutical accuracy.</li>
                </ul>
              </div>

              {/* Guidelines for clear slip */}
              <div className="bg-slate-100 rounded-3xl p-6 border border-slate-200 text-xs text-slate-700 space-y-2">
                <strong className="text-slate-900 block font-bold">
                  Tips for Clear Prescription Upload:
                </strong>
                <p>• Ensure doctor’s name, clinic details and date are clearly readable.</p>
                <p>• Make sure medicine names and dosages are not cut off.</p>
                <p>• Take photo in good natural lighting.</p>
              </div>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
