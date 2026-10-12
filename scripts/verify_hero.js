const http = require('http');

http.get('http://localhost:3000', (res) => {
  let data = '';
  res.on('data', (chunk) => {
    data += chunk;
  });
  res.on('end', () => {
    console.log('HTTP Status Code:', res.statusCode);
    console.log('Total Response Size:', data.length, 'bytes');

    const checks = [
      { name: 'Headline: Your Everyday Healthcare, Made Simple.', pass: data.includes('Your Everyday Healthcare') && data.includes('Made Simple.') },
      { name: 'Location: Serving Kubri, Giridih, Jharkhand', pass: data.includes('Serving Kubri, Giridih, Jharkhand') },
      { name: 'Supporting Text: Explore medicines, healthcare essentials...', pass: data.includes('Explore medicines, healthcare essentials and everyday wellness products at Durga Medical Hall.') },
      { name: 'Primary CTA: Explore Medicines (href="/medicines")', pass: data.includes('Explore Medicines') && data.includes('href="/medicines"') },
      { name: 'Secondary CTA: Browse Categories (href="#categories")', pass: data.includes('Browse Categories') && data.includes('href="#categories"') },
      { name: 'Category Target Section: id="categories"', pass: data.includes('id="categories"') },
      { name: 'Instant Medicine Search Present', pass: data.includes('Instant Medicine Search') },
      { name: 'Upload Prescription Shortcut Present', pass: data.includes('Have a Doctor') || data.includes('Upload Doctor Slip') },
      { name: '3D Scene Loading/Container Component Present', pass: data.includes('Loading 3D Scene') || data.includes('Hero3DCanvas') || data.includes('3D') }
    ];

    console.log('\n--- VERIFICATION CHECK RESULTS ---');
    let allPassed = true;
    for (const check of checks) {
      console.log(`[${check.pass ? 'PASS' : 'FAIL'}] ${check.name}`);
      if (!check.pass) allPassed = false;
    }
    console.log('----------------------------------');
    console.log('ALL CHECKS PASSED:', allPassed);
    process.exit(allPassed ? 0 : 1);
  });
}).on('error', (err) => {
  console.error('Request failed:', err.message);
  process.exit(1);
});
