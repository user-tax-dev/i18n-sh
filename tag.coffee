#!/usr/bin/env coffee

> @u7/uridir
  ./git > ROOT STATIC NAME git
  ./i18nUpload
  @u7/read
  @u7/verincr
  @u7/write
  fs > existsSync
  path > join

changed = 0

add = (filepath)=>
  git.add({
    filepath
  })


for i from await git.statusMatrix {
  filter: (i)=> i.indexOf('.') < 0
}
  if i[2] - 1
    await add i[0]
    changed += 1

code = 1
if changed
  name = '.v'
  fp = join STATIC, name
  if existsSync fp
    v = verincr read(fp).trim()
  else
    v = '0.0.1'
  ref = 'v'+v
  console.log ref

  await write(
    join(ROOT,'gen/I18N_VER.js')
    "export default '#{v}'"
  )
  await i18nUpload(NAME,v)

  await write fp, v
  await add name
  await git.commit {
    author:
      name: 'v'
      email: 'i@user.tax'
    message: ref
  }
  await git.tag({
    ref
  })
  code = 0

process.exit(code)

