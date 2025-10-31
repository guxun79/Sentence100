# 将网站部署到GitHub Pages

## 准备工作

### 1. 确保项目已与GitHub仓库关联

如果项目尚未与GitHub仓库关联，请执行以下命令：

```bash
# 初始化Git仓库（如果尚未初始化）
git init

# 添加远程仓库
# 请将username和repository-name替换为您的GitHub用户名和仓库名
git remote add origin https://github.com/username/repository-name.git
```

### 2. 安装gh-pages包

我们将使用gh-pages包来帮助部署。安装它：

```bash
# 使用npm安装
npm install gh-pages --save-dev

# 或者使用pnpm（推荐，因为项目有pnpm-lock.yaml）
pnpm add gh-pages --save-dev
```

## 部署步骤

### 1. 构建项目

首先确保项目构建成功：

```bash
npm run docs:build
# 或
pnpm docs:build
```

这将在`.vitepress/dist`目录生成构建文件。

### 2. 执行部署命令

我已经在package.json中添加了部署脚本，您可以直接运行：

```bash
npm run deploy
# 或
pnpm deploy
```

这个命令会：
1. 先构建项目（运行`docs:build`）
2. 然后使用gh-pages将`.vitepress/dist`目录部署到GitHub Pages

### 3. 配置GitHub仓库设置（可选）

部署完成后，您可能需要在GitHub仓库的设置中确认：

1. 访问您的GitHub仓库
2. 点击"Settings"选项卡
3. 在侧边栏找到"Pages"选项
4. 确保"Source"设置为：
   - 分支：`gh-pages`
   - 文件夹：`/ (root)`

## 其他部署选项

### 手动部署方法

如果您不想使用gh-pages包，也可以手动部署：

```bash
# 构建项目
npm run docs:build

# 创建临时目录
mkdir temp-deploy
cp -r .vitepress/dist/* temp-deploy/
cd temp-deploy

# 初始化git并部署
git init
git add .
git commit -m "Deploy"
git push --force https://github.com/username/repository-name.git master:gh-pages

# 清理
cd ..
rm -rf temp-deploy
```

### 使用GitHub Actions自动部署

您也可以设置GitHub Actions，在推送到主分支时自动部署：

1. 创建`.github/workflows/deploy.yml`文件
2. 添加以下内容：

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]  # 或 master，根据您的默认分支名

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 16
          cache: 'pnpm'
      
      - name: Install dependencies
        run: pnpm install
      
      - name: Build
        run: pnpm docs:build
      
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: .vitepress/dist
```

## 常见问题

1. **部署后页面空白**
   - 检查`base`配置是否正确（在`.vitepress/config.mts`中）
   - 如果您的仓库名不是username.github.io，则需要设置`base: '/repository-name/'`

2. **资源文件无法加载**
   - 确保使用相对路径
   - 检查`base`配置

3. **gh-pages命令失败**
   - 确保您有仓库的推送权限
   - 尝试使用`git config --global user.email "您的邮箱"`和`git config --global user.name "您的用户名"`设置Git身份