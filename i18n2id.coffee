#!/usr/bin/env coffee

> zx/globals:
  ./git > ROOT STATIC
  @u7/snake > SNAKE
  @u7/write
  @u7/read
  @u7/u8 > u8eq
  @u7/uridir
  fs > readdirSync readFileSync existsSync copyFileSync
  path > dirname join
  assert > strict:assert
  coffee_plus/compile

encoder = new TextEncoder()
I18N = join ROOT,'json'
I18N_FP = join(ROOT, 'gen/i18n.coffee')
i18n = if existsSync I18N_FP then await import('./i18n.coffee') else {}

cd I18N

do =>
  id = -1
  map = new Map Object.entries i18n
  key_id = new Map()
  for [k,v] from map.entries()
    if v > id
      id = v

  for [k,v] from Object.entries JSON.parse read 'zh.json'
    sk = SNAKE(k)
    if sk of i18n
      kid = i18n[sk]
    else
      map.set sk, ++id
      kid = id
    key_id.set k,kid

  li = [...map.entries()]
  li.sort (a,b)=>a[1]-b[1]
  txt = []
  for [k,v] from li
    txt.push "< #{k} = #{v}"
  txt.push ''
  txt = txt.join '\n'

  if existsSync I18N_FP
    pre = read I18N_FP
  if txt != pre
    await write I18N_FP[..-7]+'js',compile(txt)
    await write I18N_FP, txt

  for fp from readdirSync I18N
    if fp.endsWith '.json'
      data = JSON.parse read fp
      li = Object.entries data
      li.sort (a,b)=>key_id.get(a[0]) - key_id.get(b[0])
      li_len = li.length-1

      try
        assert li_len == id
      catch err
        console.error {li_len, id}, fp
        throw err

      len = 0
      li = li.map (i)=>
        b = encoder.encode i[1]
        len += b.length
        b
      bin = new Uint8Array(len+li_len)
      pos = 0
      for i in li
        bin.set(i,pos)
        pos += (1+i.length)
      name = fp[..-6]
      fp = join(STATIC,name)
      if existsSync fp
        if u8eq bin,readFileSync(fp)
          continue
      await write fp,bin
      #copyFileSync fp,join(STATIC, name)
  return
