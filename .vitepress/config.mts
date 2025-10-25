import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  srcDir: "docs",
  title: "Sentence 100",
  description: "100个句子记完1200个小学单词",
  
  // 使用自定义主题引入样式
  
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
    ],

    sidebar: [
      {
        text: '',
        items: [
          { text: '1 健康生活', link: '/category-1' },
          { text: '2 日常生活', link: '/category-2' },
          { text: '3 体育运动', link: '/category-3' },
          { text: '4 学校学习', link: '/category-4' },
          { text: '5 饮食文化', link: '/category-5' },
          { text: '6 娱乐活动', link: '/category-6' },
          { text: '7 情绪和情感', link: '/category-7' },
          { text: '8 家人和朋友', link: '/category-8' },
          { text: '9 人物描写', link: '/category-9' },
          { text: '10 购物与服装', link: '/category-10' },
          { text: '11 科学与自然', link: '/category-11' },
          { text: '12 旅行与交通', link: '/category-12' },
          { text: '13 学校生活', link: '/category-13' },
          { text: '14 社会与文化', link: '/category-14' },
          { text: '15 天气与季节', link: '/category-15' },
          { text: '16 动物与植物', link: '/category-16' },
          { text: '17 自然与环境', link: '/category-17' },
          { text: '18 科学技术与宇宙探索', link: '/category-18' }
        ]
      }
    ],
  }
})
