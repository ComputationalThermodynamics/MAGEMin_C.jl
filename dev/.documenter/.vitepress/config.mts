import { defineConfig } from 'vitepress'
import { tabsMarkdownPlugin } from 'vitepress-plugin-tabs'
import { mathjaxPlugin } from './mathjax-plugin'
import footnote from "markdown-it-footnote";
import path from 'path'

const mathjax = mathjaxPlugin()

function getBaseRepository(base: string): string {
  if (!base || base === '/') return '/';
  const parts = base.split('/').filter(Boolean);
  return parts.length > 0 ? `/${parts[0]}/` : '/';
}

const baseTemp = {
  base: '/MAGEMin_C.jl/dev/',// TODO: replace this in makedocs!
}

const navTemp = {
  nav: [
{ text: 'Home', link: '/index' },
{ text: 'Methods', link: '/problem' },
{ text: 'MAGEMinApp.jl', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMinApp/MAGEMinApp' },
{ text: 'Installation', link: '/MAGEMinApp/installation' },
{ text: 'Interface', link: '/MAGEMinApp/interface' },
{ text: 'Tutorials - Bulk input file', link: '/MAGEMinApp/bulk_rock' },
{ text: 'Tutorials - Partition coeficient file', link: '/MAGEMinApp/partition_coef' },
{ text: 'Tutorials - Phase diagrams', link: '/MAGEMinApp/PD_tutorials' },
{ text: 'Tutorials - P-T-X paths', link: '/MAGEMinApp/PTX_tutorials' },
{ text: 'Tutorials - Isentropic paths', link: '/MAGEMinApp/isoS_tutorials' },
{ text: 'Tutorials - Citations', link: '/MAGEMinApp/citation' }]
 },
{ text: 'MAGEMin_C.jl', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMin_C/MAGEMin_C' },
{ text: 'Installation', link: '/MAGEMin_C/installation' },
{ text: 'Tutorials - Quickstart', link: '/MAGEMin_C/quickstart' },
{ text: 'Tutorials - Output structure', link: '/MAGEMin_C/output_structure' },
{ text: 'Tutorials - Trace-elements', link: '/MAGEMin_C/trace_elements' },
{ text: 'Tutorials - Saturation models', link: '/MAGEMin_C/saturation_models' },
{ text: 'Tutorials - Fractional crystallization', link: '/MAGEMin_C/fractional_crystallization' },
{ text: 'Tutorials - Threaded fractional cryst.', link: '/MAGEMin_C/threaded_fractional_crystallization' },
{ text: 'Tutorials - Isentropic path', link: '/MAGEMin_C/isentropic_path' },
{ text: 'Tutorials - Initial guess', link: '/MAGEMin_C/initial_guess' },
{ text: 'Tutorials - Other examples', link: '/MAGEMin_C/examples' },
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
  base: '/MAGEMin_C.jl/dev/',// TODO: replace this in makedocs!
  title: 'MAGEMin',
  description: 'Documentation for MAGEMin_C.jl',
  lastUpdated: true,
  cleanUrls: true,
  outDir: '../1', // This is required for MarkdownVitepress to work correctly...
  head: [
    
    ['script', {src: `${getBaseRepository(baseTemp.base)}versions.js`}],
    // ['script', {src: '/versions.js'], for custom domains, I guess if deploy_url is available.
    ['script', {src: `${baseTemp.base}siteinfo.js`}]
  ],
  
  markdown: {
    config(md) {
      md.use(tabsMarkdownPlugin);
      md.use(footnote);
      mathjax.markdownConfig(md);
    },
    theme: {
      light: "github-light",
      dark: "github-dark"
    },
  },
  vite: {
    plugins: [
      mathjax.vitePlugin,
    ],
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
{ text: 'Interface', link: '/MAGEMinApp/interface' },
{ text: 'Tutorials - Bulk input file', link: '/MAGEMinApp/bulk_rock' },
{ text: 'Tutorials - Partition coeficient file', link: '/MAGEMinApp/partition_coef' },
{ text: 'Tutorials - Phase diagrams', link: '/MAGEMinApp/PD_tutorials' },
{ text: 'Tutorials - P-T-X paths', link: '/MAGEMinApp/PTX_tutorials' },
{ text: 'Tutorials - Isentropic paths', link: '/MAGEMinApp/isoS_tutorials' },
{ text: 'Tutorials - Citations', link: '/MAGEMinApp/citation' }]
 },
{ text: 'MAGEMin_C.jl', collapsed: false, items: [
{ text: 'Introduction', link: '/MAGEMin_C/MAGEMin_C' },
{ text: 'Installation', link: '/MAGEMin_C/installation' },
{ text: 'Tutorials - Quickstart', link: '/MAGEMin_C/quickstart' },
{ text: 'Tutorials - Output structure', link: '/MAGEMin_C/output_structure' },
{ text: 'Tutorials - Trace-elements', link: '/MAGEMin_C/trace_elements' },
{ text: 'Tutorials - Saturation models', link: '/MAGEMin_C/saturation_models' },
{ text: 'Tutorials - Fractional crystallization', link: '/MAGEMin_C/fractional_crystallization' },
{ text: 'Tutorials - Threaded fractional cryst.', link: '/MAGEMin_C/threaded_fractional_crystallization' },
{ text: 'Tutorials - Isentropic path', link: '/MAGEMin_C/isentropic_path' },
{ text: 'Tutorials - Initial guess', link: '/MAGEMin_C/initial_guess' },
{ text: 'Tutorials - Other examples', link: '/MAGEMin_C/examples' },
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
