# 将网站部署到云主机（宝塔面板）

## 准备工作

### 1. 确保您已具备
- 一台已安装宝塔面板的云服务器
- 宝塔面板的登录账号和密码
- 已解析到该服务器的域名（可选，但推荐）

### 2. 构建项目

首先在本地构建项目：

```bash
# 在项目根目录执行
npm run docs:build
# 或
pnpm docs:build
```

构建完成后，您会在项目目录下的 `.vitepress/dist` 文件夹中找到构建产物。

## 宝塔面板部署步骤

### 1. 登录宝塔面板

在浏览器中输入您服务器的IP地址和宝塔面板端口号（默认为8888）：
```
http://您的服务器IP:8888
```

输入账号密码登录宝塔面板。

### 2. 创建网站

1. 在左侧菜单中点击「网站」
2. 点击「添加站点」按钮
3. 填写网站信息：
   - 域名：输入您的域名（如 `example.com`），也可以输入IP地址
   - 根目录：设置网站的根目录，建议在 `/www/wwwroot/` 下创建项目专用目录
   - 创建数据库：本项目是静态网站，不需要数据库，可选填
   - FTP：可选是否创建FTP账号，便于文件上传
   - PHP版本：静态网站选择「纯静态」即可
4. 点击「提交」按钮创建网站

### 3. 上传网站文件

**方法一：使用宝塔面板文件管理上传**

1. 在左侧菜单中点击「文件」
2. 导航到您刚才设置的网站根目录（如 `/www/wwwroot/your-website/`）
3. 点击「上传」按钮，选择文件或文件夹
4. 选中本地 `.vitepress/dist` 文件夹中的所有文件，上传到网站根目录

**方法二：使用FTP工具上传**

1. 如果您创建了FTP账号，可以使用FileZilla、WinSCP等FTP工具连接到服务器
2. 本地导航到项目的 `.vitepress/dist` 目录
3. 服务器端导航到网站根目录
4. 将本地文件拖到服务器端完成上传

### 4. 配置网站设置（可选）

1. 返回「网站」列表，点击刚创建的网站右侧的「设置」按钮
2. 在「网站目录」选项卡中，确保「运行目录」设置正确（通常是根目录）
3. 在「SSL」选项卡中，如果您有SSL证书，可以配置HTTPS访问
4. 在「伪静态」选项卡中，可以添加以下规则（适用于SPA应用，可选）：

```
location / {
  try_files $uri $uri/ /index.html;
}
```

### 5. 访问您的网站

打开浏览器，输入您的域名或IP地址，即可访问部署好的网站。

## 自动化部署选项

### 使用宝塔面板的WebHook功能

如果您希望在代码更新后自动部署网站，可以使用宝塔面板的WebHook功能：

1. 在左侧菜单中点击「软件商店」，搜索并安装「宝塔WebHook」插件
2. 安装完成后，在左侧菜单中点击「WebHook」，然后点击「添加」
3. 填写WebHook信息：
   - 名称：如「自动部署网站」
   - 脚本内容：输入以下部署脚本（根据您的实际路径修改）
   ```bash
   #!/bin/bash
   # 进入网站目录
   cd /www/wwwroot/your-website/
   
   # 删除旧文件
   rm -rf *
   
   # 下载最新的构建包（假设您将构建包上传到了某个可访问的位置）
   # 或者您可以在这里添加从Git拉取代码并构建的命令
   wget -O dist.tar.gz https://your-storage-url/dist.tar.gz
   
   # 解压文件
   tar -zxvf dist.tar.gz
   
   # 删除压缩包
   rm -rf dist.tar.gz
   
   # 更改权限（如果需要）
   chmod -R 755 /www/wwwroot/your-website/
   ```
4. 保存WebHook，系统会生成一个URL
5. 将这个URL配置到您的代码仓库（如GitHub、Gitee）的WebHook设置中

### 配置自动化构建并推送（推荐）

您也可以结合GitHub Actions或其他CI/CD工具，在代码推送后自动构建并部署：

1. 在项目中创建`.github/workflows/deploy-to-baota.yml`文件
2. 添加以下内容（需要根据您的实际情况修改）：

```yaml
name: Deploy to Baota Panel

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 16
          cache: 'pnpm'
      
      - name: Install dependencies
        run: pnpm install
      
      - name: Build
        run: pnpm docs:build
      
      - name: Deploy to Baota Panel
        uses: SamKirkland/FTP-Deploy-Action@4.3.3
        with:
          server: ${{ secrets.FTP_SERVER }}
          username: ${{ secrets.FTP_USERNAME }}
          password: ${{ secrets.FTP_PASSWORD }}
          local-dir: .vitepress/dist/
          server-dir: /www/wwwroot/your-website/
```

3. 在GitHub仓库的「Settings」->「Secrets」中添加FTP服务器信息的密钥

## 常见问题

### 1. 网站显示404错误
- 检查文件是否正确上传到网站根目录
- 确保网站的运行目录设置正确
- 如果使用了伪静态规则，检查规则是否配置正确

### 2. 网站访问缓慢
- 考虑使用宝塔面板的「网站」->「设置」->「性能优化」开启GZIP压缩
- 可以安装宝塔面板的「Redis」插件，配合缓存插件使用
- 图片等静态资源可以考虑使用CDN加速

### 3. 权限问题
- 确保网站目录权限正确，通常设置为755
- 可以在宝塔面板文件管理器中右键目录，选择「权限」进行修改

### 4. HTTPS配置
- 可以在宝塔面板中免费申请Let's Encrypt证书
- 在网站设置的「SSL」选项卡中配置证书信息

## 注意事项

1. 定期备份您的网站文件和数据库（如果有）
2. 确保云服务器的防火墙已开放80（HTTP）和443（HTTPS）端口
3. 定期更新服务器系统和宝塔面板，保持安全性
4. 监控网站访问情况，及时优化性能