// VitePress主题入口文件
import DefaultTheme from 'vitepress/theme'
import './styles/custom.css'

export default {
  ...DefaultTheme,
  enhanceApp({ app, router, siteData }) {
    // 可以在这里进行应用增强
  }
}