'use client';

import React, { useEffect, useRef, useState } from 'react';
import * as THREE from 'three';

interface Hero3DCanvasProps {
  className?: string;
}

function checkWebGLSupport(): boolean {
  if (typeof window === 'undefined') return true;
  try {
    const canvas = document.createElement('canvas');
    return Boolean(
      window.WebGLRenderingContext &&
        (canvas.getContext('webgl') || canvas.getContext('experimental-webgl'))
    );
  } catch {
    return false;
  }
}

export default function Hero3DCanvas({ className = '' }: Hero3DCanvasProps) {
  const mountRef = useRef<HTMLDivElement>(null);
  const [webglSupported, setWebglSupported] = useState<boolean>(() => checkWebGLSupport());

  useEffect(() => {
    if (!webglSupported) return;

    // Check for reduced motion preference
    const mediaQuery = window.matchMedia('(prefers-reduced-motion: reduce)');

    // Check container
    const container = mountRef.current;
    if (!container) return;

    let renderer: THREE.WebGLRenderer;
    try {
      renderer = new THREE.WebGLRenderer({
        antialias: true,
        alpha: true,
        powerPreference: 'high-performance',
      });
    } catch {
      requestAnimationFrame(() => {
        setWebglSupported(false);
      });
      return;
    }

    const width = container.clientWidth || 500;
    const height = container.clientHeight || 500;

    renderer.setSize(width, height);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    renderer.toneMapping = THREE.ACESFilmicToneMapping;
    renderer.toneMappingExposure = 1.15;
    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFSoftShadowMap;
    container.appendChild(renderer.domElement);

    // Scene & Camera setup
    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(38, width / height, 0.1, 100);
    camera.position.set(0, 0, 7.8);

    // Lighting setup - Soft clinical mint & high-end health aesthetics
    const ambientLight = new THREE.AmbientLight(0xffffff, 1.4);
    scene.add(ambientLight);

    // Primary mint key light
    const keyLight = new THREE.DirectionalLight(0xa7f3d0, 2.8);
    keyLight.position.set(5, 6, 5);
    scene.add(keyLight);

    // Crisp white fill light
    const fillLight = new THREE.DirectionalLight(0xffffff, 2.0);
    fillLight.position.set(-6, -2, 4);
    scene.add(fillLight);

    // Top subtle emerald rim light
    const rimLight = new THREE.DirectionalLight(0x34d399, 3.2);
    rimLight.position.set(0, 8, -4);
    scene.add(rimLight);

    // Soft point light inside the central core
    const corePointLight = new THREE.PointLight(0x6ee7b7, 2.5, 10);
    corePointLight.position.set(0, 0, 0.5);
    scene.add(corePointLight);

    // --- MATERIALS ---
    // 1. Translucent Frosted Glass Material for Cross (High-end medical glass)
    const glassMaterial = new THREE.MeshPhysicalMaterial({
      color: new THREE.Color(0xdcfce7), // very pale mint
      emissive: new THREE.Color(0x064e3b),
      emissiveIntensity: 0.1,
      roughness: 0.12,
      transmission: 0.88,
      thickness: 1.4,
      ior: 1.48,
      reflectivity: 0.9,
      clearcoat: 1.0,
      clearcoatRoughness: 0.08,
      transparent: true,
      opacity: 0.94,
    });

    // 2. Glossy Mint Ceramic
    const mintCeramicMaterial = new THREE.MeshPhysicalMaterial({
      color: new THREE.Color(0x10b981), // vibrant emerald/mint
      roughness: 0.2,
      clearcoat: 1.0,
      clearcoatRoughness: 0.1,
      metalness: 0.05,
    });

    // 3. Crisp Pure White Porcelain / Capsule Base
    const whiteCeramicMaterial = new THREE.MeshPhysicalMaterial({
      color: new THREE.Color(0xffffff),
      roughness: 0.18,
      clearcoat: 0.9,
      clearcoatRoughness: 0.1,
      metalness: 0.02,
    });

    // 4. Subtle Gold Accent / Seal
    const goldAccentMaterial = new THREE.MeshPhysicalMaterial({
      color: new THREE.Color(0xfcd34d),
      metalness: 0.7,
      roughness: 0.25,
      clearcoat: 0.5,
    });

    // --- OBJECTS ---
    const mainGroup = new THREE.Group();
    scene.add(mainGroup);

    // 1. The Translucent Medical Cross
    const crossGroup = new THREE.Group();

    // Cross dimensions
    const beamLength = 2.4;
    const beamWidth = 0.82;
    const beamDepth = 0.65;
    const cornerSegments = 16;

    // We create cross using two intersecting rounded bevel box geometries
    // Vertical beam
    const vBeamGeom = new THREE.BoxGeometry(beamWidth, beamLength, beamDepth, cornerSegments, cornerSegments, 4);
    const vBeamMesh = new THREE.Mesh(vBeamGeom, glassMaterial);
    crossGroup.add(vBeamMesh);

    // Horizontal beam
    const hBeamGeom = new THREE.BoxGeometry(beamLength, beamWidth, beamDepth, cornerSegments, cornerSegments, 4);
    const hBeamMesh = new THREE.Mesh(hBeamGeom, glassMaterial);
    crossGroup.add(hBeamMesh);

    // Inner glowing core pill within the cross
    const coreGeom = new THREE.SphereGeometry(0.38, 32, 32);
    const coreMat = new THREE.MeshPhysicalMaterial({
      color: new THREE.Color(0x34d399),
      emissive: new THREE.Color(0x10b981),
      emissiveIntensity: 0.8,
      roughness: 0.1,
      transmission: 0.4,
      transparent: true,
      opacity: 0.85,
    });
    const coreMesh = new THREE.Mesh(coreGeom, coreMat);
    crossGroup.add(coreMesh);

    mainGroup.add(crossGroup);

    // Helper to create a bi-color capsule
    const createCapsule = (radius: number, length: number) => {
      const capsuleGroup = new THREE.Group();

      // Top half cylinder + hemisphere
      const halfLength = length / 2;
      const topGeom = new THREE.CylinderGeometry(radius, radius, halfLength, 32);
      topGeom.translate(0, halfLength / 2, 0);
      const topMesh = new THREE.Mesh(topGeom, mintCeramicMaterial);

      const topDomeGeom = new THREE.SphereGeometry(radius, 32, 16, 0, Math.PI * 2, 0, Math.PI / 2);
      topDomeGeom.translate(0, halfLength, 0);
      const topDome = new THREE.Mesh(topDomeGeom, mintCeramicMaterial);

      // Bottom half
      const botGeom = new THREE.CylinderGeometry(radius, radius, halfLength, 32);
      botGeom.translate(0, -halfLength / 2, 0);
      const botMesh = new THREE.Mesh(botGeom, whiteCeramicMaterial);

      const botDomeGeom = new THREE.SphereGeometry(radius, 32, 16, 0, Math.PI * 2, Math.PI / 2, Math.PI / 2);
      botDomeGeom.translate(0, -halfLength, 0);
      const botDome = new THREE.Mesh(botDomeGeom, whiteCeramicMaterial);

      // Gold connecting ring
      const ringGeom = new THREE.CylinderGeometry(radius * 1.02, radius * 1.02, 0.03, 32);
      const ring = new THREE.Mesh(ringGeom, goldAccentMaterial);

      capsuleGroup.add(topMesh, topDome, botMesh, botDome, ring);
      return capsuleGroup;
    };

    // Helper to create a round medicine tablet
    const createTablet = (radius: number, height: number) => {
      const tabletGeom = new THREE.CylinderGeometry(radius, radius, height, 36);
      const tabletMesh = new THREE.Mesh(tabletGeom, whiteCeramicMaterial);

      // Score line across tablet
      const grooveGeom = new THREE.BoxGeometry(radius * 1.6, height * 1.05, 0.02);
      const grooveMat = new THREE.MeshBasicMaterial({ color: 0x94a3b8 });
      const groove = new THREE.Mesh(grooveGeom, grooveMat);
      tabletMesh.add(groove);

      return tabletMesh;
    };

    // Helper to create a translucent medicine pearl / droplet
    const createDroplet = (radius: number) => {
      const sphereGeom = new THREE.SphereGeometry(radius, 32, 32);
      const pearlMat = new THREE.MeshPhysicalMaterial({
        color: new THREE.Color(0xa7f3d0),
        emissive: new THREE.Color(0x059669),
        emissiveIntensity: 0.15,
        roughness: 0.05,
        transmission: 0.75,
        thickness: 0.8,
        ior: 1.42,
        transparent: true,
        opacity: 0.88,
      });
      return new THREE.Mesh(sphereGeom, pearlMat);
    };

    // Floating satellite objects
    // 1. Floating Capsule Left Top
    const capsule1 = createCapsule(0.24, 0.58);
    capsule1.position.set(-2.2, 1.4, 0.8);
    capsule1.rotation.set(0.6, 0.4, 0.8);
    mainGroup.add(capsule1);

    // 2. Floating Capsule Right Bottom
    const capsule2 = createCapsule(0.22, 0.52);
    capsule2.position.set(2.1, -1.3, 0.6);
    capsule2.rotation.set(-0.8, -0.3, -0.5);
    mainGroup.add(capsule2);

    // 3. Floating Tablet Right Top
    const tablet1 = createTablet(0.42, 0.16);
    tablet1.position.set(2.2, 1.6, -0.4);
    tablet1.rotation.set(1.1, -0.5, 0.3);
    mainGroup.add(tablet1);

    // 4. Floating Tablet Left Bottom
    const tablet2 = createTablet(0.36, 0.14);
    tablet2.position.set(-1.9, -1.6, -0.2);
    tablet2.rotation.set(-0.5, 0.8, -0.4);
    mainGroup.add(tablet2);

    // 5. Ambient Translucent Drops / Spheres
    const droplet1 = createDroplet(0.28);
    droplet1.position.set(-1.2, 2.1, -0.6);
    mainGroup.add(droplet1);

    const droplet2 = createDroplet(0.22);
    droplet2.position.set(1.4, -2.0, -0.8);
    mainGroup.add(droplet2);

    const droplet3 = createDroplet(0.18);
    droplet3.position.set(-2.5, -0.2, 0.4);
    mainGroup.add(droplet3);

    // Subtle floating dust/bubbles
    const particleCount = 24;
    const particleGeom = new THREE.BufferGeometry();
    const positions = new Float32Array(particleCount * 3);
    for (let i = 0; i < particleCount * 3; i += 3) {
      positions[i] = (Math.random() - 0.5) * 7.5;
      positions[i + 1] = (Math.random() - 0.5) * 6.5;
      positions[i + 2] = (Math.random() - 0.5) * 4.0;
    }
    particleGeom.setAttribute('position', new THREE.BufferAttribute(positions, 3));
    const particleMat = new THREE.PointsMaterial({
      color: 0x34d399,
      size: 0.055,
      transparent: true,
      opacity: 0.45,
      blending: THREE.AdditiveBlending,
    });
    const particleSystem = new THREE.Points(particleGeom, particleMat);
    scene.add(particleSystem);

    // --- INTERACTION & ANIMATION STATE ---
    let mouseX = 0;
    let mouseY = 0;
    let targetRotationX = 0;
    let targetRotationY = 0;

    const handleMouseMove = (e: MouseEvent) => {
      const rect = container.getBoundingClientRect();
      const x = ((e.clientX - rect.left) / rect.width) * 2 - 1;
      const y = -(((e.clientY - rect.top) / rect.height) * 2 - 1);
      mouseX = x;
      mouseY = y;
    };

    window.addEventListener('mousemove', handleMouseMove);

    // Resize observer
    const handleResize = () => {
      if (!container) return;
      const newWidth = container.clientWidth;
      const newHeight = container.clientHeight;
      if (newWidth === 0 || newHeight === 0) return;

      camera.aspect = newWidth / newHeight;
      // Adjust camera distance based on aspect ratio for mobile responsiveness
      if (newWidth < 640) {
        camera.position.z = 10.2;
      } else if (newWidth < 1024) {
        camera.position.z = 8.8;
      } else {
        camera.position.z = 7.8;
      }
      camera.updateProjectionMatrix();
      renderer.setSize(newWidth, newHeight);
    };

    const resizeObserver = new ResizeObserver(handleResize);
    resizeObserver.observe(container);
    handleResize();

    // Animation Loop
    let animationFrameId: number;
    const clock = new THREE.Clock();

    const animate = () => {
      animationFrameId = requestAnimationFrame(animate);

      const elapsedTime = clock.getElapsedTime();
      const isMotionReduced = mediaQuery.matches;

      // Parallax smooth interpolation
      targetRotationY = mouseX * 0.45;
      targetRotationX = -mouseY * 0.35;

      mainGroup.rotation.y += (targetRotationY - mainGroup.rotation.y) * 0.05;
      mainGroup.rotation.x += (targetRotationX - mainGroup.rotation.x) * 0.05;

      if (!isMotionReduced) {
        // Continuous soft floating levitation for cross
        crossGroup.position.y = Math.sin(elapsedTime * 0.8) * 0.14;
        crossGroup.rotation.y = Math.sin(elapsedTime * 0.4) * 0.12;
        crossGroup.rotation.z = Math.cos(elapsedTime * 0.35) * 0.05;

        // Floating & rotation for satellites
        capsule1.position.y = 1.4 + Math.sin(elapsedTime * 1.1 + 1.2) * 0.18;
        capsule1.rotation.x += 0.008;
        capsule1.rotation.y += 0.012;

        capsule2.position.y = -1.3 + Math.sin(elapsedTime * 0.95 + 2.5) * 0.16;
        capsule2.rotation.x += 0.01;
        capsule2.rotation.z += 0.006;

        tablet1.position.y = 1.6 + Math.cos(elapsedTime * 1.05 + 0.5) * 0.14;
        tablet1.rotation.y += 0.007;

        tablet2.position.y = -1.6 + Math.sin(elapsedTime * 0.85 + 3.0) * 0.12;
        tablet2.rotation.z += 0.009;

        droplet1.position.y = 2.1 + Math.sin(elapsedTime * 1.2 + 0.8) * 0.15;
        droplet2.position.y = -2.0 + Math.cos(elapsedTime * 1.1 + 1.8) * 0.12;
        droplet3.position.y = -0.2 + Math.sin(elapsedTime * 0.9 + 2.2) * 0.14;

        // Micro particle drift
        particleSystem.rotation.y = elapsedTime * 0.02;
      }

      renderer.render(scene, camera);
    };

    animate();

    // Cleanup on unmount
    return () => {
      cancelAnimationFrame(animationFrameId);
      window.removeEventListener('mousemove', handleMouseMove);
      resizeObserver.disconnect();

      if (container && renderer.domElement && container.contains(renderer.domElement)) {
        container.removeChild(renderer.domElement);
      }

      // Dispose geometries and materials
      vBeamGeom.dispose();
      hBeamGeom.dispose();
      coreGeom.dispose();
      glassMaterial.dispose();
      mintCeramicMaterial.dispose();
      whiteCeramicMaterial.dispose();
      goldAccentMaterial.dispose();
      coreMat.dispose();
      particleGeom.dispose();
      particleMat.dispose();
      renderer.dispose();
    };
  }, [webglSupported]);

  if (!webglSupported) {
    // Graceful static CSS/SVG 3D Fallback
    return (
      <div className={`relative flex items-center justify-center ${className}`}>
        <div className="relative w-72 h-72 sm:w-88 sm:h-88 rounded-3xl bg-gradient-to-tr from-emerald-100/80 via-teal-50 to-white p-8 shadow-2xl border border-teal-100 flex items-center justify-center">
          <div className="absolute inset-0 rounded-3xl bg-[radial-gradient(circle_at_30%_30%,rgba(16,185,129,0.15),transparent)] pointer-events-none" />
          {/* Stylized Cross */}
          <div className="relative flex items-center justify-center">
            <div className="w-16 h-48 bg-gradient-to-b from-teal-500 to-emerald-600 rounded-2xl shadow-xl shadow-teal-500/20" />
            <div className="absolute w-48 h-16 bg-gradient-to-r from-teal-500 to-emerald-600 rounded-2xl shadow-xl shadow-teal-500/20" />
            <div className="absolute w-12 h-12 rounded-full bg-white/90 shadow-md flex items-center justify-center">
              <div className="w-6 h-6 rounded-full bg-teal-500" />
            </div>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div
      ref={mountRef}
      className={`relative w-full h-full min-h-[380px] sm:min-h-[440px] lg:min-h-[520px] cursor-grab active:cursor-grabbing select-none ${className}`}
      aria-label="Interactive 3D Healthcare Composition"
      role="img"
    />
  );
}
