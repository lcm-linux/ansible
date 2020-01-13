#  公共配置接口
commonConfigUrl="http://{{new_dns}}/api/securitypolice"
policeTenantId=104

# 是否支持换肤，如果是项目中使用，请不要打开该项
# changeSkin="false"

bak="app.js.bak"

source=`find app.js`

function file_replace()
{
  sed -i "s#commonConfigUrl_agKW8Ph6LXkreq5J#${commonConfigUrl}#g" "$source"
  sed -i "s#policeTenantId_ZCWWnMqeVwxplAyo#${policeTenantId}#g" "$source"
}


if [ ! -f "$bak" ]; then
  cp "$source" "$bak"
else
  cp "$bak" "$source"
fi

file_replace || { echo "Conf failed."; exit 1; }
