import { defineConfig } from 'vitepress'
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'
import mathjax3 from "markdown-it-mathjax3";
import footnote from "markdown-it-footnote";
import path from 'path'

function getBaseRepository(base: string): string {
  if (!base || base === '/') return '/';
  const parts = base.split('/').filter(Boolean);
  return parts.length > 0 ? `/${parts[0]}/` : '/';
}

const baseTemp = {
  base: '/MAGEMin_C.jl/v2/',// TODO: replace this in makedocs!
}

const navTemp = {
  nav: [
{ text: 'Home', link: '/index' },
{ text: 'Methods', link: '/problem' },
{ text: 'MAGEMinApp.jl', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMinApp/MAGEMinApp' },
{ text: 'Installation', link: '/MAGEMinApp/installation' },
{ text: 'Tutorials - Bulk input file', link: '/MAGEMinApp/bulk_rock' },
{ text: 'Tutorials - Phase diagrams', link: '/MAGEMinApp/PD_tutorials' },
{ text: 'Tutorials - P-T-X paths', link: '/MAGEMinApp/PTX_tutorials' },
{ text: 'Tutorials - Isentropic paths', link: '/MAGEMinApp/isoS_tutorials' },
{ text: 'Citation', link: '/MAGEMinApp/citation' },
{ text: 'Interface', link: '/MAGEMinApp/interface' }]
 },
{ text: 'MAGEMin_C.jl', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMin_C/MAGEMin_C' },
{ text: 'Installation', link: '/MAGEMin_C/installation' },
{ text: 'Tutorials - Output structure', link: '/MAGEMin_C/output_structure' },
{ text: 'Tutorials - Step by step', link: '/MAGEMin_C/tutorials' },
{ text: 'Tutorials - Quick examples', link: '/MAGEMin_C/examples' },
{ text: 'API', link: '/api' }]
 },
{ text: 'MAGEMin', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMin/MAGEMin' },
{ text: 'Compilation', link: '/MAGEMin/installation' },
{ text: 'Tutorials', link: '/MAGEMin/tutorials' }]
 }
]
,
}

const nav = [
  ...navTemp.nav,
  {
    component: 'VersionPicker'
  }
]

// https://vitepress.dev/reference/site-config
export default defineConfig({
  base: '/MAGEMin_C.jl/v2/',// TODO: replace this in makedocs!
  title: 'MAGEMin',
  description: 'Documentation for MAGEMin_C.jl',
  lastUpdated: true,
  cleanUrls: true,
  outDir: '../2', // This is required for MarkdownVitepress to work correctly...
  head: [
    
    ['script', {src: `${getBaseRepository(baseTemp.base)}versions.js`}],
    // ['script', {src: '/versions.js'], for custom domains, I guess if deploy_url is available.
    ['script', {src: `${baseTemp.base}siteinfo.js`}]
  ],
  
  vite: {
    define: {
      __DEPLOY_ABSPATH__: JSON.stringify('/MAGEMin_C.jl'),
    },
    resolve: {
      alias: {
        '@': path.resolve(__dirname, '../components')
      }
    },
    optimizeDeps: {
      exclude: [ 
        '@nolebase/vitepress-plugin-enhanced-readabilities/client',
        'vitepress',
        '@nolebase/ui',
      ], 
    }, 
    ssr: { 
      noExternal: [ 
        // If there are other packages that need to be processed by Vite, you can add them here.
        '@nolebase/vitepress-plugin-enhanced-readabilities',
        '@nolebase/ui',
      ], 
    },
  },
  markdown: {
    math: true,
    config(md) {
      md.use(tabsMarkdownPlugin),
      md.use(mathjax3),
      md.use(footnote)
    },
    theme: {
      light: "github-light",
      dark: "github-dark"}
  },
  themeConfig: {
    outline: 'deep',
    logo: { src: '/logo.png', width: 24, height: 24},
    search: {
      provider: 'local',
      options: {
        detailedView: true
      }
    },
    nav,
    sidebar: [
{ text: 'Home', link: '/index' },
{ text: 'Methods', link: '/problem' },
{ text: 'MAGEMinApp.jl', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMinApp/MAGEMinApp' },
{ text: 'Installation', link: '/MAGEMinApp/installation' },
{ text: 'Tutorials - Bulk input file', link: '/MAGEMinApp/bulk_rock' },
{ text: 'Tutorials - Phase diagrams', link: '/MAGEMinApp/PD_tutorials' },
{ text: 'Tutorials - P-T-X paths', link: '/MAGEMinApp/PTX_tutorials' },
{ text: 'Tutorials - Isentropic paths', link: '/MAGEMinApp/isoS_tutorials' },
{ text: 'Citation', link: '/MAGEMinApp/citation' },
{ text: 'Interface', link: '/MAGEMinApp/interface' }]
 },
{ text: 'MAGEMin_C.jl', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMin_C/MAGEMin_C' },
{ text: 'Installation', link: '/MAGEMin_C/installation' },
{ text: 'Tutorials - Output structure', link: '/MAGEMin_C/output_structure' },
{ text: 'Tutorials - Step by step', link: '/MAGEMin_C/tutorials' },
{ text: 'Tutorials - Quick examples', link: '/MAGEMin_C/examples' },
{ text: 'API', link: '/api' }]
 },
{ text: 'MAGEMin', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMin/MAGEMin' },
{ text: 'Compilation', link: '/MAGEMin/installation' },
{ text: 'Tutorials', link: '/MAGEMin/tutorials' }]
 }
]
,
    editLink: { pattern: "https://github.com/ComputationalThermodynamics/MAGEMin_C.jl/edit/main/docs/src/:path" },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/ComputationalThermodynamics/MAGEMin_C.jl' }
    ],
    footer: {
      message: 'Made with <a href="https://luxdl.github.io/DocumenterVitepress.jl/dev/" target="_blank"><strong>DocumenterVitepress.jl</strong></a><br>',
      copyright: `© Copyright ${new Date().getUTCFullYear()}.`
    }
  }
})
