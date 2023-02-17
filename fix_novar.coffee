#!/usr/bin/env coffee

> fs > readdirSync
  @u7/uridir
  path > dirname join
  @u7/it > loads dumps
  @u7/read
  @u7/write

NOSAPCE = 'zh ja km lo th'.split(' ')
space = (lang)=>
  if NOSAPCE.includes lang
    return ''
  ' '

fix = (o, lang)=>
  s = space(lang)
  {captchaClick} = o
  if not captchaClick.includes '@'
    captchaClick = captchaClick+s+'@'
    o.captchaClick = captchaClick
  o

ROOT = dirname uridir(import.meta)

for it from readdirSync(ROOT)
  if not it.endsWith('.it')
    continue
  fp = join ROOT,it
  o = loads read fp
  write fp, dumps fix(o,it[...-3])
