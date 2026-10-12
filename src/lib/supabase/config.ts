export function isSupabaseConfigured(): boolean {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const anonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.PUBLIC_SUPABASE_ANON_KEY;

  if (!url || !anonKey) return false;
  if (url.includes('your-project-ref') || url.includes('dummy-project')) return false;
  if (anonKey.includes('your-anon-key') || anonKey.includes('dummy-anon')) return false;

  return true;
}

export function isSupabaseAdminConfigured(): boolean {
  if (!isSupabaseConfigured()) return false;
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!serviceKey) return false;
  if (serviceKey.includes('your-service-role') || serviceKey.includes('dummy-service')) return false;
  return true;
}
