#!/usr/bin/env coffee

> ./i18nUpload.coffee
  ./git > STATIC NAME
  path > join
  fs > existsSync
  @u7/read

ver = =>
  name = '.v'
  fp = join STATIC, name
  if existsSync fp
    v = read(fp).trim()
  else
    v = '0.0.1'
  v

await i18nUpload(
  NAME
  ver()
)

