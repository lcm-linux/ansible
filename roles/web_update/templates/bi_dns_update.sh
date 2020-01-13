#  售前部署logo标识
logoPrefix=""

#  版本号标记展示，手动跟新
version="V2.4.1"

#  默认语言设置。一般选择有 zh_CN en_US pt_PT fr_FR ru_RU
defaultLang="pt_PT"

#  导出下载传输协议,支持http和https
protocol="http"

# bi后台rest服务访问路径
baseUrl="http://{{new_dns}}/api/subject"

# 统一登录首页url
home="http://{{new_dns}}/"

# logo 跳转链接配置
homeLogo="$home"

# 统一登录页接口
systemUrl="http://{{new_dns}}/api/SystemManager"

# 统一登录页接口 session失效跳转用
baseLogin="http://{{new_dns}}/api/SystemManager/gotoLogin?backUrl="

# 统一登出页地址 用户点击退出用
baseLogout="http://{{new_dns}}/api/SystemManager/logout?service="

bak="index.js.bak"

source=`find index*.js`

css=`find index*.css`
function file_replace()
{
  sed -i "s#defaultLang_545ba5be-06e1-4a56-bed1-ccb8a973a432#${defaultLang}#g" "$source"
  sed -i "s#home_acc34439-2ff7-4026-be13-7b85ef3f9f93#${home}#g" "$source"
  sed -i "s#homeLogo_98a6115f-06a3-497b-b877-e5206b7d5a9f#${homeLogo}#g" "$source"
  sed -i "s#version_98a6442f-06a3-497b-b877-e5206b7d5a9f#${version}#g" "$source"
  sed -i "s#baseUrl_540ad21c-207c-4203-a025-bdcbb474eed6#${baseUrl}#g" "$source"
  sed -i "s#systemUrl_40d32c7b-35b8-434b-b25c-0afcc8e101c8#${systemUrl}#g" "$source"
  sed -i "s#protocol_98a6442f-a306-497b-a025-bdcbb474eed6#${protocol}#g" "$source"
  sed -i "s#logoPrefix_64498a2f-a306-497b-77b8-b7d5e5206a9f#${logoPrefix}#g" "$source"
  sed -i "s#baseLogin_98a6442f-a306-497b-a025-bdcbb474eed6#${baseLogin}#g" "$source"
  sed -i "s#baseLogout_64498a2f-a306-497b-77b8-b7d5e5206a9f#${baseLogout}#g" "$source"
  sed -i "s#/index.js#/${source}#g" index.html
  sed -i "s#/index.css#/${css}#g" index.html
}


if [ ! -f "$bak" ]; then
  cp "$source" "$bak"
else
  cp "$bak" "$source"
fi

file_replace || { echo "Conf failed."; exit 1; }
